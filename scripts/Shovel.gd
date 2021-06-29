extends Area2D

onready var player = $"../Player"


func _on_Shovel_body_entered(body):
	if body == player:
		GlobalVariables.picked_shovel = self.get_path()
		self.queue_free()
