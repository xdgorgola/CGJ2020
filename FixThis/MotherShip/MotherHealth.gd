extends Node2D

export var motherHP : int = 10;
export var minTime : float = 5;
export var maxTime : float = 10;

var looseTimer : Timer = Timer.new();

func _ready():
	add_child(looseTimer);
	if (minTime > maxTime):
		push_error("Min time bigger than max time");
	looseTimer.connect("timeout", self, "loose_part");
	looseTimer.start(1); # Poner aca el start time del juego para que salga una disparada de una

func calculate_next_time():
	var next : float = rand_range(minTime, maxTime);
	looseTimer.start(next);
	
func loose_part():
	motherHP -= 1;
	if (motherHP <= 0):
		get_parent().emit_signal("bigOof");
	else:
		calculate_next_time();
	# Instancia y eso