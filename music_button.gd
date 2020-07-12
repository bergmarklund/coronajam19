extends Node
signal music_button_clicked(id)

var id = 0
var hover_yellow = Color(1,1,0)
var red = Color(1,0,0)

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
	get_child(0).set_surface_material(0, material)

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
