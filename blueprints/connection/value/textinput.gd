extends "res://blueprints/connection/reciever.gd"



func _on_reciever_connected():
	$optionalval.editable=false
	impliedvalue=null

func _on_optionalval_text_changed(new_text):
	if target==null:
		impliedvalue=new_text
