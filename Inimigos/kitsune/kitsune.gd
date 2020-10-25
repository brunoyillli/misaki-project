extends Node2D

onready var bullet_scene = load("res://Bullet_Inimigo/bullet_inimigo_teleguiado.tscn")
onready var player = get_tree().get_root().get_node("estage_1/player")
#depois de um estudo, a conclusão é que a chamada acima pega o node com o nome designado
#no caso player

var alma_azul = preload("res://Cristais/Alma_azul/alma_azul.tscn")
var alma_rosa = preload("res://Cristais/Alma_rosa/alma_rosa.tscn")

var life = 100
var mypos = Vector2(0,0)
var playerpos = Vector2(0,0)
var canShoot = true

#vector circular
var x
var y
var ratio = 0.0
var dividendo = 4.0
var dirQuad = 1
var angulo = 180

func _ready():
	ratio = 90/dividendo
	x = cos(180)
	y = 0.0
func _process(delta):
	if canShoot:
		for o in range(2):
			spawn_bullets(dirQuad)
			dirQuad += 1
			cos(180)
			angulo = 180
			#print("troca")
		canShoot = false
		$timer.start()
		
	mypos = self.global_position
	playerpos = player.global_position
	move_local_x(1 * delta)
	position.y += 50 * delta
	
	if (position.y > get_viewport_rect().size.y + 20):
		get_parent().remove_child(self)
		queue_free()

func spawn_bullets(direction):
	for i in range((dividendo)*2.0):
		quadrantes(direction)
		var b1 = bullet_scene.instance()
		get_parent().add_child(b1)
		b1.bullet_speed = 150
		b1.position = get_global_position()
		b1.dir = Vector2(x,y)
		angulo += ratio
		x = cos(angulo)
		b1.glow = true
	
func quadrantes(quad): #seta o quadrante no plano cartesiano
	match quad:
		1: y = circle()
		2: y = -1.0*circle()
		
func circle():
	return sqrt( 1.0 -(x*x)) #x,y
	
func _on_timer_timeout():
	canShoot = true
	dirQuad = 1
	if dividendo <= 8:
		dividendo = dividendo*2
	else: dividendo = 4.0
	
func damage(amount: int):
	life -= amount
	if life<= 0:
		var drop = randi() % 4 # 25% de chance de dropar a vida
		if drop == 0:
			var pick_rosa = alma_rosa.instance()
			pick_rosa.position = Vector2(self.position.x , (self.position.y - 10))
			get_parent().add_child(pick_rosa)
		var pick_azul = alma_azul.instance()
		pick_azul.position = self.position
		get_parent().add_child(pick_azul)
		queue_free()

