extends Node
signal music_button_clicked(id)

var id = 0
var hover_yellow = Color(1,1,0)
var red = Color(1,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#area = get_node(area_path)
	#area.connect("mouse_entered", self, "_on_music_button_mouse_entered")
	#area.connect("mouse_exited", self, "_on_music_button_mouse_exited")

func change_color(color):
	var material = SpatialMaterial.new()
	material.albedo_color = color
	get_child(0).set_surface_material(0, material)

func _on_music_button_mouse_entered():
	change_color(hover_yellow)


func _on_music_button_mouse_exited():
	change_color(red)


func _on_music_button_area_clicked():
	emit_signal("music_button_clicked", id)
