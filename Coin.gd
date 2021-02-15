extends Area2D

onready var player = $"../../Player"
#onready var inventory = $"../../CanvasLayer/Inventory"

func _on_Coin_body_entered(body):
	if body == player:
		PlayerGlobalVariables.coins += 1
		PickablesGlobal.picked_coins.append(self.get_path())
		#inventory.add_item()
		self.queue_free()
