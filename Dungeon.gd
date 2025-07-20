extends Node



func _Ready():
	
	EnterBattle()
		
func OnMobAttackPlayer():
	$Mob.Start($MobStart.position)
	var attackRoute = get_node(^"MobPath/MobPathFollow")
	attackRoute.progress = randi()
	#set mob's attack pattern
	#var mobAttackPath = get_node(^"MobPath/MobPathFollow")


	#logic for after player turn
func OnPlayerTurnOver():
	$MobAttack.start()
	if ($MobAttack.is_stopped()):
		OnMobAttackPlayer()
		



func EnterBattle():
	#adding player to scene
	#player start position
	$Player.BattleStart($PlayerStart.position)
	
	#adding enemy to scene
	#mob start position
	$Mob.Start($MobStart.position)
	
	#adding battle ui to scene
	#adding visible ui location
	$BattleScene.BattleUI($UIMarker.position)
	
