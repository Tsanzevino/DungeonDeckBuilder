## A card that deploys an attack when played.
@icon("res://Data/Cards/Sturdy Shortsword/sturdy_shortsword.png")
class_name AttackCard extends Card

## The attack that gets deployed.
@export var attack : Attack

## Override of the superclass to force a check for the player attacking.
func _all_conditions_satisfied(entity : Entity) -> bool:
	return super(entity) and not entity.attacking

## Performs the card action, an attack.
func _perform_action(entity : Entity) -> void:
	_start_attack(entity)

## Sets up the hitbox and puts the player in the attacking state.
func _start_attack(entity : Entity):
	entity.attacking = true
	var hitbox = Hitbox.new(attack)
	entity.pivot.add_child(hitbox)
	hitbox.attack_finished.connect(_on_attack_finished.bind((entity)))

## Takes the player out of the attacking state when the attack is finished
func _on_attack_finished(entity : Entity):
	entity.attacking = false
