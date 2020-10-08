extends Node

onready var enemy_scene = [load("res://Inimigos/inimigo_teleguiado.tscn")
]
#onready var enemy_scene = [load("res://Inimigos/Inimigo_teleguiado_Grande/Inimigo_tele_Grande.tscn")
#]

var time = 0

func _ready():
	for i in range(3):
		var enemy = enemy_scene[0].instance()
		randomize()
		enemy.position.x = rand_range(60, 500)
		enemy.position.y = -100
		add_child(enemy)
	
func _physics_process(delta):
	if time == 5:
		pass
