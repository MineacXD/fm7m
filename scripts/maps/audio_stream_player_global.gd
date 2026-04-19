extends AudioStreamPlayer
var fadingOut = false
var fadingIn = false
var trueRate = 0

func startFadeOut(time, rate):
	trueRate = rate
	volume_db = -13.5
	$FadeOutReady.start(time)
	
func startFadeIn(time, rate):
	play()
	trueRate = rate
	volume_db = -80
	$FadeInReady.start(time)
	
func fadeOut(rate):
	if volume_db > -80:
		volume_db = volume_db - rate
	else:
		fadingOut = false
	
func fadeIn(rate):
	if volume_db < -13.5:
		volume_db = volume_db + rate
	else:
		fadingIn = false
	
func defaultVolume():
	volume_db = -13.255
	
func _process(_delta: float) -> void:
	if fadingOut:
		fadeOut(trueRate)
	elif fadingIn:
		fadeIn(trueRate)

func _on_fade_out_timeout() -> void:
	fadingOut = true

func _on_fade_in_timeout() -> void:
	fadingIn = true
