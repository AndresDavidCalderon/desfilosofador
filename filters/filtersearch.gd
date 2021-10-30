extends Node
export(PackedScene) var filter


func _on_newfilter_pressed():
	$upcenter/scroll/vbox.add_child(filter.instance())
