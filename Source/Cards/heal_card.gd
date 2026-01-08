class_name HealCard extends Card

@export var healAmount : float = 1.0

func play(player : Player) -> bool:
	if player.health.health == player.health.maxHealth: return false
	if not consume_mana(player): return false
	player.health.heal(healAmount)
	return true
