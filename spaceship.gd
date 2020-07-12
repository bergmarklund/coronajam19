extends Spatial
signal display_nav_console
signal display_msg_console

var camera_start = 0
var can_go_to_panels = true
var rng_seed = 0

var lock_ship = false

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
	$background.connect("warp_done", self, "_on_warp_done")
	reload_background(rng_seed)

func reload_background(_rng_seed):
	rng_seed = _rng_seed
	if !lock_ship:
		$background.reload(rng_seed)
	
func do_warp(distance):
	lock_ship = true 
	$background.do_warp(distance)

func _on_warp_done():
	lock_ship = false
	reload_background(rng_seed)

func _input(event):
	if event is InputEventMouseButton:	
		if(event.pressed && event.button_index == BUTTON_RIGHT && !lock_ship):
			$InterpolatedCamera.set_target($camera_origin)

func _on_nav_console_area_clicked():
	if !lock_ship:
		$InterpolatedCamera.set_target($camera_console_nav)


func _on_msg_console_area_clicked():
	if !lock_ship:
		$InterpolatedCamera.set_target($camera_console_msg)
		
func _on_item_collect_area_clicked():
	Multiplayer.collect()


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
	$OmniLight.visible = !$OmniLight.visible
