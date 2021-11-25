extends RichTextLabel

func _ready():
	get_viewport().connect("size_changed",self,"setsize")

func setsize():
	rect_size=get_viewport_rect().size/1.3
	rect_position=Vector2()-(rect_size/2)

func getnormaltext()->String:
	var from=0
	var newtext=bbcode_text
	while true:
		from=newtext.find("[",from)
		if from!=-1:
			var to=newtext.find("]",from)
			newtext=stringfunc.cutout(from+1,to+2,newtext)
		else:
			break
	return newtext
