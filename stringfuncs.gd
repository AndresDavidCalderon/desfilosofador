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
