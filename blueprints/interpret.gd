extends Node
var set:Array
func fromfile(dict:Dictionary):
	set=parse_json(dict["code"])
	for i in set:
		match i["type"]:
			"find":
				globals.filterbyphrase[i["phrase"]].append(self)
func found(where:int,text:String,what:String):
	pass
