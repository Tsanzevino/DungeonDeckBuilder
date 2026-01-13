class_name StatusEffect extends Resource

enum Type{NONE,BURN,FREEZE,STUN,POISON,CONFUSION}

@export var type : Type = Type.NONE
@export var duration : float = 0.0
