extends Camera2D
export(float) var zoomspeed
export(float) var minzoom
export(float) var maxzoom
func _process(delta):
	if Input.is_action_pressed("zoomout"):
		if zoom.x<maxzoom:
			zoom.x+=zoomspeed*delta
			zoom.y+=zoomspeed*delta
	if Input.is_action_pressed("zoomin"):
		if zoom.x>minzoom:
			zoom.x-=zoomspeed*delta
			zoom.y-=zoomspeed*delta
