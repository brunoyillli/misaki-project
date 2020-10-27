extends KinematicBody2D

var pre_bullet = preload("res://Bullet_player/bullet_player.tscn")

onready var joystick = get_node("Hud/Joystick/Joystick_button")

var speed = 250

var vel := Vector2(0, 0)

var max_health = 5
var health = 3

var newDeltaX
var newDeltaY
var deltaX
var deltaY
var touchPos = Vector2()
var areaEnt = false

enum {RUNNING, DEAD, VICTORY}
var status = RUNNING

#shoot timer
var canShoot = true
var canHurt = true

func _ready():
	add_to_group("player")
	if(OS.get_name() == "Windows"):
		$Hud/Joystick.hide()
		
# warning-ignore:unused_argument
func _physics_process(delta):
	if status == RUNNING:
		running()
#	elif status == DEAD:
#		dead(delta)


#func _input(event):
#	if areaEnt == true:
#		if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
#			var bullet = pre_bullet.instance()
#			bullet.global_position = $muzzle.global_position
#			get_parent().add_child(bullet)
#			touchPos = event.get_position()
#			deltaX = touchPos.x - position.x
#			deltaY = touchPos.y - position.y
#	pass
	
#func _process(delta):
	#move_and_slide(joystick.get_value() * speed)
#	pass
	
func running():
	var dirVec := Vector2(0, 0)
	
	# verifica se tem tantos elementos no grupo bullet
	if get_tree().get_nodes_in_group("bullet_player").size() <= 64:
		if (Input.is_action_pressed("ui_ataque") or areaEnt == true) and canShoot:
				var bullet = pre_bullet.instance()
				bullet.add_to_group("bullet_player") #add no grupo 
				bullet.global_position = $muzzle.global_position
				get_parent().add_child(bullet) #Nao pode atirar, inicia o timer pra poder atirar dnv
				canShoot=false
				shootSFX()
				$shootTimer.start()
				
	if Input.is_action_pressed("ui_ataque") or areaEnt == true:
		$player_shape.visible = true
	else:
		$player_shape.visible = false
		
	if Input.is_action_pressed('ui_right'):
		dirVec.x = 1

	if Input.is_action_pressed('ui_left'):
		dirVec.x = -1

	if Input.is_action_pressed('ui_down'):
		dirVec.y = 1

	if Input.is_action_pressed('ui_up'):
		dirVec.y = -1
		
	vel = dirVec.normalized() * speed
	vel = move_and_slide(vel) 
## warning-ignore:return_value_discarded
#	move_and_slide( Vector2(dir_x , dir_y) * speed)
func damage(qtd):
	if health > 0:
		if canHurt:
			health -= qtd
			canHurt = false
			$imune.start()
			$animImun.play("imune")
	
func killed():
	if status != DEAD:
		status = DEAD

func shootSFX():
	if !$shootSFX.is_playing():
		$shootSFX.play()


func _on_TouchScreenButton_pressed():
	areaEnt = true


func _on_TouchScreenButton_released():
	areaEnt = false


func _on_shootTimer_timeout():
	canShoot = true


func _on_imune_timeout():
	$animImun.play("normal")
	canHurt = true
