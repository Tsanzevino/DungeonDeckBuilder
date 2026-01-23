class_name Chest extends Interactable

@export var lootTable : LootTable
var opened : bool = false

func _on_interact(entity : Entity) -> void:
	if opened : return
	#opened = true
	var loot : Array[Item] = lootTable.loot(entity)
	for item in loot:
		entity.collect_item(item)

func set_active():
	pass

func set_targetted():
	pass

func set_inactive():
	pass
