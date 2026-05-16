extends Node2D
var obj_bullet = preload("res://scenes/bullets/pig_bullet.tscn")
var trackGenerator = RandomNumberGenerator.new()

func returnToPreviousScene():
	var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/BattleScene_test")

	TheRoot.remove_child(ThisScene)
	ThisScene.call_deferred("free")
	var NextScene = Global.PreviousScreen
	TheRoot.add_child(NextScene)
	AudioStreamPlayerGlobal.stream_paused = false
	Global.BattleFinished = true
	

func _on_pig_spawn_timer_timeout() -> void:
	var new_bullet = obj_bullet.instantiate()
	var track = trackGenerator.randf_range(0, 2.5)
	new_bullet.position = Vector2(0, 160 * track)
	add_child(new_bullet)
	
func _process(delta: float) -> void:
	$TimeDisplay.text = "Tiempo restante: " + str(floori($BattleTimer.time_left))

func _on_battle_timer_timeout() -> void:
	QuestTracker.porkchops += 1
	returnToPreviousScene()
