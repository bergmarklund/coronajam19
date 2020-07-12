extends Spatial

# LED Colors
var green = Color(0.11, 0.38, 0.11, 0.2)
var nav_green = Color(0.2,0.4,0.2)
var yellow = Color(1,1,0)
var blue = Color(0,0,1)
var red = Color(1,0,0)

var blinking_speed_in_seconds_nav = 0.25
var blinking_speed_in_seconds_disc = 0.5
var navigation_led_color_state = 0
var nav_time = 0
var discover_time = 0

var navigation_led_blinking = false
var nearby_ship_led_blinking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	change_led_color(green)

func change_led_color(color, energy=1):
	var material = SpatialMaterial.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color
	material.emission_energy = energy
	material.metallic = 0.4
	material.roughness = 0.1
	material.refraction_enabled = true
	material.refraction_scale = 0.1
	for i in range(2,6):
		get_child(i).set_surface_material(0, material)

func blinking_navigation_led(base_color):
	change_led_color(base_color, 10)
	if navigation_led_color_state % 2 == 0:
		change_led_color(base_color)
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
	if navigation_led_blinking and nav_time > blinking_speed_in_seconds_nav:
		blinking_navigation_led(green)
		nav_time = 0
	if nearby_ship_led_blinking and discover_time > blinking_speed_in_seconds_disc:
		blinking_navigation_led(green)
		discover_time = 0
	
		
