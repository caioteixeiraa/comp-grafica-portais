extends Node

var _portalA : TeleportTestPlane
var _portalB : TeleportTestPlane
var _cameraA : Camera
var _cameraB : Camera

#export(int) var Portal1_Index
#export(int) var Portal2_Index

func _ready():
	var vp_size : Vector2 = get_viewport().size
	
	$PortalA_VP.size = vp_size
	$PortalB_VP.size = vp_size
	
	$PortalA_Sprite.region_rect.size = vp_size
	$PortalB_Sprite.region_rect.size = vp_size
	
	$PortalA_Sprite.offset = vp_size / 2
	$PortalB_Sprite.offset = vp_size / 2
	
	findPortals()

func findPortals():
	_portalA = $PortalA as TeleportTestPlane
	_portalB = $PortalB as TeleportTestPlane
	
	_cameraA = $PortalA_VP/Camera
	_cameraB = $PortalB_VP/Camera
	
#	_cameraA.cull_mask += pow(2, PortalB_Index+1)
#	_cameraB.cull_mask += pow(2, PortalA_Index+1)
	
	_portalA._exit_portal = _portalB
	_portalB._exit_portal = _portalA
	
#	_portalA.index = PortalA_Index
#	_portalB.index = PortalB_Index


func UpdateCamera(camera):
	var position = camera.global_transform.origin
	var camera_transform = camera.global_transform
	var planeA_pos = _portalA.to_local(position)
	var planeB_pos = _portalB.to_local(position)
	
	var one_eighty_rotation = Quat(Vector3(0,1,0), PI)
	var portalA_global_transform = _portalA.global_transform
	var portalB_global_transform = _portalB.global_transform
	
	_cameraA.transform.basis = portalB_global_transform.basis * Basis(one_eighty_rotation) * portalA_global_transform.basis.inverse() * camera_transform.basis
	_cameraB.transform.basis = portalA_global_transform.basis * Basis(one_eighty_rotation) * portalB_global_transform.basis.inverse() * camera_transform.basis
	_cameraA.translation = _portalB.to_global(one_eighty_rotation * planeA_pos)
	_cameraB.translation = _portalA.to_global(one_eighty_rotation * planeB_pos)

