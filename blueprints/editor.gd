extends window

onready var tests=$testcontainer
export(Dictionary) var block_by_name
func _on_compile_pressed():
	$view/workspace.set_indexes()
	var tree=[{"enabled":true,"origin":-1,"inside":[]}]
	tree[0]["inside"].append({"type":"blueprint","enabled":true,"name":"test","code":get_save_array()})
	tests.get_node("to").text=compiler.compile(tests.get_node("from").text,tree)
	$output.visible=true
	$output.add(compiler.compilelog)


func get_save_array():
	$view/workspace.set_indexes()
	var blocks=[]
	for i in $view/workspace.get_children():
		if i is blockbase:
			blocks.append(i.getsave())
	return blocks

signal save(dict)
func _on_save_pressed():
	emit_signal("save",{"type":"blueprint","enabled":true,"name":"unnamed","code":get_save_array()})
	_on_close_pressed()
var blocks=[]

func addcode(newblocks:Array):
	blocks.clear()
	$view/workspace.clear()
	for i in newblocks:
		if block_by_name.has(i["type"]):
			var new=block_by_name[i["type"]].instance()
			new.base=$view/workspace
			$view/workspace.add_child(new)
			blocks.append(new)
		else:
			globals.popuper.popup("error loading, invalid type "+i["type"])
	var idx=0
	for i in blocks:
		i.fromfile(newblocks[idx])
		idx+=1
