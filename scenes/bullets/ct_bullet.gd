extends CharacterBody2D

var speedX = 1000
var speedY = 0
var angleBullet = 0

func returnToPreviousScene():
	var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/battle_scene_ct")

	TheRoot.remove_child(ThisScene)
	ThisScene.call_deferred("free")
	
	var NextScene = Global.PreviousScreen
	AudioStreamPlayerGlobal.stream_paused = false
	TheRoot.add_child(NextScene)
	
	
func _physics_process(_delta: float) -> void:
	velocity = Vector2(speedX, speedY).rotated(deg_to_rad(angleBullet))
	rotation = velocity.angle()
		
	move_and_slide()
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.lives = Global.lives -1
		if Global.lives <= 0:
			Global.BattleFailed = true
			returnToPreviousScene()


func _on_screen_exited() -> void:
	queue_free()
