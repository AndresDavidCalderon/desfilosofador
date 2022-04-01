extends Node

static func found(word:String,context:Dictionary):
	var listed_options:String
	match context["symbol"]:
		"(":
			listed_options=stringfunc.getuntil(context["pos_on_filter"]+1,context["origin"].find,")")
		")":
			listed_options=stringfunc.getuntilback(context["pos_on_filter"]+1,context["origin"].find,"(")
	var options:Array=stringfunc.countlist(listed_options,"/")
	return word in options
