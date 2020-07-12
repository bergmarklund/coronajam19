extends Spatial

# LED Colors
var green = Color(0.11,0.38,0.11)
var nav_green = Color(0.2,0.4,0.2)
var yellow = Color(1,1,0)
var blue = Color(0,0,1)
var red = Color(1,0,0)

var blinking_speed_in_seconds = 0.5
var navigation_led_color_state = 0
var nav_time = 0
var discover_time = 0

var navigation_led_blinking = false
var nearby_ship_led_blinking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	change_led_color(green)

func change_led_color(color):
	var material = SpatialMaterial.new()
	material.albedo_color = color
	for i in range(2,6):
		get_child(i).set_surface_material(0, material)

func blinking_navigation_led(base_color):
	var color = base_color
	if navigation_led_color_state % 2 == 0:
		color = nav_green
	change_led_color(color)
	navigation_led_color_state += 1
	
func activate_navigation_led():
	navigation_led_blinking = true

func disable_navigation_led():
	navigation_led_blinking = false

func disable_nearby_ship_led_blinking():
	nearby_ship_led_blinking = false

func activate_nearby_ship_led_blinking():
	nearby_ship_led_blinking = true

func _process(_delta):
	nav_time += _delta
	discover_time += _delta
	if navigation_led_blinking and nav_time > blinking_speed_in_seconds:
		blinking_navigation_led(yellow)
		nav_time = 0
	if nearby_ship_led_blinking and discover_time > blinking_speed_in_seconds:
		blinking_navigation_led(blue)
		discover_time = 0
	
		
