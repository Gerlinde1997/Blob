extends Control

var radius = 120
var speed = 0.25

var num
var active = false

func _ready():
	$Buttons.hide()
	num = $Buttons.get_child_count()
	for button in $Buttons.get_children():
		button.rect_position = rect_position

# func _on_MenuButton_pressed():
# 	disabled = true
# 	if active:
# 		hide_menu()
# 	else:
# 		show_menu()

# func _on_Tween_tween_all_completed():
# 	disabled = false
# 	active = not active
# 	if not active:
# 		$Buttons.hide()

func hide_menu():
	for b in $Buttons.get_children():
		$Tween.interpolate_property(b, "rect_position", b.rect_position,
				rect_position, speed, Tween.TRANS_BACK, Tween.EASE_IN)
		$Tween.interpolate_property(b, "rect_scale", null,
				Vector2(0.5, 0.5), speed, Tween.TRANS_LINEAR)
	$Tween.start()

func show_menu():
	var spacing = TAU / num
	for b in $Buttons.get_children():
		var a = spacing * b.get_position_in_parent() - PI / 2
		var dest = b.rect_position + Vector2(radius, 0).rotated(a)
		$Tween.interpolate_property(b, "rect_position",
				b.rect_position, dest, speed,
				Tween.TRANS_BACK, Tween.EASE_OUT)
		$Tween.interpolate_property(b, "rect_scale",
				Vector2(0.5, 0.5), Vector2.ONE, speed,
				Tween.TRANS_LINEAR)
	$Buttons.show()
	$Tween.start()
	
