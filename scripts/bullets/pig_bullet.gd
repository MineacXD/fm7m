extends CharacterBody2D
var speed = 650

func returnToPreviousScene():
	var TheRoot = get_node("/root")  #need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/BattleScene_test")

	TheRoot.remove_child(ThisScene)
	ThisScene.call_deferred("free")
	
	var NextScene = Global.PreviousScreen
	AudioStreamPlayerGlobal.stream_paused = false
	TheRoot.add_child(NextScene)
	
	
func _physics_process(_delta: float) -> void:
	velocity.x = -speed
	if position.x < -785:
		queue_free()
		
	move_and_slide()
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.BattleFailed = true
		returnToPreviousScene()
		
