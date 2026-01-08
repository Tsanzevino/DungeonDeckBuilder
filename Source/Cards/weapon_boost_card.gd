class_name BoostCard extends ConditionalCard

@export var target : Deck.Position
@export var boostEffects : Array[Effect]

func play(player : Player) -> bool:
	if not all_conditions_satisfied(player): 
		print("cond not satisfied")
		return false
	if not consume_mana(player) : 
		print("no mana")
		return false
	for card in player.deck.get_cards(target):
		card.effects.append_array(boostEffects)
	return true
