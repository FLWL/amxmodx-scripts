#include <amxmodx>
#include <hamsandwich>
#include <cstrike>
#include <zombieplague_xp>

const Float:XP_KILL = 30.0
const Float:XP_ASSIST = 15.0

new Float:g_assist[33][33]

new g_maxplayers

public plugin_init()
{
	register_plugin("[ZP] Rewards", "1.0", "FLWL")
	
	RegisterHam(Ham_Killed, "player", "fw_KilledPlayer_Post", true)
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage_Post", true)
	
	g_maxplayers = get_maxplayers()
}

public fw_TakeDamage_Post(id, inflictor, attacker)
{
	if (0 < attacker <= g_maxplayers) g_assist[attacker][id] = get_gametime()
}

// Zombie infects human
public zp_user_infected_post(id, infector, nemesis)
{
	if (!is_user_connected(infector) || nemesis)
		return;
	
	zp_add_xp(infector, floatround(XP_KILL), "Human Infected", 3)
}

public fw_KilledPlayer_Post(id, attacker)
{
	if (!is_user_connected(attacker) || zp_get_user_nemesis(attacker) || zp_get_user_survivor(attacker) || attacker == id)
		return;
	
	// Human killed zombie
	if (zp_get_user_zombie(id))
	{
		zp_add_xp(attacker, floatround(XP_KILL), "Zombie Killed", 3)
		
		// Assist stuff
		static i, count, Float:gametime, assistxp, assistap
		gametime = get_gametime()
		
		// Calculate assist XP/AP
		count = 0
		for (i = 1; i <= g_maxplayers; i++)
		{
			if (!is_user_connected(i) || i == attacker || gametime - g_assist[i][id] > 10.0) continue;
			count++
		}
		assistxp = floatround(XP_ASSIST / count, floatround_ceil)
		assistap = floatround(2.0 / count, floatround_ceil)
		
		// Give assist XP/AP
		for (i = 1; i <= g_maxplayers; i++)
		{
			if (!is_user_connected(i) || i == attacker || gametime - g_assist[i][id] > 10.0) continue;
			zp_add_xp(i, assistxp, "Assist: Zombie Killed", assistap)
		}
	}
	else
	{
		zp_add_xp(attacker, floatround(XP_KILL), "Human Killed", 3)
	}
}

public zp_round_ended(winteam)
{
	new id, count
	for (id = 1; id <= g_maxplayers; id++)
		if (is_user_connected(id) && 0 < _:cs_get_user_team(id) < 3) count++
	
	if (count <= 1) return;
	
	// Substract 1 (self)
	count--
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (!is_user_connected(id) || !(0 < _:cs_get_user_team(id) < 3)) continue;
		
		switch (winteam)
		{
			case ZP_TEAM_ZOMBIE, ZP_TEAM_NEMESIS:
			{
				if (zp_get_user_zombie(id))
					zp_add_xp(id, count*3, "Round Won", 3)
				else
					zp_add_xp(id, count*1, "Round Lost", 1)
			}
			case ZP_TEAM_HUMAN, ZP_TEAM_SURVIVOR:
			{
				if (!zp_get_user_zombie(id))
					zp_add_xp(id, count*3, "Round Won", 3)
				else
					zp_add_xp(id, count*1, "Round Lost", 1)
			}
			case ZP_TEAM_NO_ONE:
			{
				zp_add_xp(id, count*2, "Round Draw", 2)
			}
		}
	}
}
