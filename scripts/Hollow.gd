extends Area2D

onready var player = $"../../Player"
onready var player_raycast = $"../../Player/RayCast2D"

func _ready():
	if GlobalVariables.picked_hidden_coin != null:
		$CollisionShape2D.set_deferred("disabled", true)
		$Dirt.visible = true

func show_dollar():
	$Dollar.visible = true

func hide_dollar():
	if not player_raycast.get_collider() == self:
		$Dollar.visible = false

func digging():
	if GlobalVariables.picked_shovel != null:
		GlobalVariables.picked_hidden_coin = self.get_path()
		GlobalVariables.coins += 1
		$CollisionShape2D.set_deferred("disabled", true)
		$Dirt.visible = true

# func _on_Hollow_body_entered(body):
# 	if body == player and GlobalVariables.picked_shovel != null:
# 		GlobalVariables.picked_hidden_coin = self.get_path()
# 		GlobalVariables.coins += 1
# 		$CollisionShape2D.set_deferred("disabled", true)

func _process(delta):
	hide_dollar()