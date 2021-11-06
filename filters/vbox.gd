extends VBoxContainer
func compile(text:String):
	for i in globals.filterbyphrase.keys.size():
		var key=globals.filterbyphrase.keys[i]
		while true:
			var pos=text.find(key)
			if pos-1:
				for j in globals.filterbyphrase[key].size():
					text=globals.filterbyphrase[key][j].found(pos,text)
			else:
				break
	return text
