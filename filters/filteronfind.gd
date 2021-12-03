extends Resource

var find:String
var replace:String
func fromfile(dict:Dictionary):
	find=dict["of"]
	replace=dict["to"]
	if dict["enabled"]:
		var register:String
		if find.find("/")==-1:
			register=find
		else:
			var from=find.find(")",find.find("/"))
			if find[from+1]==" ":
				from+=1
			register=find.right(from+1)
		if not globals.filterbyphrase.has(register):
			globals.filterbyphrase[register]=[]
		globals.filterbyphrase[register].append(self)
func found(pos:int,text:String):
	if not (stringfunc.withinquotes(pos,text) and globals.skipquotes):
		if find.find("/")==-1:
			text=stringfunc.replacefind(find,replace,text,pos)
		else:
			print(pos)
			var pref=stringfunc.getuntilback(pos-3,text," ")
			var options=[]
			
	return text
