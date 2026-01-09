class_name Health extends Node

@export var maxHealth : float

@onready var health : float = maxHealth :
	set(value):
		health = clampf(value, 0, maxHealth)
		if health == 0: no_heath.emit()
		if health == maxHealth: max_health.emit()
		DebugLogger.info("%s is at %3.1f health" % [get_parent().name, health])

signal max_health
signal no_heath

func damage(amount : float):
	if amount < 0: DebugLogger.error("Damage amount should not be negative for function damage!")
	health -= amount

func heal(amount : float):
	if amount < 0: DebugLogger.error("Heal amount should not be negative for function heal!")
	health += amount
