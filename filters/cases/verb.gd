extends Node

static func found(word:String,context:Dictionary):
	prints("verb",word)
	return globals.library.verbs.has(word)
