extends Node

static func found(context:Dictionary):
	if globals.library.verbs.has(context["next_on_text"]):
		context["frontpos"]+=context["next_on_text"].length()+1
	else:
		return {"cancel":true}
	return context
