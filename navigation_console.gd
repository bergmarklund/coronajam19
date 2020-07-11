extends Spatial

var led = preload("res://led.tscn")
var number_of_leds = 29
var red = Color(1,0,0)
var blue = Color(0,0,1)
# var led_nodes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	render_grid()

func render_grid():
	for i in range(number_of_leds):
		for j in range(number_of_leds):
			render_led(i,j)

func render_led(x_pos, z_pos):
	var posistion = Vector3(x_pos - ((number_of_leds-1)/2), 1.25, z_pos - ((number_of_leds-1)/2))
	var led_node = led.instance()
	led_node.set_translation(posistion)
	if x_pos == number_of_leds / 2 and z_pos == number_of_leds / 2 :
		print(posistion)
		print(str(x_pos) + " " + str(z_pos))
		led_node = change_led_color(led_node, red)
	self.add_child(led_node)
	
func change_led_color(led_node, color):
	var material = SpatialMaterial.new()
	material.albedo_color = color
	for i in range(2,6):
		led_node.get_child(i).set_surface_material(0, material)
	return led_node
	


	#print("created a node at pos " + str(posistion))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
