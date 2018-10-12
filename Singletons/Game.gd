extends Node

enum GAMEMODE {
	NoPlayer # there is no player in this scene
	Playing
	ReceiveItem
}

var gamemode = NoPlayer