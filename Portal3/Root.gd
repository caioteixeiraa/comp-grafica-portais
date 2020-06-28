extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$PortalPlanes.size = get_viewport().size
	pass # Replace with function body.

func _process(_delta):
	updateCameras()
	processPortals()
	if(Input.is_action_just_pressed("restart")):
		get_tree().reload_current_scene()
	if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		if (Input.is_action_just_pressed("ui_cancel")):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		if (Input.is_action_just_pressed("ui_cancel")):
			get_tree().quit()
		if (Input.is_action_just_pressed("resume")):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func updateCameras():
	for node in $PortalPlanes.get_children():
		node.UpdateCamera($PlayerBody/PlayerHead/Camera)

func processPortals():
	var count : int = $PortalPlanes/PortalPair.get_child_count()
	var n = 0
	for i in range (count):
		var node = $PortalPlanes/PortalPair.get_child(i)
		var count_children = node.get_child_count()
		for j in range (count_children):
			var child = node.get_child(j)
			if child is Sprite:
				n = n + 1
				
