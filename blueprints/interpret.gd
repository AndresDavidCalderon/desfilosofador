extends Node
var set:Array
var blocks:Array=[]
var ready=false
var answertext:String
func fromfile(dict:Dictionary):
	if not dict["enabled"]:return
	set=dict["code"]
	for i in set:
		match i["type"]:
			"findontext":
				compiler.wait_for_phrase(self,i["phrase"])
func found(where:int,text:String,what:String):
	answertext=text
	onexecution()
	for idx in set.size():
		var i=set[idx]
		if i["type"]=="findontext":
			if i["phrase"]==what:
				blocks[idx].values["where"]=where
				blocks[idx].values["text"]=text
				blocks[idx].doevent("found")
	return answertext
func onexecution():
	if ready:return
	for i in set:
		var new=compiler.virtualblocks[i["type"]].new() as virtualblock
		blocks.append(new)
		new.data=i
		new.interpreter=self
	ready=true
