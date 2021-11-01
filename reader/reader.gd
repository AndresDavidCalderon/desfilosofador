extends Node



func _on_close_pressed():
	$librarycontainer.visible=false

func _on_library_pressed():
	$librarycontainer.visible=true
	$librarycontainer/filtersearch.openfilters()
	


func _on_read_pressed():
	$librarycontainer/filtersearch.openfilters()
