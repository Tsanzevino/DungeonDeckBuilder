extends MovementState

func physics_update(delta: float) -> void:
	# Perform State Movement
	player.velocity = lerp(player.velocity, direction * WALK_SPEED, delta * GROUND_FRICTION)
	player.move_and_slide()
	
	# Check to leave the state
	if direction.length() > DEADZONE_SIZE:
		if Input.is_action_pressed("sprint"):
			finished.emit(SPRINTING)
	else: finished.emit(IDLE)

func enter(_previous_state_path: String, _data := {}) -> void:
	pass

func exit() -> void:
	pass
