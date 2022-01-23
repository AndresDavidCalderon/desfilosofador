extends HBoxContainer

export(String) var prefix
var conditions=1

func _ready():
	$first.savename=prefix+"1"

func _on_add_pressed():
	conditions+=1
	$del.disabled=false
	var new=preload("res://blueprints/connection/value/reciever.tscn").instance()
	new.savename=prefix+str(conditions)
	new.block=get_parent()
	add_child(new)
	move_child($add,get_child_count())
	move_child($del,get_child_count())


func _on_conditions_resized():
	get_parent().rect_size.x=rect_size.x+rect_position.x+10


func _on_del_pressed():
	get_child(conditions+1).delete()
	conditions-=1
	if conditions==0:
		$del.disabled=true


func fromfile(dict):
	var idx=1
	while dict["connections"].has(prefix+str(idx)):
		_on_add_pressed()
		idx+=1
