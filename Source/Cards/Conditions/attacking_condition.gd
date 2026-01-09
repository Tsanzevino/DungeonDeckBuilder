## A Condition to test if the player is attacking.
class_name AttackingCondition extends Condition

func _test(player : Player) -> bool:
	return player.attacking
