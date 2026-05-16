extends Node2D

var obj_bullet = preload("res://scenes/bullets/baby_bullet.tscn")
var bulletsSpawned = 0

func _ready() -> void:
	Global.lives = 3
	var new_bullet = obj_bullet.instantiate()
	add_child(new_bullet)
	bulletsSpawned += 1

func returnToPreviousScene():
	var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/battle_scene_baby")

	TheRoot.remove_child(ThisScene)
	ThisScene.call_deferred("free")
	
	var NextScene = Global.PreviousScreen
	TheRoot.add_child(NextScene)
	AudioStreamPlayerGlobal.stream_paused = false
	

func _on_bullet_spawn_timer_timeout() -> void:
	if bulletsSpawned < 4:
		var new_bullet = obj_bullet.instantiate()
		add_child(new_bullet)
		bulletsSpawned += 1
	
func _process(_delta: float) -> void:
	$TimeDisplay.text = "Tiempo restante: " + str(floori($BattleTimer.time_left))
	$LivesDisplay.text = "Vidas restantes: " + str(Global.lives)
	if Global.lives <= 0:
		Global.BattleFailed = true
		Global.BattleFinished = false
		returnToPreviousScene()

func _on_battle_timer_timeout() -> void:
	Global.BattleFinished = true
	returnToPreviousScene()
