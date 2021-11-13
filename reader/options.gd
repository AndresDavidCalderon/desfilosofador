extends HBoxContainer
onready var read=get_parent().get_node("read")
onready var new=get_parent().get_node("new")
func _ready():
	setvis()

func setvis():
	$reconstruct.visible=read.visible
	$change.visible=read.visible
	$read.visible=new.visible
