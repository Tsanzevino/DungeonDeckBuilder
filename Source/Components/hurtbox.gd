## The hurtbox is what recieves the damage from a hitbox
class_name Hurtbox extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_layer = 32
	collision_mask = 16
	monitorable = false
	setup()

func setup() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
