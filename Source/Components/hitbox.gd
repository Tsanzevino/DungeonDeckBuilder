## The hitbox tells a hurtbox that it is within range of an attack
class_name Hitbox extends Area2D

signal attack_finished

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
	top_level = attack.topLevel
	
	if top_level:
		position = get_parent().global_position + attack.offset.rotated(get_parent().rotation)
	else:
		position = attack.offset
	setup()
	var timer : SceneTreeTimer = get_tree().create_timer(attack.windup)
	timer.timeout.connect(windup_finished.bind(cs))

func setup() -> void:
	pass

func windup_finished(cs : CollisionShape2D):
	cs.set_deferred("disabled", false)
	prepare_attack_tween()
	var timer : SceneTreeTimer = get_tree().create_timer(attack.duration)
	timer.timeout.connect(duration_finished)

func prepare_attack_tween():
	if attack.propertyTweenTemplates == null or attack.propertyTweenTemplates.size() == 0: return
	var tweener := create_tween()
	for twt in attack.propertyTweenTemplates:
		tweener.tween_property(self,twt.propertyPath, get_parent().global_position + (twt.finalValue + attack.offset).rotated(get_parent().rotation),twt.duration)

func duration_finished():
	attack_finished.emit()
	queue_free()
