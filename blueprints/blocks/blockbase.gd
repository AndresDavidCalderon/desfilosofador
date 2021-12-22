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
	if get_node_or_null("select"):
		var new=Button.new()
		new.rect_position=Vector2(-10,-10)
		new.rect_size=Vector2(20,20)+rect_size
		new.connect("button_down",self,"_on_select_button_down")
		new.connect("button_down",self,"_on_select_button_up")
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
		if has_method("ondelete"):
			var answer=call("ondelete")
			if answer!=null:
				match answer:
					"cancel":
						return
		queue_free()
func getsave()->Dictionary:
	var dict={}
	dict["type"]=type
	dict["connections"]={}
	var connectionlist=dict["connections"]
	for i in connections:
		connectionlist[i.savename]={}
		var connection=connectionlist[i.savename]
		if i.target!=null:
			connection["toidx"]=i.target.get_index()
			connection["toname"]=i.target.savename
		if i.impliedvalue!=null:
			connection["impliedvalue"]=i.impliedvalue
		connection["type"]=i.connectname
	if has_method("customsave"):
		call("customsave",dict)
	return dict
