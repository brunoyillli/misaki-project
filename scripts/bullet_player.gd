extends Area2D

var vel = 300
var dir = Vector2(0 , -1)

func _ready():
	add_to_group("bullet_player")

func _physics_process(delta):
	translate(dir * vel * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()




func _on_bullet_player_area_entered(area):
	queue_free()
