extends Panel
class_name blockbase,"res://blueprints/blockbase.png"
var following:bool=false
var offset:Vector2
var base:Viewport
func _ready():
	if base==null:
		base=get_parent()
func _on_select_button_down():
	following=true
	offset=rect_position-get_global_mouse_position()

func _on_select_button_up():
	following=false

func _process(_delta):
	if following:
		rect_position=get_global_mouse_position()+offset

func _input(event):
	if event.is_action_pressed("delete") and following:
		queue_free()
