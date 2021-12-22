extends Resource
class_name virtualblock
var interpreter
var data:Dictionary

func doevent(name):
	if data["connections"].has(name):
		var connection=data["connections"][name]
		if connection["type"]=="event":
			interpreter.blocks[connection["toidx"]].onevent(connection["toname"])
		else:
			printerr("connection ",name," isnt an event")
	else:
		printerr("connection ",name," doesnt exist")
