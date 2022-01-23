extends Panel
class_name blockbase,"res://blueprints/blockbase.png"
export(String) var type
var following:bool=false
var offset:Vector2
var base:Viewport
onready var editor=base.get_parent().get_parent()
var connections=[]
var connection_by_name={}
var blockindex 

signal fromfile(dict)
func _ready():
	if base==null:
		base=get_parent()
	if get_node_or_null("select")==null:
		var new=Button.new()
		add_child(new)
		new.flat=true
		move_child(new,0)
		new.rect_position=Vector2(-10,-10)
		new.rect_size=Vector2(20,20)+rect_size
		new.connect("button_down",self,"_on_select_button_down")
		new.connect("button_up",self,"_on_select_button_up")
	else:
		$select.visible=true

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
		delete()

func delete(extra:Array=[]):
	if has_method("ondelete"):
		var answer=call("ondelete")
		if answer!=null:
			match answer:
				"cancel":
					if not extra.has("force"):
						return
	queue_free()


func fromfile(dict):
	rect_position.x=dict["pos"][0]
	rect_position.y=dict["pos"][1]
	if has_method("_fromfile"):
		call("_fromfile",dict)
		emit_signal("fromfile",dict)
	for i in dict["connections"].keys():
		var ref= dict["connections"][i]
		if connection_by_name.has(i):
			var connection=connection_by_name[i]
			if connection.type==compiler.CONNECTION_IN :
				if ref.has("toidx") and ref["toidx"]!=null:
					var external_connections=editor.blocks[ref["toidx"]].connection_by_name
					if external_connections.has(ref["toname"]):
						connection.connectto(external_connections[ref["toname"]])
					else:
						compiler.addlog(["block with id",ref["toidx"],"doesnt have connection",ref["toname"]])
				if ref.has("impliedvalue") and connection.val_provider!=null:
					match connection.val_provider.get_class():
						"LineEdit":
							connection.val_provider.text=ref["impliedvalue"]
						"CheckBox":
							connection.val_provider.pressed=ref["impliedvalue"]
					connection.impliedvalue=ref["impliedvalue"]
	if has_method("customload"):
		call("customload",dict)


func getsave()->Dictionary:
	var dict={}
	dict["type"]=type
	dict["connections"]={}
	dict["pos"]=[round(rect_position.x),round(rect_position.y)]
	var connectionlist=dict["connections"]
	for i in connections:
		connectionlist[i.savename]={}
		var connection=connectionlist[i.savename]
		match i.type:
			1:
				if i.target!=null:
					connection["toidx"]=i.target.block.blockindex
					connection["toname"]=i.target.savename
				else:
					if i.connectname=="value" and i.impliedvalue!=null:
						 connection["impliedvalue"]=i.impliedvalue
					else:
						connection["toidx"]=null
			0:
				connection["targets"]=[]
				for j in i.targets:
					if is_instance_valid(j):
						var new={}
						new["toidx"]=j.block.blockindex
						new["toname"]=j.savename
						connection["targets"].append(new)
					else:
						compiler.addlog(["internal error, output target not valid on output",i.savename])
		connection["type"]=i.connectname
		connection["isout"]=i.type==0
	if has_method("customsave"):
		call("customsave",dict)
	return dict
