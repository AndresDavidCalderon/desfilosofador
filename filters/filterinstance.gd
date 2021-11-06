extends Control
onready var new=$ui/result/new
func getsavedata():
	var save={}
	save["of"]=$ui/of/origin.text
	save["to"]=new.text
	save["enabled"]=$enabled.pressed
	return save
func fromfile(save:Dictionary):
	if save.has("enabled"):
		$enabled.pressed=save["enabled"]
	new.text=save["to"]
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
	if $enabled:
		text=stringfunc.replacefind(pos,$ui/of/origin.text,text,new.text)
	return text
