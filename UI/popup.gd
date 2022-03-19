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
onready var titlelabel=$vorder/title
func popup(title:String,desc="",fields:Array=[],canout=true,error:bool=false):
	$quit.visible=canout
	if visible:
		unpopup()
	visible=true
	titlelabel.text=title
	if error:
		titlelabel.set("custom_colors/font_color",errorcolor)
	var font=titlelabel.get("custom_fonts/font") as DynamicFont
	var looped=false
	while font.get_string_size(title).x>titlelabel.rect_size.x:
		font.size-=1
		looped=true
	if looped:
		font.size+=10
	var desclabel=$vorder/description
	desclabel.text=desc
	var instanced=[]
	for i in fields:
		var new=i.new() as Control
		instanced.append(new)
		$vorder.add_child(new)
		addedchild.append(new)
		new.set("custom_fonts/font",preload("res://UI/font/text.tres"))
	return instanced
