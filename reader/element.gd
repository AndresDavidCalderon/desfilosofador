extends Panel
export(String) var type
class_name libraryelement,"res://filters/element.png"
func getsavedata():
	var data={"type":type}
	if has_method("getsave"):
		call("getsave",data)
	return data
