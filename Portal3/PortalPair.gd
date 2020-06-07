extends Node

onready var portals = [$PortalA, $PortalB]


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Move body from portal from_portal to portal to_por
func teleport_body(body: PhysicsBody, from_portal: Spatial, to_portal: Spatial):
	var body_pos = body.global_transform
	var body_speed = body.linear_velocity
	body_pos = body_pos - from_portal.global_transform + to_portal.global_transform
	body.global_transform = body_pos
	return
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
