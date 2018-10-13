extends Node

export(Dictionary) var dialogues = {
	"/root/Main/Schild": [
		{
			"who": "Schild",
			"says": "Hallo, ich bin hier!",
		},
		{
			"who": "Schild",
			"says": "Hallo, ich bin immer noch hier!",
			"speed": .1,
		},
	]
}

export(Dictionary) var door_logic = {
	"/root/RocketScience/Doors/Door": {
		"/root/RocketScience/Buttons/Button": true,
		"/root/RocketScience/Buttons/Button2": true,
		"/root/RocketScience/Buttons/Button3": true,
		"/root/RocketScience/Buttons/Button4": true,
	}
}