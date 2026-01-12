extends MovementState

func physics_update(delta: float) -> void:
	# Perform State Movement
	look_toward_movement()
	player.velocity = lerp(player.velocity, direction * WALK_SPEED, delta * GROUND_FRICTION)
	player.move_and_slide()
	
	# Check to leave the state
	if player.attacking: finished.emit(ATTACKING)
	if direction.length() > DEADZONE_SIZE:
		if player.can_sprint():
			finished.emit(SPRINTING)
	else: finished.emit(IDLE)

func enter(_previous_state_path: String, _data := {}) -> void:
	pass

func exit() -> void:
	pass
