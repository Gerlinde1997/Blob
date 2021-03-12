extends Area2D

onready var player = $"../../Player"
var item_name

func _ready():
	item_name = "Coin"

func _on_Coin_body_entered(body):
	if body == player:
		GlobalVariables.coins += 1
		GlobalVariables.picked_coins.append(self.get_path())
		PlayerInventory.add_item(item_name, 1)
		self.queue_free()
