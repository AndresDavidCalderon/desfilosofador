extends Node


static func found(context:Dictionary):
	context["pos_on_filter"]+=1
	if context["frontpos"]>=context["text"].length()+1:
		return [-1]
	if compiler.phrase_endings.has(context["text"][context["frontpos"]-1]):
		return [-1]
	return context
