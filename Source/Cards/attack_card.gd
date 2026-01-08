class_name AttackCard extends Card

@export var attack : Attack
@export var breakChance : float = 0.0

func play(player : Player) -> bool:
	if player.attacking: return false
	if not consume_mana(player): return false
	if is_broken(): return true
	apply_effects()
	start_attack(player)
	return true

func is_broken() -> bool:
	if tags.has(Card.Tag.BROKEN): return true
	elif randf() < breakChance:
		DebugLogger.info("Your " + name + " just broke :O")
		name = "Broken " + name
		attack.damage = 0
		tags.push_back(Card.Tag.BROKEN)
		manaCost = 0.0
	return false

func start_attack(player : Player):
	player.attacking = true
	var hitbox = Hitbox.new(attack)
	player.add_child(hitbox)
	hitbox.attack_finished.connect(on_attack_finished.bind((player)))

func on_attack_finished(player : Player):
	player.attacking = false
