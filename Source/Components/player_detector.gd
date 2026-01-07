class_name PlayerDetector extends Area2D

@export var radius : float = 50.0

signal player_entered(player : Player)
signal player_exited(player : Player)

var players : Array[Player] = []
var nearestPlayer : Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var coll : CollisionShape2D = CollisionShape2D.new()
	coll.shape = CircleShape2D.new()
	coll.shape.radius = radius
	add_child(coll)
	monitorable = false
	collision_layer = 0
	collision_mask = 4
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)

func on_body_entered(body : PhysicsBody2D):
	player_entered.emit(body)
	if players.has(body): return
	players.append(body)
	if player_is_closer(body):
		nearestPlayer = body

func on_body_exited(body : PhysicsBody2D):
	player_exited.emit(body)
	
	if not players.has(body): return
	players.remove_at(players.find(body))
	
	if nearestPlayer != body: return
	nearestPlayer = null
	for player in players:
		if player_is_closer(player):
			nearestPlayer = player

func player_is_closer(player : Player) -> bool:
	return nearestPlayer == null or player.global_position.distance_squared_to(global_position) < nearestPlayer.global_position.distance_squared_to(global_position)
