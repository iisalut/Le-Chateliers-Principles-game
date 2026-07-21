extends Control

@onready var game_over_text_2: RichTextLabel = $"game over text2"
@onready var replay_button: Button = $"replay button"

func _ready():
	game_over_text_2.text="Final Score: "+str(QsData.score)



func _on_replay_button_pressed() -> void:
	QsData.full_finished_qs=[]
	QsData.temp_finished_qs=[]
	QsData.conc_finished_qs=[]
	QsData.vol_finished_qs=[]
	QsData.score=0
	get_tree().change_scene_to_file("res://quiz.tscn")
