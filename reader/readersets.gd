extends Panel


var hidden=true
export(float) var duration
export(Texture) var left
export(Texture) var right
func _on_hide_pressed():
	if hidden:
		$tween.interpolate_property(self,"rect_position",null,Vector2(-rect_size.x,-rect_size.y/2),duration)
		$tween.set_active(true)
		$hide.texture_normal=right
		hidden=false
	else:
		$tween.interpolate_property(self,"rect_position",null,Vector2(0,-rect_size.y/2),duration)
		$tween.set_active(true)
		$hide.texture_normal=left
		hidden=true
