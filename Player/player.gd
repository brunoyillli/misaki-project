extends KinematicBody2D

var pre_bullet = preload("res://Bullet_player/bullet_player.tscn")

onready var joystick = get_node("Hud/Joystick/Joystick_button")

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
	if areaEnt == true:
		if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
			var bullet = pre_bullet.instance()
			bullet.global_position = $muzzle.global_position
			get_parent().add_child(bullet)
#			touchPos = event.get_position()
#			deltaX = touchPos.x - position.x
#			deltaY = touchPos.y - position.y

func _process(delta):
	move_and_slide(joystick.get_value() * speed)
		
		
func running(delta):
	var dirVec := Vector2(0, 0)
	
	if Input.is_action_pressed("ui_ataque") or areaEnt == true:
		var bullet = pre_bullet.instance()
		bullet.global_position = $muzzle.global_position
		get_parent().add_child(bullet)
	
	if Input.is_action_pressed('ui_right'):
		dirVec.x = 1

	if Input.is_action_pressed('ui_left'):
		dirVec.x = -1

	if Input.is_action_pressed('ui_down'):
		dirVec.y = 1

	if Input.is_action_pressed('ui_up'):
		dirVec.y = -1
		
		
	vel = dirVec.normalized() * speed
	position += vel * delta
## warning-ignore:return_value_discarded
#	move_and_slide( Vector2(dir_x , dir_y) * speed)

func killed():
	if status != DEAD:
		status = DEAD



func _on_TouchScreenButton_pressed():
	areaEnt = true


func _on_TouchScreenButton_released():
	areaEnt = false
