#include <amxmodx>
#include <engine>
#include <fun>
#include <zp50_core>

new const MODEL[] = "models/zombie_plague/presents.mdl"
new const SOUND[] = "zombie_plague/present_spawn.wav"

enum (+= 2000)
{
	TASK_SPAWN
}

public plugin_precache()
{
	precache_model(MODEL)
	precache_sound(SOUND)
}

public plugin_init()
{
	register_plugin("[ZP] Supply Boxes", "1.0", "FLWL")
	
	register_touch("supply_box", "player", "touch_supply_box")
}

public zp_fw_gamemodes_start()
{
	set_task(random_float(20.0, 40.0), "spawn_random_supply_box", TASK_SPAWN, _, _, "b")
}

public zp_fw_gamemodes_end()
{
	remove_task(TASK_SPAWN)
	remove_entity_name("supply_box")
}

public spawn_random_supply_box()
{
	new Num, Float:originF[3]
	if (!FindEmptyLoc(get_random_alive_player(), originF, Num, 1000.0)) return;
	
	spawn_supply_box(originF)
}

spawn_supply_box(Float:originF[3])
{
	new ent = create_entity("info_target")
	
	if (ent)
	{
		entity_set_string(ent, EV_SZ_classname, "supply_box")
		entity_set_model(ent, MODEL)
		
		entity_set_int(ent, EV_INT_solid, SOLID_TRIGGER)
		entity_set_int(ent, EV_INT_movetype, MOVETYPE_TOSS)
		
		entity_set_float(ent, EV_FL_gravity, 1.0)
		
		// Glow
		entity_set_int(ent, EV_INT_iuser1, random(255))
		entity_set_int(ent, EV_INT_iuser2, random(255))
		entity_set_int(ent, EV_INT_iuser3, random(255))
		set_rendering(ent, kRenderFxGlowShell, entity_get_int(ent,EV_INT_iuser1), entity_get_int(ent,EV_INT_iuser2), entity_get_int(ent,EV_INT_iuser3), kRenderNormal,60)
		
		entity_set_origin(ent, originF)
		
		entity_set_float(ent, EV_FL_nextthink, halflife_time() + 0.01)
		
		// Sound
		emit_sound(ent, CHAN_AUTO, SOUND, VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
	}
}

public touch_supply_box(ent, id)
{
	remove_entity(ent)
	
	// Add any rewards here, currently it just gives the looter +100 HP
	set_user_health(id, get_user_health(id) + 100)
}

get_random_alive_player()
{
	static iPlayers[32], iNum
	get_players(iPlayers, iNum, "a")
	
	return iPlayers[random(iNum - 1)];
}

stock FindEmptyLoc(id, Float:Origin[3], &Num, Float:Radius)
{
	if (Num++ > 100)
		return PLUGIN_CONTINUE;
	
	new Float:pOrigin[3]
	entity_get_vector(id, EV_VEC_origin, pOrigin)
	
	for (new Count; Count < 2; Count++)
		pOrigin[Count] += random_float(-Radius,Radius)
	
	if (PointContents(pOrigin) != CONTENTS_EMPTY && PointContents(pOrigin) != CONTENTS_SKY)
		return FindEmptyLoc(id, Origin, Num, Radius);
	
	Origin = pOrigin
	return PLUGIN_HANDLED;
}
