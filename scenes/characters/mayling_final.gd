extends StaticBody2D
const dialogue_character_list = ["May", "Cheo", "May", "Cheo", "May", "Cheo", "Cheo", "May"]
const dialogue_list = ["CHEO!!!", "may...", "viniste a rescatarme?", "no may fijate", "ejejej", "vamos de una vez por todas", "sigo esperando a probar\nlas chuletas", "claro que si"]

var displaying_dialogue = false
var player_near = false
#dialogue index number
var number = 0
var finished = false
var localSkin

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
	if dialogue_character_list[number] == "May":
		$Dialogue/MizukiSchoolUniformChibi.visible = true
		localSkin.visible = false
	elif dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
		$Dialogue/MizukiSchoolUniformChibi.visible = false
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
	if player_near and !finished:
		if Input.is_action_just_pressed("interact_enviroment"):
			if !$Dialogue.visible:
				$Dialogue.visible = true
				Global.PlayerBusy = true
				show_next_dialogue()
			elif number >= dialogue_list.size():
				$Dialogue.visible = false
				number = 0
				finished = true
				GuiEffects.startFadeOut(0.005, 1.0)
				$Timer.start()
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
	QuestTracker.FinalMay = true
