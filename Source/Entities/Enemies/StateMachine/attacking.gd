# Enemy Attacking State
extends EnemyState


func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if enemy.attacking: return
	var direction : Vector2 = chase_direction()
	enemy.velocity = lerp(enemy.velocity, direction * ATTACK_MOVE_SPEED, delta * GROUND_FRICTION)
	look_toward(direction)
	enemy.move_and_slide()
	if not enemy.player_spotted(): 
		finished.emit(IDLE)
		return
	if not enemy.player_in_range():
		finished.emit(CHASING)
		return
	if not enemy.player_too_close():
		attack()
		return
	finished.emit(FLEEING)

func enter(_previous_state_path: String, _data := {}) -> void:
	look_toward((enemy.nearest_player().global_position - enemy.global_position).normalized())
	attack()

func attack():
	if enemy.mana.can_consume(enemy.deck.hand[0].manaCost):
		enemy.deck.play_card(0)

func exit() -> void:
	pass
