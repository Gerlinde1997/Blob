extends KinematicBody2D

var velocity = Vector2()
var facingDir = Vector2()

var moveSpeed = 80

var current_position

onready var scene_name = SceneChanger.current_scene.get_name()
onready var rayCast = $RayCast2D
var interactDist = 70

func play_animation(anim_name):
	if $AnimatedSprite.animation != anim_name:
		$AnimatedSprite.play(anim_name)

func manage_animations():
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

#func _process(delta):
#	current_position = get_position()
#	var situation = [scene_name, true]
#	var grassToStoneLeft = ["Grass", current_position.y < 0 and (current_position.x > 280 and current_position.x < 360)]
#	var grassToStoneRight = ["Grass", current_position.y < 0 and (current_position.x > 640 and current_position.x < 768)]
#	var stoneToGrassLeft = ["Stone", current_position.y > 896 and (current_position.x > 280 and current_position.x < 360)]
#	var stoneToGrassRight = ["Stone", current_position.y > 896 and (current_position.x > 640 and current_position.x < 768)]
#
#	match situation:
#		grassToStoneLeft:
#			PlayerGlobalVariables.player_pos = Vector2(320, 896)
#			SceneChanger.goto_scene("res://Stone.tscn")
#		grassToStoneRight:
#			PlayerGlobalVariables.player_pos = Vector2(704, 896)
#			SceneChanger.goto_scene("res://Stone.tscn")
#		stoneToGrassLeft:
#			PlayerGlobalVariables.player_pos = Vector2(320, 0)
#			SceneChanger.goto_scene("res://Grass.tscn")
#		stoneToGrassRight:
#			PlayerGlobalVariables.player_pos = Vector2(704, 0)
#			SceneChanger.goto_scene("res://Grass.tscn")

func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_pressed("move_up"):
		velocity.y += -1
		facingDir = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		facingDir = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		velocity.x += -1
		facingDir = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		facingDir = Vector2(1, 0)
	
	velocity = velocity.normalized()
	
	move_and_slide(velocity * moveSpeed)
	manage_animations()


func _on_Up_left_door_body_entered(body):
	# to down left stone
	PlayerGlobalVariables.animation = "IdleUp"
	PlayerGlobalVariables.pos = Vector2(320, 871)
	SceneChanger.goto_scene("res://Stone.tscn")

func _on_Down_left_door_body_entered(body):
	# to up left stone
	PlayerGlobalVariables.animation = "IdleDown"
	PlayerGlobalVariables.pos = Vector2(320, -39)
	SceneChanger.goto_scene("res://Stone.tscn")

func _on_Left_Down_door_body_entered(body):
	# to up left grass
	PlayerGlobalVariables.animation = "IdleDown"
	PlayerGlobalVariables.pos = Vector2(320, 25)
	SceneChanger.goto_scene("res://Grass.tscn")

func _on_Left_Up_door_body_entered(body):
	# to down left grass
	PlayerGlobalVariables.animation = "IdleUp"
	PlayerGlobalVariables.pos = Vector2(320, 999)
	SceneChanger.goto_scene("res://Grass.tscn")
