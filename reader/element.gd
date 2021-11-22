extends Panel
export(String) var type
export(NodePath) onready var enabler=get_node(enabler) as CheckBox
var index:int
class_name libraryelement,"res://filters/element.png"
func _ready():
	if not get_parent().root.filtertree[get_parent().root.index]["enabled"]:
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
func getonnew():
	var data={"type":type}
	call("getdef",data)
	return data
