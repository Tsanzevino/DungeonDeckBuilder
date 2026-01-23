@abstract
class_name Interactable extends Area2D

@export var interactRadius : int
signal interacted(entity : Entity)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if find_children("*", "CollisionShape2D").size() == 0:
		var coll : CollisionShape2D = CollisionShape2D.new()
		coll.shape = CircleShape2D.new()
		coll.shape.radius = interactRadius
		add_child(coll)
	monitoring = false
	collision_layer = 128
	collision_mask = 64

func interact(entity : Entity) -> void:
	interacted.emit(entity)
	_on_interact(entity)

@abstract func _on_interact(entity : Entity) -> void

@abstract func set_active()

@abstract func set_targetted()

@abstract func set_inactive()
