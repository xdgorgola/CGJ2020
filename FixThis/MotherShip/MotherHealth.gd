extends Node2D

# Parte a volar
export var part = preload("res://Parts/ShipPart.tscn");

# Vida nave nodriza
export var maxHP : int = 10;
var motherHP : int = 10;

# Cosos sivira
export var SParam : float = 10;
export var NParam : float = 5;
var interval = 0;

# Timer
var looseTimer : Timer = Timer.new();

func _ready():
	motherHP = maxHP;
	get_node("../GameManager").connect("started_game", self, "start_HP_System");

func start_HP_System():
	add_child(looseTimer);
	looseTimer.connect("timeout", self, "loose_part");
	looseTimer.start((SParam * maxHP)/NParam); 
	
func loose_part():
	motherHP -= 1;
	print("Perdiendo vida.");
	if (motherHP <= 0):
		get_parent().emit_signal("bigOof");
	else:
		if (maxHP != motherHP):
			interval = SParam * (maxHP - motherHP);
		else:
			interval = SParam * maxHP
		interval = interval / NParam;
		instantiate_part();
		looseTimer.start(interval);
		
# La nave recupera una parte
func recover_part():
	motherHP = min(maxHP, motherHP + 1);
	if (maxHP != motherHP):
		interval = SParam * (maxHP - motherHP);
	else:
		interval = SParam * maxHP
	interval = interval / NParam;
	looseTimer.start(interval);
	
func instantiate_part():
	var lostpart = part.instance();
	var dir = Vector2.RIGHT * cos(rand_range(0.0, 360.0)) + Vector2.UP * sin(rand_range(0.0, 360.0));
	get_tree().root.add_child(lostpart);
	print(get_parent().global_position);
	lostpart.get_node("LaunchSystem").spawn_part(get_parent().global_position + dir * 100, dir, rand_range(50.0, 200.0));
