extends HBoxContainer
onready var workspace=get_parent().get_node("view/workspace")

func _on_follow_pressed():
	workspace.addblock(preload("res://blueprints/blocks/conditionals/follows.tscn").instance())



func _on_equals_pressed():
	workspace.addblock(preload("res://blueprints/blocks/conditionals/equals.tscn").instance())
