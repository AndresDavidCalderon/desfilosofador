extends libraryelement
var saveindex
func _ready():
	get_parent().connect("beforesave",self,"presave")
func getsave(data):
	data["enabled"]=$enabled.pressed
	data["name"]=$name.text
	data["index"]=saveindex
func _on_open_pressed():
	get_parent().root.get_node("bottom/dir").text+="/"+$name.text
	get_parent().savecurrent()
	get_parent().openfolder(saveindex)
func fromfile(data):
	$name.text=data["name"]
	$enabled.pressed=data["enabled"]
	saveindex=data["index"]
func getdef(data):
	get_parent().root.filtertree.append({"inside":[],"origin":get_parent().root.index})
	data["index"]=get_parent().root.filtertree.size()-1
	saveindex=data["index"]
	print("set index",index)
	data["enabled"]=$enabled.pressed
	data["name"]=$name.text
func customdelete():
	for i in get_parent().root.filtertree:
		for j in i["inside"]:
			if j.has("index"):
				if j["index"]>=saveindex:
					j["index"]-=1
					prints("reindexed",j)
	for i in get_parent().root.filtertree[saveindex]["inside"]:
		var new=get_parent().scenebytype[i["type"]].instance() as libraryelement
		new.fromfile(i)
		get_parent().add_child(new)
		new.delete()
	get_parent().root.filtertree.remove(saveindex)
