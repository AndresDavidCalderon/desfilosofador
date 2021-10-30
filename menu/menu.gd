extends Control

export(PackedScene) var filterlibrary
func _on_manager_pressed():
	get_tree().change_scene_to(filterlibrary)
