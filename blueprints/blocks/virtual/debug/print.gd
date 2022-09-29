extends virtualblock

func onevent(_event):
	var result=[]
	var idx=1
	while data["connections"].has("str"+str(idx)):
		result.append(str(getvar("str"+str(idx))))
		idx+=1
	compiler.addlog(result)
	doevent("continue")
