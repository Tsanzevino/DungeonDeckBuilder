extends MovementState

func physics_update(delta: float) -> void:
	# Perform State Movement
	player.velocity = lerp(player.velocity, direction * ATTACK_SPEED, delta * GROUND_FRICTION)
	player.move_and_slide()

func enter(_previous_state_path: String, _data := {}) -> void:
	pass

func exit() -> void:
	pass
