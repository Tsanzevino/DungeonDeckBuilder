@abstract
class_name Card extends Resource

@export var name : String = ""
@export var description : String = ""

@export var conditions : Array[Condition] = []
@export var conditionEffect : Condition.Effect = Condition.Effect.NONE
@export var conditionValue : float
@export var tags : Array[Tag] = []

@abstract func success_action(player : Player) -> void
@abstract func failure_action(player : Player) -> void

func play(player : Player) -> void:
	if all_conditions_satisfied(player): success_action(player)
	else: failure_action(player)

func all_conditions_satisfied(player : Player) -> bool:
	for cond : Condition in conditions:
		if not cond.is_satisfied(player) : return false
	return true
