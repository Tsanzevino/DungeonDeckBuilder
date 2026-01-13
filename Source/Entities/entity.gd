class_name Entity extends CharacterBody2D


@export var deck : Deck
@export var mana : Mana
@export var health : Health
@export var hurtbox : Hurtbox
@export var pivot : Node2D

var attacking : bool = false

func _ready() -> void:
	deck.setup(self)
	hurtbox.hurt.connect(health.damage)
	health.no_heath.connect(on_no_health)
	health.max_health.connect(on_max_health)
	mana.max_mana.connect(on_max_mana)

func on_no_health():
	pass

func on_max_health():
	pass

func on_max_mana():
	pass
