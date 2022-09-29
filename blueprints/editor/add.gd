extends GridContainer
onready var workspace=get_parent().get_parent().get_node("view/workspace")

func _ready():
	for i in get_children():
		if i is Button or i is expandable:
			i.connect("pressed",self,"selected",[true,i])
			i.connect("toggled",self,"selected",[i])
func selected(pressed,who:Button):
	if not pressed:return
	for i in get_children():
		if i!=who:
			i.pressed=false
func _on_follow_pressed():
	workspace.addblock(preload("res://blueprints/blocks/stringfuncs/follows.tscn").instance())



func _on_equals_pressed():
	workspace.addblock(preload("res://blueprints/blocks/conditionals/equals.tscn").instance())


func _on_if_pressed():
	workspace.addblock(preload("res://blueprints/blocks/conditionals/if.tscn").instance())


func _on_preceed_pressed():
	workspace.addblock(preload("res://blueprints/blocks/stringfuncs/preceeds.tscn").instance())


func _on_print_pressed():
	workspace.addblock(preload("res://blueprints/blocks/debug/print.tscn").instance())


func _on_not_pressed():
	workspace.addblock(preload("res://blueprints/blocks/conditionals/ifnot.tscn").instance())
