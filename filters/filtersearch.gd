extends Node2D
export(PackedScene) var filter
export(bool) var onexe
var fileman=File.new()
var filedir
onready var box=$upcenter/scroll/vbox
func _ready():
	if onexe:
		filedir=OS.get_executable_path()+"/filters.json"
	else:
		filedir="user://filters.json"
func openfilters():
	var error=fileman.open(filedir,File.READ)
	if error==OK:
		if fileman.get_as_text()!="":
			var dict=JSON.parse(fileman.get_as_text())
			if dict.error==OK:
				dict=dict.result as Array
				for i in dict.size():
					var new=filter.instance()
					box.add_child(new)
					new.fromfile(dict[i])
			else:
				globals.popuper.popup("error abriendo los filtros","error "+str(dict.error)+"en la linea "+str(dict.error_line))
		else:
			print("empty file.")
		fileman.close()
	else:
		globals.popuper.popup("error abriendo el archivo","error "+str(error))
func savefilters():
	var filters=[]
	for i in box.get_children().size():
		filters.append(box.get_child(i).getsavedata())
	var error=fileman.open(filedir,File.WRITE)
	if error==OK:
		fileman.store_string(JSON.print(filters))
		prints("se guardo:",JSON.print(filters))
		fileman.close()
	else:
		globals.popuper.popup("error guardando!","error "+str(error))
func _on_newfilter_pressed():
	box.add_child(filter.instance())
func _on_save_pressed():
	savefilters()
	globals.popuper.popup("guardado!")
func _notification(what):
	if what==MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		savefilters()
