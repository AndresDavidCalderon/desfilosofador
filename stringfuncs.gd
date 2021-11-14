extends Node
#removes part of the string
func cutout(from:int,to:int,text:String)->String:
	return text.left(from)+text.right(to)
 #sees if the given index is between carachters
func isbetween(idx:int,between:String,text:String):
	var isopen=false
	var found=0
	while true:
		found=text.find(between,found)
		if found==-1:
			return false
		if found>idx and isopen:
			return true
		isopen=not isopen
func addbetween(text:String,added:String,where:int):
	return text.left(where)+added+text.right(where)
#replaces the first apeareance of a substring in a text.
func replacefind(find:String,text:String,to:String,where:int):
	#quitar la palabra
	text=cutout(where,where+find.length(),text)
	text=addbetween(text,to,where)
	return text
func findlastuntil(until:int,text:String,find:String):
	var from=0
	while true:
		var lastfrom=from
		from=text.find(find,from)
		if from==-1 or from>until:
			return lastfrom
func cutright(until:int,text:String):
	return cutout(until,text.length(),text)
