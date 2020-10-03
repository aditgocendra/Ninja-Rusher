extends CanvasLayer

var data 

onready var basic_attack = $ContainerRightBot/BasicAttack
onready var throw = $ContainerRightBot/Throw
onready var glide = $ContainerRightBot/Glide
onready var slide = $ContainerRightBot/Slide
onready var dash = $ContainerRightBot/Dash
onready var jump = $ContainerRightBot/Jump
onready var left = $Left
onready var right = $Right
onready var pause = $ContainerLeftUp/Pause


func _ready():
	data = Autoload.load_data()
	var control_data =  get_config_control()
	set_pos_btn(control_data)
	set_transparency_btn(control_data)
	set_scale_btn(control_data)
	
	
func get_config_control():
	return data["game_settings"]["control"]
	

func set_pos_btn(control_data):
	var pos_basic_attack =  control_data["basic_attack"]["position"]
	var pos_dash =  control_data["dash"]["position"]
	var pos_glide =  control_data["glide"]["position"]
	var pos_jump =  control_data["jump"]["position"]
	var pos_slide =  control_data["slide"]["position"]
	var pos_throw =  control_data["throw"]["position"]
	var pos_left =  control_data["left"]["position"]
	var pos_right =  control_data["right"]["position"]
	var pos_pause =  control_data["pause"]["position"]
	
	basic_attack.position = Vector2(pos_basic_attack["x"], pos_basic_attack["y"])
	dash.position = Vector2(pos_dash["x"], pos_dash["y"])
	glide.position = Vector2(pos_glide["x"], pos_glide["y"])
	jump.position = Vector2(pos_jump["x"], pos_jump["y"])
	slide.position = Vector2(pos_slide["x"], pos_slide["y"])
	throw.position = Vector2(pos_throw["x"], pos_throw["y"])
	left.position = Vector2(pos_left["x"], pos_left["y"])
	right.position = Vector2(pos_right["x"], pos_right["y"])
	pause.position = Vector2(pos_pause["x"], pos_pause["y"])
	
	
func set_transparency_btn(control_data):
	var modulate_throw = control_data["throw"]["modulate"]
	var modulate_glide = control_data["glide"]["modulate"]
	var modulate_slide = control_data["slide"]["modulate"]
	var modulate_dash = control_data["dash"]["modulate"]
	var modulate_jump = control_data["jump"]["modulate"]
	var modulate_left = control_data["left"]["modulate"]
	var modulate_right = control_data["right"]["modulate"]
	var modulate_pause = control_data["pause"]["modulate"]
	var modulate_basic_attack = control_data["basic_attack"]["modulate"]
	
	throw.modulate = Color(modulate_throw["r"], modulate_throw["g"], modulate_throw["b"], modulate_throw["a"])
	glide.modulate = Color(modulate_glide["r"], modulate_glide["g"], modulate_glide["b"], modulate_glide["a"])
	slide.modulate = Color(modulate_slide["r"], modulate_slide["g"], modulate_slide["b"], modulate_slide["a"])
	dash.modulate = Color(modulate_dash["r"], modulate_dash["g"], modulate_dash["b"], modulate_dash["a"])
	jump.modulate = Color(modulate_jump["r"], modulate_jump["g"], modulate_jump["b"], modulate_jump["a"])
	left.modulate = Color(modulate_left["r"], modulate_left["g"], modulate_left["b"], modulate_left["a"])
	right.modulate = Color(modulate_right["r"], modulate_right["g"], modulate_right["b"], modulate_right["a"])
	pause.modulate = Color(modulate_pause["r"], modulate_pause["g"], modulate_pause["b"], modulate_pause["a"])
	basic_attack.modulate = Color(modulate_basic_attack["r"], modulate_basic_attack["g"], modulate_basic_attack["b"], modulate_basic_attack["a"])
	
	
func set_scale_btn(control_data):
	var scale_throw = control_data["throw"]["scale"]
	var scale_glide = control_data["glide"]["scale"]
	var scale_slide = control_data["slide"]["scale"]
	var scale_dash = control_data["dash"]["scale"]
	var scale_jump = control_data["jump"]["scale"]
	var scale_left = control_data["left"]["scale"]
	var scale_right = control_data["right"]["scale"]
	var scale_pause = control_data["pause"]["scale"]
	var scale_basic_attack = control_data["basic_attack"]["scale"]
	
	throw.scale = Vector2(scale_throw["x"],scale_throw["y"])
	glide.scale = Vector2(scale_glide["x"],scale_glide["y"])
	slide.scale = Vector2(scale_slide["x"],scale_slide["y"])
	dash.scale = Vector2(scale_dash["x"],scale_dash["y"])
	jump.scale = Vector2(scale_jump["x"],scale_jump["y"])
	left.scale = Vector2(scale_left["x"],scale_left["y"])
	right.scale = Vector2(scale_right["x"],scale_right["y"])
	pause.scale = Vector2(scale_pause["x"],scale_pause["y"])
	basic_attack.scale = Vector2(scale_basic_attack["x"],scale_basic_attack["y"])
