extends StaticBody2D
const dialogue_list = ["hola soy goty", "eres el de roblox?", "soy goty", "???"]
const dialogue_character_list = ["Piggy", "Cheo", "Piggy", "Cheo"]

const post_dialogue_list = ["parese que hay un nuevo goty\nen la ciudad...", "dios sos tontisimo"] 
const post_dialogue_character_list = ["Piggy", "Cheo"]

const failed_dialogue_list = ["hola soy goty no me vas a ganar", "callate un rato porfavor"]
const failed_dialogue_character_list = ["Piggy", "Cheo"]

var displaying_dialogue = false
var player_near = false
#dialogue index number
var number = 0
var localSkin

func _ready() -> void:
	# was supposed to be a skin render func
	if Global.skinChange:
		localSkin = $Dialogue/MafuyuSchoolUniformChibi
		$Dialogue/EnaSchoolUniformChibi.visible = false
	else:
		localSkin = $Dialogue/EnaSchoolUniformChibi
		$Dialogue/MafuyuSchoolUniformChibi.visible = false

func loadBattle():
	var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/start")
	Global.PreviousScreen = ThisScene  #variable in Autoload script
	#print(ThisScene)
	#ThisScene.print_tree()
	TheRoot.remove_child(ThisScene)
	var NextScene = load("res://scenes/battles/battle_scene_piggy.tscn")
	NextScene = NextScene.instantiate()
	TheRoot.add_child(NextScene)

func show_next_dialogue():
	$Dialogue/Dialogue_body.text = dialogue_list[number]
	$Dialogue/Character.text = dialogue_character_list[number]
	if dialogue_character_list[number] == "Piggy":
		$Dialogue/PiggyRoblox.visible = true
		localSkin.visible = false
	elif dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/PiggyRoblox.visible = false
	number = number + 1

func show_post_dialogue():
	$Dialogue/Dialogue_body.text = post_dialogue_list[number]
	$Dialogue/Character.text = post_dialogue_character_list[number]
	if post_dialogue_character_list[number] == "Piggy":
		$Dialogue/PiggyRoblox.visible = true
		localSkin.visible = false
	elif post_dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/PiggyRoblox.visible = false
	number = number + 1
			
func show_failed_dialogue():
	$Dialogue/Dialogue_body.text = failed_dialogue_list[number]
	$Dialogue/Character.text = failed_dialogue_character_list[number]
	if failed_dialogue_character_list[number] == "Piggy":
		$Dialogue/PiggyRoblox.visible = true
		localSkin.visible = false
	elif failed_dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/PiggyRoblox.visible = false
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
	if Global.BattleFinished == true:
		if player_near:
			if !$Dialogue.visible:
					$Dialogue.visible = true
					show_post_dialogue()
			if Input.is_action_just_pressed("interact_enviroment"):
				if number >= post_dialogue_list.size():
					$Dialogue.visible = false
					Global.BattleFinished = false
					number = 0
					queue_free()
				else:
					show_post_dialogue()
	elif Global.BattleFailed == true:
		if player_near:
			if !$Dialogue.visible:
				$Dialogue.visible = true
				show_failed_dialogue()
			if Input.is_action_just_pressed("interact_enviroment"):
				if number >= failed_dialogue_list.size():
					$Dialogue.visible = false
					number = 0
					Global.BattleFailed = false
				else:
					show_failed_dialogue()
	else:
		if player_near:
			if Input.is_action_just_pressed("interact_enviroment"):
				if !$Dialogue.visible:
					$Dialogue.visible = true
					show_next_dialogue()
				elif number >= dialogue_list.size():
					$Dialogue.visible = false
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
