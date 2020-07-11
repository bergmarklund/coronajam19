extends Spatial

var led = preload("res://led.tscn")
# var led_nodes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	render_grid()

func render_grid():
	for i in range(31):
		for j in range(31):
			render_led(i,j)

func render_led(x_pos, y_pos):
	var posistion = Vector3(x_pos-15, 1.25, y_pos-15)
	var led_node = led.instance()
	led_node.set_translation(posistion)
	# led_nodes.append(led_node)
	self.add_child(led_node)
	if x_pos == 29:
		print(posistion)
	#print("created a node at pos " + str(posistion))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
