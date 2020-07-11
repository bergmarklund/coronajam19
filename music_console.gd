extends Spatial

var led = preload("res://led.tscn")
var button = preload("res://music_button.tscn")
var led_nodes = []
var buttons = []

var number_of_leds = 5
var led_music_state = 0
var time = 0

# Colors
var red = Color(1,0,0)
var hover_yellow = Color(1,1,0)
var green = Color(0.11,0.38,0.11)
var yellow = Color(1,1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	render_leds()
	clear_leds()
		
func render_leds():
	var origin_pos_led = $LED.transform.origin
	var origin_pos_button = $music_choice_button.transform.origin
	for i in range(number_of_leds):
		render_button(i, origin_pos_button)
		var led_array = []
		for j in range(number_of_leds):
			var led = render_led(i, j, origin_pos_led)
			led_array.append(led)
		led_nodes.append(led_array)

func render_button(id, origin_pos):
	var posistion = Vector3(origin_pos.x, 0, origin_pos.z + id * 4)
	var button_node = button.instance()
	button_node.connect("music_button_clicked", self, "_on_music_button_clicked")
	button_node.id = id
	button_node.set_translation(posistion)
	buttons.append(button_node)
	self.add_child(button_node)
	
func _on_music_button_clicked(id):
	if led_music_state % 5 == 0:
		clear_leds()
	var node_to_active = 1
	led_nodes[(led_music_state % 5)][id].change_led_color(led_nodes[(led_music_state % 5)][id], yellow)
	led_music_state += 1
	
func render_led(x_pos, z_pos, origin_pos):
	var posistion = Vector3(origin_pos.x + x_pos * 6, 0.25, origin_pos.z + z_pos * 4)
	var led_scale = Vector3(3,3,3)
	var led_node = led.instance()
	led_node.set_translation(posistion)
	led_node.set_scale(led_scale)
	self.add_child(led_node)
	return led_node

func clear_leds():
		for i in range(5):
			for j in range(5):
				led_nodes[i][j].change_led_color(led_nodes[i][j], green)
