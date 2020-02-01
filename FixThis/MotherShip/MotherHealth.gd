extends Node2D

export var motherHP : int = 10;


func loose_part():
	motherHP -= 1;
	if (motherHP <= 0):
		pass
		# Emite senal
	else:
		pass
	# Instancia y eso