## The hurtbox is what recieves the damage from a hitbox
class_name Hurtbox extends Area2D

## Emitted when the hitbox is hurt, and handled by the entity it's attached to.
signal hurt(amount : float)

## Sets up the hurtbox.
func _ready() -> void:
	collision_layer = 32
	collision_mask = 16
	monitorable = false
	area_entered.connect(on_area_entered)

## Called when an area enteres the hurtbox, and does damage if it is a hitbox.
func on_area_entered(area : Area2D) -> void:
	if not (area is Hitbox): return
	var damage = get_damage(area,area.attack.damageTarget)
	if damage != 0: hurt.emit(damage)

## Determines how much damage to deal based on the attack target.
func get_damage(hitbox : Hitbox, target : Attack.Target) -> float:
	if target == Attack.Target.EXCLUDE_USER and get_parent() == hitbox.get_parent().get_parent():
		return 0
	if target == Attack.Target.EXCLUDE_USER_TYPE and owner.collision_layer == hitbox.owner.collision_layer:
		return 0
	return hitbox.attack.damage.value
