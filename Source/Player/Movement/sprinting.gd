extends MovementState

func physics_update(delta: float) -> void:
	# Perform State Movement
	player.velocity = lerp(player.velocity, direction * SPRINT_SPEED, delta * GROUND_FRICTION)
	player.move_and_slide()
	player.use_sprint(delta)
	
	# Check to leave the state
	if direction.length() > DEADZONE_SIZE:
		if not player.can_sprint():
			finished.emit(WALKING)
	else: finished.emit(IDLE)

func enter(_previous_state_path: String, _data := {}) -> void:
	pass

func exit() -> void:
	pass
