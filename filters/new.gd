extends VBoxContainer

export(PackedScene) var verb

func _on_verb_pressed():
	get_parent().addelement(verb.instance())
