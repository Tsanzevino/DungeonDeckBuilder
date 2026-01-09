class_name WeaponBoost extends Effect

enum Type{ADD,MULTIPLY,DIVIDE}

@export var boostDuration : int = 1
@export var boostAmount : float = 1
@export var boostType : Type = Type.MULTIPLY

func apply(card : Card):
	if card.effects.has(self): return
	match boostType:
		Type.ADD:
			card.attack.damage += boostAmount
		Type.MULTIPLY:
			card.attack.damage *= boostAmount
		Type.DIVIDE:
			card.attack.damage /= boostAmount
	DebugLogger.debug("made damage on %s %d" % [card.name, card.attack.damage])
	card.card_played.connect(_on_card_played)
	card.effects.append(self)

func _on_card_played(_player : Player, card : Card):
	card.card_played.disconnect(_on_card_played)
	match boostType:
		Type.ADD:
			card.attack.damage -= boostAmount
		Type.MULTIPLY:
			card.attack.damage /= boostAmount
		Type.DIVIDE:
			card.attack.damage *= boostAmount
	DebugLogger.debug("made damage on %s %d" % [card.name, card.attack.damage])
	card.effects.pop_at(card.effects.find(self))
