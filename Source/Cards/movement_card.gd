class_name SprintCard extends Card

@export var duration : float

func play(player : Player) -> bool:
	if not consume_mana(player): return false
	player.add_sprint_duration(duration)
	return true
