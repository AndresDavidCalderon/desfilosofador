extends Button
export(NodePath) var toblock=".."
export(String) var selectname
var block:blockbase
var target:Button
func _ready():
	if block==null:
		block=get_node(toblock)

func _pressed():
	if block.base.selected[selectname]["out"]==null:
		block.base.selected[selectname]["in"]=self
	else:
		block.base.selected[selectname]["out"].connectto(self)
	
