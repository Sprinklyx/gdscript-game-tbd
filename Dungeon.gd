extends Node



func _Ready():
	
	EnterBattle()
		
func OnMobAttackPlayer():
	$Mob.Start($MobStart.position)
	var attackRoute = get_node(^"MobPath/MobPathFollow")
	attackRoute.progress_ratio += 0.1 * 0.0167
	#set mob's attack pattern



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
	
func on_mob_attack_timeout() -> void():
  OnMobAttackPlayer()
  
func _process(delta):
  on_mob_attack_timeout()