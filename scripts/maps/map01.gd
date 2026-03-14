extends Node2D
const dialogue_list = ["hola cheoo, quetal todo", "mal oye", "de verdad?", "no", "...", "...", "OYE", "Me podrias traer unas 3 chuletitas?", "No queda comida y eso,,,", "Y pq no vas tu niña", "APURATEE"]
const dialogue_character_list = ["May", "Cheo", "May", "Cheo", "May", "Cheo", "May", "May", "May", "Cheo", "May"]

var displaying_dialogue = false
#dialogue index number
var number = 0
var player_near = false
var localSkin
var bgm = preload("res://sounds/bgm/LoveIsSurvival.mp3")

func _ready() -> void:
	# was supposed to be a skin render func
	if Global.skinChange:
		localSkin = $Dialogue/MafuyuSchoolUniformChibi
		$ChairArea/Dialogue/EnaSchoolUniformChibi.visible = false
	else:
		localSkin = $Dialogue/EnaSchoolUniformChibi
		$ChairArea/Dialogue/MafuyuSchoolUniformChibi.visible = false
	AudioStreamPlayerGlobal.stream = bgm
	AudioStreamPlayerGlobal.play()

func _process(_delta: float) -> void:
	if QuestTracker.QuestPorkFinished:
		if player_near:
			#Hi may!! You went to play soo im leaving this here
			#After this youre supposed to show a Cheo dialogue and then the screen fades to black
			#Then make yourself dissapear.
			pass	
			
func _on_area_entered(area: Area2D) -> void:
	player_near = true
	$ChairArea/InteractAvailable.visible = true


func _on_area_exited(area: Area2D) -> void:
	player_near = false
	$ChairArea/InteractAvailable.visible = false
