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
	save["case"]=$expand/options/case.pressed


func fromfile(save:Dictionary):
	if save.has("sintax"):
		$sintax.pressed=save["sintax"]
	$enabled.pressed=save["enabled"]
	if save.has("case"):
		$expand/options/case.pressed=save["case"]
	new.text=save["to"]
	from.text=save["of"]
	_on_origin_text_changed(from.text)



func _on_origin_text_changed(new_text:String):
	for i in compiler.filter_cases.keys():
		if new_text.find(i)!=-1:
			$sintax.visible=true
			rect_min_size.y=100


func _on_expand_toggled(button_pressed):
	$expand/options.visible=button_pressed
