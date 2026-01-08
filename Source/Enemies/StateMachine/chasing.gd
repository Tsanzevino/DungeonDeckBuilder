# Enemy Chasing State
extends EnemyState


func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	var direction : Vector2 = chase_direction()
	enemy.velocity = lerp(enemy.velocity, direction * CHASE_MOVE_SPEED, delta * GROUND_FRICTION)
	enemy.look_at(enemy.global_position + direction)
	enemy.move_and_slide()
	
	if not enemy.player_spotted(): 
		finished.emit(IDLE)
		return
	if not enemy.player_in_range():
		# Continue Chasing
		return
	if not enemy.player_too_close():
		finished.emit(ATTACKING)
		return
	finished.emit(FLEEING)

func enter(_previous_state_path: String, _data := {}) -> void:
	start_chase()

func exit() -> void:
	pass
