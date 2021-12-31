extends blockbase

func customsave(dict):
	dict["phrase"]=$phrase.text

func customload(dict):
	$phrase.text=dict["phrase"]
