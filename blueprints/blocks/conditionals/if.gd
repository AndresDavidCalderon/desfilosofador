extends blockbase

export(PoolStringArray) var options
onready var add=$conditions/add
var conditions=0

func _on_add_pressed():
	conditions+=1
	$operator.visible=true
	$conditions/del.disabled=false
	var new=preload("res://blueprints/connection/value/reciever.tscn").instance()
	new.savename="cond"+str(conditions)
	new.block=self
	$conditions.add_child(new)
	$conditions.move_child($conditions/add,$conditions.get_child_count())
	$conditions.move_child($conditions/del,$conditions.get_child_count())


func _on_conditions_resized():
	rect_size.x=$conditions.rect_size.x+$conditions.rect_position.x+10


func _on_del_pressed():
	$conditions.get_child(conditions+1).delete()
	conditions-=1
	if conditions==0:
		$operator.visible=false
		$conditions/del.disabled=true

func customsave(dict):
	dict["operator"]=$operator.selected

func _fromfile(dict):
	var idx=1
	while dict["connections"].has("cond"+str(idx)):
		_on_add_pressed()
		idx+=1
	$operator.select(dict["operator"])
