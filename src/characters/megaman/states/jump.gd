class_name JumpState
extends BaseState

func enter(_params := {}) -> void:
	player.velocity.y = -300
	player.animator.play("jump")

func update(delta:float) -> void:
	player.gravityApply(delta)
	if(player.velocity.y > 0):
		state_machine.transition_to("fall")
	player.velocity.x = player.SPEED * player.get_axis()
	player.move_and_slide()
	
	if(player.inputs_listening):
		if(Input.is_action_just_released("ui_accept")):
			state_machine.transition_to("fall")
