extends Node

static func found(word:String,context:Dictionary):
	print("constant")
	return word==context["next_on_filter"]
