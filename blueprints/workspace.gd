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
