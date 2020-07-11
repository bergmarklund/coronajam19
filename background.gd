extends Spatial


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
	preload("background_scenes/stars/star_3.tscn")
]

var rng = null
var initial_sun_rotation = null
var planet_rotation_max = [0.002, 0.009, 0.02]
var planet_rotations = [0.0, 0.0, 0.0]
# Called when the node enters the scene tree for the first time.
func _ready():
	initial_sun_rotation = $DirectionalLight.rotation

func reload(rng_seed):
	rng = RandomNumberGenerator.new()
	rng.set_seed(rng_seed)
	draw()
	
func _process(delta):
	rotate_planets()

func rotate_planets():
	var positions = $planets.get_children()
	var idx = 0
	for pos in positions:
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
	for pos in positions:
		var i = rng.randi_range(0, len(planets) -1)
		var planet = planets[i].instance()
		pos.add_child(planet)
	
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
	for pos in positions:
		for i in range(0, 50):
			for j in range(0, 50):
				if(rng.randf() < 0.1):
					var n = rng.randi_range(0, len(stars) -1)		
					var star = stars[n].instance()
					var offset = Vector3(0, -i * 2, j * 2 )
					star.translate(offset)
					pos.add_child(star)
	
func clear_stars():
	var positions = $stars.get_children()
	for pos in positions:
		delete_children(pos)
