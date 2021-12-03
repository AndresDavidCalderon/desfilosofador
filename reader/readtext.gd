extends TextEdit

func _ready():
	get_viewport().connect("size_changed",self,"setsize")

func setsize():
	rect_size=get_viewport_rect().size/1.3
	rect_position=Vector2()-(rect_size/2)
func get_index_heigth():
	pass
