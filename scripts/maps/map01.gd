extends Node2D
const dialogue_list = ["que sueño...", "voy a dormir mientras ella cocina"]
const dialogue_character_list = ["Cheo", "Cheo"]

const post_dialogue_list = ["...?", "ah, es verdad, May deberia haber terminado el almuerzo ya"] 
const post_dialogue_character_list = ["Cheo", "Cheo"]

var displaying_dialogue = false
#dialogue index number
var number = 0

var player_near = false
var localSkin
var bgm = preload("res://sounds/bgm/LoveIsSurvival.mp3")
var trans = 0

func show_next_dialogue():
	$ChairArea/Dialogue/Dialogue_body.text = dialogue_list[number]
	$ChairArea/Dialogue/Character.text = dialogue_character_list[number]
	if dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
	number = number + 1
	
func show_post_dialogue():
	$ChairArea/Dialogue/Dialogue_body.text = post_dialogue_list[number]
	$ChairArea/Dialogue/Character.text = post_dialogue_character_list[number]
	if dialogue_character_list[number] == "Cheo":
		localSkin.visible = true
	number = number + 1

func _ready() -> void:
	# was supposed to be a skin render func
	if Global.skinChange:
		localSkin = $ChairArea/Dialogue/MafuyuSchoolUniformChibi
		$ChairArea/Dialogue/EnaSchoolUniformChibi.visible = false
	else:
		localSkin = $ChairArea/Dialogue/EnaSchoolUniformChibi
		$ChairArea/Dialogue/MafuyuSchoolUniformChibi.visible = false
	AudioStreamPlayerGlobal.stream = bgm
	AudioStreamPlayerGlobal.play()

func _process(_delta: float) -> void:
	if ($ChairArea/Dialogue/FadeOut.visible == true) and !($ChairArea/Dialogue/FadeOut.modulate == Color(1.0, 1.0, 1.0, 1.0)):
		trans += 0.01
		print(trans)
		$ChairArea/Dialogue/FadeOut.modulate = Color(1.0, 1.0, 1.0, trans)
	elif $ChairArea/Dialogue/FadeOut.modulate == Color(1.0, 1.0, 1.0, 1.0):
		get_tree().change_scene_to_file("res://scenes/maps/map02.tscn")
	if QuestTracker.QuestPorkFinished:
		if player_near:
			if Input.is_action_just_pressed("interact_enviroment"):
				if !$ChairArea/Dialogue.visible:
					$ChairArea/Dialogue.visible = true
					Global.PlayerBusy = true
					show_next_dialogue()
				elif number >= dialogue_list.size():
					$ChairArea/Dialogue/FadeOut.visible = true
					Global.PlayerBusy = false
					number = 0
				else:
					show_next_dialogue()
					
	else:
		if player_near:
			if Input.is_action_just_pressed("interact_enviroment"):
				if !$ChairArea/Dialogue.visible:
					$Dialogue.visible = true
					Global.PlayerBusy = true
					show_post_dialogue()
				elif number >= dialogue_list.size():
					$ChairArea/Dialogue.visible = false
					QuestTracker.QuestPorkStarted = true
					Global.PlayerBusy = false
					number = 0
				else:
					show_post_dialogue()
			
func _on_area_entered(area: Area2D) -> void:
	player_near = true
	if QuestTracker.QuestPorkFinished:
		$ChairArea/InteractAvailable.visible = true


func _on_area_exited(area: Area2D) -> void:
	player_near = false
	$ChairArea/InteractAvailable.visible = false
