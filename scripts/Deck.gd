extends Node
class_name Deck

enum DECK_TYPES { RIC, EGO, PRE, TOL, NET, END }

var deck_type: DECK_TYPES
var cards: Array[CardData] = []

func _init(deck_type: DECK_TYPES, cards: Array[CardData]):
	self.deck_type = deck_type
	self.cards = cards
