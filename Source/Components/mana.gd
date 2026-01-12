class_name Mana extends Node

## The maximum mana that can be stored.
@export var maxMana : float = 100.0
## The cooldown time before mana begins to recharge after use.
@export var manaChargeCooldown : float = 0.5
## The constant rate that mana recharges at.
@export var manaChargeSpeed : float = 10
## The proportion of total mana that gets re-attributed every second.
## This effectively makes mana recharge faster near the top, 
## discouraging full mana expenditure. If negative, then mana will never reach the top.
@export var manaAccRate : float = 0.5

## The current mana value.
var mana : float = maxMana
## A timer for tracking the cooldown.
var timer : float

## Consumes an amount of mana. If the amount cannot be consumed, the function passes false
## and mana remains unchanged. If there is enough mana, it is consumed and returns true.
func consume(amount : float) -> bool:
	if amount < 0: DebugLogger.error("Mana amount should not be negative for consume mana!")
	if amount == 0.0: return true
	if mana - amount < 0: 
		DebugLogger.info("Mana could not be consumed: Not enough mana.")
		not_enough_mana.emit()
		return false
	mana -= amount
	timer = 0
	return true

## Takes care of the timer and mana regeneration.
func _process(delta: float) -> void:
	# Increases the timer and checks if mana can be regenerated.
	timer += delta
	if mana == maxMana or timer < manaChargeCooldown: return
	# Increases the mana per second by a flat rate + the current mana * an acceleration rate.
	mana += (manaChargeSpeed + mana * manaAccRate) * delta
	# Clamps the mana to max mana and sends out a signal.
	if mana >= maxMana:
		mana = maxMana
		max_mana.emit()
		DebugLogger.info("Mana Full")

## Emitted when the mana is full.
signal max_mana

## Emitted if there is not enough mana when trying to consume mana.
signal not_enough_mana
