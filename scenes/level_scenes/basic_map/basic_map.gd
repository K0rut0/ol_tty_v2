extends Node2D


@export var PlayerScene: PackedScene
			
# Called when the node enters the scene tree for the first time.
func _ready():
	var index = 0
	var PlayerArr = []
	for i in GameManager.Players:
		PlayerArr.push_back(GameManager.Players[i])
	
	#sort players by id so they dont overlap in spawn
	PlayerArr.sort_custom(func(a, b): return a.id < b.id)
	print(PlayerArr)
	
	for player in PlayerArr:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(player.id)
		#print(str(GameManager.Players[i].id) + " " + GameManager.Players[i].name)
		currentPlayer.find_child("playername").text = player.name
		add_child(currentPlayer)
		
		#loop to spawn players in node
		for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			if(spawn.name == str(index)):
				currentPlayer.global_position = spawn.global_position
				#print(GameManager.Players)
				print(str(index) + "was spawned: " + currentPlayer.name)
		index+=1
		
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
