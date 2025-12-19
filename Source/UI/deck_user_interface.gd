extends Control

var selectedCard : int = 2
var deck : Deck

func setup(d : Deck):
	deck = d

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("select_first_card"):
		select_card(0)
	elif Input.is_action_just_pressed("select_last_card"):
		select_card(deck.handSize - 1)
	elif Input.is_action_just_pressed("select_left_card"):
		select_card(clampi(selectedCard - 1,0,deck.handSize - 1))
	elif Input.is_action_just_pressed("select_right_card"):
		select_card(clampi(selectedCard + 1,0,deck.handSize - 1))
	if Input.is_action_just_pressed("use_card"):
		deck.play_card(selectedCard)

func select_card(index : int):
	selectedCard = index
	DebugLogger.info("Selected card #%s: %s" % [index + 1, deck.hand[selectedCard].name])
