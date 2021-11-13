extends Panel
export(String) var type
var index:int
class_name libraryelement,"res://filters/element.png"
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
