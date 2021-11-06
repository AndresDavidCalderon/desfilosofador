extends Node

func _ready():
	$new.visible=true

func _on_close_pressed():
	$librarycontainer.visible=false

func _on_library_pressed():
	$librarycontainer.visible=true
	$librarycontainer/filtersearch.openfilters()
	

onready var reader=$read/center/text
onready var compiler=$librarycontainer/filtersearch/upcenter/scroll/vbox
func _on_read_pressed():
	$librarycontainer/filtersearch.openfilters()
	reader.text=compiler.compile($new/center/text.text)
	$new.visible=false
