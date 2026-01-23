class_name Interactor extends Area2D

const MAX_DOT : float = 0.90

@export var radius : int

var targets : Array[Interactable] = []
var bestTarget : Interactable

func _ready() -> void:
	assert(get_parent() is Entity)
	
	monitorable = false
	collision_layer = 64
	collision_mask = 128
	
	if find_children("*", "CollisionShape2D").size() == 0:
		var coll : CollisionShape2D = CollisionShape2D.new()
		coll.shape = CircleShape2D.new()
		coll.shape.radius = radius
		add_child(coll)
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and bestTarget != null:
		bestTarget.interact(get_parent())

func _physics_process(_delta : float):
	var newBestTarget : Interactable = get_best_target()
	if bestTarget == newBestTarget: return
	if bestTarget != null: bestTarget.set_active()
	if newBestTarget != null: newBestTarget.set_targetted()
	bestTarget = newBestTarget

func interact():
	bestTarget.interact(get_parent())

func _on_area_entered(area : Area2D):
	if not area is Interactable: return
	area.set_active()
	targets.push_back(area)

func _on_area_exited(area : Area2D):
	if not area is Interactable: return
	area.set_inactive()
	if area == bestTarget: bestTarget = null
	targets.remove_at(targets.find(area))

func get_best_target() -> Interactable:
	var forward : Vector2 = get_parent().get_forward()
	var newTarget : Interactable = null
	var highest_dot : float = MAX_DOT
	for target : Interactable in targets:
		# Creating Variables for readability.
		var targetPos : Vector2 = target.global_position
		var targetDirection = global_position.direction_to(targetPos)
		var dot := forward.dot(targetDirection)
		if dot > highest_dot:
			# Create a raycast to check if the pathway is clear
			# to the interactable
			var ray : RayCast2D = RayCast2D.new()
			ray.target_position = targetPos - global_position
			add_child(ray)
			ray.force_raycast_update()
			remove_child(ray)
			# Checks if clear before continuing
			if (!ray.is_colliding()):
				# Calculating the dot product from the forward vector of the camera
				# to the direction from player to target.
				# This dot product will be 1.0 if the player is looking directly
				# at the target.
				highest_dot = dot
				newTarget = target
	return newTarget
