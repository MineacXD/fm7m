extends CanvasLayer
var trans = 0
var fadingOut 
var transChanged = false
var fadingFinished = true
var actualRate
var timerStopped = true

func startFadeOut(rate, time):
	Global.PlayerBusy = true
	fadingFinished = false
	timerStopped = false
	actualRate = rate
	$readyToFadeOut.start(time)
	
func startFadeIn(rate, time):
	Global.PlayerBusy = true
	fadingFinished = false
	timerStopped = false
	actualRate = rate
	$readyToFadeIn.start(time)

func fadeOut(rate):
	if !transChanged:
		trans = 0
		actualRate = rate
		visible = true
		transChanged = true
	fadingOut = true
	trans += rate
	$Cover.modulate = Color(1.0, 1.0, 1.0, trans)
	
func fadeIn(rate):
	if !transChanged:
		trans = 1
		actualRate = rate
		visible = true
		transChanged = true
	fadingOut = false
	trans -= rate
	$Cover.modulate = Color(1.0, 1.0, 1.0, trans)
	
func _process(_delta: float) -> void:
	if fadingOut and trans < 1:
		fadeOut(actualRate)
	elif !fadingOut and trans > 0:
		fadeIn(actualRate)
	else: 
		if timerStopped and !fadingFinished:
			transChanged = false
			Global.PlayerBusy = false
			fadingFinished = true

func _on_ready_to_fade_out_timeout() -> void:
	timerStopped = true
	fadeOut(actualRate)


func _on_ready_to_fade_in_timeout() -> void:
	timerStopped = true
	fadeIn(actualRate)
