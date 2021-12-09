extends Button
export(NodePath) var toblock=".."
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
	if block.base.selectedget==null:
		block.base.selectedset=self
	else:
		connectto(block.base.selectedget)
func connectto(to:Button):
	if to.block!=block:
		target=to
		block.base.selectedset=null
		block.base.selectedget=null
	else:
		globals.popuper.popup("you cant connect 2 signals within the same block")
