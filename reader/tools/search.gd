extends Button
export(Color) var foundcolor
func _ready():
	$options.visible=false
func _toggled(button_pressed):
	$options.visible=button_pressed
func _on_terms_text_changed(new_text):
	var found=0
	if new_text!="":
		var from=0
		var findon=get_parent().gettext() as String
		while true:
			from=findon.find(new_text,from)
			if stringfunc.isbetween(from,"[]",findon):
				pass
			if from!=-1:
				from+=1
				found+=1
			else:
				break
	$options/found.text=str(found)
