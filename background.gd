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

var rng = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reload(rng_seed):
	rng = RandomNumberGenerator.new()
	rng.set_seed(rng_seed)
	draw()

func draw():
	draw_planets()

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
		if pos.get_child_count() > 0: 
			var children = pos.get_children()
			for child in children:
				child.queue_free()
		
