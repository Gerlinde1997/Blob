extends KinematicBody2D

var velocity = Vector2()
var facingDir = Vector2()

onready var patrol_path = $"../Map/NpcPath"
var patrol_index = 0
var patrol_points

var moveSpeed = 20

onready var dialoguePopup = $"../CanvasLayer/DialoguePopup"
#onready var player = $"../Player"

#enum QuestStatus {NOT_STARTED, STARTED, COMPLETED}
#var quest_status = QuestStatus.NOT_STARTED
var dialogue_state = 0

func _ready():
	if patrol_path:
		patrol_points = patrol_path.curve.get_baked_points()

func conversation(answer = null):
	manage_talking_animation()
	match dialogue_state:
		0:
			dialogue_state = 1
			dialoguePopup.npc = self
			dialoguePopup.npc_name = self.name
			dialoguePopup.dialogue_text = "Hello friend! I am {name}! Do you need something?".format({"name": self.name})
			dialoguePopup.answers = "[1] Yes   [2] No"
			dialoguePopup.open()

		1:
			match answer:
				1:
					dialogue_state = 2
					dialoguePopup.dialogue_text = "alrighty"
					dialoguePopup.answers = "[1] BYE"
					dialoguePopup.open()
				2:
					dialogue_state = 2
					dialoguePopup.dialogue_text = "That's nice!"
					dialoguePopup.answers = "[1] Bye"
					dialoguePopup.open()
		2:
			match answer:
				1:
					dialogue_state = 0
					dialoguePopup.close()
				_:
					dialoguePopup.set_process_input(true)

func play_animation(anim_name):
	if $AnimatedSprite.animation != anim_name:
		$AnimatedSprite.play(anim_name)

func manage_talking_animation():
	var playerAnimation = $"../Player/AnimatedSprite".animation
	
	if  playerAnimation == "IdleRight" or playerAnimation == "MoveRight":
		play_animation("IdleLeft")
	elif playerAnimation == "IdleLeft" or playerAnimation == "MoveLeft":
		play_animation("IdleRight")
	elif playerAnimation == "IdleUp" or playerAnimation == "MoveUp":
		play_animation("IdleDown")
	elif playerAnimation == "IdleUp" or playerAnimation == "MoveDown":
		play_animation("IdleUp")

func manage_animations():
	if velocity.x > 0:
		play_animation("MoveRight")
	elif velocity.x < 0:
		play_animation("MoveLeft")
	elif velocity.y < 0:
		play_animation("MoveUp")
	elif velocity.y > 0:
		play_animation("MoveDown")

func _physics_process(_delta):
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 1:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]

	velocity = (target - position).normalized()
	velocity = move_and_slide(velocity * moveSpeed)
	manage_animations()