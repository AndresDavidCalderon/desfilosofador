extends Resource

var find:String
var replace:String
func fromfile(dict:Dictionary):
	find=dict["of"]
	replace=dict["to"]
	if dict["enabled"]:
		if not globals.filterbyphrase.has(find):
			globals.filterbyphrase[find]=[]
		globals.filterbyphrase[find].append(self)
func found(pos:int,text:String):
	if not (stringfunc.withinquotes(pos,text) and globals.skipquotes):
		text=stringfunc.replacefind(find,replace,text,pos)
	return text
