extends Resource
class_name GunResource

@export var up : Texture2D
@export var down : Texture2D
@export var side : Texture2D
@export var diag_up : Texture2D
@export var diag_down : Texture2D
@export var bullet : Texture2D
@export var damage : float = 100

func get_sprite(name: String) -> Texture2D:
	match name:
		"up": return up
		"down": return down
		"side": return side
		"diag_up": return diag_up
		"diag_down": return diag_down
	
	printerr("Could not find sprite with name: %s" % name)
	return null
