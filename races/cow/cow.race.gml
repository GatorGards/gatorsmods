//AWESOME COW RACE! CODED AND SPRITED BY GATOR (WITH HELP FROM OTHERS)
#define init
race_id = "cow";

//#region MACROS
#macro soulcolor `@(color:${make_color_rgb(169, 195, 209)})`
#macro s "sprites/"
#macro ss "sprites/souls/"

#macro soultimer1 2
#macro soultimer2 30
#macro soultimerult 55

#macro has_thronebutt (skill_get(mut_throne_butt))

#macro has_ultra_a (ultra_get(mod_current, 1))
#macro has_ultra_b (ultra_get(mod_current, 2))
#macro has_ultra_c (ultra_get(mod_current, 3))
#macro has_ultra_d (ultra_get(mod_current, 4))
//#endregion

//A-Skin
global.spridle[0] = sprite_add(s + "idleA.png", 4, 12, 12);
global.sprwalk[0] = sprite_add(s + "walkA.png", 6, 12, 12);
global.sprhurt[0] = sprite_add(s + "hurtA.png", 3, 12, 12);
global.sprdead[0] = sprite_add(s + "deadA.png", 6, 12, 12);
global.sprsit1[0] = sprite_add(s + "sit1A.png", 3, 12, 12);
global.sprsit2[0] = sprite_add(s + "sit2A.png", 1, 12, 12);

//B-Skin
global.spridle[1] = sprite_add(s + "idleB.png", 4, 12, 12);
global.sprwalk[1] = sprite_add(s + "walkB.png", 6, 12, 12);
global.sprhurt[1] = sprite_add(s + "hurtB.png", 3, 12, 12);
global.sprdead[1] = sprite_add(s + "deadB.png", 6, 12, 12);
global.sprsit1[1] = sprite_add(s + "sit1B.png", 3, 12, 12);
global.sprsit2[1] = sprite_add(s + "sit2B.png", 1, 12, 12);

//Souls
global.sprsoulidle = sprite_add(ss + "idleSoul.png", 6, 12, 12);

global.sprsoulproj = sprite_add(ss + "projSoul.png", 1, 6, 6)
global.sprsoulprojcharge = sprite_add(ss + "projSoulCharge.png", 1, 9, 8)

global.sprsoulprojgun = sprite_add(ss + "projSoulGun.png", 1, 6, 6)
global.sprsoulprojchargegun = sprite_add(ss + "projSoulChargeGun.png", 1, 9, 8)

global.sprsmallsoulexplosion = sprite_add(ss + "smallexplosionSoul.png", 7, 12 ,12)
global.sprsoulexplosion = sprite_add(ss + "explosionSoul.png", 9, 24, 24)
global.sprsoulexplosionultra = sprite_add(ss + "explosionSoulUltra.png", 9, 24, 24)
global.soulparticles = sprite_add(ss + "particles.png", 6, 4, 4)

//Menu/HUD
global.sprslct = sprite_add(s + "slct.png", 1, 0, 0);
global.sprport = sprite_add(s + "port.png", race_skins(), 21, 235);
global.sprmapico = sprite_add(s + "mapico.png", 2, 10, 10);
global.sprskin = sprite_add(s + "skin.png", race_skins(), 16, 16);
global.sprultr = sprite_add(s + "ultr.png", 2, 12, 16);
global.sprulti = [sprite_add(s + "ulti.png", 1, 9, 9), sprite_add(s + "ulti2.png", 1, 9, 9)]

/*Sprite Reloads, Bee does this for their races and it's awesome
It lets you reload the race without the Players sprites going invisible*/
	with(instances_matching(Player, "race", mod_current)){ 
		assign_sprites();
	}

#define create
//#region SPRITE SETTING
spr_idle = global.spridle[bskin];
spr_walk = global.sprwalk[bskin];
spr_hurt = global.sprhurt[bskin];
spr_dead = global.sprdead[bskin];
spr_sit1 = global.sprsit1[bskin];
spr_sit2 = global.sprsit2[bskin];
spr_slct = global.sprslct;
//#endregion

//#region RACE VARIABLES
maxhealth = 6;

//Soul stuff
soulmult = 1;
chargespeed = 25;
soultemp = 0;
souldiff = 0;
soulcharge = 0;
chargemax = 3;
//#endregion

