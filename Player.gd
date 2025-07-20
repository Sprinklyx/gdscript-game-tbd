extends CharacterBody2D

var startingHealth
var Health = 10
var Armor = 0
var Damage = 5
var Level = 1
var DamageDealt

	
var currentScene
@export var Speed = 50

var starting_position

var ScreenSize

#set player start position
func BattleStart(start_position):
	position = start_position
	show()

#start logic for enemy turn
signal TurnOver

#player attack
func AttackDamage():
	
	#player attack logic
	var target = get_node("../Mob").position
	move_and_collide(target)
	push_error("Hit!")
	push_error(DealingDamage())

	Resetposition()
	TurnOver.emit()

#damage dealt to enemy is recorded
func DealingDamage():
	DamageDealt = Damage - get_node("../Mob").Armor
	if (DamageDealt <= 0):
		push_error("Miss")
	else:
		#enemy health lost
		get_node("../Mob").Health -= DamageDealt  
		push_error("current health is ", get_node("../Mob").Health)
		
	return DamageDealt
		
#return player to pre-attack position
func Resetposition():
	position = starting_position

#return to town
func HealthDepleted():
	if (Health == 0):
		currentScene = "res://Town.tscn"
		#load(currentScene)
  

func _ready():
	ScreenSize = get_viewport_rect().size
	currentScene = get_tree().current_scene.scene_file_path
	push_error(currentScene);
	position = Vector2(100, 370)
	starting_position = position
	
func _process(delta):
	var PlayerVelocity = Vector2.ZERO
	if (currentScene == "res://Town.tscn"):
		if (Input.is_action_pressed(&"move_right")):
			PlayerVelocity.X += 1
		if (Input.is_action_pressed(&"move_left")):
			PlayerVelocity.X -= 1
		if (Input.is_action_pressed(&"move_down")):
			PlayerVelocity.Y += 1
		if (Input.is_action_pressed(&"move_up")):
			PlayerVelocity.Y -= 1;
			
		$Player.show()
		if (PlayerVelocity.Length() > 0):
			PlayerVelocity = PlayerVelocity.Normalized() * Speed
		position += PlayerVelocity * delta
		position = position.clamp(Vector2.ZERO, ScreenSize)
