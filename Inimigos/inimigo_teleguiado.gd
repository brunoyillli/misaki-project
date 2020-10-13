extends Node2D


onready var bullet_scene = load("res://Bullet_Inimigo/bullet_inimigo_teleguiado.tscn")

onready var player = get_tree().get_root().get_node("estage_1/player")
#depois de um estudo, a conclusão é que a chamada acima pega o node com o nome designado
#no caso player

var life = 3
var mypos = Vector2(0,0)
var playerpos = Vector2(0,0)
func _ready():
	$Timer.start()
	
	var target = Vector2(position.x, 100)
	$Move_Tween.interpolate_property(self, "position", position, target, 2, 
	Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Move_Tween.start()



func _process(delta):
	mypos = self.global_position
	playerpos = player.global_position
	move_local_x(1 * delta)
	position.y += 50 * delta
	
	if (position.y > get_viewport_rect().size.y + 20):
		get_parent().remove_child(self)
		queue_free()
	
func spawn_bullets():
	var b1 = bullet_scene.instance()
	
	get_parent().add_child(b1)
	b1.bullet_speed = 600
	b1.position = self.position
	b1.dir = Vector2(playerpos.x- mypos.x, playerpos.y-mypos.y).normalized()

func _on_Timer_timeout():
	spawn_bullets()

func _on_Area2D_area_entered(area):
	#life -= 1
	if life <= 0:
		queue_free()
