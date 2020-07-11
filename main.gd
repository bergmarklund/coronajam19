extends Node

var spaceship_scene = preload("res://spaceship.tscn")
var navconsole_scene = preload("res://navigation_console.tscn")
# Called when the node enters the scene tree for the first time.

var rng_seed = 4

func _ready():
	goto_spaceship(0)

		
func clear_current_scene():
	if $current_scene.get_child_count() > 0:
		var children = $current_scene.get_children()
		for child in children:
			child.queue_free()
		
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


func _on_display_nav_console():
	goto_nav_console()
	
func _on_exit_nav_console():
	goto_spaceship(1)
	
func _on_display_msg_console():
	print("display msg")
	



