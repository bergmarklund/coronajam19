extends Spatial

var collectibles = {
	"collectible_alien": "res://collectible_scenes/collectible_alien.tscn",
	"collectible_hot_carrot": "res://collectible_scenes/collectible_hot_carrot.tscn",
	"collectible_plant_palm": "res://collectible_scenes/collectible_plant_palm.tscn",
	"collectible_plant_small": "res://collectible_scenes/collectible_plant_small.tscn",
	"collectible_plant_tree": "res://collectible_scenes/collectible_plant_tree.tscn"
}

func display_items(items):
	for i in items:
		show_item(i, items[i])
	
# Called when the node enters the scene tree for the first time.
func _ready():
	return
	
func show_item(id, name):
	if (has_item(id)):
		return
	add_item(id, name)
	
func add_item(id, name):
	var collectible_resource = load(collectibles[name])
	var collectible_item = collectible_resource.instance()
	
	collectible_item.set_name(String(id))
	
	var rng = RandomNumberGenerator.new()
	rng.set_seed(id)
	rng.randomize()
	
	var offset_x = rng.randf_range(-1.0, 2.0)
	var offset_y = rng.randf_range(0, 2.0)
	var offset_z = rng.randf_range(-1.8, 1.8)
	
	collectible_item.translate(Vector3(offset_x, offset_y, offset_z))
	collectible_item.rotate_x(rng.randf_range(0, 90))
	collectible_item.rotate_y(rng.randf_range(0, 90))
	collectible_item.rotate_z(rng.randf_range(0, 90))
	
	add_child(collectible_item)
	
func has_item(id):
	for node in get_children():
		if (node.get_name() == String(id)):
			return true
	return false

func _process(delta):
	for node in get_children():
		if( int(node.get_name()) % 2 == 0):
			node.rotate_y(0.1 * delta)
		else:
			node.rotate_y(0.8 * delta)
