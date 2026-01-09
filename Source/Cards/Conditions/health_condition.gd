## A condition to test the value of the players health.
class_name HealthCondition extends Condition

## Describes what type of test is being performed on the health value.
enum Type{
	TOTAL_LEFT ## at least [param value] health left
	,TOTAL_LOST ## at least [param value] health lost
	,PERCENTAGE_LEFT ## at least [param value]% health left
	,PERCENTAGE_LOST ## at least [param value]% health lost
	}

## This is the specific test being performed.
@export var type : Type = Type.PERCENTAGE_LEFT

## This value changes meaning depending on the type, either percent or a flat value.
@export var value : float = 0.5

func _test(player : Player) -> bool:
	var currentHealth : float = player.health.health
	match type:
		Type.TOTAL_LEFT:
			return currentHealth >= value
		Type.TOTAL_LOST:
			return currentHealth <= value
		Type.PERCENTAGE_LEFT:
			var percentHealth = currentHealth / player.health.maxHealth
			return percentHealth >= value
		Type.PERCENTAGE_LOST:
			var percentHealth = currentHealth / player.health.maxHealth
			return percentHealth <= value
		_:
			return false
