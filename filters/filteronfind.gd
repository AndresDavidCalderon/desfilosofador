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
					var prefix=stringfunc.getuntilback(pos-3,text," ")
					if not options.has(prefix):
						prints("wrong prefix",prefix)
						return text
					else:
						pos-=prefix.length()
				from-=1
			from=find.find(register)+stringfunc.getuntil(find.find(register)+1,find," ").length()
			var frontpos=pos+stringfunc.getuntil(pos,text," ").length()+2
			while from<find.length()-1:
				if frontpos>text.length():return text
				if find[from+2]=="(":
					var options=stringfunc.getuntil(from+3,find,")")
					from+=options.length()+3
					options=stringfunc.countlist(options,"/")
					var suffix=stringfunc.getuntil(frontpos,text," ")
					if not options.has(suffix):
						prints("wrong suffix",suffix,"not in",options)
						return text
					else:
						frontpos+=suffix.length()
				else:
					var next=stringfunc.getuntil(from+1,find," ")
					var ontext=stringfunc.getuntil(frontpos-2,text," ")
					if next!=ontext:
						prints("wrong constant suffix",ontext,"had to be",next)
						return text
					from+=next.length()
					frontpos+=ontext.length()
			text=stringfunc.cutout(pos-1,frontpos-1,text)
			text=stringfunc.addbetween(text,replace,pos-1)
	return text
