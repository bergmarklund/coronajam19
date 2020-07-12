extends Node

var spaceship_scene = preload("res://spaceship.tscn")
var navconsole_scene = preload("res://navigation_console.tscn")
var msgconsole_scene = preload("res://music_console.tscn")
var splash_screen = preload("res://splash_screen.tscn")
var played_messages = []

var first_data_synced = false

var col = 0
var row = 0

func _ready():
	goto_splashscreen()
	Multiplayer.connect("sync_done", self, "_on_sync")
	Multiplayer.connect("warp_done", self, "_on_warp_done")
	
	
func _on_sync():
	print("SYNCING")
	var data = Multiplayer.data
	if data.size() == 0:
		return
	var user = data.user
	var ship = user.ship
	var messages = data.messages
	
	update_messages(messages)
	
	if !first_data_synced:
		var new_row = int(ship.row)
		var new_col = int(ship.col)
		update_ship_position(new_row, new_col)
		goto_spaceship(0)
		first_data_synced = true
	
func update_messages(messages):
	for msg in messages:
		if !already_played_message(msg.id):
			play_message(msg)
		display_message(msg)
		
func display_message(message):
	var offset_row = message.row - row
	var offset_col = message.col - col
	if $current_scene.get_child_count() > 0 && abs(offset_col) <= 14 && abs(offset_row) <= 14:
		var child = $current_scene.get_children()[0]
		if child.has_method("display_message"):
			child.display_message(offset_row, offset_col)
			
func play_message(msg):
	played_messages.append(msg.id)
	$background_music.add_message(msg.content)
	
func already_played_message(msg_id):
	return played_messages.has(msg_id)
	
func update_ship_position(new_row, new_col):
	row = int(new_row)
	col = int(new_col)
	update_rng_seed()

func update_rng_seed():
	Singleton.rng_seed = abs(row + col + 1) +  abs(row) * abs(col)
	print("new rng_seed: " + str(Singleton.rng_seed))
	
func check_if_moved(new_row, new_col):
	return new_row != row || new_col != col

func clear_current_scene():
	if $current_scene.get_child_count() > 0:
		var children = $current_scene.get_children()
		for child in children:
			child.queue_free()
		
func goto_spaceship(camera_start, lock_ship = false):
	clear_current_scene()
	var spaceship = spaceship_scene.instance()
	spaceship.connect("display_nav_console", self, "_on_display_nav_console")
	spaceship.connect("display_msg_console", self, "_on_display_msg_console")
	spaceship.camera_start = camera_start
	spaceship.lock_ship = lock_ship
	$current_scene.add_child(spaceship)
	

func goto_nav_console():
	clear_current_scene()
	var nav_console = navconsole_scene.instance()
	nav_console.connect("exit_nav_console", self, "_on_exit_nav_console")
	nav_console.connect("warp_to_pos", self, "_on_warp_to_position")
	$current_scene.add_child(nav_console)
	
func goto_msg_console():
	clear_current_scene()
	var msg_console = msgconsole_scene.instance()
	msg_console.connect("exit_msg_console", self, "_on_exit_msg_console")
	msg_console.connect("send_button_clicked", self, "_on_send_button_clicked")
	$current_scene.add_child(msg_console)
	
func goto_splashscreen():
	clear_current_scene()
	var splash = splash_screen.instance()
	$current_scene.add_child(splash)

func _on_send_button_clicked(tone_sequence):
	Multiplayer.message(tone_sequence)
	

func _on_display_nav_console():
	goto_nav_console()
	
func _on_exit_nav_console():
	goto_spaceship(1)
	
func _on_display_msg_console():
	goto_msg_console()
	
func _on_exit_msg_console():
	goto_spaceship(2)

func _on_warp_to_position(offset_row, offset_col):
	if offset_row == 0 && offset_col == 0:
		return
	var global_row = row + offset_row
	var global_col = col + offset_col
	var distance = get_warp_distance(offset_row, offset_col)
	do_warp_sequence(global_row, global_col, distance)
	Multiplayer.warp(global_row, global_col)
	
# used as time! 
func get_warp_distance(offset_row, offset_col):
	var dist = offset_row + offset_col
	dist = clamp(dist, 8, 20)
	return dist

func _on_warp_done():
	Multiplayer.sync()
	
func do_warp_sequence(global_row, global_col, distance):
	goto_spaceship(1, true)
	warp_spaceship(distance)
	update_ship_position(global_row, global_col)

func warp_spaceship(distance):
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 3
	add_child(timer)
	timer.start()
	yield(timer, "timeout")
	if $current_scene.get_child_count() > 0:
		var child = $current_scene.get_children()[0]
		if child.has_method("do_warp"):
			child.do_warp(distance)
