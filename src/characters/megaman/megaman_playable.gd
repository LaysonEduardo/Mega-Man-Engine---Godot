class_name MegaMan
extends CharacterBody2D

@onready var state_machine:StateMachine = get_node("state_machine")
@onready var animator:AnimationManager = get_node("AnimationManager")
@onready var sprite:AnimatedSprite2D = get_node("animator")

var inputs_listening:bool = true

var direction:int
var facing_right:bool

const SPEED = 100.0
const JUMP_VELOCITY = -250.0
const fall_speed = 350
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(_delta):
	update_mirror()

func gravityApply(delta):
	velocity.y += gravity * delta
	if velocity.y > fall_speed :
		if(state_machine.state.name == "beam"):
			velocity.y = fall_speed * 1.5
		else:
			velocity.y = fall_speed

func get_axis():
	var axis = 0
	if(Input.is_action_pressed("ui_left")):
		axis = -1
	elif(Input.is_action_pressed("ui_right")):
		axis = 1
	
	if(axis != 0):
		direction = axis
	return axis

func update_mirror():
	if inputs_listening and state_machine.state.name != "hover":
		if direction < 0:
			facing_right = false;
			if sprite.scale.x != get_mirror_direction():
				sprite.scale.x = get_mirror_direction()
		elif direction > 0:
			facing_right = true;
			if sprite.scale.x != get_mirror_direction():
				sprite.scale.x = get_mirror_direction()

func get_mirror_direction():
	return 1 if(facing_right) else -1
