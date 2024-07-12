extends Node

var Player_Data = {}

var data_file_path = "res://Data/Player_Data.json"

func _ready():
	Player_Data = load_json_file(data_file_path)

func load_json_file(filePath : String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("Error Reading file")
	else:
		print("File Does not exist")
