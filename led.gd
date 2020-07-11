extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_led_color(led_node, color):
	var material = SpatialMaterial.new()
	material.albedo_color = color
	for i in range(2,6):
		led_node.get_child(i).set_surface_material(0, material)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
