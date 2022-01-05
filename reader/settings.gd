extends ScrollContainer
onready var reader=get_parent().get_parent().get_parent().get_node("read/text") as TextEdit
func _ready():
	globals.connect("newreader",self,"readerchange")

func _on_font_value_changed(value):
	(preload("res://UI/readtheme.tres").default_font as DynamicFont).size=value

func _on_fullscreen_toggled(button_pressed):
	OS.window_fullscreen=button_pressed
	
func _on_wrap_toggled(button_pressed):
	globals.reader.wrap_enabled=button_pressed
	
func readerchange():
	globals.reader.wrap_enabled=$list/wrap.pressed


func _on_map_toggled(button_pressed):
	reader.minimap_draw=button_pressed
