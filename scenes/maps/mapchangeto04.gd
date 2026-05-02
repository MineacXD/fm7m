extends Area2D
var mapChange = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.PlayerBusy = true
		GuiEffects.startFadeOut(0.005, 1.0)
		AudioStreamPlayerGlobal.startFadeOut(0.005, 0.1)
		$Timer.start()
		
func _process(_delta: float) -> void:
	if QuestTracker.map03Done and !AudioStreamPlayerGlobal.audioBusy and GuiEffects.fadingFinished:
		QuestTracker.map03Done2 = true


func _on_timer_timeout() -> void:
	QuestTracker.map03Done = true
