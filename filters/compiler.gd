extends Node
export(Dictionary) var onfind
export(Dictionary) var virtualblocks
var filterbyphrase={}

func compile(text:String,filtertree:Array):
	for i in filtertree.size():
		if isenabled(i,filtertree):
			i=filtertree[i] as Dictionary
			for j in i["inside"]:
				if onfind.has(j["type"]):
					onfind[j["type"]].new().fromfile(j)
	for i in filterbyphrase.keys():
		var pos=0
		var timesfound=0
		while true:
			pos=text.find(i,pos)
			if pos!=-1:
				pos+=1
				timesfound+=1
				prints("se encontró la redundancia:",i,"por ves #",timesfound)
				for j in filterbyphrase[i].size():
					text=filterbyphrase[i][j].found(pos,text,i)
			else:
				break
	return text
func isenabled(folderidx:int,tree:Array):
	while true:
		if folderidx==-1:
			return true
		if not tree[folderidx]["enabled"]:
			return false
		folderidx=tree[folderidx]["origin"]
