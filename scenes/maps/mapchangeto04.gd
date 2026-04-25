extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.PlayerBusy = true
		GuiEffects.startFadeOut(0.005, 1.0)
		AudioStreamPlayerGlobal.startFadeOut(0.005, 0.1)
