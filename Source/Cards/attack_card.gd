class_name AttackCard extends Card

static var attackInProgress : bool = false

@export var attack : Attack
@export var breakChance : float = 0.0

func play(player : Player) -> bool:
	if attackInProgress: return false
	if not consume_mana(player): return false
	if is_broken(): return true
	start_attack(player)
	return true

func is_broken() -> bool:
	if tags.has(Card.Tag.BROKEN): return true
	elif randf() < breakChance:
		DebugLogger.info("Your " + name + " just broke :O")
		name = "Broken " + name
		tags.push_back(Card.Tag.BROKEN)
		attack.damage = 0.0
		manaCost = 0.0
	return false

func start_attack(player : Player):
	attackInProgress = true
	var hitbox = Hitbox.new(attack)
	player.add_child(hitbox)
	hitbox.attack_finished.connect(on_attack_finished)

func on_attack_finished():
	attackInProgress = false