#define race_ultra_name
switch(argument0){
		case 1: return "POSSESSION";
		case 2: return "RESTLESS SPIRITS";
		//case 3: if(mod_exists("mod", "metamorphosis")) return "ULTRA C";
		//case 4: if(mod_exists("mod", "LOMutsSprites")) return "ULTRA D";
}
#define race_ultra_text
switch(argument0){
		case 1: return `@wTHREE @sEXTRA#${soulcolor}SOUL SLOTS`;
		case 2: return `${soulcolor}SOULS@s @wIMMEDIATELY@s FLY AWAY#${soulcolor}SOUL EXPLOSIONS@s DROP ${soulcolor}SOULS@s`;
		//case 3: if(mod_exists("mod", "metamorphosis")) return `@sNYI`
		//case 4: if(mod_exists("mod", "LOMutsSprites")) return `@sNYI`
}

#define race_name
switch(player_get_skin(("index" in other) ? other.index : 0)){
	case 1  : return "CLAIRE";
	default : return "COW";
}

#define race_text					return `LESS MAX @rHP#${soulcolor}SOUL @wEXTRACTION#${soulcolor}SOUL @wMANIPULATION`;
#define race_skins					return 2;
#define race_menu_button			sprite_index = global.sprslct;
#define race_mapicon				return global.sprmapico;
#define race_portrait				return global.sprport;
#define race_skin_button			sprite_index = global.sprskin image_index = argument0;
#define race_tb_text				return `${soulcolor}SOULS @wTARGET@s#@rENEMIES@s`
#define race_ultra_button			sprite_index = global.sprultr; image_index = argument0-1; image_speed = 0
#define race_ultra_icon 			return global.sprulti[argument0-1]
#define race_soundbank				return "rebel";
#define race_menu_select			return sndMutant10Slct

#define race_ttip
if(has_any_ultra()) && random(10) > 5{
	if(has_ultra_a){
		return choose(
			"SUCH TORMENT...",
			"THE ATMOSPHERE SCREAMS#IN ANGUISH",
			"HELLO, IS ANYONE THERE?"
		);
	}
	if(has_ultra_b){
		return choose(
			"I THINK IT'S#TIME TO MOVE ON",
			"BUT I NEED TO#HARNESS THIS POWER",
			"WHERE AM I?"
		);
	}
}
else{
	return choose(
		"COW ISN'T FROM HERE",
		"NOT A REAL COW!",
		"GROUND BEEF",
		"COW ABUNGA",
		"WHAT'S THIS ABOUT#A @wDEMON?@s",
		"WHAT'S THIS ABOUT#A @wSHAPESHIFTER?@s",
		"HER NAME'S CLAIRE"
		);
}

#define race_swep
switch(player_get_skin(("index" in other) ? other.index : 0)){
	case 1  : return "soulscythe";
	default : return "cowscythe";
}

#define step
//#region PASSIVE(S)
//Soul Spawning (PASSIVE)
if(instance_exists(enemy)){
	with(instances_matching_le(enemy, "my_health", 0)){
		if("soulextra" in self){
			if random(5) < 1{
				if(has_ultra_b){
					repeat(soulextra) with(soulproj_create(x,y,true)){
						if (has_ultra_b){
							sprite_index = global.sprsoulprojcharge
						}
						else sprite_index = global.sprsoulproj
					}
				}
			}
			else if(!has_ultra_b) if(random(5) < 1) repeat(soulextra) soul_create(x,y);
		}
		else{
			if(has_ultra_b){
				if random(5) < 1{
					with(soulproj_create(x,y,true)){
						if(has_ultra_b){
							sprite_index = global.sprsoulprojcharge
						}
						else sprite_index = global.sprsoulproj
					}
				}
			}
			else if(!has_ultra_b) if(random(5) < 1) soul_create(x,y);
		}
	}
}
//#endregion

//#region ACTIVE
if has_ultra_a{
	chargemax = 6
}
else chargemax = 3

if soulcharge < chargemax{
	soultemp += current_time_scale
}
	
if(soultemp > chargespeed*current_time_scale){
	soultemp = 0
	souldiff = soulcharge
	soulcharge++;
}
	
else if soulcharge >= chargemax{
	soulcharge = chargemax
}
	
if souldiff != soulcharge{
	sound_play_pitch(sndCursedPickup, 1.4 + random(0.4));
	
	with(instance_create(x, y, ChickenB)) {
		depth = depth - 1;
		image_speed = 0.5;
	}
	souldiff = soulcharge
}
	
if(soulcharge = 3){
	if random(2) < 1 with(instance_create(x,y,Curse)){
		sprite_index = global.soulparticles
	}
}

