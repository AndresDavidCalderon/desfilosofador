extends virtualblock

func asked_var(_what):
	return stringfunc.getuntilback(getvar("where"),getvar("text"),globals.finishers)
