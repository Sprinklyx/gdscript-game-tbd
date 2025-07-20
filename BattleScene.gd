extends GridContainer

func BattleUI(start_position):
	position = start_position
	show()

#add signal handler
signal Attack
func PlayerAttack():
	#send signal out
	Attack.emit()
