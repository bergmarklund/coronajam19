extends Spatial
signal warp_done


var planets = [
	preload("background_scenes/planets/planet_1.tscn"),
	preload("background_scenes/planets/planet_2.tscn"),
	preload("background_scenes/planets/planet_3.tscn"),
	preload("background_scenes/planets/planet_4.tscn"),
	preload("background_scenes/planets/planet_5.tscn"),
	preload("background_scenes/planets/planet_6.tscn"),
	preload("background_scenes/planets/planet_7.tscn"),
	preload("background_scenes/planets/planet_8.tscn"),
	preload("background_scenes/planets/planet_9.tscn"),
	preload("background_scenes/planets/planet_10.tscn")
]

var stars = [
	preload("background_scenes/stars/star_1.tscn"),
	preload("background_scenes/stars/star_2.tscn"),
	preload("background_scenes/stars/star_3.tscn"),
	preload("background_scenes/stars/star_4.tscn"),
	preload("background_scenes/stars/star_5.tscn"),
	preload("background_scenes/stars/star_6.tscn"),
	preload("background_scenes/stars/star_7.tscn"),
	preload("background_scenes/stars/star_8.tscn"),
	preload("background_scenes/stars/star_9.tscn"),
	preload("background_scenes/stars/star_10.tscn")
]

var rng = null
var initial_sun_rotation = null
var planet_rotation_max = [0.002, 0.009, 0.02]
var planet_rotations = [0.0, 0.0, 0.0]

var warping = false

var reload_scale_back = false
var scale_back_speed = 0.1

func _ready():
	initial_sun_rotation = $DirectionalLight.rotation

func reload(rng_seed):
	rng = RandomNumberGenerator.new()
	rng.set_seed(rng_seed)
	if !warping:
		reload_scale_back = true
		scale_back_speed = 0.1
		draw()
	
func _process(_delta):
	if warping:
		render_warp()
	elif reload_scale_back:
		scale_back_to_orignal()
	else:
		rotate_planets()

func scale_back_to_orignal():
	scale_back_nodes(get_all_stars())
	scale_back_nodes(get_all_planets())
	scale_back_speed += 0.05
	if scale_back_speed > 1:
		reload_scale_back = false

func scale_back_nodes(nodes):
	for node in nodes: 
		node.scale = node.scale.linear_interpolate(Vector3(1,1,1), scale_back_speed)
		node.translation = node.translation.linear_interpolate(Vector3(get_parent().translation.x, node.translation.y, node.translation.z), scale_back_speed)
		
	
func rotate_planets():
	var positions = $planets.get_children()
	var idx = 0
	for pos in positions:
		if(pos.get_child_count() > 0):
			var child = pos.get_children()
			if child[0]:
				child[0].rotate(Vector3(0, 1, 0), planet_rotations[idx])
		idx += 1 
		
func draw():
	draw_planets()
	draw_stars()
	draw_sun()
	randomize_rotations()
	
func randomize_rotations():
	var idx = 0
	for rot in planet_rotations:
		var i = rng.randf()
		planet_rotations[idx] = planet_rotation_max[idx] * i
		idx += 1
	
func draw_sun():
	$DirectionalLight.rotation = initial_sun_rotation
	var i = rng.randi_range(0, 360)
	var axis = Vector3(0, 1, 0)
	$DirectionalLight.rotate(axis, i)
	i = rng.randf_range(0.5, 4.0)
	$DirectionalLight.light_energy = i

func draw_planets():
	clear_planets()
	var positions = $planets.get_children()
	var planet_chance = 0.5
	for pos in positions:
		if(rng.randf() < planet_chance):
			var i = rng.randi_range(0, len(planets) -1)
			var planet = planets[i].instance()
			planet.scale.x += 100
			pos.add_child(planet)
			planet_chance -= 0.2
	
func clear_planets():
	var positions = $planets.get_children()
	for pos in positions:
		delete_children(pos)
	
func delete_children(node):
	if node.get_child_count() > 0: 
		var children = node.get_children()
		for child in children:
			child.queue_free()
		
func draw_stars():
	clear_stars()
	var positions = $stars.get_children()
	var idx = 0
	for pos in positions:
		for i in range(0, 50):
			for j in range(0, 50):
				if(rng.randf() < 0.1):
					var n = rng.randi_range(0, len(stars) -1)		
					var star = stars[n].instance()
					var offset = Vector3(100, -i * 2, j * 2 )
					star.translate(offset)
					star.scale.x += 100
					pos.add_child(star)
		idx += 1
	
func clear_stars():
	var positions = $stars.get_children()
	for pos in positions:
		delete_children(pos)

func do_warp(distance):
	warping = true
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = distance
	timer.connect("timeout", self, "_warp_done")
	add_child(timer)
	timer.start()

func _warp_done():
	print("warp_done")
	warping = false
	emit_signal("warp_done")
	
func warp_sun():
	$DirectionalLight.rotate(Vector3(0, 1, 0), 0.5)
	
func render_warp():
	warp_stars()
	warp_planets()
	warp_sun()
	
func warp_planets():
	var planets = get_all_planets()
	for planet in planets:
		planet.scale.x += 0.2
		planet.translation.x -= 0.25
	
func warp_stars():
	var stars = get_all_stars()
	for star in stars:
		star.scale.x += 1
		star.translation.x += 1
	
func get_all_stars():
	var stars = []
	var positions = $stars.get_children()
	for pos in positions:
		stars += pos.get_children()
	return stars

func get_all_planets():
	var planets = []
	var positions = $planets.get_children()
	for pos in positions:
		planets += pos.get_children()
	return planets
