class_name Interactable extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = PlaceholderTexture2D.new()
	sprite.z_index = 1
	sprite.texture.size = Vector2i(64,64)
	var coll : CollisionShape2D = CollisionShape2D.new()
	coll.shape = CircleShape2D.new()
	coll.shape.radius = 32
	collision_mask = 4
	add_child(coll)
	add_child(sprite)
	body_entered.connect(collect)

func collect(player : Player) -> void:
	print("hello")
	player.keys += 1
	queue_free()
