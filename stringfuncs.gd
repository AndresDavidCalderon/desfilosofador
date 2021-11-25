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
	#quitar la palabra
	text=cutout(where,where+find.length()-1,text)
	text=addbetween(text,to,where)
	return text
static func findlastuntil(until:int,text:String,find:String):
	var from=0
	while true:
		var lastfrom=from
		from=text.find(find,from)
		if from==-1 or from>until:
			return lastfrom
static func cutright(until:int,text:String):
	return cutout(until,text.length()+1,text)
static func withinquotes(idx:int,text:String):
	return isbetween(idx,"\"",text)
