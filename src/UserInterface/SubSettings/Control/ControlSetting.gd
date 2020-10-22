extends Control

onready var setting_scene = "res://src/UserInterface/Settings/Settings.tscn"

# button
onready var basic_attack = $ControlUI/RightBottomContainer/BasicAttack
onready var throw = $ControlUI/RightBottomContainer/Throw
onready var glide = $ControlUI/RightBottomContainer/Glide
onready var slide = $ControlUI/RightBottomContainer/Slide
onready var dash = $ControlUI/RightBottomContainer/Dash
onready var jump = $ControlUI/RightBottomContainer/Jump
onready var left = $ControlUI/Left
onready var right = $ControlUI/Right
onready var pause = $ControlUI/RightTopContainer/Pause

#label position
onready var label_x = $Panel/VBoxContainer/HBoxPosition/X
onready var label_y = $Panel/VBoxContainer/HBoxPosition/Y

#slider 
onready var slider_scale = $Panel/VBoxContainer/HboxScale/HSlider
onready var slide_transparency = $Panel/VBoxContainer/HboxTransparency/HSlider

onready var data  = Autoload.load_data()

var current_node = null

func _ready():
	set_pos_btn(data)
	set_scale_btn(data)
	set_transparency_btn(data)

func set_pos_btn(data_game):
	var control_sett = data_game["game_settings"]["control"]
	
	var pos_throw = control_sett["throw"]["position"]
	var pos_glide = control_sett["glide"]["position"]
	var pos_slide = control_sett["slide"]["position"]
	var pos_dash = control_sett["dash"]["position"]
	var pos_jump = control_sett["jump"]["position"]
	var pos_left = control_sett["left"]["position"]
	var pos_right = control_sett["right"]["position"]
	var pos_pause = control_sett["pause"]["position"]
	var pos_basic_attack = control_sett["basic_attack"]["position"]
	
	throw.position = Vector2(pos_throw["x"],pos_throw["y"])
	glide.position = Vector2(pos_glide["x"],pos_glide["y"])
	slide.position = Vector2(pos_slide["x"],pos_slide["y"])
	dash.position = Vector2(pos_dash["x"],pos_dash["y"])
	jump.position = Vector2(pos_jump["x"],pos_jump["y"])
	left.position = Vector2(pos_left["x"],pos_left["y"])
	right.position = Vector2(pos_right["x"],pos_right["y"])
	pause.position = Vector2(pos_pause["x"],pos_pause["y"])
	basic_attack.position = Vector2(pos_basic_attack["x"],pos_basic_attack["y"])


func set_scale_btn(data_game):
	var control_sett = data_game["game_settings"]["control"]
	
	var scale_throw = control_sett["throw"]["scale"]
	var scale_glide = control_sett["glide"]["scale"]
	var scale_slide = control_sett["slide"]["scale"]
	var scale_dash = control_sett["dash"]["scale"]
	var scale_jump = control_sett["jump"]["scale"]
	var scale_left = control_sett["left"]["scale"]
	var scale_right = control_sett["right"]["scale"]
	var scale_pause = control_sett["pause"]["scale"]
	var scale_basic_attack = control_sett["basic_attack"]["scale"]
	
	throw.scale = Vector2(scale_throw["x"],scale_throw["y"])
	glide.scale = Vector2(scale_glide["x"],scale_glide["y"])
	slide.scale = Vector2(scale_slide["x"],scale_slide["y"])
	dash.scale = Vector2(scale_dash["x"],scale_dash["y"])
	jump.scale = Vector2(scale_jump["x"],scale_jump["y"])
	left.scale = Vector2(scale_left["x"],scale_left["y"])
	right.scale = Vector2(scale_right["x"],scale_right["y"])
	pause.scale = Vector2(scale_pause["x"],scale_pause["y"])
	basic_attack.scale = Vector2(scale_basic_attack["x"],scale_basic_attack["y"])


func set_transparency_btn(data_game):
	var control_sett = data_game["game_settings"]["control"]
	
	var modulate_throw = control_sett["throw"]["modulate"]
	var modulate_glide = control_sett["glide"]["modulate"]
	var modulate_slide = control_sett["slide"]["modulate"]
	var modulate_dash = control_sett["dash"]["modulate"]
	var modulate_jump = control_sett["jump"]["modulate"]
	var modulate_left = control_sett["left"]["modulate"]
	var modulate_right = control_sett["right"]["modulate"]
	var modulate_pause = control_sett["pause"]["modulate"]
	var modulate_basic_attack = control_sett["basic_attack"]["modulate"]
	
	throw.modulate = Color(modulate_throw["r"], modulate_throw["g"], modulate_throw["b"], modulate_throw["a"])
	glide.modulate = Color(modulate_glide["r"], modulate_glide["g"], modulate_glide["b"], modulate_glide["a"])
	slide.modulate = Color(modulate_slide["r"], modulate_slide["g"], modulate_slide["b"], modulate_slide["a"])
	dash.modulate = Color(modulate_dash["r"], modulate_dash["g"], modulate_dash["b"], modulate_dash["a"])
	jump.modulate = Color(modulate_jump["r"], modulate_jump["g"], modulate_jump["b"], modulate_jump["a"])
	left.modulate = Color(modulate_left["r"], modulate_left["g"], modulate_left["b"], modulate_left["a"])
	right.modulate = Color(modulate_right["r"], modulate_right["g"], modulate_right["b"], modulate_right["a"])
	pause.modulate = Color(modulate_pause["r"], modulate_pause["g"], modulate_pause["b"], modulate_pause["a"])
	basic_attack.modulate = Color(modulate_basic_attack["r"], modulate_basic_attack["g"], modulate_basic_attack["b"], modulate_basic_attack["a"])


