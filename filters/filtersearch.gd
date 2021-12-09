extends window
export(PackedScene) var filter
export(PackedScene) var folder
export(Dictionary) var scriptonfound
export(bool) var onexe
var defaulttree=[{"origin":-1,"enabled":true,"inside":[{"type":"folder","name":"root","enabled":true,"index":1}]},{"origin":0,"enabled":true,"inside":[]}]
var filtertree:Array=defaulttree
var fileman=File.new()
var filedir
var index=1
onready var box=$scroll/vbox
func _ready():
	if onexe:
		filedir=OS.get_executable_path()+"/filters.json"
	else:
		filedir="user://filters.json"
	openfilters()
func deleteall():
	filtertree=defaulttree
func refresh():
	box.savecurrent()
	globals.filterbyphrase={}
	for i in filtertree:
		if i["enabled"]:
			for j in i["inside"]:
				if scriptonfound.has(j["type"]):
					scriptonfound[j["type"]].new().fromfile(j)
func openfilters():
	deleteall()
	var error=fileman.open(filedir,File.READ)
	if error==OK:
		if fileman.get_as_text()!="":
			var dict=JSON.parse(fileman.get_as_text())
			if dict.error==OK:
				filtertree=dict.result as Array
				box.openfolder(1)
			else:
				globals.popuper.popup("error abriendo los filtros","error "+str(dict.error)+"en la linea "+str(dict.error_line))
		else:
			print("empty file.")
			box.openfolder(1)
		fileman.close()
	else:
		globals.popuper.popup("error abriendo el archivo","error "+str(error))
func savefilters():
	box.savecurrent()
	var error=fileman.open(filedir,File.WRITE)
	if error==OK:
		fileman.store_string(JSON.print(filtertree,"\t"))
		fileman.close()
	else:
		globals.popuper.popup("error guardando!","error "+str(error))
func _on_newfilter_pressed():
	addelement(filter)
func _on_save_pressed():
	savefilters()
	globals.popuper.popup("guardado!")
func _notification(what):
	if what==MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		savefilters()

func addelement(scene:PackedScene):
	var new=scene.instance() as libraryelement
	new.index=filtertree[index]["inside"].size()
	box.add_child(new)
	var data:Dictionary
	if new.has_method("getdef"):
		data=new.getonnew()
	else:
		data=new.getsavedata()
	filtertree[index]["inside"].append(data)

func _on_newfolder_pressed():
	addelement(folder)

func _on_folderup_pressed():
	box.savecurrent()
	if index==1:return
	box.openfolder(filtertree[index]["origin"])
	var text=$dir.text
	$dir.text=stringfunc.cutright(text.find_last("/")+1,text)


func _on_excludequotes_toggled(button_pressed):
	globals.skipquotes=button_pressed


func _on_blueprint_pressed():
	$blueprints.visible=true
