extends Node2D

onready var coins = get_tree().get_nodes_in_group("coins")

func _ready():
	
	if GlobalVariables.animation:
		$Player/AnimatedSprite.animation = GlobalVariables.animation

	if GlobalVariables.pos:
		$Player.position = GlobalVariables.pos

	for coin in coins:
		if coin.get_path() in GlobalVariables.picked_coins:
			coin.queue_free()
