tool
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
export(bool) var uselocalscale
export(bool) var istool
export(NodePath) var userect
var initsize=Vector2(ProjectSettings.get("display/window/size/width"),ProjectSettings.get("display/window/size/height"))
func _ready():
	if invisiblestart and not Engine.editor_hint:
		visible=false
	if istool or not Engine.editor_hint:
		get_tree().root.connect("size_changed", self, "setgui")
		setgui()
		if userect!="" and userect!=null:
			get_node(userect).connect("resized",self,"setgui")
func setgui():
	if istool or not Engine.editor_hint:
		var base=get_viewport_rect().size
		if userect!="" and userect!=null:
			base=get_node(userect).rect_size
		if uselocalscale:
			base*=get_parent().scale
		if fromzero:
			position=Vector2(0,0)
		if sety:
			position.y=base.y*scaleview.y
		if setx:
			position.x=base.x*scaleview.x
		position+=OS.get_window_safe_area().position*safeposmult
		position+=offset
		var mult=initscale*(base/initsize)
		var newscale=[mult.x,mult.y].min()
		if scales:
			scale=Vector2(newscale,newscale)
		if has_method("customscale"):
			call("customscale",Vector2(newscale,newscale))
