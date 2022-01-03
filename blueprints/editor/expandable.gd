extends Button
func _ready():
	toggle_mode=true
	_toggled(pressed)
	for i in $options.get_children():
		i.connect("pressed",self,"_toggled",[false])
func _toggled(button_pressed):
	$options.visible=button_pressed
	if pressed!=button_pressed:
		pressed=button_pressed
