class_name Mana extends Node

## The maximum mana that can be stored.
@export var maxMana : float = 100.0
## The cooldown time before mana begins to recharge after use.
@export var manaChargeCooldown : float = 0.5
## The constant rate that mana recharges at.
@export var manaChargeSpeed : float = 10
## The proportion of total mana that gets re-attributed every second.
## This effectively makes mana recharge faster near the top, 
## discouraging full mana expenditure. If negative, then mana will never reach the top
@export var manaAccRate : float = 0.5

var mana : float = maxMana
var timer : float

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

func _process(delta: float) -> void:
	timer += delta
	if mana == maxMana or timer < manaChargeCooldown: return
	mana += (manaChargeSpeed + mana * manaAccRate) * delta
	if mana >= maxMana:
		mana = maxMana
		max_mana.emit()
		DebugLogger.info("Mana Full")

signal max_mana

signal not_enough_mana
