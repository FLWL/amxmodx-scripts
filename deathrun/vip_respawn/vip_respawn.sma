#include <amxmodx>
#include <hamsandwich>

// Cvars
new cvar_respawnflag, cvar_showmsg

// Game vars
new g_rounds

// Player vars
new g_respawned[33]

public plugin_init()
{
	register_plugin("VIP Respawn", "1.0", "FLWL")
	
	// Events
	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")
	
	// Cvars
	cvar_respawnflag = register_cvar("amx_respawn_flag", "t")
	cvar_showmsg = register_cvar("amx_respawn_show_msg", "1")
	
	// Client commands
	register_clcmd("say /respawn", "clcmd_sayrespawn")
	register_clcmd("say_team /respawn", "clcmd_sayrespawn")
}

// Round start event
public event_round_start()
{
	g_rounds++
}

// Say /respawn
public clcmd_sayrespawn(id)
{
	new flag[2]
	get_pcvar_string(cvar_respawnflag, flag, charsmax(flag))
	
	if (!(get_user_flags(id) & read_flags(flag)))
		return PLUGIN_HANDLED;
	
	if (g_respawned[id] == g_rounds)
		return PLUGIN_HANDLED;
	
	respawn_player(id)
	return PLUGIN_HANDLED;
}

// Respawn player
respawn_player(id)
{
	ExecuteHamB(Ham_CS_RoundRespawn, id)
	g_respawned[id] = g_rounds
	
	if (get_pcvar_num(cvar_showmsg))
	{
		client_print(id, print_chat, "* You have been respawned!")
	}
}
