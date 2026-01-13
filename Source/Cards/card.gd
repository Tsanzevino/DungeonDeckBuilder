## Abstract Class for all the various cards in the game.
## Provides basic, essential functionality and structure to the cards as well as the universal fields of all cards.
@abstract class_name Card extends Resource

## The name of the card.
@export var name : String = ""
## The card description.
@export var description : String = ""
## The cost to play the card.
@export var manaCost : float = 0.0
## The image displayed on the card.
@export var displayImage : Texture2D
## The conditions to play the card.
@export var conditions : Array[Condition] = []
## The tags this card has. Used to hold metadata about the card for effects and other cards.
@export var tags : Array[Tag] = [] 

## The effects currently applied to the card. 
var effects : Array[Effect]


## A signal emitted when the card is successfully played. If play() is called, the conditions
## must pass and the mana must be consumed before this signal is emitted.
signal card_played(entity : Entity, card : Card)


## Attempts to play the card. Returns true if the card was successfully played and can be discarded.
## Returns false if a condition was not met that prevents it from being played.
func play(entity : Entity) -> bool:
	if not _all_conditions_satisfied(entity): return false
	if not _consume_mana(entity): return false
	_perform_action(entity)
	card_played.emit(entity,self)
	return true


## Tests the conditions to play the card. If this returns false, the card cannot be played.
func _all_conditions_satisfied(entity : Entity) -> bool:
	for cond : Condition in conditions:
		if not cond.is_satisfied(entity) : 
			DebugLogger.debug("Condition not satisfied")
			return false
	return true

## Consumes the required mana to play the card. If this returns false, the card cannot be played.
func _consume_mana(entity : Entity) -> bool: 
	return entity.mana.consume(manaCost)

## Performs the cards actions. Only gets run if the conditions pass and there is enough mana.
@abstract 
func _perform_action(entity : Entity) -> void

## An enum for every kind of tag possible. 
##This avoids issues with strings such as misspellings, being similar but not identical, and being tedious.
enum Tag{FIRE,WATER,SPELL,MELEE,BOOST}
