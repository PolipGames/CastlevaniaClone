
extends Area2D

# setup levels for boss and colosseum fights

var gateclass = preload("res://scenes/colosseum/gate.tscn")
var gate
var gatepos = Vector2()

var isfighting = false
var tilemap

func _ready():
	tilemap = get_parent().get_parent()
	if (!Globals.get("current_quest_complete")):
		set_fixed_process(true)

# called when sensor is triggered and to start the fight
func trigger_fighting():
	pass

# called during the fight
func process_fighting():
	pass

func _fixed_process(delta):
	if (!isfighting):
		var collisions = get_overlapping_bodies()
		for i in collisions:
			if (i.get_name() == "player"):
				# block the exits
				gate = gateclass.instance()
				gate.set_global_pos(gatepos)
				tilemap.get_node("GateGroup").add_child(gate)
				isfighting = true
				get_node("CollisionShape2D").queue_free()
				trigger_fighting()
	else:
		process_fighting()