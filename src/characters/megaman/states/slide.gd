class_name SlidesState
extends BaseState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	player.animator.play("slide")

func update(delta):
	if(!player.is_on_floor()):
		state_machine.transition_to("fall")
	if(player.sprite.animation == "slide"):
		player.velocity.x = 200 * player.direction
		player.gravityApply(delta)
		player.move_and_slide()
		await player.sprite.animation_finished
		if(player.get_axis() == 0):
			state_machine.transition_to("idle")
		else:
			state_machine.transition_to("walk")
			
	

