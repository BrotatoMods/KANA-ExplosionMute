extends Node

const KANA_Explosion_Mute_LOG = "KANA-ExplosionMute"

func _init(modLoader = ModLoader):
	ModLoaderUtils.log_info("Initialized", KANA_Explosion_Mute_LOG)
	var overwrite_0 = preload("res://mods-unpacked/KANA-ExplosionMute/overwrites/projectiles/rocket/explosion.png")
	overwrite_0.take_over_path("res://projectiles/rocket/explosion.png")

func _ready():
	pass
