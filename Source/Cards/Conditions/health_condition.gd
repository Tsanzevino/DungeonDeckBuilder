class_name HealthCondition extends Condition

enum Type{TOTAL_LEFT,TOTAL_LOST,PERCENTAGE_LEFT,PERCENTAGE_LOST}

@export var type : Type = Type.PERCENTAGE_LEFT

@export var value : float = 50.0

func is_satisfied(player : Player) -> bool:
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
