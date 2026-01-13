extends Control

var selectedCard : int = 0
var swapCard : int = 0
var deck : Deck

func setup(d : Deck):
	deck = d
	for n in deck.handSize:
		var cardUI := CardUserInterface.new(deck.hand[n])
		%Cards.add_child(cardUI)
	@warning_ignore("integer_division")
	selectedCard = deck.handSize / 2
	%Cards.get_child(selectedCard).select_card()
	update_stock()
	update_discard()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Check swap
	if Input.is_action_just_pressed("swap_card"):
		swapCard = selectedCard
	if Input.is_action_just_released("swap_card") and selectedCard != swapCard:
		deck.swap_cards(swapCard, selectedCard)
		update_hand()
	# Check select
	if Input.is_action_just_pressed("select_first_card"):
		select_card(0)
	elif Input.is_action_just_pressed("select_last_card"):
		select_card(deck.handSize - 1)
	elif Input.is_action_just_pressed("select_left_card"):
		select_card(clampi(selectedCard - 1,0,deck.handSize - 1))
	elif Input.is_action_just_pressed("select_right_card"):
		select_card(clampi(selectedCard + 1,0,deck.handSize - 1))
	# Check play card
	if Input.is_action_just_pressed("use_card"):
		play_card()

func select_card(index : int):
	%Cards.get_child(selectedCard).deselect_card()
	%Cards.get_child(index).select_card()
	selectedCard = index
	DebugLogger.info("Selected card #%s: %s" % [index + 1, deck.hand[selectedCard].name])

func play_card():
	deck.play_card(selectedCard)
	update_hand()
	update_discard()
	update_stock()

func update_hand():
	for i in deck.handSize: %Cards.get_child(i).update_card(deck.hand[i])

func update_discard():
	if deck.discard.size() == 0: 
		%DiscardTop.texture = null
		%DiscardCount.text = ""
	else: 
		%DiscardTop.texture = deck.discard.back().displayImage
		%DiscardCount.text = str(deck.discard.size())

func update_stock():
	if deck.stock.size() == 0: 
		%StockTop.texture = null
		%StockCount.text = ""
	else: 
		%StockTop.texture = deck.stock.back().displayImage
		%StockCount.text = str(deck.stock.size())
