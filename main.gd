extends Node

var spaceship_scene = preload("res://spaceship.tscn")
var navconsole_scene = preload("res://navigation_console.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	switch_to_scene(0)
	
func switch_to_scene(sceneid):
	if sceneid == 0:
		clear_current_scene()
		goto_spaceship()
	elif sceneid == 1:
		clear_current_scene()
		goto_nav_console()
		
func clear_current_scene():
	if $current_scene.get_child_count() > 0:
		var children = $current_scene.get_children()
		for child in children:
			child.queue_free()
		
func goto_spaceship():
	var spaceship = spaceship_scene.instance()
	spaceship.connect("display_nav_console", self, "_on_display_nav_console")
	spaceship.connect("display_msg_console", self, "_on_display_msg_console")
	$current_scene.add_child(spaceship)

func goto_nav_console():
	var nav_console = navconsole_scene.instance()
	$current_scene.add_child(nav_console)


func _on_display_nav_console():
	switch_to_scene(1)
	
func _on_display_msg_console():
	print("display msg")
	



