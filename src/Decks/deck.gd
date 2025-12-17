## A Deck is a playable collection of cards. A deck in play consists of a Stock, Hand, and Discard pile.
## When a deck is played all the way through, it is reshuffled and played from the top.
class_name Deck extends Resource

## A list of the cards in the deck in no particular order.
@export var cards : Array[Card] = []

## The current order of the drawing pile. Cards are drawn from the end of the Array.
var stock : Array[Card] = []

## The cards in the players hand. By default, a hand size is 5.
var hand : Array[Card] = []
@export var handSize : int = 5

## The cards that have been used. This is reshuffled once the player cannot draw (stock.size() == 0)
var discard : Array[Card] = []

func setup() -> void:
	stock.append_array(cards)
	for n in handSize:
		hand.push_back(draw())

func play_card(index : int) -> Card:
	if index >= handSize: return null
	var usedCard : Card = hand[index]
	discard.push_back(usedCard)
	hand[index] = draw()
	return usedCard

func draw() -> Card:
	if stock.size() > 0:
		return stock.pop_back()
	else:
		shuffle()
		return stock.pop_back()

func shuffle() -> void:
	while discard.size() > 0:
		stock.push_back(discard.pop_at(randi() % discard.size()))

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

func print_hand():
	var printStr : String = ""
	for c in hand:
		printStr += c.name + ", "
	print(printStr)
