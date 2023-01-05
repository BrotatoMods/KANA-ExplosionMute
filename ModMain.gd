extends Node

const MOD_LOG_NAME = "KANAExplosionMute"

func KANA_edit_explosion_animation(scene_explosion):
	var animation_player = scene_explosion.get_node("AnimationPlayer")
	var sprite_node = scene_explosion.get_node("Sprite")
	
	# Load new explosion texture
	var new_explode_texture: StreamTexture = load("res://mods-unpacked/KANA-ExplosionMute/KANA_explosion.png")
	sprite_node.texture = new_explode_texture
	
	ModLoader.dev_log("Start editing explosion animation.", MOD_LOG_NAME)
	# get explode animation
	var animation_explode = animation_player.get_animation('explode')
	# get the sprite texture track index
	var track_sprite_index = animation_explode.find_track('Sprite:texture')
	# remove it
	animation_explode.remove_track(track_sprite_index)
	animation_player.clear_caches()
	
	# Create a new track to toggle the visibillity of the explosion sprite
	var track_index_visibility = animation_explode.add_track(Animation.TYPE_VALUE)
	animation_explode.track_set_path(track_index_visibility, "Sprite:visible")
	animation_explode.track_insert_key(track_index_visibility, 0.0, true)
	animation_explode.track_insert_key(track_index_visibility, 0.05, false)
	
	# Create a new track with the new explosion texture
	# For some reason replacing just the Sprite.texture is not enough
	# I have to add a new track with the new texture to propably replace the old one
	var track_index_texture = animation_explode.add_track(Animation.TYPE_VALUE)
	animation_explode.track_set_path(track_index_texture, "Sprite:texture")
	animation_explode.track_insert_key(track_index_texture, 0.0, new_explode_texture)
	animation_explode.track_insert_key(track_index_texture, 0.05, new_explode_texture)
	
	ModLoader.dev_log("Finished editing explosion animation.", MOD_LOG_NAME)

func _init(modLoader = ModLoader):
	modLoader.mod_log("Initing", MOD_LOG_NAME)

func _ready():
	ModLoader.mod_log("Finished", MOD_LOG_NAME)
	
	var scene_explosion = load("res://projectiles/explosion.tscn").instance()
	KANA_edit_explosion_animation(scene_explosion)
	
	ModLoader.saveScene(scene_explosion, "res://projectiles/explosion.tscn")
