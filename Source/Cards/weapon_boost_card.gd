## A Card that applies effects to certain target cards.
class_name BoostCard extends Card

## The effects to add to the target cards.
@export var boostEffects : Array[Effect]
## The positions of the target cards.
@export var targetPosition : Deck.Position = Deck.Position.HAND
## The types of cards being targetted.
@export var tagCondition : TagCondition

## Override of the superclass to force a check for the player's health.
func _all_conditions_satisfied(player : Player) -> bool:
	return super(player) and tagCondition.is_satisfied(player)

## Applies the effects to the cards in the target position that have the specified tags.
func _perform_action(player : Player) -> void:
	for card in player.deck.get_cards(targetPosition):
		if not ((card is AttackCard) and tagCondition.test_card(card)): continue
		for effect in boostEffects:
			effect.apply(card)
