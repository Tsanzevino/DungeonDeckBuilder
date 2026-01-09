## A Tag Condition is satisfied when the target has the specified tag.
class_name TagCondition extends Condition

## The tags being tested for. All Tags must be present on a single card in the target position.[br]
## [b]For Example:[/b] if the fire and spell tags are both specified, and the target is the stock,
## as long as a single card in the stock has both fire and spell tags, the condition will return true.[br]
## Inverting this will cause the condition to return true if there isnt a single card in the target position
## with the specified tags.
@export var tags : Array[Card.Tag]

## The position in the deck being targetted.
@export var target : Deck.Position

## Tests each card and returns true if at least one card has all tags.
func _test(player : Player) -> bool:
	for card in player.deck.get_cards(target):
		if test_card(card): return true
	return false

## Tests a specific card for containing all tags.
func test_card(card : Card) -> bool:
	for tag in tags:
		if not card.tags.has(tag): return false
	return true
