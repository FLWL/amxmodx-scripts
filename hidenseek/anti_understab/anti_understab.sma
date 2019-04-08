#include <amxmodx>
#include <engine>
#include <cstrike>
#include <hamsandwich>
#include <fun>

new Float:g_fGroundHeight[33]
new cvar_understab_mode
new g_maxplayers

public plugin_init()
{
	register_plugin("Anti-Understab", "1.0", "FLWL")
	
	RegisterHam(Ham_Player_Jump, "player", "fw_Jump_Post", 1)
	RegisterHam(Ham_Player_Duck, "player", "fw_Duck_Post", 1)
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	
	cvar_understab_mode = register_cvar("hns_understab_mode", "1")
	
	g_maxplayers = get_maxplayers()
}

public fw_Jump_Post(id)
{
	if (!is_user_alive(id))
		return;
	
	if (entity_get_int(id, EV_INT_flags) & FL_ONGROUND)
	{
		static Float:fAbsmin[3]
		entity_get_vector(id, EV_VEC_absmin, fAbsmin)
		g_fGroundHeight[id] = fAbsmin[2]
	}
}

public fw_Duck_Post(id)
{
	if (entity_get_int(id, EV_INT_flags) & FL_ONGROUND)
	{
		static Float:fAbsmin[3]
		entity_get_vector(id, EV_VEC_absmin, fAbsmin)
		g_fGroundHeight[id] = fAbsmin[2]
	}
}

public fw_TakeDamage(id, inflictor, attacker, Float:damage, damage_type)
{
	if (!get_pcvar_num(cvar_understab_mode))
		return HAM_IGNORED;
	
	if (!(1 <= attacker <= g_maxplayers))
		return HAM_IGNORED;
	
	if (cs_get_user_team(attacker) != CS_TEAM_CT || cs_get_user_team(id) != CS_TEAM_T)
		return HAM_IGNORED;
	
	// Not knife
	if (!(damage_type & DMG_BULLET|DMG_NEVERGIB) || get_user_weapon(attacker) != CSW_KNIFE || !is_user_alive(id) || !is_user_alive(attacker))
		return HAM_IGNORED;
	
	// Ignore when one of them has noclip (or is on a ladder)
	if (entity_get_int(id, EV_INT_movetype) == MOVETYPE_FLY || entity_get_int(attacker, EV_INT_movetype) == MOVETYPE_FLY)
		return HAM_IGNORED;
	
	// Victim is standing on top of the attacker
	if (entity_get_edict(id, EV_ENT_groundentity) == attacker)
		return HAM_IGNORED;
	
	static Float:fHeight1, Float:fHeight2, Float:fAbsmin[3]
	
	// Player 1, attacker
	if (entity_get_int(attacker, EV_INT_flags) & FL_ONGROUND)
	{
		entity_get_vector(attacker, EV_VEC_absmin, fAbsmin)
		fHeight1 = fAbsmin[2]
	}
	else
		fHeight1 = g_fGroundHeight[attacker]
	
	// Player 2, victim
	if (entity_get_int(id, EV_INT_flags) & FL_ONGROUND)
	{
		entity_get_vector(id, EV_VEC_absmin, fAbsmin)
		fHeight2 = fAbsmin[2]
	}
	else
		fHeight2 = g_fGroundHeight[id]
	
	static Float:distance
	distance = fHeight2 - fHeight1
	
	if (distance > 62.0)
	{
		client_print(id, print_center, "Understabbing is not allowed in this server!")
		
		switch (get_pcvar_num(cvar_understab_mode))
		{
			case 2: // reflect the damage
			{
				fakedamage(attacker, "understabbing", damage, DMG_GENERIC)
				
				static name[32]
				get_user_name(attacker, name, charsmax(name))
				client_print(0, print_chat, "* %s has been punished with %d damage for understabbing!", name, floatround(damage))
			}
			case 3: // slay
			{
				user_kill(attacker)
				
				static name[32]
				get_user_name(attacker, name, charsmax(name))
				client_print(0, print_chat, "* %s has been slain for understabbing!", name)
			}
		}
		
		return HAM_SUPERCEDE;
	}
	
	return HAM_IGNORED;
}
