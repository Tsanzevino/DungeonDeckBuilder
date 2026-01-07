class_name Player extends CharacterBody2D

@export var deck : Deck
@onready var health : Health = %Health
@onready var mana : Mana = %Mana

var sprintDuration : float = 0.0

func _ready() -> void:
	deck.setup(self)
	%UserInterfaceManager.setup(mana, health, deck)
	%Hurtbox.hurt.connect(health.damage)
	health.no_heath.connect(on_no_health)
	health.max_health.connect(on_max_health)
	mana.max_mana.connect(on_max_mana)

func on_max_mana():
	pass

func on_no_health():
	pass

func on_max_health():
	pass

func add_sprint_duration(amount : float) -> void:
	sprintDuration += amount

func use_sprint(amount : float) -> void:
	sprintDuration = maxf(sprintDuration - amount, 0.0)

func can_sprint() -> bool:
	return Input.is_action_pressed("sprint") and sprintDuration > 0
