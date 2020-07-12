extends Spatial

var collectibles = {
	"collectible_alien": preload("res://collectible_scenes/collectible_alien.tscn"),
	"collectible_hot_carrot": preload("res://collectible_scenes/collectible_hot_carrot.tscn"),
	"collectible_plant_palm": preload("res://collectible_scenes/collectible_plant_palm.tscn"),
	"collectible_plant_small": preload("res://collectible_scenes/collectible_plant_small.tscn"),
	"collectible_plant_tree": preload("res://collectible_scenes/collectible_plant_tree.tscn")
}

var displayed_items = []
var deleted_items = []

func display_items(items):
	for i in items:
		show_item(i, items[i])

func show_item(id, name):
	if (has_item(id)):
		return
	add_item(id, name)
	
func add_item(id, name):
	var collectible_resource = collectibles[name]
	var collectible_item = collectible_resource.instance()
	collectible_item.connect("collectable_clicked", self, "_on_item_clicked")
	
	collectible_item.id = id
	
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
	displayed_items.append(id)
	
func has_item(id):
	return displayed_items.has(id) || deleted_items.has(id)

func _process(delta):
	for node in get_children():
		if( int(node.get_name()) % 2 == 0):
			node.rotate_y(0.1 * delta)
		else:
			node.rotate_y(0.8 * delta)
			
func _on_item_clicked(id):
	Multiplayer.dispose(id)
	displayed_items.erase(id)
	deleted_items.append(id)
	
func clear_deleted_items():
	deleted_items = []
