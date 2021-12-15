extends blockbase
export(PackedScene) var argument

func _on_argcount_value_changed(value):
	if value>$args.get_child_count():
		var new=argument.instance()
		new.block=self
		$args.add_child(new)
		new.savename="arg"+str(new.get_index())
	if value<$args.get_child_count():
		$args.get_child($args.get_child_count()-1).queue_free()
func customsave(dict:Dictionary):
	dict["argcount"]=$argcount.value
	dict["funcname"]=$funcname.text
