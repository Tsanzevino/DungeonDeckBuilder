## A Resource to Describe an attack. These are used to create hitboxes that deal the damage.
class_name Attack extends Resource

## The targets that can be hit by an attack.
enum Target{
	EXCLUDE_USER, ## Exclude the user from being able to take damage from this attack.
	EXCLUDE_USER_TYPE, ## Exclude entities that match the user's type from this attack.
	EVERYONE ## No one is safe >:)
	}

@export var damage : Stat = Stat.new(1.0) ## How much damage the attack deals.

@export var duration : Stat = Stat.new(0.1) ## How long the attack will last.
@export var windup : Stat = Stat.new(0.1) ## The time it takes to start the attack after initiating it.
@export var offset : Vector2 = Vector2.ZERO ## The offset from the user when attacking.
@export var movement : Vector2 = Vector2.ZERO ## The movement vector traveled each second.
@export var aoe : Shape2D ## The hitboxes shape, A.K.A. the area of effect.
@export var damageTarget : Target ## The target of the attack
@export var topLevel : bool = false ## Whether this attack should follow the user. True means it should not.
