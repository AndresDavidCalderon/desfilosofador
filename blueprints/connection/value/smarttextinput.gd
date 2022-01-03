extends "res://blueprints/connection/reciever.gd"

func _ready():
	impliedvalue=""



func _on_optionalval_text_changed(new_text):
	if target!=null:
		impliedvalue=new_text



func _on_reciever_connected():
	impliedvalue=null


func _on_verb_pressed():
	$optionalval.editable=false
	$optionalval.text="verbo"
	impliedvalue=compiler.VERB

func _on_value_pressed():
	$optionalval.editable=true
	$optionalval.text=""


func _on_subject_pressed():
	$optionalval.editable=false
	$optionalval.text="sujeto"
	impliedvalue=compiler.SUBJECT
