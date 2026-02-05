class_name Stat extends Resource

@export var value : float :
	get():
		var effectedValue : float = value
		var i : int = 0
		while i < _effects.size():
			var effect := _effects[i]
			if effect.is_expired(): _effects.pop_at(i)
			else:
				effectedValue = effect.apply(effectedValue)
				i += 1
		return effectedValue

var _effects : Array[Effect]

func _init(n : float) -> void:
	value = n
	_effects = []

func add_effect(effect : Effect):
	_effects.push_back(effect.duplicate())
