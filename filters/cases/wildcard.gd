extends Node


static func found(_word,context:Dictionary):
	var endpos=context["cut_until"]+context["next_on_filter"].length()
	
	if context["cut_until"]==0 and context["direction"]==-1:
		return false
	
	var preceeds=context["text"][context["cut_until"]+context["direction"]]
	if compiler.phrase_endings.has(preceeds) and context["direction"]==-1:
		return false
	
	if (endpos==context["text"].length() or compiler.phrase_endings.has(context["text"][endpos])) and context["direction"]==1:
		return false
	#if the text ends there, its false
	
	return true
