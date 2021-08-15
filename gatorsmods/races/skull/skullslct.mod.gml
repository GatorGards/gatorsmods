#define init
skull = noone
global.campfire = sprite_add("sprites/campfire.png", 1, 24, 24)

#define step
with CampChar if "skullpos" in self other.skull = self
if instance_exists(Menu){
	if skull = noone || !instance_exists(skull){
		with instance_create(104,120,CampChar){

			spr_shadow_x = 0
			spr_shadow_y = -2
				
			do {x += random_range(-30,30);y+= random_range(-30,30)}
			until !place_meeting(x,y,Wall) && !place_meeting(x,y,CampChar)
			num = 0
			skullpos = [x,y]
			other.skull = self
			repeat(5) with instance_create(x,y,Dust){
				speed = random_range(2,5)
				direction = random(360)
			}
		}
	}
}

script_bind_step(scr,0)

#define scr
with CampChar if "skullpos" in self{

	x = skullpos[0]
	y = skullpos[1]

	sprite_index = global.campfire

	for(var i = 0; i < maxp; i++){
	if player_get_race(i) = "skull" with(instance_create(0, 0, Revive)){
		var sh = UberCont.opt_shake
		UberCont.opt_shake = 1
		p = i
		instance_change(Player,false)
		gunangle = point_direction(64,64,other.x,other.y)
		weapon_post(0,point_distance(64,64,other.x,other.y)/10*current_time_scale,0)
		instance_delete(self)
		UberCont.opt_shake = sh
	}
	}
}
instance_destroy()