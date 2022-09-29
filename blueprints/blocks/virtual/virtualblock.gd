extends Resource
class_name virtualblock
var interpreter
var data:Dictionary
var values={}

"""triggers an event output"""
func doevent(name):
	if data["connections"].has(name):
		var connection=data["connections"][name]
		if connection["type"]=="event":
			if connection["targets"].size()>0:
				for i in connection["targets"]:
					if i["toidx"]!=null:
						interpreter.blocks[i["toidx"]].onevent(i["toname"])
		else:
			printerr("connection ",name," isnt an event")
	else:
		printerr("connection ",name," doesnt exist")

#returns the value in this block
func getvar(name):
	if data["connections"].has(name):
		var connection=data["connections"][name]
		if connection["type"]=="value":
			if not connection.has("impliedvalue"):
				if connection.has("toidx") and connection["toidx"]!=null:
					return interpreter.blocks[connection["toidx"]].setvar(connection["toname"])
				else:
					compiler.addlog(["value",name,"isnt connected and seems needed"])
			else:
				return connection["impliedvalue"]
		else:
			compiler.addlog(["connection",name,"isnt value"])
			return null
	else:
		compiler.addlog(["connection ",name," doesnt exist"])
		return null

"""to ask another block for the 
value,name should be the name of 
the value in the other block"""
func setvar(name):
	if values.has(name):
		return values[name]
	else:
		if has_method("asked_var"):
			return call("asked_var",name)
		else:
			printerr("cant ask for var on this block")
			return null
