extends CharacterBody2D

var speedX = 1000
var speedY = 0
var angleBullet = 0
	
func _physics_process(_delta: float) -> void:
	velocity = Vector2(speedX, speedY).rotated(deg_to_rad(angleBullet))
	rotation = velocity.angle()
		
	move_and_slide()
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.lives -= 1
		#there used to be a returntopreviousscreen call here
		#but you should put it on the main battle scene may

func _on_screen_exited() -> void:
	queue_free()
