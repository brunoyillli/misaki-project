extends CanvasLayer

onready var player = get_node("../../player")

const Hearth_row_size = 5
const Hearth_offset = 8

func _ready():
	for i in player.max_health:
		var new_heart = Sprite.new()
		new_heart.texture = $hearts.texture
		new_heart.hframes = $hearts.hframes
		$hearts.add_child(new_heart)
		
	for heart in $hearts.get_children():
		var index = heart.get_index()
		
		var x = (index % Hearth_row_size) * Hearth_offset
		var y = (index / Hearth_row_size) * Hearth_offset
		heart.position = Vector2(x, y)
		
func _process(_delta):
	for heart in $hearts.get_children():
		var index = heart.get_index()
		var last_heart = floor(player.health)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (player.health - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
