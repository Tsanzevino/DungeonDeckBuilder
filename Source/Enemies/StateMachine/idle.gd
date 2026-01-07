# Enemy Idle State
extends EnemyState


func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	enemy.velocity = lerp(enemy.velocity, Vector2.ZERO, delta * GROUND_FRICTION)
	enemy.move_and_slide()
	
	if not enemy.player_spotted(): 
		# Remain Idle
		return
	if not enemy.player_in_range(): 
		finished.emit(CHASING)
		return
	if not enemy.player_too_close():
		finished.emit(ATTACKING)
		return
	finished.emit(FLEEING)
	
func enter(_previous_state_path: String, _data := {}) -> void:
	pass

func exit() -> void:
	pass
