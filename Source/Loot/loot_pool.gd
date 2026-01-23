class_name LootPool extends Resource

@export var rolls : int = 1
@export var conditions : Array[Condition]
@export var entries : Array[LootEntry]

func loot(entity : Entity) -> Array[Item]:
	# Select all entries whose conditions pass
	var passingPool : Array[LootEntry] = []
	for entry : LootEntry in entries:
		if entry.conditions_passed(entity):
			passingPool.append(entry)
	if passingPool.size() == 0: return []
	# Roll the resulting pool n times.
	var result : Array[Item] = []
	for n in rolls: result.append(roll(passingPool).loot(entity))
	# Return the result
	return result

func roll(pool : Array[LootEntry]) -> LootEntry:
	# Create an array of indices with each entry getting n entries
	# where n is equal to its weight value.
	var lottery : Array[int] = []
	for i in pool.size(): for n in pool[i].weight: lottery.push_back(i)
	# Select one entry randomly from that lottery pool and return
	# the resulting indexed entry from the pool.
	var result = lottery[randi() % lottery.size()]
	return pool[result]

func conditions_passed(entity : Entity) -> bool:
	for cond in conditions: if not cond.is_satisfied(entity): return false
	return true
