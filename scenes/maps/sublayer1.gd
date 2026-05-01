extends TileMapLayer

func _process(delta: float) -> void:
	if Global.StartCastleButtonPressed:
			visible = true
			
	if Global.z_index_player == z_index:
		set_modulate(Color(1.0, 1.0, 1.0, 1.0))
		if Global.StartCastleButtonPressed:
			visible = true
	else: 
		if z_index == 0:
			set_modulate(Color(0.355, 0.355, 0.355, 1.0))
		else:
			visible = false
