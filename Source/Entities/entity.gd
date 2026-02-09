class_name Entity extends CharacterBody2D


@export var deck : Deck
@export var mana : Mana
@export var health : Health
@export var hurtbox : Hurtbox
@export var pivot : Node2D


var attacking : bool = false
var keys : int = 0
signal attack_finished
signal died

func _ready() -> void:
	deck.setup(self)
	hurtbox.hurt.connect(health.damage)
	health.no_heath.connect(on_no_health)
	health.max_health.connect(on_max_health)
	mana.max_mana.connect(on_max_mana)

func get_forward() -> Vector2: return Vector2.UP.rotated(pivot.rotation)

func collect_item(item : Item):
	if item.name == "Key":
		DebugLogger.info("Key collected!")
		keys += 1
	elif item is Card:
		DebugLogger.info("%s Card collected!" % item.name)
		deck.add_card(item)

func on_no_health():
	died.emit()

func on_max_health():
	pass

func on_max_mana():
	pass

func finish_attack():
	attacking = false
	attack_finished.emit()
