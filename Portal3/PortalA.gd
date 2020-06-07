extends Spatial


const MAX_CONTACTS_REPORTED = 4

var staticBody: RigidBody
var collidingBodies
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready(): 
	get_node("RigidBody").set_max_contacts_reported(MAX_CONTACTS_REPORTED)
	staticBody = get_node("RigidBody")
	pass # Replace with function body.

func _physics_process(delta):
	var collidingBodies = staticBody.get_colliding_bodies()
	for collidingBody in collidingBodies:
		if collidingBody is KinematicBody:	
			shouldTeleport(collidingBody)
	

func shouldTeleport(collidingBody: KinematicBody):
	# TODO get collidingBody position (should be a Vector3)
	# TODO calculate if it is inside the CollisionShape
	# TODO get collidingBody position relative to PortalA position (relativePos = collidingBody.position - parentNode.position)
	# TODO if it is, set collidingBody position to (PortalB.position + relativePos)
	pass
