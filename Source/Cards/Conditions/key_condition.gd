## A Condition to test if the player has a certain amount of keys
class_name KeyCondition extends Condition

@export var keyMinimum = 1

func _test(entity : Entity) -> bool:
	return (entity is Player) and entity.keys >= keyMinimum
