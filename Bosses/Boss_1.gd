extends Area2D


var bullet_scene = load("res://Bullet_Boss_1/Bullet_Boss_1.tscn")

var type = "ENEMY"

var life = 1000

var var_mov = -50


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var target = Vector2(position.x, 100)
	$Move_Tween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Move_Tween.start()
	
	$Timer.set_wait_time(0.02)
	$RpTimer.set_wait_time(1)
	$RpTimer.start()


func _process(delta):
	move_local_x(1 * delta)
	if position.x >= 480:
		var_mov = -50
		position.x += var_mov * delta
	elif position.x <= 50:
		var_mov = 50
		position.x += var_mov * delta
	else:
		position.x += var_mov * delta
		
func spawn_bullets():
	
	rotate(5)
	var b = bullet_scene.instance()
	b.position = self.position
	b.rotation = self.rotation
	
	get_parent().add_child(b)


func _on_Timer_timeout():
	spawn_bullets()
	
	
func damage(amount: int):
	life -= amount
	if life<= 0:
		queue_free()


func _on_RpTimer_timeout():
	$Timer.start()
	$RpTimer.stop()


func _on_Boss_1_area_entered(_area):
	damage(1)
