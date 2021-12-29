extends virtualblock
func asked_var(name:String):
	if name=="return":
		print(stringfunc.addbetween(getvar("text"),getvar("toadd"),getvar("where")))
		return stringfunc.addbetween(getvar("text"),getvar("toadd"),getvar("where"))
