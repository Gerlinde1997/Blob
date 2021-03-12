extends Panel

# preload texture normally...
var def_color = Color(1, 0, 0, 0.5) 
var empty_color = Color(1, 0.44, 0.44, 1)
var def_style: StyleBoxFlat = null
var empty_style: StyleBoxFlat = null


var Item = preload("res://Item.tscn")
var item = null
var slot_index

func _ready():
	def_style = StyleBoxFlat.new()
	empty_style = StyleBoxFlat.new()
	def_style.bg_color = def_color
	empty_style.bg_color = empty_color
	refresh_style()

func refresh_style():
	if item == null:
		set("custom_styles/panel", empty_style)
	else:
		set("custom_styles/panel", def_style)

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null
	refresh_style()

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)
	refresh_style()

func init_item(item_name, item_quantity):
	if item == null:
		item = Item.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
	refresh_style()