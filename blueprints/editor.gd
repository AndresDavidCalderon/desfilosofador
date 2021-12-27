extends window

onready var tests=$testcontainer
func _on_compile_pressed():
	$view/workspace.set_indexes()
	var tree=[{"enabled":true,"origin":-1,"inside":[]}]
	tree[0]["inside"].append({"type":"blueprint","enabled":true,"code":get_save_array()})
	tests.get_node("to").text=compiler.compile(tests.get_node("from").text,tree)
	$output.visible=true
	$output.add(compiler.compilelog)


func get_save_array():
	var blocks=[]
	for i in $view/workspace.get_children():
		if i is blockbase:
			blocks.append(i.getsave())
	return blocks
