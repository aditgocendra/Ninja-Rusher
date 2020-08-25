extends Control

onready var label_setting = $Background/ContainerSetting/LabelSetting
onready var sound_setting = preload("res://src/UserInterface/SubSettings/Sound/Sound.tscn").instance()
onready var general_setting = preload("res://src/UserInterface/SubSettings/General/General.tscn").instance()
onready var control_scene = "res://src/UserInterface/SubSettings/Control/Control.tscn"
onready var first_menu = "res://src/UserInterface/FirstMenu/FirstMenu.tscn"


func _on_TouchGeneral_pressed():
	if label_setting.text != "General":
		label_setting.text = "General"
		$Background/ContainerSetting.remove_child($Background/ContainerSetting.get_child(1))
		$Background/ContainerSetting.add_child(general_setting)


func _on_TouchSound_pressed():
	if label_setting.text != "Sound":
		label_setting.text = "Sound"
		$Background/ContainerSetting.remove_child($Background/ContainerSetting.get_child(1))
		$Background/ContainerSetting.add_child(sound_setting)


func _on_TouchControl_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(control_scene)


func _on_TouchBack_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(first_menu)
