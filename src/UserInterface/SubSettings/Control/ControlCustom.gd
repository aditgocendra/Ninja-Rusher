extends TouchScreenButton
class_name ControlCustom

var is_dragging = false


func _process(_delta):
	if (is_dragging):
			var pos = get_viewport().get_mouse_position()
			set_position(pos)
			get_parent().get_parent().setLabelPos(pos)


func changeScale(new_scale, node) -> void:
	if node != null:
		node.scale = Vector2(new_scale, new_scale)
		
func changeTransparency(new_modulate, node) -> void:
	if node != null:
		node.modulate.a = new_modulate
