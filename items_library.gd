extends Spatial


var collectibles = {
	"collectible_alien": preload("res://assets/sounds/communication/receive/A_low.wav"),
	"collectible_hot_carrot": preload("res://assets/sounds/communication/receive/B_low.wav"),
	"collectible_plant_palm": preload("res://assets/sounds/communication/receive/C_low.wav"),
	"collectible_plant_small": preload("res://assets/sounds/communication/receive/D_high.wav"),
	"collectible_plant_tree": preload("res://assets/sounds/communication/receive/D_low.wav"),
}

func display_items(items):
	print("displaying items")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
