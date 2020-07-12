extends Node
signal music_button_clicked(id)

var id = 0
var hover_yellow = Color(1,1,0)
var red = Color(1,0,0)
var green = Color(0,1,0)

var timer = null
var button_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	self.add_child(timer)
	timer.set_wait_time(0.25)

func change_color(color):
	var material = SpatialMaterial.new()
	material.albedo_color = color
	var last_child_index = get_child_count() - 1
	var child_index = 1
	for child in get_children():
		print(last_child_index)
		if child_index == last_child_index:
			return	
		child.set_surface_material(0, material)
		child_index += 1

func _on_music_button_mouse_entered():
	change_color(hover_yellow)

func _on_music_button_mouse_exited():
	change_color(red)

func _on_music_button_area_clicked():
	if !button_pressed:
		lower_button()
	emit_signal("music_button_clicked", id)

func lower_button():
	button_pressed = true
	var pos = self.transform.origin
	pos.y -= 0.2
	self.transform.origin = pos
	timer.start()
	yield(timer, "timeout")
	pos.y += 0.2
	self.transform.origin = pos
	button_pressed = false

func _on_send_area_clicked():
	if !button_pressed:
		lower_button()
	emit_signal("music_button_clicked", id)

func _on_send_mouse_entered():
	change_color(hover_yellow)

func _on_send_mouse_exited():
	change_color(Color("7f1212"))

func _on_play_area_clicked():
	if !button_pressed:
		lower_button()
	emit_signal("music_button_clicked", id)

func _on_play_mouse_entered():
	change_color(hover_yellow)

func _on_play_mouse_exited():
	change_color(Color("0a760a"))

func _on_music_panel_send_ready():
	change_color(Color("7f1212"))
