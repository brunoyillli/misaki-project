extends Node

onready var enemy_scene = [load("res://Inimigos/inimigo_teleguiado.tscn")
]
onready var teleguiado_Grande_scene = [load("res://Inimigos/Inimigo_teleguiado_Grande/Inimigo_tele_Grande.tscn")
]
onready var linear_scene = [load("res://Inimigos/Inimigo_linear/Inimigo_linear.tscn")
]

var time = 0
var wave = 1
var spawnTimer = 0


#func _ready():	
#
##	for i in range(3):
##		var enemy = enemy_scene[0].instance()
##		randomize()
##		enemy.position.x = rand_range(60, 500)
##		enemy.position.y = -100
##		add_child(enemy)
	
func _physics_process(delta):
	if time == 5:
		pass


func _on_Enemy_Timer_timeout():
	match wave:
		1:
			var enemy = linear_scene[0].instance()
			enemy.position.x = 90
			enemy.position.y = -100
			add_child(enemy)
			spawnTimer = 5
			$Enemy_Timer.set_wait_time(spawnTimer)
			wave = 2
		2:
			var enemy = teleguiado_Grande_scene[0].instance()
			enemy.position.x = 400
			enemy.position.y = -100
			add_child(enemy)
			spawnTimer = 5
			$Enemy_Timer.set_wait_time(spawnTimer)
			wave = 3
		_:
			var enemy = enemy_scene[0].instance()
			enemy.position.x = 250
			enemy.position.y = -100
			add_child(enemy)
			$Enemy_Timer.set_wait_time(spawnTimer)
		
		
		
		
		
		
		
