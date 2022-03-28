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


func found(pos_on_text:int,text:String,_what:String):
	var original_text=text
	if not (stringfunc.withinquotes(pos_on_text,text) and globals.skipquotes):
		if not usesintax:
			text=stringfunc.replacefind(find,replace,text,pos_on_text)
		else:
			var pos_on_filter=find.find(register)
			while pos_on_filter>0:
				if find[pos_on_filter-2]==")":
					var options=stringfunc.getuntilback(pos_on_filter-3,find,"(")
					pos_on_filter-=options.length()+2
					options=stringfunc.countlist(options,"/")
					var prefix=stringfunc.getuntilback(pos_on_text-2,text," ")
					if not options.has(prefix):
						return text
					else:
						#length returns 1 more that compensates the space
						pos_on_text-=prefix.length()
				pos_on_filter-=1
			pos_on_filter=find.find(register)+stringfunc.getuntil(find.find(register),find," ").length()+1
			var frontpos=pos_on_text+stringfunc.getuntil(pos_on_text+1,text," ").length()+2
			if frontpos>stringfunc.lengthidx(text):
				return text
			
			#apply syntax
			while pos_on_filter<find.length()-1:
				var next_on_text=stringfunc.get_until_opts(frontpos,text,compiler.word_endings)
				if compiler.filter_cases.has(find[pos_on_filter+1]):
					pos_on_filter+=1
					var result:Dictionary=compiler.filter_cases[find[pos_on_filter]].found({
						"pos_on_filter":pos_on_filter,
						"text":text,
						"origin":self,
						"next_on_text":next_on_text,
						"frontpos":frontpos
					})
					if result.has("cancel") and result["cancel"]:
						return text
					pos_on_filter=result["pos_on_filter"]
					text=result["text"]
					frontpos=result["frontpos"]
				else:
					var next=stringfunc.getuntil(pos_on_filter,find," ")
					var ontext=stringfunc.getuntil(frontpos,text," ")
					if next!=ontext:
						return text
					pos_on_filter+=next.length()
					frontpos+=ontext.length()
			text=stringfunc.cutout(pos_on_text,frontpos,text)
			text=stringfunc.addbetween(text,replace,pos_on_text)
	if original_text!=text:
		compiler.used.append(self)
	return text
