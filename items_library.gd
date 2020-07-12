extends Spatial

var collectibles = {
	"collectible_alien": "res://collectible_scenes/collectible_alien.tscn",
	"collectible_hot_carrot": "res://collectible_scenes/collectible_hot_carrot.tscn",
	"collectible_plant_palm": "res://collectible_scenes/collectible_plant_palm.tscn",
	"collectible_plant_small": "res://collectible_scenes/collectible_plant_small.tscn",
	"collectible_plant_tree": "res://collectible_scenes/collectible_plant_tree.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready():

	add_item(1, "collectible_alien")
	
func add_item(id, name):
	var collectible_resource = load(collectibles[name])
	var collectible_item = collectible_resource.instance()
	
	collectible_item.set_name(String(id))
	
	var rng = RandomNumberGenerator.new()
	rng.set_seed(id)
	rng.randomize()
	
	var offset_x = rng.randf_range(-2, 2)
	var offset_z = rng.randf_range(-2, 2)
	collectible_item.translate(Vector3(offset_x, 0, offset_z))
	
	add_child(collectible_item)
	
func _process(delta):
	for node in get_children():
		node.rotate_y(1 * delta)
