extends Node
class_name Deck

enum DECK_TYPES { RIC, EGO, PRE, TOL, NET, END }

var deck_type: DECK_TYPES
var cards: Array[Card] = []

func _init(deck_type: DECK_TYPES, cards: Array[Card]):
	self.deck_type = deck_type
	self.cards = cards
