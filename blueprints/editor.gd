extends Panel

func _ready():
	get_viewport().connect("size_changed",self,"sized")
func sized():
	if not get_parent() is Viewport:return
	rect_size=get_viewport_rect().size
