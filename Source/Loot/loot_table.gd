class_name LootTable extends Resource

## If true, only the first pool from the array whose conditions pass will be looted.
## Change this to false if you want all pools to be available.
@export var firstAcceptedPool : bool = true
@export var pools : Array[LootPool]

func loot(entity : Entity) -> Array[Item]:
	var results : Array[Item] = []
	for pool in pools:
		if pool.conditions_passed(entity):
			results.append_array(pool.loot(entity))
			if firstAcceptedPool: return results
	return results
