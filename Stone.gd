extends Node2D

func _ready():
	if PlayerGlobalVariables.player_pos:
		$Player.position = PlayerGlobalVariables.player_pos
