extends Node


var Player_Level
var MyCoin = 0
var Player_Health
var Enemy_Health
var Attack_Player_Point
var Enemy_Attack_Player_Point

func _ready():
	Player_Health = StaticData.Player_Data["Player_data"]["Player_Health"]
	Attack_Player_Point = StaticData.Player_Data["Player_data"]["Player_Attack"]
	Player_Level = StaticData.Player_Data["Player_data"]["Player_Level"]
	Enemy_Health = 100
	Enemy_Attack_Player_Point = 1
	$Enemy.visible = true
	$Enemy.play("idle")
	$Labels/Player_Health.text = "Player Health =  " + str(Player_Health)
	$Labels/Attack_Point_Player.text = "Attack Point = " + str(Attack_Player_Point)
	$Labels/Level_Label.text = "Seviye = " + str(Player_Level)
	$Labels/Enemy_Health.text = "Enemy Health =  " + str(Enemy_Health)
	$Restore_Helath.disabled = true
	$Restore_Helath.hide()
	$Level_Up_Button.hide()
	$Level_Up_Button.disabled = true

func _on_fight_button_pressed():
	$Fight_Button.disabled = true
	$Timers/Enemy_attack_Timer.start()
	$Restore_Helath.visible = false
	$Restore_Helath.disabled = true
	$Timers/Health_Timer.stop()
	
func _attack_on_player():
	Player_Health = Player_Health - Enemy_Attack_Player_Point
	$Labels/Player_Health.text = "Player Health =  " + str(Player_Health)
	$Enemy.play("attack")
	$Player.play("damaged")
	
func _attack_on_enemy():
	Enemy_Health = Enemy_Health - Attack_Player_Point
	$Labels/Enemy_Health.text = "Enemy Health =  " + str(Enemy_Health)
	$Enemy.play("damaged")
	$Player.play("attack")

func _on_enemy_attack_timer_timeout():
	_attack_on_player()
	if Player_Health <= 0:
		print("You Lose")
		MyCoin = 0
	else:
		$Timers/Player_attack_Timer.start()


func _on_player_attack_timer_timeout():
	_attack_on_enemy()
	if Enemy_Health <= 0:
		MyCoin += 1
		$Labels/Coin_Label.text = "Coin = " + str(MyCoin)
		$Enemy.visible = false
		if MyCoin >= 2:
			$Restore_Helath.disabled = false
			$Restore_Helath.show()
		if MyCoin >= 5:
			$Level_Up_Button.show()
			$Level_Up_Button.disabled = false
		$Timers/Wait_Timer.start()
	else:
		$Timers/Enemy_attack_Timer.start()


func _on_wait_timer_timeout():
	$Enemy.visible = true
	$Player.play("idle")
	$Enemy.play("idle")
	_Reset_enemy_player()
	$Timers/Begin_Timer.start()

func _on_begin_timer_timeout():
	$Restore_Helath.visible = false
	$Restore_Helath.disabled = true

	$Timers/Enemy_attack_Timer.start()

func _Reset_enemy_player():
	Enemy_Health = 100
	Enemy_Attack_Player_Point = 1
	$Labels/Player_Health.text = "Player Health =  " + str(Player_Health)
	$Labels/Enemy_Health.text = "Enemy Health =  " + str(Enemy_Health)


func _on_restore_helath_pressed():
	$Restore_Helath.disabled = true
	$Player.play("idle")
	$Timers/Enemy_attack_Timer.stop()
	$Timers/Player_attack_Timer.stop()
	$Timers/Wait_Timer.stop()
	$Timers/Begin_Timer.stop()
	$Timers/Health_Timer.start()
	MyCoin -= 2
	$Labels/Coin_Label.text = "Coin = " + str(MyCoin)
	$Fight_Button.disabled = false
	if  MyCoin >= 5:
		pass
	else:
		$Level_Up_Button.hide()
		$Level_Up_Button.disabled = true


func _on_health_timer_timeout():
	if Player_Health <= 199:
		Player_Health += 1
		$Labels/Player_Health.text = "Player Health =  " + str(Player_Health)
	else:
		$Timers/Health_Timer.stop()
		_ready()


func _on_level_up_button_pressed():
	Player_Level += 1
	$Labels/Level_Label.text = "Seviye = " + str(Player_Level)
	MyCoin -= 5
	$Labels/Coin_Label.text = "Coin = " + str(MyCoin)
	if Player_Level == 2:
		get_tree().change_scene_to_file("res://training.tscn")
	$Level_Up_Button.disabled = true
	$Level_Up_Button.hide()

	if Player_Level == 3:
		Attack_Player_Point = 100
		$Labels/Attack_Point_Player.text = "Attack Point = " + str(Attack_Player_Point)

	if MyCoin >= 2:
		pass
	else:
		$Restore_Helath.disabled = true
		$Restore_Helath.visible = false
