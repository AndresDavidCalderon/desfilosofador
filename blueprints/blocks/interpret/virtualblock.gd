extends Resource
class_name virtualblock
var interpreter
var data:Dictionary
var values={}
func doevent(name):
	if data["connections"].has(name):
		var connection=data["connections"][name]
		if connection["type"]=="event":
			print(connection)
			if connection["targets"].size()>0:
				for i in connection["targets"]:
					interpreter.blocks[i["toidx"]].onevent(i["toname"])
			else:
				compiler.addlog(["signal",name,"not connected"])
		else:
			printerr("connection ",name," isnt an event")
	else:
		printerr("connection ",name," doesnt exist")

func getvar(name):
	if data["connections"].has(name):
		var connection=data["connections"][name]
		if connection["type"]=="value":
			if connection.has("impliedvalue"):
				return connection["impliedvalue"]
			return connection["toidx"].setvar(connection["toname"])
		else:
			compiler.addlog("getting invalid value")
			return null
	else:
		compiler.addlog(["connection ",name," doesnt exist"])
		return null

func setvar(name):
	if values.has(name):
		return values[name]
	else:
		if has_method("asked_var"):
			return call("asked_var",name)
		else:
			printerr("cant ask for var on this block")
			return null
