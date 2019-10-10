extends Area2D

onready var orbit_position = $Pivot/OrbitPosition

export var radius = 100
var rotation_speed = PI


	
	
func init(_position, _radius = radius):
	position = _position
	radius = _radius
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.radius = radius
	
	var img_size = $Sprite.texture.get_size().x / 2
	$Sprite.scale = Vector2(1, 1) * radius / img_size
	orbit_position.position.x = radius + 25
	
	rotation_speed = rotation_speed * pow(-1, randi() %2)
	
func implode():
	$AnimationPlayer.play("implode")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
	
func capture():
	$AnimationPlayer.play("capture")

func _process(delta: float) -> void:
	$Pivot.rotation += rotation_speed * delta
