extends libraryelement
onready var new=$ui/result/new
onready var from=$ui/of/origin
func getsave(save:Dictionary):
	save["of"]=from.text
	save["to"]=new.text
	save["enabled"]=$enabled.pressed
func fromfile(save:Dictionary):
	$enabled.pressed=save["enabled"]
	new.text=save["to"]
	from.text=save["of"]

var oldtext=""

