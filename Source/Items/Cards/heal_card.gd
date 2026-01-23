## A card that heals the player.
class_name HealCard extends Card

## The type of healing to be done on the player.
enum Type{
	PERCENTAGE_INCREASE, ## Increases health by [code]healAmount[/code] as a percent of the max health.
	FLAT_INCREASE, ## Increases health by [code]healAmount[/code].
	PERCENT_SET,## Sets health to [code]healAmount[/code] as a percent of the max health.
	FLAT_SET## Sets health to [code]healAmount[/code].
	}

## The amount to heal according to the type.
@export var healAmount : float = 1.0
## The type of healing to be done on the player.
@export var type : Type = Type.FLAT_INCREASE
## The health condition required before health can be modified.
@export var healCondition : HealthCondition = preload("res://Data/Conditions/HealthConditions/not_full_health.tres")

## Override of the superclass to force a check for the player's health.
func _all_conditions_satisfied(entity : Entity) -> bool:
	return super(entity) and healCondition.is_satisfied(entity)

## Applies the type of healing on the player.
func _perform_action(entity : Entity) -> void:
	match type:
		Type.PERCENTAGE_INCREASE:
			entity.health.heal(healAmount * entity.health.maxHealth)
		Type.FLAT_INCREASE:
			entity.health.heal(healAmount)
		Type.PERCENT_SET:
			entity.health.health = healAmount * entity.health.maxHealth
		Type.FLAT_SET:
			entity.health.health = healAmount
		
