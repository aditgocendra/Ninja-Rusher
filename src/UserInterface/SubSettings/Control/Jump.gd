extends ControlCustom



func _on_Jump_pressed():
	get_parent().get_parent().get_current_btn(self)
	get_parent().get_parent().setScaleSlider(self.scale)
	get_parent().get_parent().set_transparency(self.modulate)
	is_dragging = true


func _on_Jump_released():
	is_dragging = false