extends Button
var impliedvalue=null
export(NodePath) var toblock=".."
export(String) var connectname
export(String) var savename
export(NodePath) var toprovider
var val_provider
var block:blockbase
var type=compiler.CONNECTION_IN
var target:Button
signal connected
func _ready():
	if val_provider==null:
		val_provider=get_node_or_null(toprovider)
	if block==null:
		block=get_node(toblock)
	block.connections.append(self)
	block.connection_by_name[savename]=self
func _process(_delta):
	var lastpoint=$line.points[$line.points.size()-1]
	if is_instance_valid(target):
		lastpoint=(target.rect_global_position+target.rect_size/2)-rect_global_position
		$line.points[0]=rect_size/2
		$linebutton.rect_position=lastpoint
		$linebutton.rect_size.x=$line.points[0].distance_to(lastpoint)
		var angle=$line.points[0].angle_to_point(lastpoint)
		$linebutton.rect_rotation=rad2deg(angle)
		$linebutton.rect_position-=Vector2(0,$linebutton.rect_size.y/2).rotated(angle)
	else:
		target=null
		lastpoint=$line.points[0]
	$line.points[$line.points.size()-1]=lastpoint
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
			cut()
		block.base.lastselected=null
		target=to
		target.pressed=false
		pressed=false
		emit_signal("connected")
		target.emit_signal("connected",self)
		target.targets.append(self)
		$linebutton.mouse_filter=Control.MOUSE_FILTER_STOP
		$linebutton.disabled=false
		return true
	else:
		to.pressed=false
		pressed=false
		block.base.lastselected=null
		globals.popuper.popup("you cant connect 2 signals within the same block")
		return false

func cut():
	if target!=null:
		target.targets.erase(self)
		target.emit_signal("disconnected")
		target=null
		$linebutton.mouse_filter=Control.MOUSE_FILTER_IGNORE
		$linebutton.disabled=true

func delete():
	cut()
	block.connections.erase(self)
	block.connection_by_name.erase(savename)
	queue_free()

func _on_linebutton_pressed():
	cut()
