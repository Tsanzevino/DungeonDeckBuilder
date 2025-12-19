## A Tag Condition is satisfied when the target has the specified tag.
class_name TagCondition extends Condition

@export var tag : Card.Tag

@export var target : Deck.Position

func is_satisfied(player : Player) -> bool:
	for card in player.deck.get_cards(target):
		if card.tags.has(tag): return true
	return false
