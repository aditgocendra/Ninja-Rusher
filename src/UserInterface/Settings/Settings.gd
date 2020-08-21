extends Control

onready var label_setting = $Background/VBoxContainer2/LabelSetting
onready var sound_setting = preload("res://src/UserInterface/SubSettings/Sound/Sound.tscn").instance()
onready var control_scene = "res://src/UserInterface/SubSettings/Control/Control.tscn"
onready var first_menu = "res://src/UserInterface/FirstMenu/FirstMenu.tscn"




func _on_TouchGeneral_pressed():
	label_setting.text = "General"


func _on_TouchSound_pressed():
	label_setting.text = "Sound"


func _on_TouchControl_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(control_scene)


func _on_TouchBack_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(first_menu)
