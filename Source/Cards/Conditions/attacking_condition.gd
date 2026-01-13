## A Condition to test if the player is attacking.
class_name AttackingCondition extends Condition

func _test(entity : Entity) -> bool:
	return entity.attacking
