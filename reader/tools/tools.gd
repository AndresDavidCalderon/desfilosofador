extends HBoxContainer
export(float) var margin
var reader:Control
onready var result=get_parent().get_parent().get_node("read/text")
onready var input=get_parent().get_parent().get_node("new/center/text")
func _ready():
	get_viewport().connect("size_changed",self,"resize")
func resize():
	rect_size.x=get_viewport_rect().size.x-margin
	rect_position.x=-rect_size.x/2

func _on_text_visibility_changed():
	if get_parent().get_parent().get_node("new").visible:
		reader=input
	else:
		reader=result

func gettext()->String:
	if reader is RichTextLabel:
		return reader.bbcode_text
	if reader is TextEdit:
		return reader.text
	return ""
