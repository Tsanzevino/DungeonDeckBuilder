## A Card that applies effects to certain target cards.
class_name BoostCard extends Card

## The effects to add to the target cards.
@export var boostEffects : Array[Boost]
## The positions of the target cards.
@export var targetPosition : Deck.Position = Deck.Position.HAND
## The types of cards being targetted.
@export var tagCondition : TagCondition

## Override of the superclass to force a check for the player's health.
func _all_conditions_satisfied(entity : Entity) -> bool:
	return super(entity) and tagCondition.is_satisfied(entity)

## Applies the effects to the cards in the target position that have the specified tags.
func _perform_action(entity : Entity) -> void:
	for card in entity.deck.get_cards(targetPosition):
		if not ((card is AttackCard) and tagCondition.test_card(card)): continue
		for effect in boostEffects:
			effect.apply(card)
