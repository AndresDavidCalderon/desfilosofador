class_name libraryelement,"res://filters/elements/element.png"
extends Panel

export(String) var type
export(NodePath) onready var to_enabler
var enabler
var index:int

func _ready():
	if to_enabler!="":
		enabler=get_node(to_enabler) as CheckBox
		if not compiler.isenabled(get_parent().root.index,get_parent().root.filtertree):
			enabler.disabled=true


func getsavedata():
	var data={"type":type}
	if has_method("getsave"):
		call("getsave",data)
	return data


func delete():
	get_parent().root.filtertree[get_parent().root.index]["inside"].erase(self)
	if has_method("customdelete"):
		call("customdelete")
	queue_free()


func exists():
	return get_parent().root.currentfolder.has(self)

#get default data
func getonnew():
	var data={"type":type}
	call("getdef",data)
	return data
