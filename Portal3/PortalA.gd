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
	update_camera_position()
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

func update_camera_position():
	var currentCameraTransform = get_node("RigidBody/CollisionShape/MeshInstance/Viewport/Camera").global_transform
	var otherPortalTransform = get_parent().get_node("PortalB").global_transform
	var thisPortalTransform = self.global_transform
	var playerTransform = get_tree().root.get_child(0).get_node("PlayerBody").global_transform
	
	var newCameraTransform = add_matrices(currentCameraTransform, playerTransform, false)
	newCameraTransform = add_matrices(newCameraTransform, thisPortalTransform, true)
	newCameraTransform = add_matrices(newCameraTransform, otherPortalTransform, false)
	
	get_node("RigidBody/CollisionShape/MeshInstance/Viewport/Camera").global_transform = newCameraTransform
	pass	
	
	
func add_matrices(matrixOne: Transform, matrixTwo: Transform, is_subtraction: bool):
	var result = matrixOne
	for i in range(2):
		for j in range(3):
			if (is_subtraction):
				result[i][j] = matrixOne[i][j] + matrixTwo[i][j]
			else:
				result[i][j] = matrixOne[i][j] + matrixTwo[i][j]	
	return result
	
