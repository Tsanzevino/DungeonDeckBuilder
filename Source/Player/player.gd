class_name Player extends CharacterBody2D

@export var deck : Deck
@onready var health : Health = %Health
@onready var mana : Mana = %Mana

func _ready() -> void:
	deck.setup(self)
	%UserInterfaceManager.setup(mana, health, deck)
	health.no_heath.connect(on_no_health)
	health.max_health.connect(on_max_health)
	mana.max_mana.connect(on_max_mana)

func on_max_mana():
	pass

func on_no_health():
	pass

func on_max_health():
	pass
