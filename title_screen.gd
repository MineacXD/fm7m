extends Control

func _on_change_skin_pressed() -> void:
	if Global.skinChange == false:
		$BoxContainer/ChangeSkin.text = "Current skin: fuyu"
		Global.skinChange = true
	else:
		$BoxContainer/ChangeSkin.text = "Current skin: enanan"
		Global.skinChange = false


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/maps/map01.tscn")
