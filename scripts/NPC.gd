extends KinematicBody2D

var velocity = Vector2()
var facingDir = Vector2()

onready var patrol_path_node = "../Map/{name}Path".format({"name": self.name})
onready var patrol_path = get_node(patrol_path_node)
var patrol_index = 0
var patrol_points

var moveSpeed = 20

var walk = true
onready var dialoguePopup = $"../CanvasLayer/DialoguePopup"
onready var player = $"../Player"

enum QuestStatus {NOT_STARTED, STARTED, COMPLETED}
enum CoinStatus {NOT_ENOUGH, ENOUGH}
var quest_status
var coin_status
var dialogue_state = 0

func _ready():
	if patrol_path:
		patrol_points = patrol_path.curve.get_baked_points()

func set_coin_status():
	if GlobalVariables.coins >= 2:
		coin_status = CoinStatus.ENOUGH
	else:
		coin_status = CoinStatus.NOT_ENOUGH

func set_quest_status(name):
	if GlobalVariables.quest_status_by_npc[name] == 0:
		quest_status = QuestStatus.NOT_STARTED
	elif GlobalVariables.quest_status_by_npc[name] == 1:
		quest_status = QuestStatus.STARTED
	elif GlobalVariables.quest_status_by_npc[name] == 2:
		quest_status = QuestStatus.COMPLETED

func conversation(answer = null):
	dialoguePopup.npc = self
	dialoguePopup.npc_name = self.name
	manage_talking_animation()
	set_coin_status()
	set_quest_status(self.name)
	match quest_status:
		QuestStatus.NOT_STARTED:
			match dialogue_state:
				0:
					dialogue_state = 1					
					dialoguePopup.dialogue_text = "Hello friend! I am {name}! Do you want to buy my colour?".format({"name": self.name})
					dialoguePopup.answers = "[1] Yes   [2] No"
					dialoguePopup.open()

				1:
					match coin_status:
						CoinStatus.NOT_ENOUGH:
							match answer:
								1:
									dialogue_state = 2
									quest_status = QuestStatus.STARTED
									GlobalVariables.quest_status_by_npc[self.name] = 1
									dialoguePopup.dialogue_text = "Sorry, you don't have enough coins. See you later!"
									dialoguePopup.answers = "[1] I try to find more! Bye"
									dialoguePopup.open()

								2:
									dialogue_state = 2
									quest_status = QuestStatus.STARTED
									GlobalVariables.quest_status_by_npc[self.name] = 1
									dialoguePopup.dialogue_text = "See you later!"
									dialoguePopup.answers = "[1] Bye!"
									dialoguePopup.open()

						CoinStatus.ENOUGH:
							match answer:
								1:
									dialogue_state = 2
									quest_status = QuestStatus.COMPLETED
									GlobalVariables.quest_status_by_npc[self.name] = 2
									dialoguePopup.dialogue_text = "Here you are!"
									dialoguePopup.answers = "[1] Thank you very much! Byebye"
									dialoguePopup.open()
									GlobalVariables.coins -= 2
									GlobalVariables.colors.append(self.name)

								2:
									dialogue_state = 2
									dialoguePopup.dialogue_text = "See you later!"
									dialoguePopup.answers = "[1] Bye!"
									dialoguePopup.open()

				2:
					match answer:
						1:
							dialogue_state = 0
							dialoguePopup.close()
						_:
							dialoguePopup.set_process_input(true)
			
		QuestStatus.STARTED:
			match dialogue_state:
				0:
					dialogue_state = 1
					dialoguePopup.npc = self
					dialoguePopup.npc_name = self.name
					dialoguePopup.dialogue_text = "Hello again! Do you want to buy my colour now?".format({"name": self.name})
					dialoguePopup.answers = "[1] Yes   [2] No"
					dialoguePopup.open()
				
				1:
					match coin_status:
						CoinStatus.NOT_ENOUGH:
							match answer:
								1:
									dialogue_state = 2
									quest_status = QuestStatus.STARTED
									GlobalVariables.quest_status_by_npc[self.name] = 1
									dialoguePopup.dialogue_text = "Sorry, you don't have enough coins. See you later!"
									dialoguePopup.answers = "[1] I try to find more! Bye"
									dialoguePopup.open()

								2:
									dialogue_state = 2
									quest_status = QuestStatus.STARTED
									GlobalVariables.quest_status_by_npc[self.name] = 1
									dialoguePopup.dialogue_text = "See you later!"
									dialoguePopup.answers = "[1] Bye!"
									dialoguePopup.open()

						CoinStatus.ENOUGH:
							match answer:
								1:
									dialogue_state = 2
									quest_status = QuestStatus.COMPLETED
									GlobalVariables.quest_status_by_npc[self.name] = 2
									dialoguePopup.dialogue_text = "Here you are!"
									dialoguePopup.answers = "[1] Thank you very much! Byebye"
									dialoguePopup.open()
									GlobalVariables.coins -= 2
									GlobalVariables.colors.append(self.name)
									
								2:
									dialogue_state = 2
									quest_status = QuestStatus.STARTED
									GlobalVariables.quest_status_by_npc[self.name] = 1
									dialoguePopup.dialogue_text = "See you later!"
									dialoguePopup.answers = "[1] Bye!"
									dialoguePopup.open()

				2:
					match answer:
						1:
							dialogue_state = 0
							dialoguePopup.close()
						_:
							dialoguePopup.set_process_input(true)

		QuestStatus.COMPLETED:
			match dialogue_state:
				0:
					dialogue_state = 2
					dialoguePopup.npc = self
					dialoguePopup.npc_name = self.name
					dialoguePopup.dialogue_text = "Hi! Have fun with my colour!".format({"name": self.name})
					dialoguePopup.answers = "[1] Thanks, bye!"
					dialoguePopup.open()

				1:
					dialogue_state = 2
					dialoguePopup.npc = self
					dialoguePopup.npc_name = self.name
					dialoguePopup.dialogue_text = "Hi! Have fun with my colour!".format({"name": self.name})
					dialoguePopup.answers = "[1] Thanks, bye!"
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
	if !walk:
		return
	
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 1:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]

	velocity = (target - position).normalized()
	velocity = move_and_slide(velocity * moveSpeed)
	manage_animations()