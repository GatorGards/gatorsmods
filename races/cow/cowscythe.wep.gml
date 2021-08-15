#define init
//#region MACROS
#macro sw "sprites/weapons/"
//#endregion

global.scythe = sprite_add_weapon(sw + "scythe.png", 3, 5);
global.scytheLOADOUT = sprite_add_weapon(sw + "loadoutScythe.png", 24, 24)

#define weapon_name					return "SCYTHE";
#define weapon_text					return "A DEMON'S BEST FRIEND";
#define weapon_type					return 0;
#define weapon_cost					return 0;
#define weapon_area					return -1;
#define weapon_load					return 18;
#define weapon_swap					return sndSwapSword;
#define weapon_auto					return 0;
#define weapon_melee				return 1;
#define weapon_laser_sight			return 0;
#define weapon_sprt					return global.scythe;
#define weapon_loadout				return global.scytheLOADOUT;
#define weapon_fire
	//Sound:
	sound_play(sndChickenSword);

	//Visuals/Movement
	wepangle = -wepangle;
	weapon_post(5,8,3);
	motion_add(gunangle,5);

	 // Create Slashes:
	with(instance_create(x, y, Slash)){
		motion_add(other.gunangle, 2 + (skill_get(13) * 5));
		image_angle = direction;
		image_yscale = 1.2
		image_xscale = 0.8
		damage = 5;
		team = other.team;
		creator = other;
	}
#define weapon_reloaded
	wepflip = sign(wepangle)