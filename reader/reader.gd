extends Panel
func _ready():
	globals.reader=$new/center/text
	$new.visible=true
	$read.visible=false
	get_viewport().connect("size_changed",self,"setsize")
func setsize():
	rect_size=get_viewport_rect().size

func _on_close_pressed():
	$librarycontainer.visible=false

func _on_library_pressed():
	$librarycontainer.visible=true
	

onready var reader=$read/center/text
onready var compiler=$librarycontainer/filtersearch/upcenter/scroll/vbox
func _on_read_pressed():
	globals.reader=$read/center/text
	reader.text=compiler.compile($new/center/text.text)
	$new.visible=false
	$read.visible=true

func _on_reconstruct_pressed():
	reader.text=compiler.compile($new/center/text.text)

func _on_change_pressed():
	globals.reader=$new/center/text
	$new.visible=true
	$read.visible=false
