extends Button
signal connected(to)
signal disconnected()
export(NodePath) var toblock=".."
export(String) var connectname
export(String) var savename
var targets=[]
var type=0
var block:blockbase
var impliedvalue
func _ready():
	if block==null:
		block=get_node(toblock)
	get_parent().connections.append(self)
	block.connection_by_name[savename]=self
func _pressed():
	var last=block.base.lastselected
	if last==null or last.type==type or last.connectname!=connectname:
		if last!=null:
			last.pressed=false
		block.base.lastselected=self
	else:
		last.connectto(self)
