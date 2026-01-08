class_name RandomCondition extends Condition

@export_range(0.0,1.0,0.01) var chance : float = 0.5

func is_satisfied(player : Player) -> bool:
	return randf() <= chance
