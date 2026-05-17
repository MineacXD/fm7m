extends Control
var TimerDone = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GuiEffects.startFadeIn(0.005, 1.0)
	if Global.skinChange:
		$Scroll/Mafu.visible = true
	else:
		$Scroll/Ena.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if TimerDone:
		$Scroll.position.y -= 0.3


func _on_timer_timeout() -> void:
	TimerDone = true
