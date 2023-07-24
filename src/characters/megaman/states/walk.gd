class_name WalkState
extends BaseState

func physics_update(delta: float) -> void:
	if(player.inputs_listening):
		if(player.is_on_floor()):
			player.velocity.x = player.SPEED * player.get_axis()
			_set_animation()

		if(player.velocity.y > 0):
			state_machine.transition_to("fall")
		if((Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right")) and Input.is_action_pressed("ui_down") and Input.is_action_just_pressed("ui_accept")):
			state_machine.transition_to("slide")
		elif (Input.is_action_just_pressed("ui_accept") and player.is_on_floor()):
			state_machine.transition_to("jump")
		if(player.velocity.x == 0):
			state_machine.transition_to("idle")
	player.gravityApply(delta)
	player.move_and_slide()
	
func _set_animation():
	if(player.velocity.x != 0 and player.is_on_floor() and player.velocity.y == 0):
		player.animator.play("walk")

