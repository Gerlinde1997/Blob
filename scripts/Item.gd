extends Area2D

var item_name
var item_quantity

func _ready():
	var rand_val = randi() % 2
	if rand_val == 0:
		item_name = "Coin"
		$ColorRect.color = Color(0.99, 0.80, 0.01, 1)
	else:
		item_name = "BlueColor"
		$ColorRect.color = Color(0.01, 0.67, 0.99, 1)

	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	item_quantity = randi() % stack_size + 1

	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = String(item_quantity)

func set_item(nm, qt):
	item_name = nm
	item_quantity = qt
	# "normally" set the right texture
	if item_name == "Coin":
		$ColorRect.color = Color(0.99, 0.80, 0.01, 1)
	elif item_name == "BlueColor":
		$ColorRect.color = Color(0.01, 0.67, 0.99, 1)
	
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(item_quantity)


func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)