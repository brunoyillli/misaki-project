extends Area2D

var vel = 300
var dir = Vector2(0 , 1)

func _ready():
	pass
	
func _physics_process(delta):
	position.y += vel * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	Global.points += 100
	queue_free()

