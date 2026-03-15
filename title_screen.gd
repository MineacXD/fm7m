extends Control
var bgm = preload("res://sounds/bgm/TitleScreenBgm.mp3")
var trans = 0
var timerDone = false

func _ready() -> void:
	AudioStreamPlayerGlobal.stream = bgm
	AudioStreamPlayerGlobal.play()
	$BoxContainer.modulate = Color(1.0, 1.0, 1.0, 0.0)
	$Timer.start()
	
func _process(_delta: float) -> void:
	if timerDone:
		trans += 0.005 
		$BoxContainer.modulate = Color(1.0, 1.0, 1.0, trans)

func _on_change_skin_pressed() -> void:
	$BoxContainer/OptionSelected.play()
	if Global.skinChange == false:
		$BoxContainer/ChangeSkin.text = "Current skin: fuyu"
		Global.skinChange = true
	else:
		$BoxContainer/ChangeSkin.text = "Current skin: enanan"
		Global.skinChange = false


func _on_play_pressed() -> void:
	$BoxContainer/OptionSelected.play()
	$StartTimer.start()


func _on_timer_timeout() -> void:
	timerDone = true
	$BoxContainer.visible = true


func _on_mouse_entered() -> void:
	if $BoxContainer.visible:
		$BoxContainer/Scrolling.play()


func _on_start_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/maps/map01.tscn")
