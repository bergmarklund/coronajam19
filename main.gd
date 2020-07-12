extends Node

var spaceship_scene = preload("res://spaceship.tscn")
var navconsole_scene = preload("res://navigation_console.tscn")
var msgconsole_scene = preload("res://music_console.tscn")

var rng_seed = 1

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	rng_seed = rng.randi()
	print(rng_seed)
	goto_spaceship(0)


func clear_current_scene():
	if $current_scene.get_child_count() > 0:
		var children = $current_scene.get_children()
		for child in children:
			child.queue_free()
			
func reload():
	if $current_scene.get_child_count() > 0:
		var child = $current_scene.get_children()[0]
		if child.has_method("reload"):
			child.reload(rng_seed)
		
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
	$current_scene.add_child(nav_console)
	
func goto_msg_console():
	clear_current_scene()
	var msg_console = msgconsole_scene.instance()
	msg_console.connect("exit_msg_console", self, "_on_exit_msg_console")
	msg_console.connect("send_button_clicked", self, "_on_send_button_clicked")
	# msg_console.tone_sequence = tone_sequence
	$current_scene.add_child(msg_console)

func _on_send_button_clicked(tone_sequence):
	print("MAIN TONE SEQUENCE: " + tone_sequence)

func _on_display_nav_console():
	goto_nav_console()
	
func _on_exit_nav_console():
	goto_spaceship(1)
	
func _on_display_msg_console():
	goto_msg_console()
	
func _on_exit_msg_console():
	goto_spaceship(2)



