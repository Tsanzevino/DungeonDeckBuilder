## The hurtbox is what recieves the damage from a hitbox
class_name Hitbox extends Area2D

@export var attack : Attack

func _init(newAttack : Attack = attack) -> void:
	attack = newAttack
	collision_layer = 16
	collision_mask = 32
	monitoring = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cs : CollisionShape2D = CollisionShape2D.new()
	cs.shape = attack.aoe
	cs.set_deferred("disabled", true)
	add_child(cs)
	position = attack.offset
	setup()
	var timer : SceneTreeTimer = get_tree().create_timer(attack.windup)
	timer.timeout.connect(windup_finished.bind(cs))

func setup() -> void:
	pass

func windup_finished(cs : CollisionShape2D):
	cs.set_deferred("disabled", false)
	var timer : SceneTreeTimer = get_tree().create_timer(attack.duration)
	timer.timeout.connect(duration_finished)

func duration_finished():
	queue_free()
