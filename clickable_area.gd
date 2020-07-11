extends Node
signal area_clicked()

export (NodePath) var area_path = null

var mouse_over = false
var area = null

func _ready():
	area = get_node(area_path)
	area.connect("mouse_entered", self, "_mouse_entered_area")
	area.connect("mouse_exited", self, "_mouse_exited_area")

func _mouse_entered_area():
	mouse_over = true

func _mouse_exited_area():
	mouse_over = false
	
func _input(event):
	if event is InputEventMouseButton:	
		if(event.pressed && event.button_index == BUTTON_LEFT):
			if(mouse_over):
				emit_signal("area_clicked")
