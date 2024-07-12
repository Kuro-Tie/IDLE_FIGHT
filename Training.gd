extends Node

var MyScore = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AimButton.hide()
	$AimButton.disabled = true
	$Appear.start()
	
func _on_appear_timeout():
	$WinOrLose.hide()
	randomize()
	var x_axis = randi_range(0,1022)
	var y_axis = randi_range(0,518)
	$AimButton.position = Vector2(x_axis,y_axis)
	$AimButton.show()
	$AimButton.disabled = false



func _on_wait_timeout():
	get_tree().change_scene_to_file("res://idle_world.tscn")


func _on_aim_button_pressed():
	MyScore += 1
	$AimButton.hide()
	$AimButton.disabled = true
	$Appear.start() 
	if MyScore == 3:
		$Appear.stop()
		$Lose.stop()
		$WinOrLose.text = "You Leveled UP"
		$WinOrLose.show()
		StaticData.Player_Data["Player_data"]["Player_Attack"] = 50
		StaticData.Player_Data["Player_data"]["Player_Level"] = 2
		$Wait.start()

func _on_lose_timeout():
	$Appear.stop()
	$AimButton.hide()
	$AimButton.disabled = true
	$WinOrLose.show()
	$WinOrLose.text = "You Couldn't Level up."
	$Wait.start()

