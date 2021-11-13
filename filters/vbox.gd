extends VBoxContainer
export(Dictionary) var scenebytype
func compile(text:String):
	for i in globals.filterbyphrase.keys():
		var pos=0
		var timesfound=0
		while true:
			pos=text.find(i,pos)
			if pos!=-1:
				timesfound+=1
				prints("se encontró la redundancia:",i,"por ves #",timesfound)
				for j in globals.filterbyphrase[i].size():
					text=globals.filterbyphrase[i][j].found(pos,text)
			else:
				break
	return text
func openfolder(folder:Dictionary):
	for i in folder["subelements"]:
		var new=scenebytype[i["type"]].instance() as libraryelement
		add_child(new)
		new.fromfile(i["data"])
