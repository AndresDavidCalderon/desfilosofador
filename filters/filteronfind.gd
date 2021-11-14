extends Resource

var find:String
var replace:String
func fromfile(dict:Dictionary):
	find=dict["from"]
	replace=dict["to"]
	if dict["enabled"]:
		if not globals.filterbyphrase.has(find):
			globals.filterbyphrase[find]=[]
		globals.filterbyphrase[find].append(self)
