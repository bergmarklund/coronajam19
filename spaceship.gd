extends Spatial



# Called when the node enters the scene tree for the first time.
func _ready():
	$InterpolatedCamera.enabled = true
	$InterpolatedCamera.set_target($camera_origin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event is InputEventMouseButton:	
		if(event.pressed && event.button_index == BUTTON_RIGHT):
			$InterpolatedCamera.set_target($camera_origin)

func _on_nav_console_area_clicked():
	$InterpolatedCamera.set_target($camera_console_nav)


func _on_msg_console_area_clicked():
	$InterpolatedCamera.set_target($camera_console_msg)
