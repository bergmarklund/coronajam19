extends Spatial


var led = preload("res://led.tscn")
var button = preload("res://music_button.tscn")
var led_nodes = []
var buttons = []

var number_of_leds = 5
var center_led_pos = Vector2((number_of_leds-1) / 2, (number_of_leds-1) / 2)
var navigation_led_pos = center_led_pos
var navigation_led_color_state = 0
var time = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	render_leds()
	
func render_leds():
	var origin_pos_led = $LED.transform.origin
	var origin_pos_button = $music_choice_button.transform.origin
	for i in range(number_of_leds):
		render_button(i, origin_pos_button)
		for j in range(number_of_leds):
			render_led(i, j, origin_pos_led)

func render_button(id, origin_pos):
	var posistion = Vector3(origin_pos.x, 0, origin_pos.z + id * 4)
	var button_node = button.instance()
	button_node.set_translation(posistion)
	buttons.append(button_node)
	self.add_child(button_node)
	
func render_led(x_pos, z_pos, origin_pos):
	var posistion = Vector3(origin_pos.x + x_pos * 6, 0.25, origin_pos.z + z_pos * 4)
	var led_scale = Vector3(3,3,3)
	var led_node = led.instance()
	led_node.set_translation(posistion)
	led_node.set_scale(led_scale)
	led_nodes.append(led_node)
	self.add_child(led_node)
