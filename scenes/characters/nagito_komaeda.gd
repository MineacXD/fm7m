extends StaticBody2D
const dialogue_list = ["nagito?", "cheo...", "tu estabas detrás de todo esto...?", "...", "para que exista\nuna verdadera esperanza", "primero debe existir\nuna verdadera desesperación"]
const dialogue_character_list = ["Cheo", "Nagito", "Cheo", "Nagito", "Nagito", "Nagito"]

const failed_dialogue_list = ["que decepcionante...", "la esperanza no venció\na la desesperación", "ya casi llego May", "aguanta...", ""] 
const failed_dialogue_character_list = ["Nagito", "Nagito", "Cheo", "Cheo", "Cheo"]

const post_dialogue_list = ["...gracias", "MUCHAS GRACIAS CHEO!!!", "ESTA ES LA ESPERANZA QUE BUSCABA!!!", "...", "abreme la puerta niño", "..."] 
const post_dialogue_character_list = ["Nagito", "Nagito", "Nagito", "Cheo", "Cheo", "Nagito"]

var displaying_dialogue = false
var player_near = false
#dialogue index number
var number = 0
var localSkin

var started = false

func loadBattle():
	var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/map04")
	Global.PreviousScreen = ThisScene  #variable in Autoload script
	AudioStreamPlayerGlobal.stop()
	print(TheRoot)
	TheRoot.remove_child(ThisScene)
	var NextScene = load("res://scenes/battles/battle_scene_nagito.tscn") 
	NextScene = NextScene.instantiate()
	TheRoot.add_child(NextScene)

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
	
func show_failed_dialogue():
	$Dialogue/Dialogue_body.text = failed_dialogue_list[number]
	$Dialogue/Character.text = failed_dialogue_character_list[number]
	if failed_dialogue_character_list[number] == "Nagito":
		$Dialogue/NagitoDialog.visible = true
		localSkin.visible = false
	elif failed_dialogue_character_list[number] == "Cheo":
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
	if Global.BattleFailed:
		if player_near:
			if !$Dialogue.visible:
				number = 0
				$Dialogue.visible = true
				Global.PlayerBusy = true
				show_failed_dialogue()
			elif number >= failed_dialogue_list.size():
				$Dialogue.visible = false
				Global.PlayerBusy = false
				number = 0
				Global.BattleFailed = false
				started = false
				loadBattle()
			else:
				if Input.is_action_just_pressed("interact_enviroment"):
					show_failed_dialogue()

				
	elif Global.BattleFinished:
		if player_near:
			if !$Dialogue.visible:
				number = 0
				$Dialogue.visible = true
				Global.PlayerBusy = true
				show_post_dialogue()
			elif number >= post_dialogue_list.size():
				$Dialogue.visible = false
				Global.PlayerBusy = false
				number = 0
				Global.BattleFinished = false
				QuestTracker.FinalBattleDone = true
			else:
				if Input.is_action_just_pressed("interact_enviroment"):
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
					number = 0
					loadBattle()
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
