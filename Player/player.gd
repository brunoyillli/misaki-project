extends KinematicBody2D

var pre_bullet = preload("res://Bullet_player/bullet_player.tscn")

var speed = 300

enum {RUNNING, DEAD, VICTORY}
var status = RUNNING


func _ready():
	add_to_group("player")

# warning-ignore:unused_argument
func _physics_process(delta):
	if status == RUNNING:
		running()
#	elif status == DEAD:
#		dead(delta)


func _input(event):
	
	if event is InputEventScreenTouch or Input.is_action_pressed("ui_ataque"):
		var bullet = pre_bullet.instance()
		bullet.global_position = $muzzle.global_position
		get_parent().add_child(bullet)

func running():
	
	var dir_x = 0
	var dir_y = 0
	
	if Input.is_action_pressed('ui_right'):
		dir_x = 1

	if Input.is_action_pressed('ui_left'):
		dir_x = -1

	if Input.is_action_pressed('ui_down'):
		dir_y = 1

	if Input.is_action_pressed('ui_up'):
		dir_y = -1
		
# warning-ignore:return_value_discarded
	move_and_slide( Vector2(dir_x , dir_y) * speed)

func killed():
	if status != DEAD:
		status = DEAD
