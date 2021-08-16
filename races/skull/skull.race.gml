//AWESOME COW RACE! CODED AND SPRITED BY GATOR (WITH HELP FROM OTHERS)
#define init
race_id = "skull";

//#region MACROS
#macro s "sprites/"

#macro has_ultra_a (ultra_get(mod_current, 1))
#macro has_ultra_b (ultra_get(mod_current, 2))
#macro has_ultra_c (ultra_get(mod_current, 3))
#macro has_ultra_d (ultra_get(mod_current, 4))
//#endregion

//A-Skin
global.spridle[0] = sprite_add(s + "idleA.png", 7, 12, 12);
/*global.sprwalk[0] = sprite_add(s + "walkA.png", 6, 12, 12);
global.sprhurt[0] = sprite_add(s + "hurtA.png", 3, 12, 12);
global.sprdead[0] = sprite_add(s + "deadA.png", 6, 12, 12);
global.sprsit1[0] = sprite_add(s + "sit1A.png", 3, 12, 12);
global.sprsit2[0] = sprite_add(s + "sit2A.png", 1, 12, 12);*/

//B-Skin
global.spridle[1] = sprite_add(s + "idleB.png", 7, 12, 12);
/*global.sprwalk[1] = sprite_add(s + "walkB.png", 6, 12, 12);
global.sprhurt[1] = sprite_add(s + "hurtB.png", 3, 12, 12);
global.sprdead[1] = sprite_add(s + "deadB.png", 6, 12, 12);
global.sprsit1[1] = sprite_add(s + "sit1B.png", 3, 12, 12);
global.sprsit2[1] = sprite_add(s + "sit2B.png", 1, 12, 12);*/

//A-Skin
global.sprwalk[0] = sprite_add(s + "walkA.png", 1, 12, 12);
global.sprhurt[0] = sprite_add(s + "hurtA.png", 3, 12, 12);
global.sprdead[0] = sprite_add(s + "deadA.png", 1, 12, 12);
global.sprsit1[0] = sprite_add(s + "sit1A.png", 1, 12, 12);
global.sprsit2[0] = sprite_add(s + "sit2A.png", 1, 12, 12);

//B-Skin
global.sprwalk[1] = sprite_add(s + "walkB.png", 1, 12, 12);
global.sprhurt[1] = sprite_add(s + "hurtB.png", 3, 12, 12);
global.sprdead[1] = sprite_add(s + "deadB.png", 1, 12, 12);
global.sprsit1[1] = sprite_add(s + "sit1B.png", 1, 12, 12);
global.sprsit2[1] = sprite_add(s + "sit2B.png", 1, 12, 12);

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

//#region VARIABLES
cursecharge = 0
curseboost = false
//#endregion

#define race_ultra_name
switch(argument0){
		case 1: return "ULTRA A";
		case 2: return "ULTRA B";
		case 3: if(mod_exists("mod", "metamorphosis")) return "ULTRA C";
		case 4: if(mod_exists("mod", "LOMutsSprites")) return "ULTRA D";
}
#define race_ultra_text
switch(argument0){
		case 1: return `@sNYI`;
		case 2: return `@sNYI`;
		case 3: if(mod_exists("mod", "metamorphosis")) return `@sNYI`
		case 4: if(mod_exists("mod", "LOMutsSprites")) return `@sNYI`
}

#define race_name					return (player_get_skin(0) ? "DAMIEN" : "SKULL")
#define race_text					return `NO CURSE WEAPON DROPS#BUFFED CURSE WEAPONS#CURSE YOUR WEAPON`;
#define race_skins					return 2;
#define race_menu_button			sprite_index = global.sprslct;
#define race_mapicon				return global.sprmapico;
#define race_portrait				return global.sprport;
#define race_skin_button			sprite_index = global.sprskin image_index = argument0;
#define race_tb_text				return `@sNYI`
#define race_ultra_button			sprite_index = global.sprultr; image_index = argument0-1; image_speed = 0
#define race_ultra_icon 			return global.sprulti[argument0-1]
#define race_soundbank				return "melting";
#define race_menu_select			return sndMutant4Slct

#define race_ttip
if(has_any_ultra()) && random(10) > 5{
	if(has_ultra_a){
		return choose(
			"DEEZ"
		);
	}
	if(has_ultra_b){
		return choose(
			"NUTS"
		);
	}
}
else{
	return choose(
		"HA",
		"GOTEM"
		);
}

#define race_swep
switch(player_get_skin(("index" in other) ? other.index : 0)){
	case 1  : return wep_machinegun;
	default : return wep_revolver;
}

#define step
//#region HORN (B) ((THESE ARE COWS, I'LL FINISH THEM LATER LOLOLOLOLOL!!))
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

//#region PASSIVE(S)
//#region EVIL PASSIVE / No Curse Weapon Drops
with(WepPickup){
	if "curse" in self{
		curse = 0
	}
}
//#endregion
//#region HOLY PASSIVE?! / Buffed cursed weapons
with(Player){
	if(curse = 1){
		//Apply boost
		if(!curseboost){
			reloadspeed += 0.4 //Faster reload
			accuracy -= 0.4 //Better accuracy
			
			curseboost = true //Shows that the boost is active for other things
		}
	}
	else{
		//Remove boost
		if(curseboost){
			reloadspeed -= 0.4
			accuracy += 0.4
			
			curseboost = false
		}
	}
}
//#endregion
//#endregion

//#region ACTIVE
if wep or bwep != wep_none{
	if curse = 0{
		if(button_check(index, "spec")){
			cursecharge += 1*current_time_scale
			sound_play_pitchvol(sndCursedPickup,cursecharge/5, 0.8);
		
		if cursecharge >= 25*current_time_scale{
			sound_play_pitch(sndCursedChest, 1);
			if random(2) < 1 instance_create(x,y,Curse)
			cursecharge = 0
			curse = 1
			}
		}
	}
}

if(button_released(index, "spec")){
	cursecharge = 0
}
//#endregion

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