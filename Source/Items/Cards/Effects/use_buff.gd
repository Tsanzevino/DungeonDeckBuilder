class_name UseBuff extends Buff

@export var buffDuration : int = 1

func is_expired() -> bool:
	return buffDuration <= 0

func update_expiration():
	buffDuration -= 1
