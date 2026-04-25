extends StaticBody2D
const dialogue_list = ["RANPOOOOO", "Cheoo tanto tiempo", "Como va todo ranpo", "Bien, tratando de mejorar", ":v", ":v"]
const dialogue_character_list = ["Cheo", "Ranpo", "Cheo", "Ranpo", "Cheo", "Ranpo"]

const post_dialogue_list = ["Ah si, a lo que venia", "Que pasa???", "Logre recolectar informacion sobre May", "Como sabes que la estoy buscando?", "No se", "Lo unico que se es que\nesta atrapada en el castillo del frente", "Gracias Ranpo", "Ya casi May"] 
const post_dialogue_character_list = ["Ranpo", "Cheo", "Ranpo", "Cheo", "Ranpo", "Ranpo", "Cheo", "Cheo"]


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
	if dialogue_character_list[number] == "Ranpo":
		$Dialogue/RanpoDialogue.visible = true
		localSkin.visible = false
	elif dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/RanpoDialogue.visible = false
	number = number + 1

func show_post_dialogue():
	$Dialogue/Dialogue_body.text = post_dialogue_list[number]
	$Dialogue/Character.text = post_dialogue_character_list[number]
	if post_dialogue_character_list[number] == "Ranpo":
		$Dialogue/RanpoDialogue.visible = true
		localSkin.visible = false
	elif post_dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/RanpoDialogue.visible = false
	number = number + 1
	
func _process(_delta: float) -> void:
	if indicationsDone:
		if player_near:
			if Input.is_action_just_pressed("interact_enviroment"):
				if !$Dialogue.visible:
					$Dialogue.visible = true
					Global.PlayerBusy = true
					show_post_dialogue()
				elif number >= post_dialogue_list.size():
					$Dialogue.visible = false
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
			
