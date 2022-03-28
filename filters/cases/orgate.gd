extends Node

static func found(context:Dictionary):
	var options=stringfunc.getuntil(context["pos_on_filter"]+1,context["origin"].find,")")
	context["pos_on_filter"]+=options.length()+2
	options=stringfunc.countlist(options,"/")
	var suffix=context["next_on_text"]
	if not options.has(suffix):
		return {"cancel":true}
	else:
		context["frontpos"]+=suffix.length()+1
	return  context
