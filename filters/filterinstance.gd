extends libraryelement
onready var new=$ui/result/new
onready var from=$ui/of/origin
func _ready():
	$sintax.visible=false


func getsave(save:Dictionary):
	save["of"]=from.text
	save["to"]=new.text
	save["enabled"]=$enabled.pressed
	save["sintax"]=$sintax.pressed


func fromfile(save:Dictionary):
	if save.has("sintax"):
		$sintax.pressed=save["sintax"]
	$enabled.pressed=save["enabled"]
	new.text=save["to"]
	from.text=save["of"]
	_on_origin_text_changed(from.text)

func _on_origin_text_changed(new_text:String):
	if new_text.find("_")!=-1 or new_text.find("/")!=-1:
		$sintax.visible=true
		rect_min_size.y=100
