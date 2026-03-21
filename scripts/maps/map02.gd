extends Node2D
const dialogue_list = ["...", "donde mierda estoy"]
const dialogue_character_list = ["Cheo", "Cheo"]

var number = 0
var localSkin
var trans = 1
var timerDone = false
var done = false

func show_next_dialogue():
	$Dialogue/Dialogue_body.text = dialogue_list[number]
	$Dialogue/Character.text = dialogue_character_list[number]
	if dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
	number = number + 1

func _ready() -> void:
	# was supposed to be a skin render func
	if Global.skinChange:
		localSkin = $Dialogue/MafuyuSchoolUniformChibi
		$Dialogue/EnaSchoolUniformChibi.visible = false
	else:
		localSkin = $Dialogue/EnaSchoolUniformChibi
		$Dialogue/MafuyuSchoolUniformChibi.visible = false
	AudioStreamPlayerGlobal.stop()
	Global.PlayerBusy = true
	show_next_dialogue()
	$Dialogue/FadeOut/Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if trans > 0.6 and timerDone:
		trans -= 0.01
		print(trans)
		$Dialogue/FadeOut.modulate = Color(1.0, 1.0, 1.0, trans)
		
	if done == false:
		if Input.is_action_just_pressed("interact_enviroment"):
			if !$Dialogue.visible:
				$Dialogue.visible = true
				Global.PlayerBusy = true
				show_next_dialogue()
			elif number >= dialogue_list.size():
				$Dialogue/FadeOut.visible = true
				Global.PlayerBusy = false
				number = 0
				$Dialogue/EnaSchoolUniformChibi.visible = false
				$Dialogue/MafuyuSchoolUniformChibi.visible = false
				$Dialogue/DialogueBoxName.visible = false
				$Dialogue/DialogueBoxText.visible = false
				$Dialogue/DialogueNext.visible = false
				$Dialogue/Character.visible = false
				$Dialogue/Dialogue_body.visible = false
				done = true
			else:
				show_next_dialogue()
		
		
func _on_timer_timeout() -> void:
	timerDone = true
