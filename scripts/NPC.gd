extends KinematicBody2D

var velocity = Vector2()
var facingDir = Vector2()

onready var patrol_path_node = "../Map/{name}Path".format({"name": self.name})
onready var patrol_path = get_node(patrol_path_node)
var patrol_index = 0
var patrol_points

var moveSpeed = 20
var walk = true

onready var dialoguePopup = $"../GUI/DialoguePopup"
onready var player = $"../Player"
onready var cloud_sprite = $Sprite

var color_dict = {"Red": Color(1, 0, 0, 1), 
				"Orange": Color(0.9, 0.5, 0, 1), 
				"Yellow": Color(1, 1, 0, 1),
				"Green": Color(0.5, 1, 0,1),
				"Blue": Color(0, 0.5, 0.9, 1),
				"Purple": Color(0.45, 0, 1, 1)}

enum QuestStatus {NOT_STARTED, STARTED, COMPLETED}
enum CoinStatus {NOT_ENOUGH, ENOUGH}
var quest_status
var coin_status
var dialogue_state = 0

func _ready():
	if patrol_path:
		patrol_points = patrol_path.curve.get_baked_points()
	
	$AnimatedSprite.self_modulate = color_dict[self.name]

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

func show_cloud():
	cloud_sprite.visible = true
	walk = false

func hide_cloud():
	cloud_sprite.visible = false
	walk = true

func conversation(answer = null):
	dialoguePopup.npc = self
	dialoguePopup.npc_name = self.name
	manage_talking_animations()
	set_coin_status()
	set_quest_status(self.name)
	match quest_status:
		QuestStatus.NOT_STARTED:
			match dialogue_state:
				0:
					dialogue_state = 1					
					dialoguePopup.dialogue_text = "Hello friend! I am {name}! Do you want to buy my colour?".format({"name": self.name})
					dialoguePopup.answer_1 = "[1] Yes"
					dialoguePopup.answer_2 = "[2] No"
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
									dialoguePopup.answer_1 = "[1] I try to find more! Bye"
									dialoguePopup.answer_2 = ""
									dialoguePopup.open()

								2:
									dialogue_state = 2
									quest_status = QuestStatus.STARTED
									GlobalVariables.quest_status_by_npc[self.name] = 1
									dialoguePopup.dialogue_text = "See you later!"
									dialoguePopup.answer_1 = "[1] Bye!"
									dialoguePopup.answer_2 = ""
									dialoguePopup.open()

						CoinStatus.ENOUGH:
							match answer:
								1:
									dialogue_state = 2
									quest_status = QuestStatus.COMPLETED
									GlobalVariables.quest_status_by_npc[self.name] = 2
									dialoguePopup.dialogue_text = "Here you are!"
									dialoguePopup.answer_1 = "[1] Thank you very much! Byebye"
									dialoguePopup.answer_2 = ""
									dialoguePopup.open()
									GlobalVariables.coins -= 2
									GlobalVariables.colors.append(self.name)

								2:
									dialogue_state = 2
									dialoguePopup.dialogue_text = "See you later!"
									dialoguePopup.answer_1 = "[1] Bye!"
									dialoguePopup.answer_2 = ""
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
					dialoguePopup.answer_1 = "[1] Yes!"
					dialoguePopup.answer_2 = "[2] No"
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
									dialoguePopup.answer_1 = "[1] I try to find more! Bye"
									dialoguePopup.answer_2 = ""
									dialoguePopup.open()

								2:
									dialogue_state = 2
									quest_status = QuestStatus.STARTED
									GlobalVariables.quest_status_by_npc[self.name] = 1
									dialoguePopup.dialogue_text = "See you later!"
									dialoguePopup.answer_1 = "[1] Bye!"
									dialoguePopup.answer_2 = ""
									dialoguePopup.open()

						CoinStatus.ENOUGH:
							match answer:
								1:
									dialogue_state = 2
									quest_status = QuestStatus.COMPLETED
									GlobalVariables.quest_status_by_npc[self.name] = 2
									dialoguePopup.dialogue_text = "Here you are!"
									dialoguePopup.answer_1 = "[1] Thank you very much! Byebye"
									dialoguePopup.answer_2 = ""
									dialoguePopup.open()
									GlobalVariables.coins -= 2
									GlobalVariables.colors.append(self.name)
									
								2:
									dialogue_state = 2
									quest_status = QuestStatus.STARTED
									GlobalVariables.quest_status_by_npc[self.name] = 1
									dialoguePopup.dialogue_text = "See you later!"
									dialoguePopup.answer_1 = "[1] Bye!"
									dialoguePopup.answer_2 = ""
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
					dialoguePopup.answer_1 = "[1] Thanks, bye!"
					dialoguePopup.answer_2 = ""
					dialoguePopup.open()

				1:
					dialogue_state = 2
					dialoguePopup.npc = self
					dialoguePopup.npc_name = self.name
					dialoguePopup.dialogue_text = "Hi! Have fun with my colour!".format({"name": self.name})
					dialoguePopup.answer_1 = "[1] Thanks, bye!"
					dialoguePopup.answer_2 = ""
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

func manage_talking_animations():
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
	if !walk:
		if velocity.x > 0:
			play_animation("IdleRight")
		elif velocity.x < 0:
			play_animation("IdleLeft")
		elif velocity.y < 0:
			play_animation("IdleUp")
		elif velocity.y > 0:
			play_animation("IdleDown")
	else:
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
		manage_talking_animations()
		return
	
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 1:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]

	velocity = (target - position).normalized()
	velocity = move_and_slide(velocity * moveSpeed)
	manage_animations()
	hide_cloud()

# FOR CLICK AND MOVE!
func _on_NPC_input_event(_vieuwport, event, _shape_idx):
	if GlobalVariables.chosen_input == "click_move":
		if event is InputEventMouseButton:
			walk = false
			if cloud_sprite.visible:
				player.moveTarget = null
				conversation()
			else:
				player.npc_target = self

