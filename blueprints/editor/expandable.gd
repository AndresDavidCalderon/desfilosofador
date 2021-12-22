extends Button
func _ready():
	_toggled(pressed)
func _toggled(button_pressed):
	$options.visible=button_pressed
