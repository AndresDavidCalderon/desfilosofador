extends virtualblock

func onevent(event:String):
	if event=="send":
		interpreter.answertext=getvar("text")
