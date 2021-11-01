extends Panel
class_name popup,"res://UI/popupicon.png"
signal closed
export(Color) var errorcolor
func _init():
	globals.popuper=self
	visible=false
var normalsize=rect_size.y
var addedchild=[]
func _ready():
	visible=false
func _on_quit_pressed():
	unpopup()
func unpopup():
	emit_signal("closed")
	if visible:
		var cleared=0
		while cleared<addedchild.size():
			addedchild[cleared].queue_free()
			cleared+=1
		addedchild.clear()
		visible=false
		$vorder.rect_size.y=0
		$vorder.queue_sort()
	else:
		globals.iprint("already unpopuped")
func popup(title:String,desc="",fields:Array=[],canout=true,error:bool=false):
	$quit.visible=canout
	if visible:
		unpopup()
	visible=true
	var added=0
	$title.text=title
	if error:
		$title.set("custom_colors/font_color",errorcolor)
	var font=$title.get("custom_fonts/font") as DynamicFont
	while font.get_string_size(title).x>$title.rect_size.x:
		font.size-=1
	var desclabel=$vorder/description
	desclabel.text=desc
	var instanced=[]
	while added<fields.size():
		var new=fields[added].new() as Control
		instanced.append(new)
		$vorder.add_child(new)
		addedchild.append(new)
		new.set("custom_fonts/font",preload("res://UI/font/text.tres"))
		added+=1
	return instanced

func _on_vorder_sort_children():
	rect_size.y=($vorder.rect_position.y+$vorder.rect_size.y)+5
