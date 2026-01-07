class_name Attack extends Resource

enum Target{EXCLUDE_USER, EXCLUDE_USER_TYPE,EVERYONE}

@export var damage : float
@export var aoe : Shape2D
@export var offset : Vector2
@export var duration : float
@export var windup : float
@export var damageTarget : Target
