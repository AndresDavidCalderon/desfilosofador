extends Node
var popuper:popup
var skipquotes=true
var reader:Control setget setreader
signal newreader
func setreader(value):
	if value!=reader:
		reader=value
		emit_signal("newreader")
func _input(event):
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen=not OS.window_fullscreen
