extends StaticBody2D

const COLORS = {
	"red": Color8(230, 57, 70),
	"orange": Color8(244, 140, 6),
	"yellow": Color8(255, 209, 4),
	"green": Color8(56, 176, 0),
	"blue": Color8(30, 96, 219),
	"purple": Color8(142, 36, 170),
}

@export var color = "red"
var life = 1
var hits = 0

@onready var sprite = $sprite

func _ready():
	sprite.modulate = COLORS.get(color, COLORS["purple"])

func play_effect():
	var color_normal = sprite.modulate
	var color_brillo = Color(250, 250, 250, 1)

	var effect = create_tween()
	effect.tween_property(sprite, "modulate", color_brillo, 0.1)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# Animación de vuelta (0.2 segundos) con retraso
	effect.tween_property(sprite, "modulate", color_normal, 0.1)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN).set_delay(0.1)

	return effect

func hit():
	hits += 1
	var effect = play_effect()
	if hits >= life:
		if Points.current_score > 0:
			$shape.disabled = true
		Points.inc_current_score(10)
		# Esperar un instante para que se vea el efecto antes de borrarlo
		await effect.finished
		queue_free()
