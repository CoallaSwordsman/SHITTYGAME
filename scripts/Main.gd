extends Control
const CLIENT = preload("res://objects/Client.tscn")


export var recipe = []
var points
var is_client = false
var current_client
var pot_ready = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_children())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(recipe)>0:
		$Cauld_button/giga.visible=true
	else:
		$Cauld_button/giga.visible=false
	
	if is_client == false:
		points = 0
		current_client = CLIENT.instance()
		current_client.set_name("current_client")
		add_child(current_client)
		$current_client.position += Vector2(300, 200)
		for i in $current_client.illness:
			if "vampd" == i.name:
				$Control/ch3.visible = true
			if "hall" == i.name:
				$Control/ch1.visible = true
			if "franyk" == i.name:
				$Control/ch2.visible = true
		is_client = true
		print(recipe)
	else:
		if pot_ready == false:
			print(recipe)

		else:
			for cure in recipe:
				for ill in $current_client.illness:
					if cure in ill.anticures:
						get_tree().change_scene("res://objects/Death.tscn")
					elif cure in ill.cures:
						points += 1
			if points > 1:
				if points > 3:
					points = 3
				print("sas")
				print(points)
				$current_client.queue_free()
				is_client = false
				pot_ready = false
				$Control/ch3.visible = false
				$Control/ch1.visible = false
				$Control/ch2.visible = false
				recipe = []
			else:
				get_tree().change_scene("res://objects/Death.tscn")
		
	


func _on_Quest_smol_button_down():
	$Control.visible=true
