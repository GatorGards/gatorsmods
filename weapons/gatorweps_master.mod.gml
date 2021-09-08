#define init

#macro soulcolor `@(color:${make_color_rgb(169, 195, 209)})`
#macro s "sprites/"
#macro ss "sprites/souls/"
#macro cs "../races/cow/"
#macro sammo global.soulammo
#macro sammotemp global.soulammotemp
#macro sammodif global.soulammo
#macro mammo 100

global.soulparticles = sprite_add(cs + ss + "particles.png", 6, 4, 4)
global.sprsoulproj = sprite_add(cs + ss + "projSoulGun.png", 1, 6, 6)
global.sprsmallsoulexplosion = sprite_add(cs + ss + "smallexplosionSoul.png", 7, 12 ,12)

global.soulammo = 99
global.soulammotemp = 99
global.souldelay = 0

#define soulproj_create(_x,_y)
if instance_exists(Player){
with(instance_create(_x,_y,CustomProjectile)){
	//These are all default, you can change them in with()
	depth = -7
	tt = 0;
	
	explotype = MeatExplosion;
	explosnd = sndExplosionS;
	explospr = global.sprsmallsoulexplosion;
	explodamage = 2;
	
	maxspeed = 10;
	minspeed = 1;
	
	sprite_index = global.sprsoulproj;
	creator = noone;
	team = Player.team;
	
	direction = other.gunangle
	image_angle = direction
	
	soul_on_hit = 0;
	on_step = soulproj_step;
	on_destroy = soulproj_destroy;
	on_wall = soulproj_destroy;
	
	sound_play_pitch(sndBloodHurt, 1.4 + random(0.4));
	return self;
}
}
#define soulproj_step
	with(instance_create(x,y,Curse)){
		sprite_index = global.soulparticles
		depth = -7
	}

motion_add_ct(direction, minspeed);
image_angle = direction

if(speed > maxspeed){
    speed = maxspeed;
}

#define soulproj_destroy
	with(instance_create(x,y,explotype)){
		sprite_index = other.explospr
		damage = round(other.explodamage*GameCont.level)
		force = 0;
		if(instance_exists(Player)){
		team = Player.team;
		}
		else team = enemy.team;
	}
	sound_play_pitchvol(explosnd, random_range(1,2), 1);
	soul_on_hit = 0;
	instance_destroy();
	
#define soul_projectile_create(xx,yy,nn)
    if mod_script_exists("mod",mod_current, "soulproj_create"){
        with(mod_script_call("mod",mod_current, "soulproj_create", xx, yy)){
            if "name" not in self name = soulproj_create;
            return self;
        }
	}

#define weapon_get_soul(_w)
if is_object(_w) _w = _w.wep //for lwo object weapons.
if is_string(_w){
    var n = mod_script_call_self("weapon", _w, "weapon_soul")
    if n != undefined return n
    else return 0
}

#define step
if instance_exists(Player){
	with(Player){
		if weapon_get_soul(wep) and !(button_check(index, "fire")) or weapon_get_soul(bwep){
				if global.souldelay < 10{
					global.souldelay++
				}
				
				if global.souldelay = 10{
				//
					if sammo < mammo{
						sammotemp += current_time_scale
					}
						
					if(sammotemp > 1*current_time_scale){
						sammotemp = 0
						sammodif = sammo
						sammo++;
						sound_play_pitchvol(sndCursedPickup,sammo/10, 0.8);
					}
						
					else if sammo >= mammo{
						sammo = mammo
					}
					
					if sammodif = 99{
						sound_play_pitch(sndCursedChest, 1);
						
						repeat(5)with(instance_create(x, y, Curse)) {
							depth = Player.depth - 1;
							image_speed = 0.5;
							x += random_range(-5,5)
							y += random_range(-5,5)
						}
					}
				//
				}
    	}
    	else if(button_pressed(index, "fire")){
    		global.souldelay = 0
    	}
	}
}