extends Button
var selected
signal selected(index)
func _ready():
	for i in $box.get_children():
		i.connect("pressed",self,"select",[i.get_index()])
func select(index):
	$box.visible=false
	selected=index
	text=$box.get_child(index).text
	emit_signal("selected",index)
func _pressed():
	$box.visible=not $box.visible
