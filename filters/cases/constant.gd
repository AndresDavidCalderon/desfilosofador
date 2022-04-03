extends Node

static func found(word:String,context:Dictionary):
	return word==context["next_on_filter"]
