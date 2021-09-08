#define init
global.racelist = ["cow","skull"]
global.shadowx = [0,0,1]
global.shadowy = [6.5,0,5]
num = 0
with CampChar if "_id" in self {
	instance_delete(self)
}

//Cow
global.sprt_slct[0] = sprite_add("cow/sprites/campfire.png",		24, 24, 16); //Selected
global.sprt_menu[0] = sprite_add("cow/sprites/campfire.png",		24, 24, 16); //Waiting
global.sprt_from[0] = sprite_add("cow/sprites/campfire.png",		24, 24, 16); //Selecting
global.sprt_to[0]	= sprite_add("cow/sprites/campfire.png",		24, 24, 16); //Deselecting

//Skull
global.sprt_slct[1] = sprite_add("skull/sprites/campfire.png",		 1, 24, 24); //Selected
global.sprt_menu[1] = sprite_add("skull/sprites/campfire.png",		 1, 24, 24); //Waiting
global.sprt_from[1] = sprite_add("skull/sprites/campfire.png",		 1, 24, 24); //Selecting
global.sprt_to[1]	= sprite_add("skull/sprites/campfire.png",		 1, 24, 24); //Deselecting

#macro anim_end (image_index + image_speed >= image_number || image_index + image_speed < 0)

#define step
script_bind_step(scr,0)
with CampChar if "_id" in self {
	other.num += 1
}
if instance_exists(Menu){
	if num < array_length(global.racelist){
		for (var a = 0; a < array_length(global.racelist); a ++) {
			var xpos = 0;
			var ypos = 0;
			with instance_create(Campfire.x,Campfire.y,CampChar){
				//Visual
				spr_slct = global.sprt_slct[a] //Selected
				spr_menu = global.sprt_menu[a] //Waiting
				spr_from = global.sprt_from[a] //Selecting
				spr_to = global.sprt_to[a] //Deselecting
				sprite_index = spr_menu
				spr_shadow_x = global.shadowx[a]
				spr_shadow_y = global.shadowy[a]
				//Important
				_id = a;
				num = 0.1;
				race = global.racelist[a]
				mask_index = sprite_index
				//Position
				var _tries = 1000;
				while(_tries-- > 0){
					// Move Somewhere
					x = xstart;
					y = ystart;
					move_contact_solid(random(360), random_range(32, 64) + random(random(64)));
					x = round(x);
					y = round(y);
					// Safe
					if(!collision_circle(x, y, 24, CampChar, true, true) && !collision_circle(x, y, 24, Wall, true, true)  && !collision_circle(x, y, 8, TV, true, true)){
						xpos = x;
						ypos = y;
						break;
					}
				}
			}
		}
	} else num = 0;
}

#define scr
with CampChar if "_id" in self{
	//Panning && Animation			
	for(var i = 0; i < maxp; i++) if player_is_active(i) {
		if player_get_race(i) == global.racelist[_id] with(instance_create(0, 0, Revive)){
			//Checks if you're playing on Local Multiplayer
			var _local = false;
			for(var j = 0; j < maxp; j++) {
				if(j != i && player_get_uid(j) == player_get_uid(i)) {
					_local = true;
					break;
				}
			}
			//Only pans camera if you're NOT on Local
			if(!_local){
				var shake = UberCont.opt_shake;
				UberCont.opt_shake = 1.15;
				instance_change(Player,false);
				p = i;
				gunangle = point_direction(64,64,other.x,other.y);
				weapon_post(0,point_distance(64,64,other.x,other.y)/10*current_time_scale,0);
			}
			if(anim_end) {
				if(sprite_index != spr_slct) {
					if(sprite_index == spr_from) {
						sprite_index = spr_slct;
					} else {
						sprite_index = spr_from;
					}
				}
				image_index = 0;
			} //Animation
			instance_delete(self);
			UberCont.opt_shake = shake;
		} else if(anim_end) {
			if(sprite_index != spr_menu) {
				if(sprite_index == spr_to ) {
					sprite_index = spr_menu;
				} else {
					sprite_index = spr_to;
				}
			}
			image_index = 0;
		} //Animation
	}
}
instance_destroy()