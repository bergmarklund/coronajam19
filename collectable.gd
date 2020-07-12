extends "res://clickable_area.gd"
signal collectable_clicked

var id = null

func _ready():
	self.connect("area_clicked", self, "_on_area_clicked")
	
func _on_area_clicked():
	emit_signal("collectable_clicked", id)
	queue_free()
