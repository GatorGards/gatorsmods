#define init
#macro ss "sprites/souls/"
global.sprsoulmeter = sprite_add(ss + "meterSoul.png", 4, 0, 0);
global.sprsoulmetertb = sprite_add(ss + "meterSoulTB.png", 7, 0, 0);

#define player_hud(_player, _hudIndex, _hudSide)
switch (_player.race) {
	case "cow": {
		draw_sprite_ext(
			(ultra_get("cow", 1) ? global.sprsoulmetertb : global.sprsoulmeter),
			_player.soulcharge,
			(_hudSide ? 1 : 93),
			4,
			(_hudSide ? -1 : 1),
			1,
			0,
			c_white,
			1
		);
	}
	break;
}
	
#define draw_gui
	 // Player HUD Management:
	if(instance_exists(Player) && !instance_exists(PopoScene) && !instance_exists(MenuGen)){
		if(instance_exists(TopCont) || instance_exists(GenCont) || instance_exists(LevCont)){
			var _hudFade  = 0,
			    _hudIndex = 0,
			    _lastSeed = random_get_seed();
			    
			 // Game Win Fade Out:
			if(array_length(instances_matching(TopCont, "fadeout", true))){
				with(TopCont){
					_hudFade = clamp(fade, 0, 1);
				}
			}
			if(_hudFade > 0){
				 // GMS1 Partial Fix:
				try if(!null){}
				catch(_error){
					_hudFade = min(_hudFade, round(_hudFade));
				}
				
				 // Dim Drawing:
				if(_hudFade > 0){
					draw_set_fog(true, c_black, 0, 16000 / _hudFade);
				}
			}
			
			 // Draw Player HUD:
			for(var _isOnline = 0; _isOnline <= 1; _isOnline++){
				for(var _index = 0; _index < maxp; _index++){
					if(
						player_is_active(_index)
						&& (_hudIndex < 2 || !instance_exists(LevCont))
						&& (player_is_local_nonsync(_index) ^^ _isOnline)
					){
						var _hudVisible = false;
						
						 // HUD Visibility:
						for(var i = 0; true; i++){
							var _local = player_find_local_nonsync(i);
							if(!player_is_active(_local)){
								break;
							}
							if(player_get_show_hud(_index, _local)){
								_hudVisible = true;
								break;
							}
						}
						
						 // Draw HUD:
						if(_hudVisible || _isOnline == 0){
							if(_hudVisible){
								var _player = player_find(_index);
								if(instance_exists(_player)){
									 // Rad Canister / Co-op Offsets:
									var _playerNum = 0;
									for(var i = 0; i < maxp; i++){
										_playerNum += player_is_active(i);
									}
									if(_playerNum <= 1){
										d3d_set_projection_ortho(
											view_xview_nonsync - 17,
											view_yview_nonsync,
											game_width,
											game_height,
											0
										);
									}
									else draw_set_projection(2, _index);
									
									 // Draw:
									player_hud(_player, _hudIndex, _hudIndex % 2);
									
									draw_reset_projection();
								}
							}
							_hudIndex++;
						}
					}
				}
			}
			if(_hudFade > 0){
				draw_set_fog(false, 0, 0, 0);
			}
			random_set_seed(_lastSeed);
		}
	}
	
#define draw_pause
	 // Paused Player HUD Management:
	var _local = player_find_local_nonsync();
	if(player_is_active(_local)){
		 // Store Main Player’s Variables:
		if(instance_exists(Player)){
			global.hud_pause_vars = undefined;
			with(player_find(_local)){
				global.hud_pause_vars = {};
				with(variable_instance_get_names(self)){
					lq_set(global.hud_pause_vars, self, variable_instance_get(other, self));
				}
			}
		}
		
		 // Draw Main Player’s HUD:
		if(!instance_exists(BackMainMenu)){
			var _ref  = script_ref_create(draw_pause),
			    _vars = mod_variable_get(_ref[0], _ref[1], "hud_pause_vars");
			    
			if(!is_undefined(_vars)){
				for(var i = 0; player_is_active(player_find_local_nonsync(i)); i++){
					if(player_get_show_hud(_local, player_find_local_nonsync(i))){
						var _playerNum = 0,
						    _lastSeed  = random_get_seed();
						    
						 // View + Rad Canister Offset:
						for(var i = 0; i < maxp; i++){
							_playerNum += player_is_active(i);
						}
						d3d_set_projection_ortho(
							((_playerNum <= 1) ? -17 : 0),
							0,
							game_width,
							game_height,
							0
						);
						
						 // Draw:
						player_hud(global.hud_pause_vars, 0, false);
						
						draw_reset_projection();
						random_set_seed(_lastSeed);
						break;
					}
				}
			}
		}
	}