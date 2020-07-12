extends Spatial
signal exit_nav_console
signal warp_to_pos(navigation_led_pos_row, navigation_led_pos_col)

# Variables
var led = preload("res://led.tscn")
var led_nodes = []
var number_of_leds = 29
var center_led_pos = Vector2((number_of_leds-1) / 2, (number_of_leds-1) / 2)
var navigation_led_pos = center_led_pos
var timer = null

# Colors
var green = Color(0.11,0.38,0.11)
var red = Color(1,0,0)
var hover_yellow = Color(1,1,0)
var arrow_grey = Color(0.41, 0.41, 0.41)
var launch_red = Color(1,0,0)


func _input(event):
	if event is InputEventMouseButton:	
		if(event.pressed && event.button_index == BUTTON_RIGHT):
			emit_signal("exit_nav_console")

func _ready():
	render_grid()
	fix_button_colors()
	
func fix_button_colors():
	change_arrow_color(get_child(4), red)
	for i in range(4):
		change_arrow_color(get_child(i), arrow_grey)

func render_grid():
	timer = Timer.new()
	self.add_child(timer)
	timer.set_wait_time(0.25)
	for i in range(number_of_leds):
		var led_array = []
		for j in range(number_of_leds):
			var led_node = render_led(i,j)
			led_array.append(led_node)
		led_nodes.append(led_array)

func render_led(x_pos, z_pos):
	var posistion = Vector3(x_pos - ((number_of_leds-1)/2), 1.25, z_pos - ((number_of_leds-1)/2))
	var led_node = led.instance()
	led_node.set_translation(posistion)
	self.add_child(led_node)
	if x_pos == number_of_leds / 2 and z_pos == number_of_leds / 2 :
		led_node.change_led_color(red)
	return led_node

func get_led_by_pos(pos_2d):
	return led_nodes[pos_2d.x][pos_2d.y]

func change_arrow_color(arrow_node, color):
	var material = SpatialMaterial.new()
	material.albedo_color = color
	arrow_node.get_child(0).set_surface_material(0, material)

func compare_vector_pos(vec1, vec2):
	var same_pos = vec1.x == vec2.x and vec1.y == vec2.y
	return same_pos

func led_switch(navigation_led_pos, status):
	if not compare_vector_pos(center_led_pos, navigation_led_pos):
		var led_node = get_led_by_pos(navigation_led_pos)
		led_node.change_led_color(green)
		if status:
			led_node.activate_navigation_led()
		else:
			led_node.disable_navigation_led()

func lower_button(id):
	var button = get_child(id)
	var pos = button.transform.origin
	pos.y -= 0.2
	button.set_translation(pos)
	timer.start()
	yield(timer, "timeout")
	pos.y += 0.2
	button.set_translation(pos)

func display_message(offset_row, offset_col):
	var led_node = led_nodes[navigation_led_pos.x - offset_col][navigation_led_pos.y - offset_row]
	led_node.change_led_color(red)
	led_node.activate_nearby_ship_led_blinking()
	
### Hover and click functions ###
func _on_arrow_up_clicked():
	lower_button(2)
	$arrow_up/AudioStreamPlayer.play()
	led_switch(navigation_led_pos, false)
	navigation_led_pos.y -= 1
	led_switch(navigation_led_pos, true)

func _on_arrow_right_area_clicked():
	lower_button(0)
	$arrow_right/AudioStreamPlayer.play()
	led_switch(navigation_led_pos, false)
	navigation_led_pos.x += 1
	led_switch(navigation_led_pos, true)

func _on_arrow_left_area_clicked():
	lower_button(1)
	$arrow_left/AudioStreamPlayer.play()
	led_switch(navigation_led_pos, false)
	navigation_led_pos.x -= 1
	led_switch(navigation_led_pos, true)

func _on_arrow_down_area_clicked():
	lower_button(3)
	$arrow_down/AudioStreamPlayer.play()
	led_switch(navigation_led_pos, false)
	navigation_led_pos.y += 1
	led_switch(navigation_led_pos, true)

func _on_arrow_right_mouse_entered():
	change_arrow_color(get_child(0), hover_yellow)

func _on_arrow_left_mouse_entered():
	change_arrow_color(get_child(1), hover_yellow)

func _on_arrow_up_mouse_entered():
	change_arrow_color(get_child(2), hover_yellow)

func _on_arrow_down_mouse_entered():
	change_arrow_color(get_child(3), hover_yellow)

func _on_arrow_right_mouse_exited():
	change_arrow_color(get_child(0), arrow_grey)

func _on_arrow_left_mouse_exited():
	change_arrow_color(get_child(1), arrow_grey)

func _on_arrow_up_mouse_exited():
	change_arrow_color(get_child(2), arrow_grey)

func _on_arrow_down_mouse_exited():
	change_arrow_color(get_child(3), arrow_grey)

func _on_launch_button_mouse_entered():
	change_arrow_color(get_child(4), hover_yellow)

func _on_launch_button_mouse_exited():
	change_arrow_color(get_child(4), red)

func _on_launch_button_area_clicked():
	lower_button(4)
	emit_signal("warp_to_pos", center_led_pos.y - navigation_led_pos.y, navigation_led_pos.x - center_led_pos.x)
	emit_signal("exit_nav_console")
