extends libraryelement

var verb_index=0
onready var selected=$ES

#where the forms are located, on the 2 element of the file.
var save_array:Array

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
	verb_index=dict["i"]
	$lang.select(save_array[0])
	_on_lang_selected(save_array[0])
	var idx=0
	for i in save_array:
		if i==0:i=1
		selected.get_child(idx).get_node("val").text=i
		idx+=1


func getsave(dict):
	dict["i"]=verb_index
	save_array.clear()
	save_array.append($lang.selected)
	for i in selected.get_children():
		get_parent().root.verbs.append(i.text)

func getdef(data:Dictionary):
	get_parent().root.verbs.append([])
	verb_index=get_parent().root.verbs.size()-1
	save_array=get_parent().root.verbs[verb_index]
	data=getsavedata()
