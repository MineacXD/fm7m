extends StaticBody2D
const dialogue_list = ["nagito?", "cheo...", "tu estabas detrás de todo esto...?", "...", "para que exista una verdadera esperanza", "primero debe existir\nuna verdadera desesperación"]
const dialogue_character_list = ["Cheo", "Nagito", "Cheo", "Nagito", "Nagito", "Nagito"]

const post_dialogue_list = ["así termina todo?", "ya casi llego May", "aguanta..."] 
const post_dialogue_character_list = ["Cheo", "Cheo", "Cheo"]

var displaying_dialogue = false
var player_near = false
#dialogue index number
var number = 0
var localSkin

var indicationsDone = false

# Called when the node enters the scene tree for the first time.
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
	if dialogue_character_list[number] == "Nagito":
		$Dialogue/NagitoDialog.visible = true
		localSkin.visible = false
	elif dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/NagitoDialog.visible = false
	number = number + 1
	
func show_post_dialogue():
	$Dialogue/Dialogue_body.text = post_dialogue_list[number]
	$Dialogue/Character.text = post_dialogue_character_list[number]
	if post_dialogue_character_list[number] == "Nagito":
		$Dialogue/NagitoDialog.visible = true
		localSkin.visible = false
	elif post_dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/NagitoDialog.visible = false
	number = number + 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	if indicationsDone:
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
					indicationsDone = true
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
