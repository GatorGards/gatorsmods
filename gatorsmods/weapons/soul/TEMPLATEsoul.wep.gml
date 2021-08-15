#define init
//#region MACROS
#macro s "sprites/"
#macro sammo mod_variable_get("mod", "gatorweps_master", "soulammo") //Gets the `soulammo` variable from the master mod
//#endregion

global.sprite = sprite_add_weapon(s + "soulrevolver.png", -2, 3); //Weapon Sprite
global.spriteHUD = sprite_add(s + "soulrevolverHUD.png", 1, 0, 3); //HUD Sprite (Get the Weapon Sprite and make it a solid Blue color (Pick it from another weapon) to get the cool blue outline)
global.muzzle = sprite_add(s + "muzzleflash.png", 1, 8, 8) //Muzzle flash sprite

#define weapon_name					return "SOUL BASE"; //Name of the weapon
#define weapon_type					return 0; //Type of weapon it is (Leave as 0 pls)
#define weapon_cost					return 0; //Weapon cost (Also leave as 0 pls)
#define weapon_area					return 11; //Where the weapon starts spawning (You can figure this out, probably)
#define weapon_load					return 15; //How fast the weapon fires
#define weapon_swap					return sndSwapPistol; //Sound the weapon makes when swapping
#define weapon_auto					return 0; //Whether it's auto or not
#define weapon_melee				return 0; //Whether it's melee or not
#define weapon_laser_sight			return 0; //Whether it has laser sight
#define weapon_sprt					return global.sprite; //The weapon sprite
#define weapon_sprt_hud				return global.spriteHUD; //The hud sprite

#define weapon_soul					return true; //This should ALWAYS return true, makes sure the game knows that it's a soul weapon with regenerating ammo

#define weapon_fire
motion_add(gunangle,-2); //Pushes the player back a bit
weapon_post(7, 8, 8); //Screenshake & stuff

wepcost = 3 //How much ammo it takes when fired (Soul ammo maxes at 100)

if sammo >= wepcost{
	//Fire code (Make sure to add the macros up there ^^^ to you gun)
	mod_variable_set("mod", "gatorweps_master", "soulammo",sammo - other.wepcost)
	
	//All the other shit
	sound_play(sndPistol);
	
	//Creates the soul projectile
	with(mod_script_call("mod","gatorweps_master","soul_projectile_create",x + lengthdir_x(15, gunangle), y + lengthdir_y(15, gunangle))){
		direction = other.gunangle + random_range(-1,1) * other.accuracy;
		image_angle = direction;
	}
	
	//Creates the muzzle flash
	with instance_create(x+lengthdir_x(15,gunangle),y+ lengthdir_y(15,gunangle),CustomObject){
		depth = -1
		sprite_index = global.muzzle
		image_speed = 1.9
		on_step = muzzle_step
		on_draw = muzzle_draw
		image_angle = other.gunangle
	}
}
else{
	//For when theres no charge left
	sound_play(sndEmpty);
}

/* VVV Muzzle Stuff VVV */
#define muzzle_step
if image_index > 1{instance_destroy()}

#define muzzle_draw
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.9*image_xscale, 1.9*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);