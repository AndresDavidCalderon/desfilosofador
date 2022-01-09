extends virtualblock

func determine():
	var idx=1
	var result=true
	while data["connections"].has("cond"+str(idx)):
		var cond=getvar("cond"+str(idx))
		match data["operator"]:
			0:
				if not cond:return false
			1:
				if cond:return true
		idx+=1
	match data["operator"]:
		0:
			return true
		1:
			return false

func asked_var(_val):
	return determine()

func onevent(_event):
	var result=determine()
	values["saver"]=result
	if result:
		doevent("sender")
