extends libraryelement

#where the separator is placed on the verb array
var verb_index=0
export(int) var verb_size
onready var global_verbs=get_parent().root.verbs

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
	verb_index=dict["i"]
	for i in selected.get_children():
		i.get_node("val").text=global_verbs[verb_index+i.get_index()]

func getsave(dict):
	dict["i"]=verb_index
	global_verbs[verb_index]="*"
	for i in selected.get_children():
		global_verbs[verb_index+i.get_index()+1]=i.get_node("val").text

func getdef(data):
	verb_index=global_verbs.size()
	var new=["*"]
	new.resize(verb_size+1)
	global_verbs.append_array(new)


func customdelete():
	for i in get_parent().root.filtertree:
		for j in i["inside"]:
			if j.type=="verb":
				if j["i"]>verb_index:
					j["i"]-=verb_size+1
					prints("reindexed verb",j)
	
	for i in get_parent().root.box.get_children():
		if i.type=="verb":
			if i.verb_index>verb_index:
				i.verb_index-=verb_size+1
	
	for i in verb_size+1:
		global_verbs.remove(verb_index)
