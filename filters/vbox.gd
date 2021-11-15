extends VBoxContainer
export(Dictionary) var scenebytype
onready var root=get_parent().get_parent().get_parent()
func compile(text:String):
	root.refresh()
	for i in globals.filterbyphrase.keys():
		var pos=0
		var timesfound=0
		while true:
			pos=text.find(i,pos)
			if pos!=-1:
				pos+=1
				timesfound+=1
				prints("se encontró la redundancia:",i,"por ves #",timesfound)
				for j in globals.filterbyphrase[i].size():
					text=globals.filterbyphrase[i][j].found(pos,text)
			else:
				break
	return text
func openfolder(index:int):
	for i in get_children():
		i.queue_free()
	root.index=index
	for i in getcurrent():
		var new=scenebytype[i["type"]].instance() as libraryelement
		add_child(new)
		new.fromfile(i)
signal beforesave
func savecurrent():
	getcurrent().clear()
	for i in get_children():
		getcurrent().append(i.getsavedata())
func getcurrent():
	return root.filtertree[root.index]["inside"]
