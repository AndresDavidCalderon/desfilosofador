extends libraryelement
onready var new=$ui/result/new
onready var from=$ui/of/origin
func getsave(save:Dictionary):
	save["of"]=from.text
	save["to"]=new.text
	save["enabled"]=$enabled.pressed
func fromfile(save:Dictionary):
	if save.has("enabled"):
		$enabled.pressed=save["enabled"]
	new.text=save["to"]
	register(save["of"])
	from.text=save["of"]

var oldtext=""
func register(new_text):
	if oldtext!="":
		globals.filterbyphrase[oldtext].erase(self)
	if new_text!=null and new_text!="":
		if not globals.filterbyphrase.has(new_text):
			globals.filterbyphrase[new_text]=[]
		globals.filterbyphrase[new_text].append(self)
	oldtext=new_text
func found(pos,text:String):
	if $enabled:
		text=stringfunc.replacefind(pos,from.text,text,new.text)
	return text


func delete():
	if globals.filterbyphrase.has(from.text):
		globals.filterbyphrase[from.text].erase(self)
	queue_free()
