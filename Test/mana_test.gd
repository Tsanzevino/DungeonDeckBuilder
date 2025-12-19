extends Node

@onready var mana : Mana = get_child(0)
var currentTest : String
func _ready() -> void:
	mana.max_mana.connect(test_one)
	mana.mana = 0
	Stopwatch.start("Mana Full Refill")

func test_one() -> void:
	Stopwatch.stop("Mana Full Refill")
	mana.max_mana.disconnect(test_one)
	mana.max_mana.connect(test_two)
	mana.consume_mana(mana.maxMana / 2.0)
	Stopwatch.start("Mana Half Refill")

func test_two() -> void:
	Stopwatch.stop("Mana Half Refill")
