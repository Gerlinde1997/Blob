extends CanvasLayer

onready var inventory = $Inventory

func _ready():
	inventory.visible = false

func _input(event):
	if event.is_action_pressed("inventory"):
		inventory.visible = !inventory.visible
		inventory.init_inventory()