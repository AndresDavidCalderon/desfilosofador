extends Node
#removes part of the string
func cutout(from:int,to:int,text:String)->String:
	return text.left(from)+text.right(text.length()-to)
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
	return text.left(where)+added+text.right(text.length()-where)
#replaces the first apeareance of a substring in a text.
func replacefind(from:int,find:String,text:String,to:String):
	var where=text.find(find,from)
	cutout(where,find.length(),text)
	addbetween(text,to,where)
