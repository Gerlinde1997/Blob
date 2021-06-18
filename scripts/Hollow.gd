extends Area2D

onready var player = $"../../Player"
onready var player_raycast = $"../../Player/RayCast2D"

var dirt = preload("res://Sprites/hollow_64x64.png")
var mark = preload("res://Sprites/exclamation_mark32x32.png")
var shovel = preload("res://Sprites/mark_shovel.png")

func _ready():
	if GlobalVariables.picked_hidden_coin != null:
		$Sprite.texture = dirt

func show_mark():
	$Sprite.texture = mark

	if GlobalVariables.picked_shovel != null:
		$Sprite.texture = shovel

func hide_mark():
	if $Sprite.texture == dirt:
		$Sprite.texture = dirt
	else:
		$Sprite.texture = null

func digging():
	if GlobalVariables.picked_shovel != null:
		GlobalVariables.picked_hidden_coin = self.get_path()
		GlobalVariables.coins += 1
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite.texture = dirt
