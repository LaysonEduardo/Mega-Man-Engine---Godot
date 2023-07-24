class_name StateMachine
extends Node

@export var DEBUG_MODE:= false

# Emitted when transitioning to a new state.
signal transitioned(state_name)
var history = []
# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state := "idle"

# The current active state. At the start of the game, we get the `initial_state`.
@onready var state: BaseState = get_node(initial_state)

@onready var player:MegaMan = get_parent()

func _ready() -> void:
	await owner.ready
	# The state machine assigns itself to the State objects' state_machine property.
	state.enter()


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, params: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if(state.name == target_state_name):
		if(params.is_empty()):
			return
	
	if not has_node(target_state_name):
		print(target_state_name, " State not exist!")
		return
	
	var new_state:BaseState = get_node(target_state_name)
	if(new_state.active == false):
		print(target_state_name, "State not activate!")
		return
	history.append(state.name)
	await state.exit()
	state = new_state
	
	if(DEBUG_MODE):
		print("Entering state: ", state.name)
	state.enter(params)
	emit_signal("transitioned", state.name)

func last_state()->String:
	return history[-1]

func back():
	if history.size() > 0:
		state.exit()
		var last_state_a:String = history.pop_back()
		state = get_node(last_state_a)
		state.enter()
		history.append(state.name)
		emit_signal("transitioned", state.name)
