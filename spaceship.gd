extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$InterpolatedCamera.enabled = true
	$InterpolatedCamera.set_target($camera_origin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
