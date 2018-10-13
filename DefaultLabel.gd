extends Label

func set_label(title, amount = 1, ps = ""):
	var plural = amount > 1

	if plural:
		text = str(amount) + "x " + title + "s"
	else:
		text = title

	if ps:
		text += ps
