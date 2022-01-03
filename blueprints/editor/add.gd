extends HBoxContainer
onready var workspace=get_parent().get_node("view/workspace")


func _on_follows_pressed():
	workspace.addblock(preload("res://blueprints/blocks/conditionals/follows.tscn").instance())
