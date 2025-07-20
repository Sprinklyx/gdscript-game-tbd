extends Area2D

var Health = 15 
var Armor = 2 
var Damage = 1 
var  Level  = 2 
var DamageDealt 
	
func Attack():
	position.move_toward($Player.position, 0.0167) 

func OnBodyEntered():
	#attacks player
	DealingDamage() 
	

#enemy attack hhandler
signal AttackPlayer

#enemy attack damage
func DealingDamage():
	AttackPlayer.emit()
	DamageDealt = Damage - $Player.Armor 
	if (DamageDealt <= 0):
		push_error("Miss") 
	else:
		#player loses health
		$Player.Health -= DamageDealt 
		push_error("Player health = " + $Player.Health) 
	return DamageDealt 
	

#remove enemy sprite
func HealthDepleted():
	if (Health == 0):
		queue_free()

#set enemy start position
func Start(start_position):
	position = start_position 
	show() 
	
