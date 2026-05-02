extends CharacterBody2D
var speed = 400

func _ready() -> void:
	# was supposed to be a skin render func
	if Global.skinChange:
		$EnaSchoolUniformChibi.visible = false
	else:
		$MafuyuSchoolUniformChibi.visible = false

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	Global.playerX = position.x
	Global.playerY = position.y

	move_and_slide()
