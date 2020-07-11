extends Spatial
signal light_switch_clicked

func _on_Area_area_clicked():
	emit_signal("light_switch_clicked")
