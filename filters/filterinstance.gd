extends Control
func getsavedata():
	var save={}
	save["of"]=$ui/of/origin.text
	save["to"]=$ui/result/new.text
	save["enabled"]=$enabled.pressed
	return save
func fromfile(save:Dictionary):
	if save.has("enabled"):
		$enabled.pressed=save["enabled"]
	$ui/result/new.text=save["to"]
	$ui/of/origin.text=save["of"]

var oldtext=""
func _on_origin_text_changed(new_text):
	if oldtext!="":
		globals.filterbyphrase[oldtext].erase(self)
	if new_text!=null:
		if not globals.filterbyphrase.has(new_text):
			globals.filterbyphrase[new_text]=[]
		globals.filterbyphrase[new_text].append(self)
	oldtext=new_text
func found(pos,text:String):
	text.replace($ui/of/origin.text,$ui/result/new.text)
