extends virtualblock

func do(follows):
	var text=getvar("text")
	var where=getvar("where")
	var suf=getvar("suffix")
	var result=false
	match suf:
		compiler.VERB:
			pass
func asked_var(what):
	if what=="return":
		do(false)
