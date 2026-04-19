extends TileMapLayer
var modulateColor = 0

func _process(_delta: float) -> void:
	modulateColor = 0.355 - (Global.z_index_player * 0.15)
	print(modulateColor)
	print(Global.z_index_player)
	set_modulate(Color(modulateColor, modulateColor, modulateColor, 1.0))
