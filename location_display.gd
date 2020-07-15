extends Spatial

var led = preload("res://led.tscn")
var digit_per_col = 8
var digits_in_row = []
var digits_in_col = []

var start_pos = start_pos
var distance_between_digits = 4
var current_dist_between_leds = 0 

var segments_in_digit = {}
var digit_func_map = {}

var green = Color(0.11, 0.38, 0.11, 0.2)

func _ready():
	start_pos = $LED.transform.origin
	digits_in_row = render_grid()
	current_dist_between_leds += distance_between_digits
	digits_in_col = render_grid()
	
func calc_digit_segments(leds_in_digit):
	segments_in_digit = {
		"up" : [leds_in_digit[0][0], leds_in_digit[1][0], leds_in_digit[2][0]],
		"mid" : [leds_in_digit[0][2], leds_in_digit[1][1], leds_in_digit[2][2]],
		"down" : [leds_in_digit[0][-1], leds_in_digit[1][-1], leds_in_digit[2][-1]],
		"up_left" : [leds_in_digit[0][0], leds_in_digit[0][1], leds_in_digit[0][2]],
		"up_right" : [leds_in_digit[2][0], leds_in_digit[2][1], leds_in_digit[2][2]],
		"down_left" : [leds_in_digit[0][2], leds_in_digit[0][3], leds_in_digit[0][4]],
		"down_right" : [leds_in_digit[2][2], leds_in_digit[2][3], leds_in_digit[2][4]],
		}
	
	#digit_func_map = {
	#	"-" : display_neg(leds_in_digit),
	#	"0" : display_zero(leds_in_digit),
	#	"1" : display_one(leds_in_digit),
	#	"2" : display_two(leds_in_digit),
	#	"3" : display_three(leds_in_digit),
	#	"4" : display_four(leds_in_digit),
	#	"5" : display_five(leds_in_digit),
	#	"6" : display_six(leds_in_digit),
	#	"7" : display_seven(leds_in_digit),
	#	"8" : display_eight(leds_in_digit),
	#	"9" : display_nine(leds_in_digit),
	#	}

func render_grid():
	var digits = []
	for digit in range(digit_per_col):
		var leds_in_digit = []
		for col in range(3):
			var led_col = []
			for row in range(5):
				if row % 2 == 1 and col == 1:
					continue
				var led_node = render_led(col + current_dist_between_leds,row)
				led_col.append(led_node)
			leds_in_digit.append(led_col)
		current_dist_between_leds += distance_between_digits
		digits.append(leds_in_digit)
	return digits
	
func render_led(x_pos, z_pos):
	var posistion = Vector3(x_pos + start_pos.x, 1.25 + start_pos.y, z_pos + start_pos.z)
	var led_node = led.instance()
	led_node.set_translation(posistion)
	self.add_child(led_node)
	return led_node

func render_location(row, col):
	clear_display(digits_in_row)
	clear_display(digits_in_col)
	if len(str(row)) > digit_per_col or len(str(col)) > digit_per_col:
		display_error(digits_in_row)
		display_error(digits_in_col)
	else:
		display_digits(row, digits_in_row)
		display_digits(col, digits_in_col)

func clear_display(digits):
	for digit in digits:
		for col in digit:
			for led in col:
				led.change_led_color(green)

func display_digits(posistion, digits):
	var str_pos = str(posistion)
	var i = 0
	for dig in str_pos:
		var leds_in_digit = digits[i]
		calc_digit_segments(leds_in_digit)
		#digit_func_map[dig]
		i += 1
		if dig == "-":
			display_neg()
		if dig == "0":
			display_zero()
		if dig == "1":
			display_one()
		if dig == "2":
			display_two()
		if dig == "3":
			display_three()
		if dig == "4":
			display_four()
		if dig == "5":
			display_five()
		if dig == "6":
			display_six()
		if dig == "7":
			display_seven()
		if dig == "8":
			display_eight()
		if dig == "9":
			display_nine()

func display_error(digits):
	var i = 0
	for ch in "error":
		var leds_in_digit = digits[i]
		calc_digit_segments(leds_in_digit)
		if ch == "e":
			display_e()
		if ch == "r":
			display_r()
		if ch == "o":
			display_zero()
		i += 1
	
func display_e():
	for led in segments_in_digit["up"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_left"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["mid"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_left"]:
		led.change_led_color(green, 10)	
	for led in segments_in_digit["down"]:
		led.change_led_color(green, 10)

func display_r():
	for led in segments_in_digit["up"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_left"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_left"]:
		led.change_led_color(green, 10)	
	
func display_neg():
	for led in segments_in_digit["mid"]:
		led.change_led_color(green, 10)

func display_zero():
	for led in segments_in_digit["up"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_left"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_left"]:
		led.change_led_color(green, 10)	
	for led in segments_in_digit["down"]:
		led.change_led_color(green, 10)
			
func display_one():
	for led in segments_in_digit["up_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_right"]:
		led.change_led_color(green, 10)

func display_two():
	for led in segments_in_digit["up"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["mid"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_left"]:
		led.change_led_color(green, 10)
	
func display_three():
	for led in segments_in_digit["up"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["mid"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_right"]:
		led.change_led_color(green, 10)	
	for led in segments_in_digit["down"]:
		led.change_led_color(green, 10)

func display_four():
	for led in segments_in_digit["up_left"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["mid"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_right"]:
		led.change_led_color(green, 10)	

func display_five():
	for led in segments_in_digit["up"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_left"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["mid"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down"]:
		led.change_led_color(green, 10)
	
func display_six():
	for led in segments_in_digit["up"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_left"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["mid"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_left"]:
		led.change_led_color(green, 10)	
	for led in segments_in_digit["down"]:
		led.change_led_color(green, 10)
	
func display_seven():
	for led in segments_in_digit["up"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_right"]:
		led.change_led_color(green, 10)	
	
func display_eight():
	for led in segments_in_digit["up"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_left"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["mid"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_left"]:
		led.change_led_color(green, 10)	
	for led in segments_in_digit["down"]:
		led.change_led_color(green, 10)
	
func display_nine():
	for led in segments_in_digit["up"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_left"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["up_right"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["mid"]:
		led.change_led_color(green, 10)
	for led in segments_in_digit["down_right"]:
		led.change_led_color(green, 10)	
