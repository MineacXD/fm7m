extends Node2D
var bgmLost = preload("res://sounds/bgm/ReDistrust.mp3")

var obj_bullet1 = preload("res://scenes/bullets/bullet_nagito_1.tscn")
var obj_bullet2 = preload("res://scenes/bullets/bullet_nagito_2.tscn")
var obj_bullet3 = preload("res://scenes/bullets/bullet_nagito_3.tscn")

#bullet 1 aka pig
var trackGenerator = RandomNumberGenerator.new()

#bullet 2 aka usp
var positionGenerator = RandomNumberGenerator.new()
var angleBullet = 0
var angleGenerator = RandomNumberGenerator.new()

#bullet 3 aka baby
var bulletsSpawned = 0

func _ready() -> void:
	Global.lives = 5
	var new_bullet = obj_bullet3.instantiate()
	add_child(new_bullet)
	bulletsSpawned += 1

func returnToPreviousScene():
	var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/battle_scene_nagito")

	TheRoot.remove_child(ThisScene)
	ThisScene.call_deferred("free")
	if Global.BattleFailed == true:
		AudioStreamPlayerGlobal.stream = bgmLost
		AudioStreamPlayerGlobal.play()
	var NextScene = Global.PreviousScreen
	TheRoot.add_child(NextScene)
	
#bullet 1
func _on_bullet_spawn_timer_timeout1() -> void:
	var new_bullet = obj_bullet1.instantiate()
	var track = trackGenerator.randf_range(0, 604)
	new_bullet.position = Vector2(track, 0)
	add_child(new_bullet)
	
	
#bullet 2
func _on_bullet_spawn_timer_timeout2() -> void:
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
	var new_bullet = obj_bullet2.instantiate()
	
	add_child(new_bullet)
	$USPfired.play()
	new_bullet.angleBullet = angleBullet
	new_bullet.position = $Path2D/PathFollow2D/Marker2D.global_position
	
#bullet 3
func _on_bullet_spawn_timer_timeout3() -> void:
	if bulletsSpawned < 2:
		var new_bullet = obj_bullet3.instantiate()
		add_child(new_bullet)
		bulletsSpawned += 1
	
	
func _process(delta: float) -> void:
	$TimeDisplay.text = "Tiempo restante: " + str(floori($BattleTimer.time_left))
	$LivesDisplay.text = "Vidas restantes: " + str(Global.lives)
	if Global.lives <= 0:
		Global.BattleFailed = true
		Global.BattleFinished = false
		returnToPreviousScene()

func _on_battle_timer_timeout() -> void:
	Global.BattleFinished = true
	returnToPreviousScene()
