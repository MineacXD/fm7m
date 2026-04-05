extends Node2D

var obj_bullet = preload("res://scenes/bullets/ct_bullet.tscn")
var positionGenerator = RandomNumberGenerator.new()
var angleBullet = 0
var angleGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	Global.lives = 3

func returnToPreviousScene():
	var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/battle_scene_ct")

	TheRoot.remove_child(ThisScene)
	ThisScene.call_deferred("free")
	
	var NextScene = Global.PreviousScreen
	TheRoot.add_child(NextScene)
	AudioStreamPlayerGlobal.stream_paused = false
	Global.BattleFinished = true
	

func _on_bullet_spawn_timer_timeout() -> void:
	var spawnpoint = positionGenerator.randi_range(1, 4)
	if spawnpoint == 1:
		angleBullet = angleGenerator.randi_range(75, 112)
		$Path2D/PathFollow2D.progress = 385
	elif spawnpoint == 2:
		angleBullet = angleGenerator.randi_range(157, 210)
		$Path2D/PathFollow2D.progress = 1050
	elif spawnpoint == 3:
		angleBullet = angleGenerator.randi_range(-112, -75)
		$Path2D/PathFollow2D.progress = 1775
	else:
		angleBullet = angleGenerator.randi_range(-25, 25)
		$Path2D/PathFollow2D.progress = 2450
	var new_bullet = obj_bullet.instantiate()
	
	add_child(new_bullet)
	$USPfired.play()
	new_bullet.angleBullet = angleBullet
	new_bullet.position = $Path2D/PathFollow2D/Marker2D.global_position
	
func _process(delta: float) -> void:
	$TimeDisplay.text = "Tiempo restante: " + str(floori($BattleTimer.time_left))
	$LivesDisplay.text = "Vidas restantes: " + str(Global.lives)

func _on_battle_timer_timeout() -> void:
	returnToPreviousScene()
