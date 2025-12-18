class_name AttackCard extends Card

@export var attack : Attack

func success_action(player : Player) -> void:
	var hitbox = Hitbox.new(attack)
	player.add_child(hitbox)
	print(attack.damage)

func failure_action(_player : Player) -> void:
	name = "Broken " + name
	attack.damage = 0.0
