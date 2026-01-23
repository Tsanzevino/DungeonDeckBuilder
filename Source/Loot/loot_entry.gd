class_name LootEntry extends Resource

@export var conditions : Array[Condition]
@export var weight : int = 1
@export var item : Item

func conditions_passed(entity : Entity) -> bool:
	for cond in conditions:
		if not cond.is_satisfied(entity): return false
	return true

func loot(_entity : Entity) -> Item:
	return item
