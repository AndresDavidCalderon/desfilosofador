extends Resource
var register:String
var find:String
var replace:String
var usesintax:bool
func fromfile(dict:Dictionary):
	find=dict["of"]
	replace=dict["to"]
	if dict.has("sintax"):
		usesintax=dict["sintax"]
	if dict["enabled"]:
		if not usesintax:
			register=find
		else:
			register=stringfunc.findnotbracketed(find,"(",")")
		if not globals.filterbyphrase.has(register):
			globals.filterbyphrase[register]=[]
		globals.filterbyphrase[register].append(self)


func found(pos:int,text:String):
	if not (stringfunc.withinquotes(pos,text) and globals.skipquotes):
		if not usesintax:
			text=stringfunc.replacefind(find,replace,text,pos-1)
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
			from=find.find(register)+stringfunc.getuntil(find.find(register),find," ").length()+1
			var frontpos=pos+stringfunc.getuntil(pos,text," ").length()+1
			if frontpos>text.length()-1:
				print("reached end")
				return text
			print("looping through from")
			while from<find.length()-1:
				match find[from+1]:
					"(":
						var options=stringfunc.getuntil(from+3,find,")")
						from+=options.length()+3
						options=stringfunc.countlist(options,"/")
						var suffix=stringfunc.getuntil(frontpos,text," ")
						if not options.has(suffix):
							prints("wrong suffix",suffix,"not in",options)
							return text
						else:
							frontpos+=suffix.length()
					"_":
						from+=1
						if frontpos>=text.length()+1:
							prints("cant fill wildcard, text end.")
							return text
						if text[frontpos-1]=="." or text[frontpos-1]==",":
							prints("cant fill wildcard, sentence end.")
							return text
						pos+=1
					_:
						print("found constant")
						var next=stringfunc.getuntil(from,find," ")
						var ontext=stringfunc.getuntil(frontpos,text," ")
						
						if next!=ontext:
							prints("wrong constant suffix",ontext,"had to be",next)
							return text
						from+=next.length()
						frontpos+=ontext.length()
			text=stringfunc.cutout(pos-2,frontpos,text)
			text=stringfunc.addbetween(text,replace,pos-2)
	return text
