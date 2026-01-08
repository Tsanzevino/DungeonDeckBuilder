# Enemy Attacking State
extends EnemyState


func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	enemy.velocity = lerp(enemy.velocity, chase_direction() * ATTACK_MOVE_SPEED, delta * GROUND_FRICTION)
	enemy.move_and_slide()
	#sadfs 

func enter(_previous_state_path: String, _data := {}) -> void:
	enemy.look_at(enemy.nearest_player().global_position)
	enemy.rotate(PI/2)
	start_attack()

func start_attack():
	var hitbox = Hitbox.new(enemy.attack)
	enemy.add_child(hitbox)
	hitbox.attack_finished.connect(_on_attack_finished)

func _on_attack_finished():
	var timer = get_tree().create_timer(enemy.attackCooldown)
	timer.timeout.connect(change_state)

func change_state():
	if not enemy.player_spotted(): 
		finished.emit(IDLE)
		return
	if not enemy.player_in_range():
		finished.emit(CHASING)
		return
	if not enemy.player_too_close():
		start_attack()
		return
	finished.emit(FLEEING)

func exit() -> void:
	pass
