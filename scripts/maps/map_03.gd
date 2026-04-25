extends Node2D
var bgm = preload("res://sounds/bgm/KillNow.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioStreamPlayerGlobal.stream = bgm
	GuiEffects.startFadeIn(0.005, 1.0)
	AudioStreamPlayerGlobal.startFadeIn(0.005, 0.5)


func _on_death_area_area_entered(area: Area2D) -> void:
	GuiEffects.fadeOut(0.1)
	$"map layer 0/deathArea/Death".play()
	$"map layer 0/deathArea/Timer".start()


func _on_death_timer_timeout() -> void:
	$Player.position.x = 195.0
	$Player.position.y = 275.0
	GuiEffects.fadeIn(0.1)
	
