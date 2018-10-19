extends Node

export(Dictionary) var dialogues = {
	"/root/Main/Readables/Schild": [
		{
			"says": "Three times' a charm.",
		},
	],
	"/root/Main/Readables/Letter": [
		{
			"says": "I hope you landed well. It's not looking well up here as far as I'm concerned.",
			"speed": 2.5,
		},
		{
			"says": "Did you find the apple? I hope it's near you.",
			"speed": 2.5,
		},
		{
			"says": "The next letter will be at the fountain.\nLove, Kara.",
			"speed": 2.5,
		},
	]
}

export(Dictionary) var door_logic = {
	"/root/RocketScience/Doors/Door": {
		"/root/RocketScience/Buttons/Button": true,
		"/root/RocketScience/Buttons/Button2": true,
		"/root/RocketScience/Buttons/Button3": true,
		"/root/RocketScience/Buttons/Button4": true,
	},
	"/root/Main/Interactables/Door": {
		"/root/Main/Buttons/Button": true,
		"/root/Main/Buttons/Button2": true,
		"/root/Main/Buttons/Button3": true,
	}
}
