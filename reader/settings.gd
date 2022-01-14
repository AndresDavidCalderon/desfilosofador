extends ScrollContainer
onready var reader=get_parent().get_parent().get_parent().get_node("read") as TextEdit
func _ready():
	globals.connect("newreader",self,"readerchange")

func _on_font_value_changed(value):
	(preload("res://UI/readtheme.tres").default_font as DynamicFont).size=value

func _on_fullscreen_toggled(button_pressed):
	OS.window_fullscreen=button_pressed
	
func _on_wrap_toggled(button_pressed):
	globals.reader.wrap_enabled=button_pressed

func readerchange():
	for i in $list.get_children():
		if i is Button:
			i.emit_signal("toggled",i.pressed)

func _on_map_toggled(button_pressed):
	reader.minimap_draw=button_pressed
