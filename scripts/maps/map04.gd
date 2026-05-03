extends Node2D
var bgm = preload("res://sounds/bgm/KillNow.mp3")
var playerSavedPos = Vector2(896, 83)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PlayerBusy = false
	AudioStreamPlayerGlobal.stream = bgm
	GuiEffects.startFadeIn(0.005, 1.0)
	AudioStreamPlayerGlobal.startFadeIn(0.005, 0.1)
	
func _process(delta: float) -> void:
	pass


func _on_death_area_entered(area: Area2D) -> void:
	GuiEffects.fadeOut(0.05)
	$"map layer 1/deathArea/Death".play()
	$"map layer 1/deathArea/Timer".start()


func _on_death_timer_timeout() -> void:
	$Player.position = playerSavedPos
	GuiEffects.fadeIn(0.1)

		
func _on_save_point_1_area_entered(_area: Area2D) -> void:
	playerSavedPos = $"map layer 1/savePoint1/SavePointCollision".position

func _on_save_point_2_area_entered(_area: Area2D) -> void:
	playerSavedPos = $"map layer 1/savePoint2/SavePointCollision".position
