extends Area2D
var mapChange = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.PlayerBusy = true
		GuiEffects.startFadeOut(0.005, 1.0)
		AudioStreamPlayerGlobal.startFadeOut(0.005, 0.1)
		$Timer.start()
		
func _process(_delta: float) -> void:
	if mapChange and !AudioStreamPlayerGlobal.audioBusy and GuiEffects.fadingFinished:
		get_tree().change_scene_to_file("res://scenes/maps/map04.tscn")


func _on_timer_timeout() -> void:
	mapChange = true
