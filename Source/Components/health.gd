## Class for tracking health.
class_name Health extends Node

## The maximum health. Health cannot go over this value.
@export var maxHealth : Stat = Stat.new(0)
## The current health of the entity.
@onready var health : float = maxHealth.value :
	set(value):
		health = clampf(value, 0, maxHealth.value)
		health_changed.emit()
		if health == 0: no_heath.emit()
		if health == maxHealth.value: max_health.emit()
		DebugLogger.info("%s is at %3.1f health" % [get_parent().name, health])

## A signal emitted when it reaches max health, or when health is modified and clamped to max health.
signal max_health
## A signal emitted when it reaches no health, or when health is modified and clamped to zero.
signal no_heath
## A signal emitted when the health value is changed.
signal health_changed

## Takes a certain amount of damage.
func damage(amount : float):
	if amount < 0: DebugLogger.error("Damage amount should not be negative for function damage!")
	health -= amount

## Heals a certain amount of health.
func heal(amount : float):
	if amount < 0: DebugLogger.error("Heal amount should not be negative for function heal!")
	health += amount
