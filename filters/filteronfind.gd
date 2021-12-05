extends Resource
var register:String
var find:String
var replace:String
func fromfile(dict:Dictionary):
	find=dict["of"]
	replace=dict["to"]
	if dict["enabled"]:
		if find.find("/")==-1:
			register=find
		else:
			register=stringfunc.findnotbracketed(find,"(",")")
		if not globals.filterbyphrase.has(register):
			globals.filterbyphrase[register]=[]
		globals.filterbyphrase[register].append(self)
func found(pos:int,text:String):
	if not (stringfunc.withinquotes(pos,text) and globals.skipquotes):
		if find.find("/")==-1:
			text=stringfunc.replacefind(find,replace,text,pos)
		else:
			var from=find.find(register)
			while from>0:
				if find[from-2]==")":
					var options=stringfunc.getuntilback(from-3,find,"(")
					from-=options.length()+2
					options=stringfunc.countlist(options,"/")
				from-=1
