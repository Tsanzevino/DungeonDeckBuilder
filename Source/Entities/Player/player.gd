class_name Player extends Entity

var sprintDuration : float = 0.0

func _ready() -> void:
	super()
	%UserInterfaceManager.setup(mana, health, deck)
	print(health.health)

func add_sprint_duration(amount : float) -> void:
	sprintDuration += amount

func use_sprint(amount : float) -> void:
	sprintDuration = maxf(sprintDuration - amount, 0.0)

func can_sprint() -> bool:
	return Input.is_action_pressed("sprint") and sprintDuration > 0
