extends Button
var impliedvalue=null
export(NodePath) var toblock=".."
export(String) var connectname
export(String) var savename
var block:blockbase
var type=1
var target:Button
signal connected
func _ready():
	if block==null:
		block=get_node(toblock)
	block.connections.append(self)
func _process(_delta):
	if is_instance_valid(target):
		$line.points[1]=(target.rect_global_position+target.rect_size/2)-rect_global_position
		$line.points[0]=rect_size/2
	elif target!=null:
		target=null
		$line.points[1]=$line.points[0]
func _pressed():
	var last=block.base.lastselected
	if last==null or last.type==type or last.connectname!=connectname:
		if last!=null:
			last.pressed=false
		block.base.lastselected=self
	else:
		connectto(last)
func connectto(to:Button):
	if to.block!=block:
		if target!=null:
			target.emit_signal("disconnected")
			target.targets.remove(self)
		block.base.lastselected=null
		target=to
		target.pressed=false
		pressed=false
		emit_signal("connected")
		target.emit_signal("connected",self)
		target.targets.append(self)
		return true
	else:
		to.pressed=false
		pressed=false
		block.base.lastselected=null
		globals.popuper.popup("you cant connect 2 signals within the same block")
		return false
