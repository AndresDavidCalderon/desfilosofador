extends Node


static func found(_word,context:Dictionary):
	if context["frontpos"]==0 and context["direction"]==-1:
		return false
	if context["frontpos"]==context["text"].length() and context["direction"]==1:
		return false
	#if the text ends there, its false
	
	var preceeds=context["text"][context["frontpos"]]+context["direction"]
	if compiler.phrase_endings.has(preceeds):
		return false
	return true
