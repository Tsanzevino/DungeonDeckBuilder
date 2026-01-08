class_name Attack extends Resource

enum Target{EXCLUDE_USER, EXCLUDE_USER_TYPE,EVERYONE}

@export var damage : float = 1.0
@export var duration : float = 0.1
@export var windup : float = 0.1
@export var offset : Vector2 = Vector2.ZERO
@export var aoe : Shape2D
@export var propertyTweenTemplates : Array[PropertyTweenTemplate]
@export var damageTarget : Target
@export var topLevel : bool = false
