## The hurtbox is what recieves the damage from a hitbox
class_name Hurtbox extends Area2D

signal hurt(amount : float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_layer = 32
	collision_mask = 16
	monitorable = false
	area_entered.connect(on_area_entered)
	setup()

func setup() -> void:
	pass

func on_area_entered(area : Area2D) -> void:
	if not (area is Hitbox): return
	print("hitbox entered hurtbox")
	var damage = get_damage(area,area.attack.damageTarget)
	if damage != 0: hurt.emit(damage)

func get_damage(hitbox : Hitbox, target : Attack.Target) -> float:
	if target == Attack.Target.EXCLUDE_USER and owner == hitbox.owner: return 0
	if target == Attack.Target.EXCLUDE_USER_TYPE and owner.collision_layer == hitbox.owner.collision_layer: return 0
	return hitbox.attack.damage
