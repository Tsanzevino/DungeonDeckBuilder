@abstract
class_name Boost extends Effect

enum Type{ADD,MULTIPLY,DIVIDE}

@export var boostDuration : int = 1
@export var boostAmount : float = 1
@export var boostType : Type = Type.MULTIPLY

func get_boosted_value(value : float) -> float:
	match boostType:
		Type.ADD:
			return value + boostAmount
		Type.MULTIPLY:
			return value * boostAmount
		Type.DIVIDE:
			return value / boostAmount
		_:
			return value

func get_unboosted_value(value : float) -> float:
	match boostType:
		Type.ADD:
			return value - boostAmount
		Type.MULTIPLY:
			return value / boostAmount
		Type.DIVIDE:
			return value * boostAmount
		_:
			return value
