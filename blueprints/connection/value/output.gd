extends Button
export(NodePath) var toblock=".."
export(String) var connectname
signal needsvalue
var block:blockbase
var value
var target:Button
func _process(_delta):
	if target!=null:
		$line.points[1]=(target.rect_global_position+target.rect_size/2)-rect_global_position
		$line.points[0]=rect_size/2
func _ready():
	if block==null:
		block=get_node(toblock)
func _pressed():
	if block.base.selected[connectname]["in"]==null:
		block.base.selected[connectname]["out"]=self
	else:
		connectto(block.base.selected[connectname]["in"])
func connectto(to:Button):
	if to.block!=block:
		target=to
		block.base.selected[connectname]["out"]=null
		block.base.selected[connectname]["in"]=null
	else:
		globals.popuper.popup("you cant connect 2 signals within the same block")
