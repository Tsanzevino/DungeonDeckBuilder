class_name AttackBoost extends Boost

func apply(card : Card):
	if card.effects.has(self): return
	card.attack.damage = get_boosted_value(card.attack.damage)
	DebugLogger.debug("made damage on %s %d" % [card.name, card.attack.damage])
	card.card_played.connect(_on_card_played)
	card.effects.append(self)

func _on_card_played(_player : Player, card : Card):
	card.card_played.disconnect(_on_card_played)
	card.attack.damage = get_unboosted_value(card.attack.damage)
	DebugLogger.debug("made damage on %s %d" % [card.name, card.attack.damage])
	card.effects.pop_at(card.effects.find(self))
