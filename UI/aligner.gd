extends Node2D
class_name aligner,"res://ui/extendericon.png"
export(bool) var sety
export(bool) var setx
export var scaleview=Vector2(1,1)
export(bool) var invisiblestart
export(Vector2) var offset
export var safeposmult=Vector2(0,0)
onready var initscale=scale
export(bool) var scales
export(bool) var fromzero=true
var initsize=Vector2(ProjectSettings.get("display/window/size/width"),ProjectSettings.get("display/window/size/height"))
func _ready():
	if invisiblestart:
		visible=false
	get_tree().root.connect("size_changed", self, "setgui")
	setgui()
func setgui():
	var base=get_viewport_rect()
	if fromzero:
		position=Vector2(0,0)
	if sety:
		position.y=base.size.y*scaleview.y
	if setx:
		position.x=base.size.x*scaleview.x
	position+=OS.get_window_safe_area().position*safeposmult
	position+=offset
	
	var mult=initscale*(get_viewport_rect().size/initsize)
	var newscale=[mult.x,mult.y].min()
	if scales:
		scale=Vector2(newscale,newscale)
	if has_method("customscale"):
		call("customscale",Vector2(newscale,newscale))
