extends Area2D

onready var bullet_scene = load("res://Bullet_Inimigo/Linear_bullet/bullet_linear.tscn")

#onready var player = get_parent().get_parent().get_node("player")
##depois de um estudo, a conclusão é que a chamada acima pega o node com o nome designado
##no caso player
onready var leftGun := $FiringPositions/LeftGun
onready var rightGun := $FiringPositions/RightGun

var life = 3

func _ready():
	$Timer.start()
	var target = Vector2(position.x, 100)
	$Move_Tween.interpolate_property(self, "position", position, target, 2, 
	Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Move_Tween.start()



func _process(delta):
	move_local_x(1 * delta)
	
	if (position.y > get_viewport_rect().size.y + 20):
		get_parent().remove_child(self)
		queue_free()
	
func spawn_bullets():
		var b1 = bullet_scene.instance()
		b1.bullet_speed = 300
		b1.position = leftGun.global_position
		var b2 = bullet_scene.instance()
		b2.bullet_speed = 300
		b2.position = rightGun.global_position
		get_tree().current_scene.add_child(b2)
		get_tree().current_scene.add_child(b1)
		

func _on_Timer_timeout():
	spawn_bullets()

func damage(amount: int):
	life -= amount
	if life<= 0:
		queue_free()
