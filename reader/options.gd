extends HBoxContainer
##the tools at the top.

onready var read=get_parent().get_node("read")
func _ready():
	setvis()

func setvis():
	$reconstruct.visible=read.visible
	$change.visible=read.visible
	$read.visible=$"%NewText".visible
