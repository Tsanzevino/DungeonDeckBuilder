# Enemy Fleeing State
extends EnemyState


func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	var direction = flee_direction()
	enemy.velocity = lerp(enemy.velocity, direction * FLEE_MOVE_SPEED, delta * GROUND_FRICTION)
	enemy.look_at(enemy.global_position + direction)
	enemy.move_and_slide()
	
	if not enemy.player_spotted(): 
		finished.emit(IDLE)
		return
	if not enemy.player_in_range():
		finished.emit(CHASING)
		return
	if not enemy.player_too_close():
		finished.emit(ATTACKING)
		return
	# Continue Fleeing

func enter(_previous_state_path: String, _data := {}) -> void:
	pass

func exit() -> void:
	pass
