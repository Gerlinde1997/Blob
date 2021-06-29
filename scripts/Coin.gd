extends Area2D

var item_name
onready var player = $"../../Player"


func _ready():
	item_name = "Coin"


func _on_Coin_body_entered(body):
	if body == player:
		GlobalVariables.coins += 1
		GlobalVariables.picked_coins.append(self.get_path())
		self.queue_free()
