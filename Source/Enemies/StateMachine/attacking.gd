# Enemy Attacking State
extends EnemyState


func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	enemy.velocity = lerp(enemy.velocity, move_direction() * ATTACK_MOVE_SPEED, delta * GROUND_FRICTION)
	enemy.move_and_slide()
	
	if not enemy.player_spotted(): 
		finished.emit(IDLE)
		return
	if not enemy.player_in_range():
		finished.emit(CHASING)
		return
	if not enemy.player_too_close():
		# Continue Attacking
		return
	finished.emit(FLEEING)

func enter(_previous_state_path: String, _data := {}) -> void:
	pass

func exit() -> void:
	pass
