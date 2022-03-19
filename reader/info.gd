extends Button

func _pressed():
	globals.popuper.popup("build information","used "+str(compiler.used.size())+" filters",[])
