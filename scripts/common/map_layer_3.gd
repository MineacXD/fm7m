extends TileMapLayer


func _process(delta: float) -> void:
	if Global.z_index_player > 0:
		visible = false
	else: 
		visible = true
