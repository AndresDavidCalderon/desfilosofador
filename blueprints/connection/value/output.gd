extends Button
export(NodePath) var toblock=".."
export(String) var connectname
var type=0
signal needsvalue
var block:blockbase
var value
func _ready():
	if block==null:
		block=get_node(toblock)
func _pressed():
	var last=block.base.lastselected
	if last==null or last.type==type or last.connectname!=connectname:
		if last!=null:
			last.pressed=false
		block.base.lastselected=self
	else:
		last.connectto(self)
