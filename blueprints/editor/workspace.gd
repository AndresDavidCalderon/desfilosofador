extends Viewport
var lastselected:Button
func _ready():
	addblock(preload("res://blueprints/blocks/return.tscn").instance())
	vis()
	globals.popuper.connect("visibility_changed",self,"vis")
func _on_value_pressed():
	addblock(preload("res://blueprints/blocks/value.tscn").instance())
func addblock(block:Panel):
	block.base=self
	add_child(block)
	block.rect_position=$camera.position

func _on_method_pressed():
	addblock(preload("res://blueprints/blocks/function.tscn").instance())

func set_indexes():
	var idx=0
	for i in get_children():
		if i is blockbase:
			i.blockindex=idx
			idx+=1

func vis():
	for i in get_children():
		if globals.popuper.visible:
			i.visible=false
		else:
			i.visible=get_parent().get_parent().visible

func clear():
	for i in get_children():
		if i is blockbase:
			i.delete(["force"])

func _on_find_pressed():
	addblock(preload("res://blueprints/blocks/actions/find.tscn").instance())


func _on_addinside_pressed():
	addblock(preload("res://blueprints/blocks/stringfuncs/addinside.tscn").instance())
