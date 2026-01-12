## Detects players inside the specified radius and tracks the nearest player.
class_name PlayerDetector extends Area2D

## The radius to detect within.
@export var radius : float = 50.0

## Emitted when a player enters the radius.
signal player_entered(player : Player)
## Emitted when a player exits the radius.
signal player_exited(player : Player)

## The players within the radius.
var players : Array[Player] = []
## The nearest player within the radius.
var nearestPlayer : Player = null

func _ready() -> void:
	# Creates a circle collider with the specified radius.
	var coll : CollisionShape2D = CollisionShape2D.new()
	coll.shape = CircleShape2D.new()
	coll.shape.radius = radius
	add_child(coll)
	# It is meant to monitor only, so turn that off and make the mask track players.
	monitorable = false
	collision_layer = 0
	collision_mask = 4
	# Connect the signals
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)


func on_body_entered(body : PhysicsBody2D):
	# Emit the detected player.
	player_entered.emit(body)
	# If we already contain the player somehow, return.
	if players.has(body): return
	# Add the player to the list.
	players.append(body)
	# Check if it is closer than the current nearest player 
	# and update accordingly.
	if player_is_closer(body):
		nearestPlayer = body


func on_body_exited(body : PhysicsBody2D):
	# Emit the detected player.
	player_exited.emit(body)
	# If we already don't have it somehow, return.
	if not players.has(body): return
	# Remove the player from the list.
	players.remove_at(players.find(body))
	# If the player we removed was the nearest player, find the new nearest player.
	if nearestPlayer != body: return
	nearestPlayer = null
	for player in players:
		if player_is_closer(player):
			nearestPlayer = player

## Determines if a player is closer than the current nearest player.
func player_is_closer(player : Player) -> bool:
	return nearestPlayer == null or player.global_position.distance_squared_to(global_position) < nearestPlayer.global_position.distance_squared_to(global_position)
