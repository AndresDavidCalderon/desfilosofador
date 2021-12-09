extends Panel
class_name window,"res://UI/window/icon.png"
var offset=Vector2()
func _process(_delta):
	if $up.pressed or $topleft.pressed or $upright.pressed:
		var before=rect_global_position.y
		rect_global_position.y=get_global_mouse_position().y
		rect_size.y+=before-rect_global_position.y
	if $left.pressed or $topleft.pressed or $downleft.pressed:
		var before=rect_global_position.x
		rect_global_position.x=get_global_mouse_position().x
		rect_size.x+=before-rect_global_position.x
	if $down.pressed or $downright.pressed or $downleft.pressed:
		rect_size.y=get_global_mouse_position().y-rect_global_position.y
	if $right.pressed or $downright.pressed or $upright.pressed:
		rect_size.x=get_global_mouse_position().x-rect_global_position.x
func _on_close_pressed():
	visible=false
