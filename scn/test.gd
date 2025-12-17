extends Node2D

@export var deck : Deck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck.setup()
	print(deck)
	deck.print_hand()
	print("played ", deck.play_card(0).name)
	deck.print_hand()
	print("played ", deck.play_card(0).name)
	deck.print_hand()
	print("played ", deck.play_card(0).name)
	deck.print_hand()
	print("played ", deck.play_card(0).name)
	deck.print_hand()
	print("played ", deck.play_card(0).name)
	deck.print_hand()
	print("played ", deck.play_card(0).name)
	deck.print_hand()
