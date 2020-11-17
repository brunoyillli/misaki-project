extends Node

var time = 0 
var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
var semaforo = true

func _process(_delta):
	
	if dialog == null and get_tree().paused:
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		
	time = get_tree().get_root().get_node("estage_1/timeGame").time
	if time >= 10:
		if semaforo == true:
			pause()
			dialogo()
		semaforo = false
func dialogo():
	dialog.dialog_script = [
		{
			'background': "res://addons/dialogs/Images/background/placeholder-2.png"
		},
		{
			'character': 'Iteb',
			'position': 'center',
			'text':'Hell nigga os shiet kpop modafuka'
		},
		{
			'character': 'Zas',
			'position': 'center',
			'text': 'Hey {Kubuk}, do you know what this is?'
		}
	]
	add_child(dialog)

func pause():
	#var new_pause_state = not get_tree().get_root().get_node("estage_1/timeGame").paused
	#get_tree().get_root().get_node("estage_1/timeGame").paused = new_pause_state
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	
