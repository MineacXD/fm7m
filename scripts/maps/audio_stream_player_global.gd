extends AudioStreamPlayer
#var volumeLocal = 0.05
#var volumeNormal = volume_db
#
#func fadeOut():
	#while volume_db > -80:
		#volume_db -= volumeLocal
