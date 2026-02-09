@abstract
class_name Buff extends Effect

enum Type{ADD,MULTIPLY,DIVIDE}

@export var buffAmount : float = 1
@export var buffType : Type = Type.MULTIPLY

func apply(value : float) -> float:
	match buffType:
		Type.ADD: return value + buffAmount
		Type.MULTIPLY: return value * buffAmount
		Type.DIVIDE: return value / buffAmount
		_: return value

@abstract func update_expiration()
