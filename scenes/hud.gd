extends CanvasLayer

onready var player = get_node("../../player")

const Hearth_row_size = 5
const Hearth_offset = 8
const Power_row_size = 5
const Power_offset = 8
func _ready():
	
	for i in player.max_power:
		var new_power = Sprite.new()
		new_power.texture = $power.texture
		new_power.hframes = $power.hframes
		$power.add_child(new_power)
	for i in player.max_health:
		var new_heart = Sprite.new()
		new_heart.texture = $hearts.texture
		new_heart.hframes = $hearts.hframes
		$hearts.add_child(new_heart)
	
	for power in $power.get_children():
		var index = power.get_index()
		var x = (index % Hearth_row_size) * Hearth_offset
		var y = (index / Hearth_row_size) * Hearth_offset
		power.position = Vector2(x, y)
		
	for heart in $hearts.get_children():
		var index = heart.get_index()
		
		var x = (index % Hearth_row_size) * Hearth_offset
		var y = (index / Hearth_row_size) * Hearth_offset
		heart.position = Vector2(x, y)
		
func _process(_delta):
	for power in $power.get_children():
		var index = power.get_index()
		var last_power = floor(player.power)
		if index > last_power:
			power.frame = 0
		if index == last_power:
			power.frame = (player.power - last_power) * 4
		if index < last_power:
			power.frame = 4
	for heart in $hearts.get_children():
		var index = heart.get_index()
		var last_heart = floor(player.health)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (player.health - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
