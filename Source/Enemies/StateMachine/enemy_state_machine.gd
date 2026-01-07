class_name EnemyStateMachine extends StateMachine

func _ready() -> void:
	for state_node : EnemyState in find_children("*", "EnemyState"):
		state_node.finished.connect(_transition_to_next_state)
		state_node.enemy = owner
	
	await owner.ready
	state.enter("")
