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
			var cut_until=pos_on_text
			
			if cut_until>stringfunc.lengthidx(text):
				return text
			
			var backpos=pos_on_text
			#1 if going forward, -1 if backward
			var directionsign:int=-1
			#apply syntax forward from the start
			for i in 2:
				if i==1 or pos_on_filter==0:
					directionsign=1
					i=2
				while (pos_on_filter>=0 and directionsign==-1) or (pos_on_filter<find.length() and directionsign==1):
					var next_on_text=stringfunc.get_until_opts(cut_until,text,compiler.word_endings,directionsign)
					var next_on_filter=stringfunc.get_until_opts(pos_on_filter,find,compiler.word_endings,directionsign)
					
					var keyword:Object
					var symbol=find[pos_on_filter]
					
					if compiler.filter_cases.has(symbol):
						keyword=compiler.filter_cases[symbol]
						prints("found symbol",symbol)
					else:
						keyword=preload("res://filters/cases/constant.gd")
					
					var result=keyword.found(next_on_text,{
						"pos_on_filter":pos_on_filter,
						"charachter_found":next_on_filter,
						"text":text,
						"origin":self,
						"next_on_text":next_on_text,
						"cut_until":cut_until,
						"direction":directionsign,
						"next_on_filter":next_on_filter,
						"symbol":symbol
					})
					
					var accept:bool
					var context
					
					
					match typeof(result):
						TYPE_BOOL:
							accept=result
						TYPE_ARRAY:
							accept=result[0]
							context=result[1]
						TYPE_DICTIONARY:
							context=result
						
					if accept!=null:
						if accept:
							cut_until+=(next_on_text.length()+1)*directionsign
							pos_on_filter+=(next_on_filter.length()+1)*directionsign
						
						else:
							return text
					
					if context!=null:
						pos_on_filter=context["pos_on_filter"]
						text=context["text"]
						cut_until=context["cut_until"]
					
					if directionsign==-1:
						backpos=cut_until
					
			text=stringfunc.cutout(pos_on_text,cut_until,text)
			text=stringfunc.addbetween(text,replace,pos_on_text)
	if original_text!=text:
		compiler.used.append(self)
	return text
