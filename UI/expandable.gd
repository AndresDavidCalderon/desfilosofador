extends Button
class_name expandable,"res://UI/images/expandable.png"
export(bool) var has_background=true
export(Vector2) var margin=Vector2(10,10)
var background=Panel.new()
onready var options=$options
var layerer:Node2D=Node2D.new()
func _ready():
	add_child(layerer)
	layerer.z_index=1
	remove_child(options)
	layerer.add_child(options)
	if has_background:
		layerer.add_child(background)
		background.name="back"
		background.add_stylebox_override("Panel",null)
		layerer.move_child(background,0)
		options.connect("resized",self,"updateback")
		updateback()
	toggle_mode=true
	_toggled(pressed)
	for i in options.get_children():
		i.connect("pressed",self,"_toggled",[false])
func _toggled(button_pressed):
	background.visible=button_pressed
	options.visible=button_pressed
	if pressed!=button_pressed:
		pressed=button_pressed
func updateback():
	background.rect_position=options.rect_position-margin
	background.rect_size=options.rect_size+(margin*2)
