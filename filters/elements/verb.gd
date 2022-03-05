extends libraryelement

onready var selected=$ES

func _ready():
	_on_lang_selected(0)

func _on_lang_selected(index):
	selected.visible=false
	match index:
		0:
			selected=$ES
		1:
			selected=$EN
	selected.visible=true


func fromfile(dict):
	$lang.select(dict["lang"])
	var idx=0
	for i in dict["forms"]:
		selected.get_child(idx).get_node("val").text=i
		idx+=1


func getsave(dict):
	dict["lang"]=$lang.selected
	dict["forms"]=[]
	for i in selected.get_children():
		dict["forms"].append(i.get_node("val").text)

