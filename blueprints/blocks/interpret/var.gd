extends virtualblock

func asked_var(name):
	match data["vartype"]:
		"string":
			return str(getvar("content"))
		"float":
			return float(getvar("content"))
		"bool":
			match getvar("content"):
				"true":
					return true
				"false":
					return false
				_:
					compiler.addlog("invalid bool, returning false")
					return false
