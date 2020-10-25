extends Node2D

onready var enemy_scene = [load("res://Inimigos/inimigo_teleguiado.tscn")
]
onready var teleguiado_Grande_scene = [load("res://Inimigos/Inimigo_teleguiado_Grande/Inimigo_tele_Grande.tscn")
]
onready var linear_scene = [load("res://Inimigos/Inimigo_linear/Inimigo_linear.tscn")
]
onready var kitsune = [load("res://Inimigos/kitsune/kitsune.tscn")
]

var wave = 1
var spawnTimer = 0
var spawnPosY = Vector2(0,0)

export var triggerSpawn = [2,9.5,18,27,33] #tempos que spawnarão em segundos
export var spawnType = [1,2,1,3,1] #tipo de criatura que sera spawanada
var timeTimer = 0
var index = 0 #valor do slot dos arrays
var time = 0 #tempo da cena
var mainScene = ""
var spawnPosX = Vector2(0,0)

func _ready():
	spawnPosX = get_global_position()
	mainScene = get_tree().get_root().get_node("estage_1")
##	for i in range(3):
##		var enemy = enemy_scene[0].instance()
##		randomize()
##		enemy.position.x = rand_range(60, 500)
##		enemy.position.y = -100
##		add_child(enemy)
	
func _process(delta):
	#atualiza o tempo do script
	spawnPosY = get_tree().get_root().get_node("estage_1/spawnPos").get_global_position()
	time = get_tree().get_root().get_node("estage_1/timeGame").time
	
	canSpawn()
#função se pode spawnar, analisa o tempo do script, 
#com os tempos predeterminados do array
func canSpawn():
	if index <= (triggerSpawn.size())-1: #limitador pra n pegar slot do array que não existe
		if time >= triggerSpawn[index]:
			wave = spawnType[index]
			spawn()
			index += 1


func spawn():
	match wave:
		1:
			var enemy = linear_scene[0].instance()
			enemy.global_position.x = spawnPosX.x
			enemy.global_position.y = spawnPosY.y
			mainScene.add_child(enemy)
		2:
			var enemy = teleguiado_Grande_scene[0].instance()
			enemy.global_position.x = spawnPosX.x
			enemy.global_position.y = spawnPosY.y
			mainScene.add_child(enemy)

		3:
			var enemy = enemy_scene[0].instance()
			enemy.global_position.x = spawnPosX.x
			enemy.global_position.y = spawnPosY.y
			mainScene.add_child(enemy)
		4:
			var enemy = kitsune[0].instance()
			enemy.global_position.x = spawnPosX.x
			enemy.global_position.y = spawnPosY.y
			mainScene.add_child(enemy)
		
		
		
		
		
		
