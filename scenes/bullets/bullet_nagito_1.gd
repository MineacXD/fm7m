extends CharacterBody2D
var speed = 650	
	
func _physics_process(_delta: float) -> void:
	velocity.y = speed
	if position.y > 684:
		queue_free()
		
	move_and_slide()
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.lives -= 1
