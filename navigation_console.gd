extends Spatial

# Variables
var led = preload("res://led.tscn")
var led_nodes = []
var number_of_leds = 29
var center_led_pos = Vector2((number_of_leds-1) / 2, (number_of_leds-1) / 2)
var navigation_led_pos = center_led_pos
var navigation_led_color_state = 0
var time = 0

# Colors
var green = Color(0.11,0.38,0.11)
var yellow = Color(1,1,0)
var red = Color(1,0,0)
var blue = Color(0,0,1)

var hover_yellow = Color(1,1,0)
var arrow_grey = Color(0.41, 0.41, 0.41)
var launch_red = Color(1,0,0)



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
		led_node = change_led_color(led_node, red)
	led_nodes.append(led_node)
	self.add_child(led_node)

func blinking_navigation_led(pos_2d):
	var led_node = get_led_by_pos(pos_2d)
	var color = yellow
	if navigation_led_color_state % 2 == 0:
		color = green
	change_led_color(led_node, color)
	navigation_led_color_state += 1

func get_led_by_pos(pos_2d):
	return led_nodes[ pos_2d.x*29 + pos_2d.y]

func change_led_color(led_node, color):
	var material = SpatialMaterial.new()
	material.albedo_color = color
	for i in range(2,6):
		led_node.get_child(i).set_surface_material(0, material)
	return led_node

func change_arrow_color(arrow_node, color):
	var material = SpatialMaterial.new()
	material.albedo_color = color
	arrow_node.get_child(0).set_surface_material(0, material)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	time = time + _delta
	if not compare_vector_pos(center_led_pos, navigation_led_pos) and int(time) % 2 == 1:
		blinking_navigation_led(navigation_led_pos)
		time = 0

func compare_vector_pos(vec1, vec2):
	var same_pos = vec1.x == vec2.x and vec1.y == vec2.y
	return same_pos
	

# Hover and click functions
func _on_arrow_up_clicked():
	if not compare_vector_pos(center_led_pos, navigation_led_pos):
		change_led_color(get_led_by_pos(navigation_led_pos), green)
	navigation_led_pos.y -= 1
	
func _on_arrow_right_area_clicked():
	if not compare_vector_pos(center_led_pos, navigation_led_pos):
		change_led_color(get_led_by_pos(navigation_led_pos), green)
	navigation_led_pos.x += 1

func _on_arrow_left_area_clicked():
	if not compare_vector_pos(center_led_pos, navigation_led_pos):
		change_led_color(get_led_by_pos(navigation_led_pos), green)
	navigation_led_pos.x -= 1

func _on_arrow_down_area_clicked():
	if not compare_vector_pos(center_led_pos, navigation_led_pos):
		change_led_color(get_led_by_pos(navigation_led_pos), green)
	navigation_led_pos.y += 1

func _on_arrow_right_mouse_entered():
	change_arrow_color(get_child(0), yellow)

func _on_arrow_left_mouse_entered():
	change_arrow_color(get_child(1), yellow)

func _on_arrow_up_mouse_entered():
	change_arrow_color(get_child(2), yellow)

func _on_arrow_down_mouse_entered():
	change_arrow_color(get_child(3), yellow)

func _on_arrow_right_mouse_exited():
	change_arrow_color(get_child(0), arrow_grey)

func _on_arrow_left_mouse_exited():
	change_arrow_color(get_child(1), arrow_grey)

func _on_arrow_up_mouse_exited():
	change_arrow_color(get_child(2), arrow_grey)

func _on_arrow_down_mouse_exited():
	change_arrow_color(get_child(3), arrow_grey)

func _on_launch_button_mouse_entered():
	change_arrow_color(get_child(4), yellow)

func _on_launch_button_mouse_exited():
	change_arrow_color(get_child(4), arrow_grey)

func _on_launch_button_area_clicked():
	pass
