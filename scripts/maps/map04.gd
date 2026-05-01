extends Node2D
var bgm = preload("res://sounds/bgm/KillNow.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PlayerBusy = false
	AudioStreamPlayerGlobal.stream = bgm
	GuiEffects.startFadeIn(0.005, 1.0)
	AudioStreamPlayerGlobal.startFadeIn(0.005, 0.1)
