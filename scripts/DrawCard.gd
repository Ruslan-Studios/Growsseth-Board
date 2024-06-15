extends Button

@onready var card_inv = $"../../../MarginContainer/VBoxContainer/InventoryContainer/CardInv"
@onready var matchUI = $"../../.."
@export var card_scene: PackedScene

func _on_pressed():
	var card_instance = card_scene.instantiate()
	print("Size: ", card_instance.size )
	print("Size2: ", card_instance.get_child(0).size )
	card_instance.get_child(0).size = card_instance.size
	
	matchUI.get_node("Plancia").add_child(card_instance)
