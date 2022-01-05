extends Button
class_name optionbutton,"res://UI/images/options.png"
export(int) var selected
signal selected(index)
func _ready():
	$box.visible=false
	for i in $box.get_children():
		i.connect("pressed",self,"select",[i.get_index()])
	$box.get_child(selected).pressed=true


func select(index):
	$box.visible=false
	selected=index
	text=$box.get_child(index).text
	emit_signal("selected",index)


func _pressed():
	$box.visible=not $box.visible
