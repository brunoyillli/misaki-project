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
			'character': 'Misaki Anri.',
			'position': 'center',
			'text':'Acho melhor eu derrotar quem está por trás dessa confusão!'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': '???',
			'position': 'center',
			'text':'Oh, nós temos visitantes!'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Nogitsune.',
			'position': 'center',
			'text':'Oh, nós temos visitantes!'
		},
		{
			'character': 'Nogitsune.',
			'position': 'center',
			'text':'Espere um segundo, vou pegar um chá'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Misaki Anri',
			'position': 'center',
			'text':'Você poderia me dizer o que realmente deseja fazer deixando esses yokais e espíritos tão irritadas? '
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Nogitsune.',
			'position': 'center',
			'text':'Bom, não sei exatamente o que está acontecendo...'
		},
		{
			'action': 'clear_portraits'
		},
		{
			'character': 'Nogitsune',
			'position': 'center',
			'text':'Mas se quiser realmente saber, terá que ir me batendo!!'
		},
	]
	add_child(dialog)

func pause():
	#var new_pause_state = not get_tree().get_root().get_node("estage_1/timeGame").paused
	#get_tree().get_root().get_node("estage_1/timeGame").paused = new_pause_state
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	
