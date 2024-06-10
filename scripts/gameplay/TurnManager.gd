extends Node
class_name TurnManager

var players: Array

signal next_player_turn

func next_turn():
	next_player_turn.emit()
