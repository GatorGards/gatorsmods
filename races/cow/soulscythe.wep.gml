#define init
//#region MACROS
#macro s "sprites/weapons/"
#macro sammo mod_variable_get("mod", "gatorweps_master", "soulammo")
//#endregion

global.sprite = sprite_add_weapon(s + "soulscythe.png", 3, 5);
global.spriteHUD = sprite_add(s + "soulscytheHUD.png", 1, 0, 5);
global.spriteLOADOUT = sprite_add_weapon(s + "soulscytheLOADOUT.png", 24, 24)
global.slash = sprite_add(s + "soulslash.png", 3, 0, 24)

#define weapon_name					return "SOUL SCYTHE";
#define weapon_text					return "A DEMON'S TRUE BEST FRIEND";
#define weapon_type					return 0;
#define weapon_cost					return 0;
#define weapon_area					return 23;
#define weapon_load					return 12;
#define weapon_swap					return sndSwapSword;
#define weapon_auto					return 1;
#define weapon_melee				return 1;
#define weapon_laser_sight			return 0;
#define weapon_sprt					return global.sprite;
#define weapon_sprt_hud				return global.spriteHUD;
#define weapon_loadout				return global.spriteLOADOUT;
#define weapon_soul					return true;

#define weapon_fire
//How much ammo it takes when fired (Soul ammo maxes at 100)
if skill_get(mut_trigger_fingers) or (mod_exists("mod", "metamorphosis")) and skill_get("racingthoughts"){
	wepcost = 5
}
else wepcost = 6

if sammo >= wepcost{
	//Fire code (Make sure to add the macros up there ^^^ to you gun)
	mod_variable_set("mod", "gatorweps_master", "soulammo",sammo - wepcost)
	
	//All the other shit
	wepangle = -wepangle;
	motion_add(gunangle,5);
	weapon_post(5,8,3);
	
	sound_play(sndChickenSword);
	
	with(instance_create(x, y, Slash)){
		motion_add(other.gunangle, 2 + (skill_get(13) * 5));
		sprite_index = global.slash
		image_angle = direction;
		image_yscale = 1.3
		damage = 12;
		team = other.team;
		creator = other;
	}
}
else{
	sound_play(sndUltraEmpty);
}
#define weapon_reloaded
	wepflip = sign(wepangle)