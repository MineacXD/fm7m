extends Node2D
const dialogue_list = ["hola cheoo, quetal todo", "mal oye", "de verdad?", "no", "...", "...", "OYE", "Me podrias traer unas 3 chuletitas?", "No queda comida y eso,,,", "Y pq no vas tu niña", "APURATEE"]
const dialogue_character_list = ["May", "Cheo", "May", "Cheo", "May", "Cheo", "May", "May", "May", "Cheo", "May"]

var displaying_dialogue = false
#dialogue index number
var number = 0
var player_near = false

func _process(_delta: float) -> void:
	if QuestTracker.QuestPorkFinished:
		if player_near:
			#Hi may!! You went to play soo im leaving this here
			#After this youre supposed to show a Cheo dialogue and then the screen fades to black
			#Then make yourself dissapear.
			pass	
			
func _on_area_entered(area: Area2D) -> void:
	player_near = true
	$ChairArea/InteractIcon.visible = true


func _on_area_exited(area: Area2D) -> void:
	player_near = false
	$ChairArea/InteractIcon.visible = false
