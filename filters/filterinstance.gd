extends Control
func getsavedata():
	var save={}
	save["of"]=$ui/of/origin.text
	save["to"]=$ui/result/new.text
	return save
func fromfile(save:Dictionary):
	$ui/result/new.text=save["to"]
	$ui/of/origin.text=save["to"]

var oldtext=""
func _on_origin_text_changed(new_text):
	if oldtext!="":
		globals.filterbyphrase[oldtext].erase(self)
	if new_text!=null:
		if not globals.filterbyphrase.has(new_text):
			globals.filterbyphrase[new_text]=[]
		globals.filterbyphrase[new_text].append(self)
	oldtext=new_text
