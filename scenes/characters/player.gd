extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -230.0
var is_in_water = false
var skin

func _ready() -> void:
	if Global.skinChange:
		$MafuyuSchoolUniformChibi.visible = true
		$EnaSchoolUniformChibi.visible = false
		skin = $MafuyuSchoolUniformChibi
	else:
		$MafuyuSchoolUniformChibi.visible = false
		$EnaSchoolUniformChibi.visible = true
		skin = $EnaSchoolUniformChibi
## updates the z_index global variable so other scripts can fetch it.
func setZindex():
	Global.z_index_player = z_index

func _physics_process(delta: float) -> void:
	if Global.PlayerBusy == false:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or !$CoyoteJump.is_stopped() or is_in_water):
			velocity.y = JUMP_VELOCITY
			if is_in_water:
				$Swim.play()

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		
		if Input.is_action_pressed("ui_right"):
			skin.flip_h = true
		elif Input.is_action_pressed("ui_left"):
			skin.flip_h = false
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		var was_on_floor = is_on_floor()
		move_and_slide()
		var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
		if just_left_ledge:
			$CoyoteJump.start()
		
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_up"):
		#if z_index < 2:
			#z_index = z_index + 1
			#setZindex()
	#if Input.is_action_just_pressed("ui_down"):
		#if z_index > 0:
			#z_index = z_index - 1
			#setZindex()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("interior") or area.is_in_group("index definer"):
		z_index = area.z_index
		setZindex()
	if area.is_in_group("Water"):
		is_in_water = true
		setZindex()
	
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("interior"):
		setZindex()
	elif area.is_in_group("Water"):
		is_in_water = false
		setZindex()
