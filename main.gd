extends Node

var spaceship_scene = preload("res://spaceship.tscn")
var navconsole_scene = preload("res://navigation_console.tscn")
var msgconsole_scene = preload("res://music_console.tscn")
var played_messages = []


var rng_seed = 1
var col = null
var row = null

func _ready():
	goto_spaceship(0)
	Multiplayer.connect("sync_done", self, "_on_sync")
	
	
func _on_sync():
	print("SYNCING")
	var data = Multiplayer.data
	if data.size() == 0:
		return
	var user = data.user
	var ship = user.ship
	var messages = data.messages
	var new_row = int(ship.row)
	var new_col = int(ship.col)
	if check_if_moved(new_row, new_col):
		update_ship_position(new_row, new_col)
	
	update_messages(messages)
	
func update_messages(messages):
	for msg in messages:
		if !already_played_message(msg.id):
			play_message(msg)
		display_message(msg)
		
func display_message(message):
	print("message seend: " + message)
	var offset_row = row - message.row
	var offset_col = col - message.col
	if $current_scene.get_child_count() > 0:
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
	reload_ship_background()

func update_rng_seed():
	rng_seed = row * col
	print("new rng_seed: " + str(rng_seed))
	
func check_if_moved(new_row, new_col):
	return new_row != row || new_col != col

func clear_current_scene():
	if $current_scene.get_child_count() > 0:
		var children = $current_scene.get_children()
		for child in children:
			child.queue_free()
			
func reload_ship_background():
	if $current_scene.get_child_count() > 0:
		var child = $current_scene.get_children()[0]
		if child.has_method("reload_background"):
			child.reload_background(rng_seed)
		
func goto_spaceship(camera_start):
	clear_current_scene()
	var spaceship = spaceship_scene.instance()
	spaceship.connect("display_nav_console", self, "_on_display_nav_console")
	spaceship.connect("display_msg_console", self, "_on_display_msg_console")
	spaceship.camera_start = camera_start
	spaceship.rng_seed = rng_seed
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
	print("Pos in main: " + str(offset_row) + " " + str(offset_col))
	if offset_row == 0 && offset_col == 0:
		return
	var global_row = row + offset_row
	var global_col = col + offset_col
	Multiplayer.warp(global_row, global_col)
	var dist = abs(offset_row) + abs(offset_col)
	do_warp_sequence(dist)

func do_warp_sequence(distance):
	goto_spaceship(1)
	warp_spaceship(distance)

func warp_spaceship(distance):
	if $current_scene.get_child_count() > 0:
		var child = $current_scene.get_children()[0]
		if child.has_method("do_warp"):
			child.do_warp(distance)
