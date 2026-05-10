extends CharacterBody2D
var staticPlayerX
var staticPlayerY
var target
var lockedIn = false
var permaTime = 0
var nearPlayer = false
var invincible = false
var speed = 250

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	permaTime = 1 + Global.babyOffset
	Global.babyOffset = Global.babyOffset + 0.15 
	$Cooldown.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lockedIn and floor((target - position).length()) > 10:
		speed = 500 * delta * (target - position).length()
		position = position.move_toward(target, speed * delta)
	elif lockedIn and floor((target - position).length()) <= 10:
		$Cooldown.start()
		lockedIn = false
		
	if nearPlayer and !invincible :
		Global.lives -= 1
		$iFrames.start()
		invincible = true
		


func _on_lock_in_timeout() -> void:
	speed = 500
	staticPlayerX = Global.playerX
	staticPlayerY = Global.playerY
	target = Vector2(Global.playerX, Global.playerY)
	$BabyScream.play()
	lockedIn = true


func _on_cooldown_timeout() -> void:
	$BabyAlarm.play()
	$LockIn.start(permaTime)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		nearPlayer = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		nearPlayer = false


func _on_i_frames_timeout() -> void:
	invincible = false
