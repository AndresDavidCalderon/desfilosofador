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
		if not compiler.filterbyphrase.has(register):
			 compiler.filterbyphrase[register]=[]
		compiler.filterbyphrase[register].append(self)


func found(pos:int,text:String,_what:String):
	var original_text=text
	if not (stringfunc.withinquotes(pos,text) and globals.skipquotes):
		if not usesintax:
			text=stringfunc.replacefind(find,replace,text,pos)
		else:
			var from=find.find(register)
			while from>0:
				if find[from-2]==")":
					var options=stringfunc.getuntilback(from-3,find,"(")
					from-=options.length()+2
					options=stringfunc.countlist(options,"/")
					var prefix=stringfunc.getuntilback(pos-2,text," ")
					if not options.has(prefix):
						return text
					else:
						#length returns 1 more that compensates the space
						pos-=prefix.length()
				from-=1
			from=find.find(register)+stringfunc.getuntil(find.find(register),find," ").length()+1
			var frontpos=pos+stringfunc.getuntil(pos+1,text," ").length()+2
			if frontpos>stringfunc.lengthidx(text):
				return text
			while from<find.length()-1:
				match find[from+1]:
					"(":
						var options=stringfunc.getuntil(from+1,find,")")
						from+=options.length()+3
						options=stringfunc.countlist(options,"/")
						var suffix=stringfunc.getuntil(frontpos,text," ")
						if not options.has(suffix):
							return text
						else:
							frontpos+=suffix.length()
					"_":
						from+=1
						if frontpos>=text.length()+1:
							return text
						if compiler.phrase_endings.has(text[frontpos-1]):
							return text
						pos+=1
					_:
						var next=stringfunc.getuntil(from,find," ")
						var ontext=stringfunc.getuntil(frontpos,text," ")
						if next!=ontext:
							return text
						from+=next.length()
						frontpos+=ontext.length()
			text=stringfunc.cutout(pos-1,frontpos,text)
			text=stringfunc.addbetween(text,replace,pos-1)
	if original_text!=text:
		compiler.used.append(self)
	return text
