extends CharacterBody2D

var player_speed = 500
@onready var animation_tree = $AnimationTree
@onready var animation_mode = animation_tree.get("parameters/playback")
var stamina = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	handle_animations(Vector2(0, 1))
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		if(Input.get_action_strength(("shift")) > 0):
			player_speed = 700
			stamina-=1*delta
		else:
			player_speed = 500
			stamina += 1*delta
			
		velocity = player_speed*input_direction
		handle_animations(input_direction)
		move_and_slide()
		pick_new_state()
	pass

#handles animation changes
func handle_animations(mov_dir):
	if(velocity != Vector2.ZERO):
		animation_tree.set("parameters/walk/blend_position", mov_dir)
		animation_tree.set("parameters/idle/blend_position", mov_dir)

#changes states based on velocity
func pick_new_state():
	if(velocity != Vector2.ZERO):
		animation_mode.travel("walk")
	else:
		animation_mode.travel("idle")
