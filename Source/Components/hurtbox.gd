## The hurtbox is what recieves the damage from a hitbox
class_name Hurtbox extends Area2D

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
	if area is Hitbox:
		pass
