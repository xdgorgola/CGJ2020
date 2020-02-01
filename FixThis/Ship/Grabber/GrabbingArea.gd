extends Area2D

func _on_GrabbingArea_body_entered(body):
	if (get_parent().node_b.is_empty()):
		get_parent().node_b = body.get_path();
		print(get_parent().node_b)
	print("puta maldita")
