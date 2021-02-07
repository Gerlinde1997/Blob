extends Area2D

onready var player = $"../../Player"


func _on_Coin_body_entered(body):
	if body == player:
		PlayerGlobalVariables.coins += 1
		PickablesGlobal.picked_coins.append(self.name)
		self.queue_free()
