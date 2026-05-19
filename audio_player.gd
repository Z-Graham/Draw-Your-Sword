extends Node


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func pitch_down(): 
	audio_stream_player.pitch_scale = 0.5
