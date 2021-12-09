extends Button
export(NodePath) var toblock=".."
var block:Panel
func _ready():
	if block==null:
		block=get_node(toblock)
