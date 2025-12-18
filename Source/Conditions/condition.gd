@abstract
class_name Condition extends Resource

enum Effect{NONE,MULTIPLY,DIVIDE,ADD,SUBTRACT}

@abstract func is_satisfied(player : Player) -> bool
