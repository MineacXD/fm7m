extends Node2D
const dialogue_list = ["otro interruptor?????"]
const dialogue_character_list = ["Cheo"]

const failed_dialogue_list = ["hmmm...", "quizas tenga algo que ver con\nel cuarto de arriba"]
const failed_dialogue_character_list = ["Cheo", "Cheo"]

var displaying_dialogue = false
var player_near = false
#dialogue index number
var number = 0
var localSkin

var passcodeInProgress = false
var passcodeFail = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# was supposed to be a skin render func
	if Global.skinChange:
		localSkin = $Dialogue/DialogueGroup/MafuyuSchoolUniformChibi
		$Dialogue/DialogueGroup/EnaSchoolUniformChibi.visible = false
	else:
		localSkin = $Dialogue/DialogueGroup/EnaSchoolUniformChibi
		$Dialogue/DialogueGroup/MafuyuSchoolUniformChibi.visible = false
	
func show_next_dialogue():
	$Dialogue/DialogueGroup/Dialogue_body.text = dialogue_list[number]
	$Dialogue/DialogueGroup/Character.text = dialogue_character_list[number]
	localSkin.visible = true
	number = number + 1
	
func show_failed_dialogue():
	$Dialogue/DialogueGroup/Dialogue_body.text = failed_dialogue_list[number]
	$Dialogue/DialogueGroup/Character.text = failed_dialogue_character_list[number]
	localSkin.visible = true
	number = number + 1
	
func _process(_delta: float) -> void:
	if player_near and !passcodeInProgress:
		if Input.is_action_just_pressed("interact_enviroment"):
			if !$Dialogue.visible:
				$Dialogue.visible = true
				Global.PlayerBusy = true
				show_next_dialogue()
			elif number >= dialogue_list.size():
				number = 0
				$Dialogue/DialogueGroup.visible = false
				$Dialogue/passCode.visible = true
				passcodeInProgress = true
			else:
				show_next_dialogue()
	elif player_near and passcodeFail:
		if !$Dialogue/DialogueGroup.visible:
			$Dialogue/DialogueGroup.visible = true
			$Dialogue/passCode.visible = false
			show_failed_dialogue()
		if Input.is_action_just_pressed("interact_enviroment"):
			if number >= failed_dialogue_list.size():
				number = 0
				$Dialogue/DialogueGroup.visible = true
				$Dialogue/passCode.visible = false
				$Dialogue.visible = false
				Global.PlayerBusy = false
				passcodeFail = false
				passcodeInProgress = false
			else:
				show_failed_dialogue()
		
					
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_near = true
		$InteractAvailable.visible = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_near = false
		Global.PlayerBusy = false
		$InteractAvailable.visible = false


func _on_listo_pressed() -> void:
	if $Dialogue/passCode/TextEdit.text == "0101":
		$ButtonPressed.play()
		Global.StartCastlePasscodeDone = true
		$Dialogue.visible = false
		Global.PlayerBusy = false
	else:
		passcodeFail = true
