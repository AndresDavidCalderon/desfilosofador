extends virtualblock
func asked_var(name:String):
	if name=="return":
		return stringfunc.addbetween(getvar("text"),getvar("toadd"),getvar("where"))
