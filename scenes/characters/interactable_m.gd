extends StaticBody2D
const dialogue_list = ["hola cheoo, quetal todo", "mal oye", "de verdad?", "no", "...", "...", "OYE", "Me podrias traer unas 3 chuletitas?", "No queda comida y eso,,,", "Y pq no vas tu niña", "APURATEE"]
const dialogue_character_list = ["May", "Cheo", "May", "Cheo", "May", "Cheo", "May", "May", "May", "Cheo", "May"]

const post_dialogue_list = ["HOLII", "aqui tienes", "YAYY MUCHAS GRACIAS", "jeje", "Prepararé algo,,, mientras ve a\nhacer algo mas", "estaré cerca del lago mientras"] 
const post_dialogue_character_list = ["May", "Cheo", "May", "Cheo", "May", "Cheo"]

const failed_dialogue_list = ["HOLII", "aqui tienes", "Pero no tienes las 3\nchuletas que te pedi..", "Recuerda que te pedi 3"]
const failed_dialogue_character_list = ["May", "Cheo", "May", "May"]

var displaying_dialogue = false
#dialogue index number
var number = 0
var player_near = false

func show_next_dialogue():
	$Dialogue/Dialogue_body.text = dialogue_list[number]
	$Dialogue/Character.text = dialogue_character_list[number]
	if dialogue_character_list[number] == "May":
		$Dialogue/MizukiSchoolUniformChibi.visible = true
		$Dialogue/EnaSchoolUniformChibi.visible = false
	elif dialogue_character_list[number] == "Cheo":
		$Dialogue/EnaSchoolUniformChibi.visible = true
		$Dialogue/MizukiSchoolUniformChibi.visible = false
	number = number + 1

func show_post_dialogue():
	$Dialogue/Dialogue_body.text = post_dialogue_list[number]
	$Dialogue/Character.text = post_dialogue_character_list[number]
	if post_dialogue_character_list[number] == "May":
		$Dialogue/MizukiSchoolUniformChibi.visible = true
		$Dialogue/EnaSchoolUniformChibi.visible = false
	elif post_dialogue_character_list[number] == "Cheo":
		$Dialogue/EnaSchoolUniformChibi.visible = true
		$Dialogue/MizukiSchoolUniformChibi.visible = false
	number = number + 1

func show_failed_dialogue():
	$Dialogue/Dialogue_body.text = failed_dialogue_list[number]
	$Dialogue/Character.text = failed_dialogue_character_list[number]
	if failed_dialogue_character_list[number] == "May":
		$Dialogue/MizukiSchoolUniformChibi.visible = true
		$Dialogue/EnaSchoolUniformChibi.visible = false
	elif failed_dialogue_character_list[number] == "Cheo":
		$Dialogue/EnaSchoolUniformChibi.visible = true
		$Dialogue/MizukiSchoolUniformChibi.visible = false
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
	if QuestTracker.porkchops == 3:
		if player_near:
			if Input.is_action_just_pressed("interact_enviroment"):
				if !$Dialogue.visible:
					$Dialogue.visible = true
					show_post_dialogue()
				elif number >= post_dialogue_list.size():
					$Dialogue.visible = false
					QuestTracker.QuestPorkFinished = true
					number = 0
				else:
					show_post_dialogue()
	elif QuestTracker.QuestPorkStarted and QuestTracker.porkchops < 3:
		if player_near:
			if Input.is_action_just_pressed("interact_enviroment"):
				if !$Dialogue.visible:
					$Dialogue.visible = true
					show_failed_dialogue()
				elif number >= failed_dialogue_list.size():
					$Dialogue.visible = false
					number = 0
				else:
					show_failed_dialogue()
	else:
		if Input.is_action_just_pressed("interact_enviroment"):
			if !$Dialogue.visible:
				$Dialogue.visible = true
				show_next_dialogue()
			elif number >= dialogue_list.size():
				$Dialogue.visible = false
				QuestTracker.QuestPorkStarted = true
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
