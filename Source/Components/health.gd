class_name Health extends Node

@export var maxHealth : float

@onready var health : float = maxHealth

signal max_health
signal no_heath

func damage(amount : float):
	if amount < 0: DebugLogger.error("Damage amount should not be negative for function damage!")
	health = clampf(health - amount, 0, maxHealth)
	if health == 0: no_heath.emit()

func heal(amount : float):
	if amount < 0: DebugLogger.error("Heal amount should not be negative for function heal!")
	health = clampf(health + amount, 0, maxHealth)
	if health == maxHealth: max_health.emit()
