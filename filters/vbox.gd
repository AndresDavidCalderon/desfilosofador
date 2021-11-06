extends VBoxContainer
func compile(text:String):
	for i in globals.filterbyphrase.keys():
		while true:
			var pos=text.find(i)
			if pos-1:
				for j in globals.filterbyphrase[i].size():
					text=globals.filterbyphrase[i][j].found(pos,text)
					prints("se encontró la redundancia",i)
			else:
				break
	return text
