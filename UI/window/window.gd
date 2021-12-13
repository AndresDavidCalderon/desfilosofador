extends Panel
class_name window,"res://UI/window/icon.png"
export var obfuscateback:bool
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
var back=ColorRect.new()
func _ready():
	back.color.a=0.2
	get_viewport().connect("size_changed",self,"onsize")
func _on_window_visibility_changed():
	if not obfuscateback:return
	if visible:
		get_parent().add_child(back)
		onsize()
	else:
		get_parent().remove_child(back)
func onsize():
	if not back.is_inside_tree():return
	back.rect_global_position=Vector2.ZERO
	back.rect_size=get_viewport_rect().size
	get_parent().move_child(back,get_index())
