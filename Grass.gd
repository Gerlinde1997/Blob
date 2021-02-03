extends Node2D

func _ready():
	if PlayerGlobalVariables.animation:
		$Player/AnimatedSprite.animation = PlayerGlobalVariables.animation
	if PlayerGlobalVariables.pos:
		$Player.position = PlayerGlobalVariables.pos
