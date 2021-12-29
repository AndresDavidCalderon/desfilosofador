extends libraryelement
var code:Array
func fromfile(dict):
	$enabled.pressed=dict["enabled"]
	$name.text=dict["name"]
	code=dict["code"]
func getsave(dict):
	dict["enabled"]=$enabled.pressed
	dict["name"]=$name.text
	dict["code"]=code


func _on_edit_pressed():
	get_parent().root.editblue(self)
