extends Node
export(Dictionary) var onfind
export(Dictionary) var virtualblocks
export(Array,String) var line_endings
export(Array,String) var phrase_endings:Array

enum{
	CONNECTION_OUT,
	CONNECTION_IN
}
enum{
	SUBJECT,
	VERB
}
var filterbyphrase={}
var compilelog=[]
var pos
func _ready():
	line_endings.append("\n")
	phrase_endings.append_array(line_endings)

func compile(text:String,filtertree:Array):
	compilelog.clear()
	filterbyphrase.clear()
	for i in filtertree.size():
		if isenabled(i,filtertree):
			i=filtertree[i] as Dictionary
			for j in i["inside"]:
				if onfind.has(j["type"]):
					onfind[j["type"]].new().fromfile(j)
	for i in filterbyphrase.keys():
		pos=0
		var timesfound=0
		while true:
			pos=text.find(i,pos)
			if pos!=-1:
				timesfound+=1
				for j in filterbyphrase[i].size():
					var newtext=filterbyphrase[i][j].found(pos,text,i) as String
					pos+=(newtext.length()-text.length())+i.length()
					text=newtext
			else:
				break
	for i in line_endings:
		text=text.replace(i+" \n",i+"\n\n")
	return text


func isenabled(folderidx:int,tree:Array):
	while true:
		if folderidx==-1:
			return true
		if not tree[folderidx]["enabled"]:
			return false
		folderidx=tree[folderidx]["origin"]


func addlog(messages):
	var final=""
	if messages is Array:
		for i in messages.size():
			final+=messages[i]
			if i<messages.size()-1:
				final+=" "
	else:
		final=str(messages)
	compilelog.append(final)


func wait_for_phrase(who:Object,phrase:String):
	if not filterbyphrase.has(phrase):
		filterbyphrase[phrase]=[]
	filterbyphrase[phrase].append(who)
	
