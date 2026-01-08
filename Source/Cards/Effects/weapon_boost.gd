class_name WeaponBoost extends Effect

enum Type{ADD,MULTIPLY,DIVIDE,EXPONENTIAL}

@export var boostDuration : int = 1
@export var boostAmount : float = 1
@export var boostType : Type = Type.MULTIPLY

func apply(card : Card):
	boostDuration -= 1
	card.attack.damage *= 2

func remove(card : Card):
	card.attack.damage /= 2

func is_expired() -> bool:
	return boostDuration < 0
