#include <amxmodx>
#include <fakemeta>
#include <hamsandwich>
#include <cstrike>
#include <zp50_gamemodes>
#include <zp50_colorchat>

new cvar_infection_allow_respawn, cvar_armageddon_allow_respawn, cvar_multi_allow_respawn,
cvar_nemesis_allow_respawn, cvar_plague_allow_respawn, cvar_survivor_allow_respawn,
cvar_swarm_allow_respawn, cvar_respawn_delay

public plugin_init()
{
	register_plugin("[ZP50] Automatic Respawn", "1.0", "FLWL")
	
	register_forward(FM_ClientDisconnect, "fw_ClientDisconnect_Post", 1)
	RegisterHam(Ham_Spawn, "player", "fw_SpawnPlayer_Post", 1)
	
	cvar_infection_allow_respawn = get_cvar_pointer("zp_infection_allow_respawn")
	cvar_armageddon_allow_respawn = get_cvar_pointer("zp_armageddon_allow_respawn")
	cvar_multi_allow_respawn = get_cvar_pointer("zp_multi_allow_respawn")
	cvar_nemesis_allow_respawn = get_cvar_pointer("zp_nemesis_allow_respawn")
	cvar_plague_allow_respawn = get_cvar_pointer("zp_plague_allow_respawn")
	cvar_survivor_allow_respawn = get_cvar_pointer("zp_survivor_allow_respawn")
	cvar_swarm_allow_respawn = get_cvar_pointer("zp_swarm_allow_respawn")
	cvar_respawn_delay = get_cvar_pointer("zp_respawn_delay")
	
	register_clcmd("joinclass", "clcmd_joinclass")
}

public fw_ClientDisconnect_Post(id)
{
	remove_task(id)
}

public fw_SpawnPlayer_Post(id)
{
	remove_task(id)
}

public clcmd_joinclass(id)
{
	static gamemode_id, gamemode_name[32]
	gamemode_id = zp_gamemodes_get_current()
	zp_gamemodes_get_name(gamemode_id, gamemode_name, charsmax(gamemode_name))
	
	if (equal(gamemode_name, "Infection Mode") && !get_pcvar_num(cvar_infection_allow_respawn))
		return;
	else if (equal(gamemode_name, "Armageddon Mode") && !get_pcvar_num(cvar_armageddon_allow_respawn))
		return;
	else if (equal(gamemode_name, "Multiple Infection Mode") && !get_pcvar_num(cvar_multi_allow_respawn))
		return;
	else if (equal(gamemode_name, "Nemesis Mode") && !get_pcvar_num(cvar_nemesis_allow_respawn))
		return;
	else if (equal(gamemode_name, "Plague Mode") && !get_pcvar_num(cvar_plague_allow_respawn))
		return;
	else if (equal(gamemode_name, "Survivor Mode") && !get_pcvar_num(cvar_survivor_allow_respawn))
		return;
	else if (equal(gamemode_name, "Swarm Mode") && !get_pcvar_num(cvar_swarm_allow_respawn))
		return;
	
	set_task(get_pcvar_float(cvar_respawn_delay), "task_respawn", id)
}

public task_respawn(id)
{
	if (cs_get_user_team(id) != CS_TEAM_CT) return;
	
	zp_core_respawn_as_zombie(id)
	ExecuteHamB(Ham_CS_RoundRespawn, id)
	
	zp_colored_print(id, "You should be respawned now!")
}
