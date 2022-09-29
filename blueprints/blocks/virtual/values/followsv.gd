extends virtualblock

func asked_var(what):
	return stringfunc.get_until_opts(getvar("where"),getvar("text"),globals.finishers)
