extends VBoxContainer

onready var reader=get_parent().get_parent()
func _on_fontsize_value_changed(value):
	var font=preload("res://UI/readtheme.tres").default_font as DynamicFont
	font.size=value
 
