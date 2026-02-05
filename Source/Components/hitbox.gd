## The hitbox tells a hurtbox that it is within range of an attack.
class_name Hitbox extends Area2D

## Signal for when the attack finishes and the hitbox is removed.
signal attack_finished

## The attack being performed by the hitbox.
@export var attack : Attack

## Creates a hitbox from a new attack.
func _init(newAttack : Attack = attack) -> void:
	attack = newAttack.duplicate(true)
	collision_layer = 16
	collision_mask = 32
	monitoring = false

## Sets up the hitbox.
func _ready() -> void:
	# Creates the collision and disables the collision shape.
	var cs : CollisionShape2D = CollisionShape2D.new()
	cs.shape = attack.aoe
	cs.set_deferred("disabled", true)
	add_child(cs)
	# This determines if the attack should be connected to the player or not.
	top_level = attack.topLevel
	
	if top_level:
		# Top level requires the position to be transformed to put it in the right place.
		position = get_parent().global_position + attack.offset.rotated(get_parent().rotation)
		# The attack movement also needs rotated to move in the right direction.
		attack.movement = attack.movement.rotated(get_parent().rotation)
	else:
		# Otherwise, you can just apply offset as normal.
		position = attack.offset
	# Starts a timer for the windup and begins waiting.
	var timer : SceneTreeTimer = get_tree().create_timer(attack.windup.value)
	timer.timeout.connect(windup_finished.bind(cs))

## Accounts for the attack movement.
func _physics_process(delta: float) -> void:
	position += attack.movement * delta

## Enables collision and ends the windup, Starting the timer for the attack.
func windup_finished(cs : CollisionShape2D):
	cs.set_deferred("disabled", false)
	var timer : SceneTreeTimer = get_tree().create_timer(attack.duration.value)
	timer.timeout.connect(duration_finished)

## Closes out the attack by emitting attack_finished and deleting the hitbox.
func duration_finished():
	attack_finished.emit()
	queue_free()
