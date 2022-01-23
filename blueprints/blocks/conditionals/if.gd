extends blockbase

func customload(dict):
	$operator.select(dict["operator"])
func customsave(dict):
	dict["operator"]=$operator.selected


func _on_add_pressed():
	if $conditions.conditions>1:
		$operator.visible=true


func _on_del_pressed():
	if $conditions.conditions==0:
		$operator.visible=false

func fromfile(dict):
	$operator.select(dict["operator"])
