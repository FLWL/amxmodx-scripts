#include <amxmodx>
#include <engine>
#include <fakemeta>
#include <fun>
#include <zp50_core>
#include <zp50_class_zombie>
#include <zp50_colorchat>

new cvar_ability_delay

new Float:g_last_use[33]

new g_class_id
new g_sprite
new g_maxplayers

public plugin_precache()
{
	register_plugin("[ZP50] Zombie Class: Healer", "1.0", "FLWL")
	g_class_id = zp_class_zombie_register("Healer Zombie", "Ability to heal", 2500, 1.0, 0.8)
	zp_class_zombie_register_kb(g_class_id, 1.1)
	zp_class_zombie_register_model(g_class_id, "zombie_source")
	zp_class_zombie_register_claw(g_class_id, "models/zombie_plague/v_knife_zombie.mdl")
	
	g_sprite = precache_model("sprites/zombie_plague/zb_restore_health.spr")
}

public plugin_init()
{
	cvar_ability_delay = register_cvar("zp_zombie_class_healer_delay", "30.0")
	
	register_clcmd("drop", "clcmd_drop")
	
	g_maxplayers = get_maxplayers()
	
	set_task(5.0, "task_global_heal", _, _, _, "b")
}

public clcmd_drop(id)
{
	if (!zp_core_is_zombie(id) || zp_class_zombie_get_current(id) != g_class_id)
		return PLUGIN_CONTINUE;
	
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime - g_last_use[id] < get_pcvar_float(cvar_ability_delay))
		return PLUGIN_CONTINUE;
	
	static Float:origin[3]
	entity_get_vector(id, EV_VEC_origin, origin)
	
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
	write_byte(TE_SPRITE)
	engfunc(EngFunc_WriteCoord, origin[0])
	engfunc(EngFunc_WriteCoord, origin[1])
	engfunc(EngFunc_WriteCoord, origin[2] + 30.0)
	write_short(g_sprite)
	write_byte(8)
	write_byte(255)
	message_end()
	
	// Collisions
	static victim
	victim = -1
	
	while ((victim = find_ent_in_sphere(victim, origin, 250.0)))
	{
		// Only effect alive zombies
		if (!is_user_alive(victim) || !zp_core_is_zombie(victim))
			continue;
		
		heal(victim, floatround(float(zp_class_zombie_get_max_health(victim, zp_class_zombie_get_current(victim)) / 2)))
	}
	
	g_last_use[id] = gametime
	return PLUGIN_HANDLED;
}

public task_global_heal()
{
	for (new id = 1; id < g_maxplayers; id++)
	{
		if (!is_user_alive(id) || !zp_core_is_zombie(id) || zp_class_zombie_get_current(id) != g_class_id)
			continue;
		
		heal(id, random_num(100, 500))
	}
}

heal(id, amount)
{
	static health, newhealth
	health = get_user_health(id)
	newhealth = clamp(health + amount, 1, zp_class_zombie_get_max_health(id, zp_class_zombie_get_current(id)))
	
	if (newhealth > health) set_user_health(id, newhealth)
}
