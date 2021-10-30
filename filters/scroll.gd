extends ScrollContainer

func _ready():
	get_viewport().connect("size_changed",self,"newsize")
func newsize():
	rect_size.y=get_viewport_rect().size.y
