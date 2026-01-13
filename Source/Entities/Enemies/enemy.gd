class_name Enemy extends Entity

func on_no_health() -> void:
	queue_free()

func player_spotted() -> bool:
	return %ChaseRange.nearestPlayer != null

func player_in_range() -> bool:
	return %AttackRange.nearestPlayer != null

func player_too_close() -> bool:
	return %FleeRange.nearestPlayer != null

func nearest_player() -> Player:
	return %ChaseRange.nearestPlayer

func get_nav() -> NavigationAgent2D:
	return %NavigationAgent2D
