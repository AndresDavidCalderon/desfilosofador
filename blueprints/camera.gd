extends Camera2D
export(float) var zoomspeed
export(float) var minzoom
export(float) var maxzoom
onready var editor=get_parent().get_parent().get_parent()
func _process(delta):
	if Input.is_action_pressed("zoomout"):
		if zoom.x<maxzoom:
			zoom.x+=zoomspeed*delta
			zoom.y+=zoomspeed*delta
	if Input.is_action_pressed("zoomin"):
		if zoom.x>minzoom:
			zoom.x-=zoomspeed*delta
			zoom.y-=zoomspeed*delta
	$background/move.rect_size=get_parent().size*zoom
	$background/move.rect_position=-get_parent().size*zoom/2
var before:Vector2
func _input(event):
	if $background/move.pressed and event is InputEventMouseMotion:
		position+=event.relative
func _on_move_button_down():
	if editor.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_move_button_up():
	if editor.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
