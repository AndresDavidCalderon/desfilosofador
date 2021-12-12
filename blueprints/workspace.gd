extends Viewport
var selected={}
export(PoolStringArray) var connections
func _ready():
	_on_window_visibility_changed()
	for i in connections:
		selected[i]={"in":null,"out":null}

func _on_value_pressed():
	addblock(preload("res://blueprints/blocks/value.tscn").instance())
func addblock(block:Panel):
	add_child(block)
	block.rect_position=$camera.position
func _on_method_pressed():
	addblock(preload("res://blueprints/blocks/function.tscn").instance())


func _on_window_visibility_changed():
	for i in get_children():
		i.visible=get_parent().get_parent().visible
