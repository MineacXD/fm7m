extends StaticBody2D
const dialogue_list = ["un boton?"]
const dialogue_character_list = ["Cheo"]

var displaying_dialogue = false
var player_near = false
#dialogue index number
var number = 0
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
	localSkin.visible = true
	number = number + 1
	
func _process(_delta: float) -> void:
	if player_near:
		if Input.is_action_just_pressed("interact_enviroment"):
			if !$Dialogue.visible:
				$Dialogue.visible = true
				Global.PlayerBusy = true
				show_next_dialogue()
			elif number >= dialogue_list.size():
				$ButtonPressed.play()
				number = 0
				$Dialogue.visible = false
			else:
				show_next_dialogue()
					
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_near = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_near = false


func _on_button_pressed_finished() -> void:
	Global.PlayerBusy = false
	Global.PreCastleButtonPressed = true
	queue_free()
