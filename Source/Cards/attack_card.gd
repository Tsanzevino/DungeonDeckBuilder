## A card that deploys an attack when played.
class_name AttackCard extends Card

## The attack that gets deployed.
@export var attack : Attack

## Override of the superclass to force a check for the player attacking.
func _all_conditions_satisfied(player : Player) -> bool:
	return super(player) and not player.attacking

## Performs the card action, an attack.
func _perform_action(player : Player) -> void:
	_start_attack(player)

## Sets up the hitbox and puts the player in the attacking state.
func _start_attack(player : Player):
	player.attacking = true
	var hitbox = Hitbox.new(attack)
	player.add_child(hitbox)
	hitbox.attack_finished.connect(_on_attack_finished.bind((player)))

## Takes the player out of the attacking state when the attack is finished
func _on_attack_finished(player : Player):
	player.attacking = false
