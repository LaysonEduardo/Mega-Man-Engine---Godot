class_name IdleState
extends BaseState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_params := {}) -> void:
	player.animator.play("idle")
	


func physics_update(delta: float) -> void:
	player.gravityApply(delta)
	player.move_and_slide()
	player.velocity.x = 0
	if(!player.is_on_floor()):
		state_machine.transition_to("fall")
#
	if(player.inputs_listening):
		if((Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right")) and Input.is_action_pressed("ui_down") and Input.is_action_just_pressed("ui_accept")):
			state_machine.transition_to("slide")
		elif(Input.is_action_just_pressed("ui_accept")):
			state_machine.transition_to("jump")
		if(Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right")):
			state_machine.transition_to("walk")
