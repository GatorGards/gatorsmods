#define init
//#region MACROS
#macro s "sprites/"
#macro sammo mod_variable_get("mod", "gatorweps_master", "soulammo")
//#endregion

global.sprite = sprite_add_weapon(s + "soulminigun.png", 3, 4);
global.spriteHUD = sprite_add(s + "soulminigunHUD.png", 1, 0, 5);
global.muzzle = sprite_add(s + "muzzleflash.png", 1, 8, 8)

#define weapon_name					return "SOUL MINIGUN";
#define weapon_type					return 0;
#define weapon_cost					return 0;
#define weapon_area					return 19;
#define weapon_load					return 4;
#define weapon_swap					return sndMinigun;
#define weapon_auto					return 1;
#define weapon_melee				return 0;
#define weapon_laser_sight			return 0;
#define weapon_sprt					return global.sprite;
#define weapon_sprt_hud				return global.spriteHUD;
#define weapon_soul					return true;

#define weapon_fire
motion_add(gunangle,-5);
weapon_post(7, 8, 8);

//How much ammo it takes when fired (Soul ammo maxes at 100)
if skill_get(mut_trigger_fingers) or (mod_exists("mod", "metamorphosis")) and skill_get("racingthoughts"){
	wepcost = 4
}
else wepcost = 5

if sammo >= wepcost{
	//Fire code (Make sure to add the macros up there ^^^ to you gun)
	mod_variable_set("mod", "gatorweps_master", "soulammo",sammo - wepcost)
	
	//All the other shit
	sound_play(sndPistol);
	
	with(mod_script_call("mod","gatorweps_master","soul_projectile_create",x + lengthdir_x(15, gunangle), y + lengthdir_y(15, gunangle))){
		direction = other.gunangle + random_range(-15,15) * other.accuracy;
		image_angle = direction;
	}
	
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
	sound_play(sndEmpty);
}

#define muzzle_step
if image_index > 1{instance_destroy()}

#define muzzle_draw
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.9*image_xscale, 1.9*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);