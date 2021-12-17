extends VBoxContainer
export(Dictionary) var scenebytype
onready var root=get_parent().get_parent()
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
