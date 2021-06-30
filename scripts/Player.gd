extends KinematicBody2D

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

# WSAD
var velocity = Vector2()
var facingDir = Vector2()
var rayCastdir = Vector2()

# Click and move
var moveTarget = null
var npc_target
var dir = Vector2()

const MOVESPEED = 100

var detected_obj

var func_ref
var interact_arg


func _ready():
	set_input_type()


func _process(_delta):
	if GlobalVariables.chosen_input == "wsad":
		manage_animations_wsad()
	if GlobalVariables.chosen_input == "click_move":
		manage_animations_mouse()


func _physics_process(_delta):
	func_ref.call_func()


func _physics_process_wsad():
	velocity = Vector2()
	get_wsad_input()

	if detected_obj and Input.is_action_pressed("interact_wsad"):
		try_interact(detected_obj)

	velocity = move_and_slide(velocity * MOVESPEED)
		
		
func _physics_process_click_move():
	velocity = Vector2()
	if npc_target:
		moveTarget = npc_target.position
	else:	
		get_mouse_input()
	
	if moveTarget:
		dir = position.direction_to(moveTarget)
		if position.distance_to(moveTarget) > 5:
			velocity = dir * MOVESPEED
			velocity = move_and_slide(velocity)
		else:
			moveTarget = null


func set_input_type():
	if GlobalVariables.chosen_input == "wsad":
		func_ref = funcref(self, '_physics_process_wsad')
		interact_arg = "interact_wsad"
	elif GlobalVariables.chosen_input == "click_move":
		func_ref = funcref(self, '_physics_process_click_move')
		interact_arg = "interact_c_m"


func get_mouse_input():
	if Input.is_action_pressed("click"):
		moveTarget = get_global_mouse_position()


func get_wsad_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("move_up"):
		velocity.y += -1
		rayCastdir.y += -1
		facingDir = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		rayCastdir.y += 1
		facingDir = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		velocity.x += -1
		rayCastdir.x += -1
		facingDir = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		rayCastdir.x += 1
		facingDir = Vector2(1, 0)
	
	velocity = velocity.normalized()
	rayCastdir = rayCastdir.normalized()


func try_interact(target):
	if target.has_method("conversation"):
		var actions = InputMap.get_actions()
		for action in actions:
			if Input.is_action_pressed(action):
				Input.action_release(action)
		velocity = Vector2()
		target.conversation()
	
	if target.has_method("digging"):
		target.digging()


func play_animation(anim_name):
	if $AnimatedSprite.animation != anim_name:
		$AnimatedSprite.play(anim_name)


func manage_animations_wsad():
	if velocity.x > 0:
		play_animation("MoveRight")
	elif velocity.x < 0:
		play_animation("MoveLeft")
	elif velocity.y < 0:
		play_animation("MoveUp")
	elif velocity.y > 0:
		play_animation("MoveDown")
	elif facingDir.x == 1:
		play_animation("IdleRight")
	elif facingDir.x == -1:
		play_animation("IdleLeft")
	elif facingDir.y == 1:
		play_animation("IdleDown")
	elif facingDir.y == -1:
		play_animation("IdleUp")


func manage_animations_mouse():
	if moveTarget:
		if dir.x > 0.5:
			play_animation("MoveRight")
		elif dir.x < -0.5:
			play_animation("MoveLeft")
		elif dir.y < 0.5:
			play_animation("MoveUp")
		elif dir.y > -0.5:
			play_animation("MoveDown")
	else:
		if dir.x > 0.5:
			play_animation("IdleRight")
		elif dir.x < -0.5:
			play_animation("IdleLeft")
		elif dir.y > 0.5:
			play_animation("IdleDown")
		elif dir.y < -0.5:
			play_animation("IdleUp")


func _on_Detection_body_entered(body):
	if body.has_method("conversation"):
		body.show_cloud()
		detected_obj = body
		moveTarget = null
		npc_target = null


func _on_Detection_body_exited(body):
	if body.has_method("conversation"):
		detected_obj = null
		body.hide_cloud()


func _on_Detection_area_entered(area):
	if area.has_method("digging"):
		detected_obj = area
		area.show_mark()


func _on_Detection_area_exited(area):
	if area.has_method("digging"):
		detected_obj = null
		area.hide_mark()
