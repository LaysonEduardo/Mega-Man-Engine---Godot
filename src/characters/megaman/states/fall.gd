class_name FallState
extends BaseState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_params := {}) -> void:
	player.velocity.y = 0
	player.animator.play("fall")

	

func physics_update(delta: float) -> void:
	player.gravityApply(delta)
	player.move_and_slide()
	player.velocity.x = player.SPEED * player.get_axis()
	
	if(player.is_on_floor()):
		state_machine.transition_to("landed")
	
	


