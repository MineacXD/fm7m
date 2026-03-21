extends Sprite2D

func returnToPreviousScene():
	var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/map02")

	TheRoot.remove_child(ThisScene)
	ThisScene.call_deferred("free")
	
	var NextScene = Global.PreviousScreen
	TheRoot.add_child(NextScene)
	AudioStreamPlayerGlobal.stream_paused = false
	Global.BattleFinished = true

func _on_area_entered(area: Area2D) -> void:
	$Canva/Fadeout.visible = true
	$DreamWakeUp.play()
	$Timer.start()


func _on_timer_timeout() -> void:
	QuestTracker.DreamComplete = true
	QuestTracker.QuestPorkFinished = false
	returnToPreviousScene()


func _on_timer_audio_timeout() -> void:
	$DreamWakeUp.play()
