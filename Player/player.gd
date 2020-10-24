extends KinematicBody2D

var pre_bullet = preload("res://Bullet_player/bullet_player.tscn")

onready var joystick = get_node("Hud/Joystick/Joystick_button")

signal health_updated(health)
signal killed()

export (float) var max_health = 10

onready var health = 4 setget _set_health
onready var invu_timer = $Invulneravel


var speed = 300

var vel := Vector2(0, 0)

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

func _ready():
	add_to_group("player")
	if(OS.get_name() == "Windows"):
		$Hud/Joystick.hide()
		
# warning-ignore:unused_argument
func _physics_process(delta):
	if status == RUNNING:
		running(delta)
#	elif status == DEAD:
#		dead(delta)


func _input(event):
#	if areaEnt == true:
#		if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
#			var bullet = pre_bullet.instance()
#			bullet.global_position = $muzzle.global_position
#			get_parent().add_child(bullet)
#			touchPos = event.get_position()
#			deltaX = touchPos.x - position.x
#			deltaY = touchPos.y - position.y
	pass
	
func _process(delta):
	#move_and_slide(joystick.get_value() * speed)
	pass
	
func running(delta):
	var dirVec := Vector2(0, 0)
	
	# verifica se tem tantos elementos no grupo bullet
	if get_tree().get_nodes_in_group("bullet_player").size() <= 6:
		if (Input.is_action_just_pressed("ui_ataque") or areaEnt == true) and canShoot:
				var bullet = pre_bullet.instance()
				bullet.add_to_group("bullet_player") #add no grupo 
				bullet.global_position = $muzzle.global_position
				get_parent().add_child(bullet) #Nao pode atirar, inicia o timer pra poder atirar dnv
				canShoot=false
				shootSFX()
				$shootTimer.start()
			
	
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

func killed():
	if status != DEAD:
		status = DEAD

func shootSFX():
	$shootSFX.play()


func _on_TouchScreenButton_pressed():
	areaEnt = true


func _on_TouchScreenButton_released():
	areaEnt = false


func _on_shootTimer_timeout():
	canShoot = true

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()
			emit_signal("killed")
			
	
func damage(amount):
	if invu_timer.is_stopped():
		invu_timer.start()
		_set_health(health - amount)
		$AnimationPlayer.play("invunerability")
		
	
func kill():
	queue_free()
	
func _on_Invulneravel_timeout():
	$AnimationPlayer.play("rest")
