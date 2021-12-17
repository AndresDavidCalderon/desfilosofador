extends Viewport
var lastselected:Button
func _ready():
	vis()
	globals.popuper.connect("visibility_changed",self,"vis")
func _on_value_pressed():
	addblock(preload("res://blueprints/blocks/value.tscn").instance())
func addblock(block:Panel):
	add_child(block)
	block.rect_position=$camera.position
func _on_method_pressed():
	addblock(preload("res://blueprints/blocks/function.tscn").instance())


func vis():
	for i in get_children():
		if globals.popuper.visible:
			i.visible=false
		else:
			i.visible=get_parent().get_parent().visible


func get_save_array():
	var blocks=[]
	for i in get_children():
		if i is blockbase:
			blocks.append(i.getsave())
	return blocks

onready var tests=get_parent().get_parent().get_node("testcontainer")
func _on_compile_pressed():
	var tree=[{"enabled":true,"origin":-1,"inside":[]}]
	tree[0]["inside"].append({"type":"blueprint","enabled":true,"code":get_save_array()})
	tests.get_node("to").text=compiler.compile(tests.get_node("from").text,tree)
