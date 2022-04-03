##holds universal string manipulation functions.
##shouldnt be initialized, it just holds code, 
##isnt supposed to do anything.
class_name stringfunc
extends Node

#removes part of the string
static func cutout(from:int,to:int,text:String)->String:
	var takeleft=text.left(from)
	var takeright=text.right(to)
	return takeleft+takeright
 #sees if the given index is between carachters


static func isbetween(idx:int,between:String,text:String):
	var isopen=false
	var found=0
	while true:
		found=text.find(between,found)
		if found==-1:
			return false
		if found>idx:
			if isopen:
				return true
			else:
				return false
		found+=1
		isopen=not isopen


static func isbracketed(idx:int,open:String,close:String,text:String):
	var isopen=false
	var from=0
	while true:
		if isopen:
			from=text.find(close,from)
		else:
			from=text.find(open,from)
		if from==-1:
			if isopen:
				return true
			else:
				return false
		if from>idx:
			if isopen:
				return true
			else:
				return false
		from+=1
		isopen= not isopen


static func addbetween(text:String,added:String,where:int):
	return text.left(where)+added+text.right(where)


#replaces the first apeareance of a substring in a text.
static func replacefind(find:String,to:String,text:String,search:bool=true,where:int=0,case_sensitive:bool=true):
	if search:
		if case_sensitive:
			where=text.find(find,where)
		else:
			where=text.findn(find,where)
		
	text=cutout(where,where+find.length(),text)
	
	text=addbetween(text,to,where)
	return text


#finds the last appereance of a substring on a text until the limit.
static func findlastuntil(text:String,find:String,until:int):
	var from=0
	while true:
		var lastfrom=from
		from=text.find(find,from)
		if from==-1 or from>until:
			return lastfrom


static func cutright(until:int,text:String):
	return cutout(until,text.length()+1,text)


#returns if the sentence is a quote "a"=true a=false
static func withinquotes(idx:int,text:String):
	return isbetween(idx,"\"",text)


#removes carachters between open and close, for example passing [ and ] will remove bbcode
static func removebetween(text:String,open:String,close:String)->String:
	var from=0
	while true:
		from=text.find(open,from)
		if from!=-1:
			var to=text.find(close,from)
			text=cutout(from+1,to+2,text)
		else:
			return text.right(from)
		from=1
	return text


#gets words until the until argument is found, goes backwards.
static func getuntilback(idx:int,text:String,until)->String:
	var word=""
	while idx>-1:
		if (until is String and text[idx]!=until) or (until is Array and not until.has(text[idx])):
			word=text[idx]+word
			idx-=1
		else:
			break
	return word


static func lengthidx(string:String)->int:
	return string.length()-1


static func getuntil(idx:int,text:String,until:String)->String:
	var word=""
	if text[idx]==until:
		idx+=1
	#length retorna 1 más
	while idx<text.length():
		if text[idx]!=until:
			word=word+text[idx]
			idx+=1
		else:
			break
	return word

static func get_until_opts(idx:int,text:String,until:Array,direction:int=1)->String:
	var word=""
	if until.has(text[idx]):
		idx+=1*direction
	#length retorna 1 más
	while (direction==1 and idx<text.length()) or (direction==.1 and idx>=0):
		if not until.has(text[idx]):
			word=word+text[idx]
			idx+=1*direction
		else:
			break
	if direction==-1:
		return reverse(word)
	return word

static func reverse(text:String)->String:
	var result=""
	var idx=text.length()-1
	while idx>=0:
		result+=text[idx]
		idx-=1
	return result
	

static func countlist(text:String,separator:String)->Array:
	var list=[]
	var from=0
	while from<text.length()-1:
		var new=getuntil(from,text,separator)
		list.append(new)
		from+=new.length()+1
	return list

static func findnotbracketed(text:String,open:String,close:String,from:int=0,skipwild:bool=true)->String:
	while from<text.length()-1:
		match text[from]:
			" ":
				from+=1
				continue
			"_":
				if skipwild:
					from+=1
				else:
					continue
			open:
				from+=getuntil(from,text,close).length()
			_:
				return getuntil(from,text," ")
		from+=1
	return ""
