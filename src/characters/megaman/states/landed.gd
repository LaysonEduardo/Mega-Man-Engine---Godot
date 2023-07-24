class_name LandedState
extends BaseState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	pass

func update(delta):
	player.velocity.x = 0
	player.gravityApply(delta)
	player.animator.play("landed")
	player.move_and_slide()
	
	if(player.is_on_floor() and player.inputs_listening):
		if((Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right")) and Input.is_action_pressed("ui_down") and Input.is_action_just_pressed("ui_accept")):
			state_machine.transition_to("slide")
		if(Input.is_action_just_pressed("ui_accept")):
			state_machine.transition_to("jump")
		elif(Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right")):
			state_machine.transition_to("walk")
			
	if(player.is_on_floor()):
		await player.sprite.animation_finished
		if(player.is_on_floor() and player.get_axis() == 0):
			state_machine.transition_to("idle")
	else:
		state_machine.transition_to("fall")

