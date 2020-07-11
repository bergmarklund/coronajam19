extends Spatial
signal display_nav_console
signal display_msg_console

var camera_start = 0
var can_go_to_panels = true

func _ready():
	var start = $camera_origin
	if camera_start == 1:
		start = $camera_console_nav
		can_go_to_panels = false
	elif camera_start == 2:
		start = $camera_console_msg
		can_go_to_panels = false

	$InterpolatedCamera.translation = start.translation
	$InterpolatedCamera.rotation = start.rotation
	$InterpolatedCamera.enabled = true
	$background.reload(5)

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


func _on_nav_console_body_entered(body):
	print(body)


func _on_nav_console_area_entered(area):
	if(area == $InterpolatedCamera/Area && can_go_to_panels):
		emit_signal("display_nav_console")


func _on_nav_console_area_exited(area):
	if(area == $InterpolatedCamera/Area):
		can_go_to_panels = true


func _on_msg_console_area_entered(area):
	if(area == $InterpolatedCamera/Area && can_go_to_panels):
		emit_signal("display_msg_console")


func _on_msg_console_area_exited(area):
	if(area == $InterpolatedCamera/Area):
		can_go_to_panels = true
