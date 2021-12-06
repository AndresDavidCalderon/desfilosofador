extends ScrollContainer
func _ready():
	pass 

func _on_font_value_changed(value):
	(preload("res://UI/readtheme.tres").default_font as DynamicFont).size=value


func _on_fullscreen_toggled(button_pressed):
	OS.window_fullscreen=button_pressed


func _on_wrap_toggled(button_pressed):
	globals.reader.wrap_enabled=button_pressed

