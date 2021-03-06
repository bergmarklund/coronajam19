extends Spatial
signal display_nav_console
signal display_msg_console
signal toggle_radio

var camera_start = 0
var can_go_to_panels = true

var lock_ship = false
var warp_back = false

func _ready():
	var start = $camera_origin
	if camera_start == 1:
		start = $control_panel_nav/camera_position
		can_go_to_panels = false
	elif camera_start == 2:
		start = $control_panel_msg/camera_position
		can_go_to_panels = false

	$InterpolatedCamera.transform = start.global_transform
	$InterpolatedCamera.enabled = true
	$background.connect("warp_done", self, "_on_warp_done")
	reload_background(warp_back)

func reload_background(_warp_back = false):
	$background.reload_scale_back = _warp_back
	$background.reload()
	
func do_warp(distance):
	lock_ship = true
	$background.do_warp(distance)

func _on_warp_done():
	lock_ship = false

func update_location_display(row, col):
	$location_display.render_location(row, col)
	
	
func _input(event):
	if event is InputEventMouseButton:	
		if(event.pressed && event.button_index == BUTTON_RIGHT && !lock_ship):
			$InterpolatedCamera.set_target($camera_origin)

func _on_nav_console_area_clicked():
	if !lock_ship:
		$InterpolatedCamera.set_target($control_panel_nav/camera_position)


func _on_msg_console_area_clicked():
	if !lock_ship:
		$InterpolatedCamera.set_target($control_panel_msg/camera_position)

func _on_trash_can_area_clicked():
	if !lock_ship:
		Multiplayer.collect()
		$items_library.clear_deleted_items()


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


func _on_light_switch_light_switch_clicked():
	$space_light.visible = !$space_light.visible


func _on_radio_area_clicked():
	emit_signal("toggle_radio")

func display_items(items):
	$items_library.display_items(items)

func display_neighbors(ids):
	$background.display_neighbors(ids)
