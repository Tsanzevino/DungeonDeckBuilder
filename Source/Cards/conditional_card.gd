@abstract
class_name ConditionalCard extends Card

@export var conditions : Array[Condition] = []

func all_conditions_satisfied(player : Player) -> bool:
	for cond : Condition in conditions:
		if not cond.is_satisfied(player) : return false
	return true
