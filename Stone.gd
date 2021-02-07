extends Node2D

onready var coins = get_tree().get_nodes_in_group("coins")

func _ready():
	
	if PlayerGlobalVariables.animation:
		$Player/AnimatedSprite.animation = PlayerGlobalVariables.animation

	if PlayerGlobalVariables.pos:
		$Player.position = PlayerGlobalVariables.pos

	for coin in coins:
		if coin.name in PickablesGlobal.picked_coins:
			coin.queue_free()