if(button_pressed(index, "spec")){
	if(soulcharge > 0){
		with(soulproj_create(x+lengthdir_x(5,gunangle),y+lengthdir_y(5,gunangle),false)){
			maxspeed = 25;
			turnspeed = 40;
			
			creator = Player;
			
			wallthrough = false;
			tt = 6;
			strtdir = other.gunangle;
			direction = other.gunangle;
			explodamage = 3;
			
			if(has_thronebutt and instance_exists(enemy)){
				msx = instance_nearest(x,y,enemy).x
				msy = instance_nearest(x,y,enemy).y
			}
			else{
				msx = mouse_x
				msy = mouse_y
			}
			
			if(has_thronebutt){
				sprite_index = global.sprsoulprojchargegun
			}
			else sprite_index = global.sprsoulprojgun
		}
		soulcharge -= 1
	}
}

//#endregion

//#region HORN (B)
if(button_pressed(index,"horn")){
	with(instance_create(x, y, PopupText)){
		//#region BASE AREAS
		//#region CAMPFIRE
		if GameCont.area = 0{
			text = choose(
			"THEY'RE ALL DEAD...",
			"DID I DO THIS?",
			"WHAT'S GOING ON?",
			"THE ATMOSPHERE SCREAMS..."
			);
		}
		//#endregion
		
		//#region DESERT
		else if GameCont.area = 1{
			text = choose(
			"IT'S SO HOT...",
			"SANDY...",
			"IT'S SO QUIET...",
			"WHERE IS EVERYONE?"
			);
		}
		//#endregion
		//#region SEWERS
		else if GameCont.area = 2{
			text = choose(
			"IT STINKS!",
			"THIS IS SO GROSS...",
			"YUCK!",
			"WHY ARE THEY SO BIG?"
			);
		}
		//#endregion
		//#region SCRAPYARDS
		else if GameCont.area = 3{
			text = choose(
			"I'M GETTING SOAKED...",
			"ARE THOSE COWBOY ROBOTS?",
			"THEY'VE GOT GUNS...",
			"ARE THEY DEAD?"
			);
		}
		//#endregion
		//#region CAVES
		else if GameCont.area = 4{
			text = choose(
			"IT'S SO PRETTY...",
			"ARE THOSE SPIDERS?",
			"THAT SAC IS MOVING...",
			"STUPID WEBS..."
			);
		}
		//#endregion
		//#region CITY
		else if GameCont.area = 5{
			text = choose(
			"IT'S SO COLD...",
			"ARE THOSE ROBOTS?",
			"WAS THIS A CITY?",
			"SO SLIPPERY..."
			);
		}
		//#endregion
		//#region LABS
		else if GameCont.area = 6{
			text = choose(
			"THESE THINGS ARE HIDEOUS...",
			"ARE THEY IN PAIN?",
			"WHY WON'T THEY DIE?",
			"THIS IS HORRIBLE..."
			);
		}
		//#endregion
		//#region PALACE
		else if GameCont.area = 7{
			text = choose(
			"IT'S SO EERIE...",
			"WHAT ARE THEY MADE OF?",
			"AM I NEARLY THERE?",
			"THEY HAVE NO SOULS..."
			);
		}
		//#endregion
		//#endregion
		
		//#region SECRET AREAS
		//#region VAULTS
		else if GameCont.area = 100{
			text = choose(
			"WHAT'S THIS CROWN?",
			"WHAT ARE THESE MARKINGS?",
			"THIS PLACE SEEMS OLD...",
			"WHO BUILT THIS?"
			);
		}
		//#endregion
		//#region OASIS
		else if GameCont.area = 101{
			text = choose(
			"HOW AM I BREATHING?",
			"I'M GONNA GET WET...",
			"ARE THOSE THEIR BONES?",
			"SO BEAUTIFUL..."
			);
		}
		//#endregion
		//#region PIZZA SEWERS
		else if GameCont.area = 102{
			text = choose(
			"THIS REMINDS ME OF SOMETHING...",
			"WHY IS THERE PIZZA HERE?",
			"WHERE DID THEY GET THIS TV?",
			"WHERE'S THEIR HEADBANDS?"
			);
		}
		//#endregion
		//#region MANSION
		else if GameCont.area = 103{
			text = choose(
			"AM I IN SPACE?",
			"I HEAR SINGING...",
			"IT'S SO FANCY...",
			"WHAT ARE THESE THINGS?"
			);
		}
		//#endregion
		//#region CURSED CAVES
		else if GameCont.area = 104{
			text = choose(
			"EVERYTHING'S SCREAMING...",
			"THIS ISN'T RIGHT...",
			"I HEAR THEIR SUFFERING...",
			"I'M SCARED..."
			);
		}
		//#endregion
		//#region JUNGLE
		else if GameCont.area = 105{
			text = choose(
			"SO MANY LEAVES...",
			"SUCH THICK FOREST...",
			"ARE THOSE FLIES?",
			"DID THAT BUSH JUST MOVE?"
			);
		}
		//#endregion
		//#region IDPD HEADQUARTERS
		else if GameCont.area = 106{
			text = choose(
			"ARE THESE COPS?",
			"ARE THEY HUMAN?",
			"SO FUTURISTIC...",
			"THEY'RE ADVANCED..."
			);
		}
		//#endregion
		//#region CRIB
		else if GameCont.area = 107{
			text = choose(
			"AM I IN SPACE?",
			"WHO'S THIS GUY?",
			"IT'S SO FANCY...",
			"SO MANY GUNS..."
			);
		}
		//#endregion
		//#endregion
		else{
			text = choose(
			"WHERE AM I?",
			"I'M SO LOST...",
			"I HEAR SCREAMING...",
			"AM I DEAD?"
			);
		}
	}
}

