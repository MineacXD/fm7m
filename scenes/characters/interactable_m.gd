extends StaticBody2D
const dialogue_list = ["hola cheoo, quetal todo", "mal oye", "de verdad?", "no", "...", "...", "OYE", "Me podrias traer unas 3 chuletitas?", "No queda comida y eso,,,", "Y pq no vas tu niña", "APURATEE"]
const dialogue_character_list = ["May", "Cheo", "May", "Cheo", "May", "Cheo", "May", "May", "May", "Cheo", "May"]

const post_dialogue_list = ["HOLII", "aqui tienes", "YAYY MUCHAS GRACIAS", "jeje", "Prepararé algo,,, mientras ve a\nhacer algo mas", "estaré cerca del lago mientras"] 
const post_dialogue_character_list = ["May", "Cheo", "May", "Cheo", "May", "Cheo"]

const failed_dialogue_list = ["HOLII", "aqui tienes", "Pero no tienes las 3\nchuletas que te pedi..", "Recuerda que te pedi 3"]
const failed_dialogue_character_list = ["May", "Cheo", "May", "May"]

const final_dialogue_list = ["May??", "photo", "...", "debo encontrarla"]
const final_dialogue_character_list = ["Cheo", "photo", "Cheo", "Cheo"]

var displaying_dialogue = false
#dialogue index number
var number = 0
var player_near = false
var localSkin
var bgmDespair = preload("res://sounds/bgm/LifeOfDespair.mp3")
var guiBusy = false

func _ready() -> void:
	# was supposed to be a skin render func
	if Global.skinChange:
		localSkin = $Dialogue/MafuyuSchoolUniformChibi
		$Dialogue/EnaSchoolUniformChibi.visible = false
	else:
		localSkin = $Dialogue/EnaSchoolUniformChibi
		$Dialogue/MafuyuSchoolUniformChibi.visible = false
		
func show_next_dialogue():
	$Dialogue/Dialogue_body.text = dialogue_list[number]
	$Dialogue/Character.text = dialogue_character_list[number]
	if dialogue_character_list[number] == "May":
		$Dialogue/MizukiSchoolUniformChibi.visible = true
		localSkin.visible = false
	elif dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/MizukiSchoolUniformChibi.visible = false
	number = number + 1

func show_post_dialogue():
	$Dialogue/Dialogue_body.text = post_dialogue_list[number]
	$Dialogue/Character.text = post_dialogue_character_list[number]
	if post_dialogue_character_list[number] == "May":
		$Dialogue/MizukiSchoolUniformChibi.visible = true
		localSkin.visible = false
	elif post_dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/MizukiSchoolUniformChibi.visible = false
	number = number + 1

func show_failed_dialogue():
	$Dialogue/Dialogue_body.text = failed_dialogue_list[number]
	$Dialogue/Character.text = failed_dialogue_character_list[number]
	if failed_dialogue_character_list[number] == "May":
		$Dialogue/MizukiSchoolUniformChibi.visible = true
		localSkin.visible = false
	elif failed_dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/MizukiSchoolUniformChibi.visible = false
	number = number + 1
	
func show_final_dialogue():
	$Dialogue/Dialogue_body.text = final_dialogue_list[number]
	$Dialogue/Character.text = final_dialogue_character_list[number]
	if final_dialogue_character_list[number] == "photo":
		$Dialogue/Note/TurnPage.play()
		$Dialogue/Note/Timer.start()
		localSkin.visible = false
		$Dialogue/Character.visible = false
		$Dialogue/Dialogue_body.visible = false
		$Dialogue/DialogueNext.visible = false
		$Dialogue/DialogueBoxName.visible = false
		$Dialogue/DialogueBoxText.visible = false
		guiBusy = true
	elif final_dialogue_character_list[number] == "Cheo":
		$Dialogue/MizukiSchoolUniformChibi.visible = false
		localSkin.visible = true
		$Dialogue/Note.visible = false
		$Dialogue/Character.visible = true
		$Dialogue/Dialogue_body.visible = true
		$Dialogue/DialogueNext.visible = true
		$Dialogue/DialogueBoxName.visible = true
		$Dialogue/DialogueBoxText.visible = true
	number = number + 1
	

func _process(delta: float) -> void:
	if Global.z_index_player == z_index:
		set_modulate(Color(1.0, 1.0, 1.0, 1.0))
		visible = true
	else: 
		if z_index == 0:
			set_modulate(Color(0.355, 0.355, 0.355, 1.0))
		else:
			visible = false
	
	#checks if dialogue is available
	if QuestTracker.porkchops == 3 and !QuestTracker.DreamComplete:
		if player_near:
			if Input.is_action_just_pressed("interact_enviroment"):
				if !$Dialogue.visible:
					$Dialogue.visible = true
					Global.PlayerBusy = true
					show_post_dialogue()
				elif number >= post_dialogue_list.size():
					$Dialogue.visible = false
					QuestTracker.QuestPorkFinished = true
					Global.PlayerBusy = false
					number = 0
				else:
					show_post_dialogue()
	elif QuestTracker.QuestPorkStarted and QuestTracker.porkchops < 3 and !QuestTracker.DreamComplete:
		if player_near:
			if Input.is_action_just_pressed("interact_enviroment"):
				if !$Dialogue.visible:
					$Dialogue.visible = true
					Global.PlayerBusy = true
					show_failed_dialogue()
				elif number >= failed_dialogue_list.size():
					$Dialogue.visible = false
					Global.PlayerBusy = false
					number = 0
				else:
					show_failed_dialogue()
	elif QuestTracker.DreamComplete:
		if player_near:
			if Input.is_action_just_pressed("interact_enviroment") and !guiBusy:
				if !$Dialogue.visible:
					AudioStreamPlayerGlobal.stop()
					$Dialogue.visible = true
					Global.PlayerBusy = true
					show_final_dialogue()
				elif number >= final_dialogue_list.size():
					$Dialogue.visible = false
					Global.PlayerBusy = false
					number = 0
					QuestTracker.PrologueComplete = true
				else:
					show_final_dialogue()
	else:
		if player_near:
			if Input.is_action_just_pressed("interact_enviroment"):
				if !$Dialogue.visible:
					$Dialogue.visible = true
					Global.PlayerBusy = true
					show_next_dialogue()
				elif number >= dialogue_list.size():
					$Dialogue.visible = false
					QuestTracker.QuestPorkStarted = true
					Global.PlayerBusy = false
					number = 0
				else:
					show_next_dialogue()
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$InteractAvailable.visible = true
		player_near = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		$InteractAvailable.visible = false
		player_near = false


func _on_timer_timeout() -> void:
	$Dialogue/Note/Timer.stop()
	AudioStreamPlayerGlobal.stream = bgmDespair
	AudioStreamPlayerGlobal.play()
	$Dialogue/Note.visible = true
	guiBusy = false
