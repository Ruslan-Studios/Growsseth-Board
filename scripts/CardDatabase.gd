extends Node

var cache: Dictionary

@export_dir var cards_folder

func _ready():
	var folder = DirAccess.open(cards_folder)
	folder.list_dir_begin()
	
	var file_name = folder.get_next()
	
	while file_name != "":
		cache[file_name] = load(cards_folder + "/" + file_name)
		file_name = folder.get_next()
