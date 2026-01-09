## A Deck is a playable collection of cards. A deck in play consists of a Stock, Hand, and Discard pile.
## When a deck is played all the way through, it is reshuffled and played from the top.
class_name Deck extends Resource

## The positions in the deck a card can be.
## This enum helps in specifying in resources where to look for a card.
enum Position{HAND,DISCARD,STOCK,TOP_DISCARD,TOP_STOCK}

## A list of the cards in the deck in no particular order.
@export var cards : Array[Card] = []

## The current order of the drawing pile. Cards are drawn from the end of the Array.
var stock : Array[Card] = []

## The cards in the players hand. By default, a hand size is 5.
var hand : Array[Card] = []
@export var handSize : int = 5

## The cards that have been used. This is reshuffled once the player cannot draw (stock.size() == 0).
var discard : Array[Card] = []

## The owner of the deck.
var owner : Player

## Called by the owner to set up the deck.
func setup(p : Player) -> void:
	owner = p
	var newCards : Array[Card] = []
	for i in range(cards.size() - 1, -1,-1):
		newCards.append(cards[i].duplicate_deep(DeepDuplicateMode.DEEP_DUPLICATE_ALL))
	cards = newCards
	stock.append_array(cards)
	for n in handSize:
		hand.push_back(draw())

## Finds the card in the hand at [param index] and plays it, moving it to the discard and then drawing a new card.
func play_card(index : int) -> void:
	if index >= handSize: return
	var playedCard : Card = hand[index]
	if not playedCard.play(owner): return
	discard.push_back(playedCard)
	hand[index] = draw()

## Draws a new card from the stock.
## If there is not stock left, it will shuffle and then draw a card.
func draw() -> Card:
	if stock.size() > 0:
		return stock.pop_back()
	else:
		shuffle()
		return stock.pop_back()

## Shuffles the discard and recycles it into the stock.
func shuffle() -> void:
	discard.shuffle()
	stock.append_array(discard)
	discard = []

## A lookup function for finding cards with the Position enum.
func get_cards(position : Position) -> Array[Card]:
	if position == Position.HAND: return hand
	if position == Position.DISCARD: return discard
	if position == Position.STOCK: return stock
	if position == Position.TOP_DISCARD: return discard.back() if discard.back() != null else ([] as Array[Card])
	if position == Position.TOP_STOCK: return stock.back() if stock.back() != null else ([] as Array[Card])
	return []

## Converts the deck to string with better formatting.
func _to_string() -> String:
	var out : String = ""
	var counts : Dictionary[String, int] = {}
	for c in cards:
		if counts.has(c.name):
			counts[c.name] += 1
		else:
			counts[c.name] = 1
	for count : String in counts.keys():
		out += str(counts[count]) + " x " + count + ", "
	return out

## Converts the hand into a string.
func hand_to_string() -> String:
	var handStr : String = ""
	for i in hand.size() - 1:
		handStr += hand[i].name + ", "
	handStr += hand.back().name
	return handStr