//#endregion

#define soul_create(_x,_y)
if instance_exists(Player){
	with(instance_create(x+random_range(-15,15), y+random_range(-15,15), CustomObject)){
		depth = -7
		sprite_index = global.sprsoulidle;
		speed = 0;
		direction = other.direction;
		targ = noone;
		pickable = false;
		t = 50
		on_step = soul_step;
		
		return self;
	}
}
#define soul_step
	if random(2) < 1 with(instance_create(x,y,Curse)){
		sprite_index = global.soulparticles
		depth = -7
	}
	image_speed = 0.5;
	t--;
	if(t <= 0){
		soulproj_create(x,y,false)
		instance_delete(self);
	}
#define soulproj_create(_x,_y,_thronebuttd)
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
	
	strtdir = random(360);
	turnspeed = 25;
	
	if(has_thronebutt and instance_exists(enemy)){
		msx = instance_nearest(x,y,enemy).x
		msy = instance_nearest(x,y,enemy).y
	}
	else{
		msx = random_range(-360,360);
		msy = random_range(-360,360);
	}
	
	turndir = choose(-1,1);
	dircorrect = false;
	
	image_angle = direction
	thronebuttd = _thronebuttd
	wallthrough = true
	
	soul_on_hit = 0;
	on_step = soulproj_step;
	on_destroy = soulproj_destroy;
	
	kill = 0
	
	sound_play_pitch(sndBloodHurt, 1.4 + random(0.4));
	return self;
}
}
#define soulproj_step
	with(instance_create(x,y,Curse)){
		sprite_index = global.soulparticles
		depth = -7
	}
	
ang = point_direction(x,y,msx,msy);
angdif = angle_difference(direction,ang);
image_angle = direction
kill++

if(kill >= 250){
	soul_on_hit = 1;
}

//Movement
if(tt <= 5){
	tt++;
	direction = strtdir;
}
else if(abs(angdif) <= turnspeed){
	direction = ang;
	dircorrect = true;
}
else{
	if(dircorrect != true) direction += turnspeed*turndir;
}

motion_add_ct(direction, minspeed);

if(speed > maxspeed){
    speed = maxspeed;
}

//Soul Hit Enemy
with(enemy){
	if(place_meeting(x, y, self)){
		if my_health < 1{
		soul_on_hit = 1;
		}
	}
}

//Soul Hit Wall
if(!place_meeting(x, y, Wall)){
	wallthrough = false
}
if(dircorrect == true and wallthrough == false){
	if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall)){
		speed = 0;
		soul_on_hit = 1;
	}
}

//Soul Hit
if(soul_on_hit == 1){
	if(thronebuttd = true and has_ultra_b){
		soul_create(x,y)
	}
	soulproj_destroy();
}

#define soulproj_destroy
	with(instance_create(x,y,other.explotype)){
		sprite_index = other.explospr
		damage = round(other.explodamage*GameCont.level)
		force = 0;
		if(instance_exists(Player)){
		team = Player.team;
		}
		else team = enemy.team;
	}
	sound_play_pitchvol(other.explosnd, random_range(1,2), 1);
	soul_on_hit = 0;
	instance_destroy();
	
#define assign_sprites
	if(object_index == Player) {
		spr_idle = global.spridle[bskin];
		spr_walk = global.sprwalk[bskin];
		spr_hurt = global.sprhurt[bskin];
		spr_dead = global.sprdead[bskin];
		spr_sit1 = global.sprsit1[bskin];
		spr_sit2 = global.sprsit2[bskin];
	}
	
#define has_any_ultra
for(var i = 1;i<=ultra_count(race) ;i++){
	if ultra_get(mod_current,i){
		return true;
		exit;
		}
	}
return false;
//Thanks for this, Spaz :)
	
//#define chance_ct(percent)
//return random(100) <= percent * current_time_scale;