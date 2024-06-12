extends Node

@export var players: Array
@export var dead_players: Array

func get_player(targetFaction: Faction.FACTION_TYPES, isDead: bool):
	if isDead:
		for player in dead_players:
			if player.faction == targetFaction:
				return player
	else:
		for player in players:
			if player.faction == targetFaction:
				return player

func add_player(player):
	players.append(player)
	add_child(player)

# Sostituire con il tiro di 3 d12 per ogni player
func set_faction_order():
	var index = 0
	players.shuffle()
	for player in players:
		print("Faction " + str(index) + ": " + str(player.faction))
		index += 1
