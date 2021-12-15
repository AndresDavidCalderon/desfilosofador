extends Panel
class_name blockbase,"res://blueprints/blockbase.png"
export(String) var type
var following:bool=false
var offset:Vector2
var base:Viewport
var connections=[]
func _ready():
	if base==null:
		base=get_parent()
func _on_select_button_down():
	following=true
	offset=rect_position-get_global_mouse_position()

func _on_select_button_up():
	following=false

func _process(_delta):
	if following:
		rect_position=get_global_mouse_position()+offset

func _input(event):
	if event.is_action_pressed("delete") and following:
		queue_free()
func getsave()->Dictionary:
	var dict={}
	dict["type"]=type
	for i in connections:
		dict[i.savename]={}
		dict[i.savename]["to"]=i.target.get_index()
		dict[i.savename]["type"]=i.target.connectname
	if has_method("customsave"):
		call("customsave",dict)
	return dict
