extends TextureProgressBar

@export var health : Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = health.maxHealth.value
	value = health.health
	health.health_changed.connect(update_display)

func update_display():
	value = health.health
