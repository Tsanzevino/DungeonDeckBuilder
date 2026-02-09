class_name Mana extends Node

## The maximum mana that can be stored.
@export var maxMana : Stat = Stat.new(100.0)
## The cooldown time before mana begins to recharge after use.
@export var manaChargeCooldown : Stat = Stat.new(1.0)
## The constant rate that mana recharges at.
@export var manaChargeSpeed : Stat = Stat.new(10.0)
## The proportion of total mana that gets re-attributed every second.
## This effectively makes mana recharge faster near the top, 
## discouraging full mana expenditure. If negative, then mana will never reach the top.
@export var manaAccRate : Stat = Stat.new(0.5)

@onready var mana : float = maxMana.value
## A timer for tracking the cooldown.
var timer : float = 0.0

## Consumes an amount of mana. If the amount cannot be consumed, the function passes false
## and mana remains unchanged. If there is enough mana, it is consumed and returns true.
func consume(amount : float) -> bool:
	if not can_consume(amount): 
		if amount < 0: DebugLogger.error("Mana amount should not be negative for consume mana!")
		elif mana < amount: 
			DebugLogger.info("Mana could not be consumed: Not enough mana.")
			not_enough_mana.emit()
		return false
	mana -= amount
	timer = 0
	return true

## Tests if the amount of mana is available for use.
func can_consume(amount : float) -> bool:
	return amount >= 0 and mana >= amount

## Takes care of the timer and mana regeneration.
func _process(delta: float) -> void:
	# Increases the timer and checks if mana can be regenerated.
	timer += delta
	if mana == maxMana.value or timer < manaChargeCooldown.value: return
	# Increases the mana per second by a flat rate + the current mana * an acceleration rate.
	mana += (manaChargeSpeed.value + mana * manaAccRate.value) * delta
	# Clamps the mana to max mana and sends out a signal.
	if mana >= maxMana.value:
		mana = maxMana.value
		DebugLogger.info("Mana Full")
		max_mana.emit()

## Emitted when the mana is full.
signal max_mana

## Emitted if there is not enough mana when trying to consume mana.
signal not_enough_mana
