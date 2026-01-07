class_name Enemy extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Hurtbox.hurt.connect(%Health.damage)
	%Health.no_heath.connect(die)
	setup()

func die() -> void:
	queue_free()

func setup() -> void:
	pass

func player_spotted() -> bool:
	return %ChaseRange.nearestPlayer != null

func player_in_range() -> bool:
	return %AttackRange.nearestPlayer != null

func player_too_close() -> bool:
	return %FleeRange.nearestPlayer != null

func nearest_player() -> Player:
	return %ChaseRange.nearestPlayer
