extends ControlCustom



func _on_BasicAttack_pressed():
	is_dragging = true


func _on_BasicAttack_released():
	is_dragging = false
