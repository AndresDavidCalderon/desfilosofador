extends Node
class_name stringfunc
#removes part of the string
static func cutout(from:int,to:int,text:String)->String:
	return text.left(from-1)+text.right(to-1)
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
	return text.left(where-1)+added+text.right(where)
#replaces the first apeareance of a substring in a text.
static func replacefind(find:String,to:String,text:String,where:int):
	text=cutout(where,where+find.length()-1,text)
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
static func getuntilback(idx:int,text:String,until:String)->String:
	var word=""
	while idx>-1:
		if text[idx]!=until:
			word=text[idx]+word
			idx-=1
		else:
			break
	return word
static func getuntil(idx:int,text:String,until:String):
	var word=""
	if text[idx]==until:
		idx+=1
	while idx<text.length():
		if text[idx]!=until:
			word=word+text[idx]
			idx+=1
		else:
			break
	return word
static func countlist(text:String,separator:String):
	var list=[]
	var from=0
	while from<text.length()-1:
		var new=getuntil(from,text,separator)
		print(new)
		list.append(new)
		from+=new.length()
	return list
static func findnotbracketed(text:String,open:String,close:String,from:int=0):
	var result=""
	while from<text.length()-1:
		if text[from]==open:
			from=text.find(close,from)
		else:
			break
		from+=1
		result=text.right(from+1)
	return result
