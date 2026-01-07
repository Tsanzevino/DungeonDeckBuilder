@abstract class_name EnemyState extends State

const CHASE_MOVE_SPEED : float = 75.0
const ATTACK_MOVE_SPEED : float = 0.0
const FLEE_MOVE_SPEED : float = 100.0
const GROUND_FRICTION : float = 15

const IDLE : String = "Idle"
const CHASING : String = "Chasing"
const FLEEING : String = "Fleeing"
const ATTACKING : String = "Attacking"

var enemy : Enemy

func handle_input(_event: InputEvent) -> void: pass

func move_direction() -> Vector2:
	if enemy.nearest_player() == null: return Vector2.ZERO
	return (enemy.nearest_player().global_position - enemy.global_position).normalized()