func setNewControl() -> void :
	var new_set_control = null
	new_set_control = {
		basic_attack= {
		  modulate= {
			a= basic_attack.modulate.a,
			b= basic_attack.modulate.b,
			g= basic_attack.modulate.g,
			r= basic_attack.modulate.r
		  },
		  position= {
			x= basic_attack.position.x,
			y= basic_attack.position.y
		  },
		  scale={
			x=basic_attack.scale.x,
			y=basic_attack.scale.y
		  }
		},
		throw= {
		  modulate= {
			a= throw.modulate.a,
			b= throw.modulate.b,
			g= throw.modulate.g,
			r= throw.modulate.r
		  },
		  position= {
			x= throw.position.x,
			y= throw.position.y
		  },
		  scale={
			x=throw.scale.x,
			y=throw.scale.y
		  }
		},
		slide= {
		  modulate= {
			a= slide.modulate.a,
			b= slide.modulate.b,
			g= slide.modulate.g,
			r= slide.modulate.r
		  },
		  position= {
			x= slide.position.x,
			y= slide.position.y
		  },
		  scale={
			x=slide.scale.x,
			y=slide.scale.y
		  }
		},
		glide= {
		  modulate= {
			a= glide.modulate.a,
			b= glide.modulate.b,
			g= glide.modulate.g,
			r= glide.modulate.r
		  },
		  position= {
			x= glide.position.x,
			y= glide.position.y
		  },
		  scale={
			x= glide.scale.x,
			y= glide.scale.y
		  }
		},
		dash= {
		  modulate= {
			a= dash.modulate.a,
			b= dash.modulate.b,
			g= dash.modulate.g,
			r= dash.modulate.r
		  },
		  position= {
			x= dash.position.x,
			y= dash.position.y
		  },
		  scale={
			x=dash.scale.x,
			y=dash.scale.y
		  }
		},
		jump= {
		  modulate= {
			a= jump.modulate.a,
			b= jump.modulate.b,
			g= jump.modulate.g,
			r= jump.modulate.r
		  },
		  position= {
			x= jump.position.x,
			y= jump.position.y
		  },
		  scale={
			x=jump.scale.x,
			y=jump.scale.y
		  }
		},
		right= {
		  modulate= {
			a= right.modulate.a,
			b= right.modulate.b,
			g= right.modulate.g,
			r= right.modulate.r
		  },
		  position= {
			x= right.position.x,
			y= right.position.y
		  },
		  scale={
			x=right.scale.x,
			y=right.scale.y
		  }
		},
		left= {
		  modulate= {
			a= left.modulate.a,
			b= left.modulate.b,
			g= left.modulate.g,
			r= left.modulate.r
		  },
		  position= {
			x= left.position.x,
			y= left.position.y
		  },
		  scale={
			x=left.scale.x,
			y=left.scale.y
		  }
		},
		pause= {
		  modulate= {
			a= pause.modulate.a,
			b= pause.modulate.b,
			g= pause.modulate.g,
			r= pause.modulate.r
		  },
		  position= {
			x= pause.position.x,
			y= pause.position.y
		  },
		  scale={
			x=pause.scale.x,
			y=pause.scale.y
		  }
		}
	}
	
	saveNewCustControl(new_set_control)

func setDefaultControl() -> void:
	var default_data = Autoload.default_data
	var default_control = default_data["game_settings"]["control"]
	
	saveNewCustControl(default_control)
	set_pos_btn(default_data)
	set_scale_btn(default_data)
	set_transparency_btn(default_data)

func saveNewCustControl(new_control) -> void:
	data["game_settings"]["control"] = new_control
	Autoload.save_data(data)


func setLabelPos(new_pos : Vector2) -> void :
	label_x.set_text("X :  %d" % [new_pos.x])
	label_y.set_text("Y :  %d" % [new_pos.y])


func get_current_btn(last_node):
	current_node = last_node


func setScaleSlider(scale):
	slider_scale.value = scale.x
	
func set_transparency(_modulate):
	slide_transparency.value = _modulate.a
	

func _on_Exit_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(setting_scene)


func _on_Save_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			setNewControl()


func _on_Reset_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			setDefaultControl()


func _on_Scale_value_changed(value):
	ControlCustom.new().changeScale(value, current_node)


func _on_Transparency_value_changed(value):
	ControlCustom.new().changeTransparency(value, current_node)
