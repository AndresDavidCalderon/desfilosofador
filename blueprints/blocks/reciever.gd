extends Button
export(NodePath) var toblock=".."
var block:blockbase
var target:Button
func _ready():
	if block==null:
		block=get_node(toblock)

func _pressed():
	if block.base.selectedset==null:
		block.base.selectedget=self
	else:
		block.base.selectedset.connectto(self)
	
