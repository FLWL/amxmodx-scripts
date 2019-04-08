#include <amxmodx>
#include <fakemeta>

new g_fwPrecacheSound
new g_msgSendAudio

new g_cheatwins

public plugin_precache()
{
	new mapname[32]
	get_mapname(mapname, charsmax(mapname))
	
	if (equali(mapname, "surf_snowspliter3"))
		set_fail_state("Not running in surf_snowspliter3")
	
	// Prevent hostage sounds from being precached
	g_fwPrecacheSound = register_forward(FM_PrecacheSound, "fw_PrecacheSound")
}

public plugin_init()
{
	register_plugin("Force Round End", "1.0", "FLWL")
	
	// Message IDs
	g_msgSendAudio = get_user_msgid("SendAudio")
	
	// Messages
	register_message(g_msgSendAudio, "message_sendaudio")
	register_message(get_user_msgid("HostagePos"), "message_hostagepos")
	register_message(get_user_msgid("Scenario"), "message_scenario")
	register_message(get_user_msgid("TextMsg"), "message_textmsg")
	register_message(get_user_msgid("TeamScore"), "message_teamscore")
	
	// Fake Hostage (to force round ending)
	new ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "hostage_entity"))
	if (pev_valid(ent))
	{
		engfunc(EngFunc_SetOrigin, ent, Float:{8192.0,8192.0,8192.0})
		dllfunc(DLLFunc_Spawn, ent)
	}
	
	register_forward(FM_EmitSound, "fw_EmitSound")
	unregister_forward(FM_PrecacheSound, g_fwPrecacheSound)
}

// Block CS round win audio messages, since we're playing our own instead
public message_sendaudio()
{
	static audio[32]
	get_msg_arg_string(2, audio, charsmax(audio))
	
	// Block terrorist win messages so we can resend them later
	if (equal(audio[7], "terwin"))
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Block hostages from appearing on radar
public message_hostagepos()
{
	return PLUGIN_HANDLED;
}

// Block hostage HUD display
public message_scenario()
{
	if (get_msg_args() > 1)
	{
		static sprite[8]
		get_msg_arg_string(2, sprite, charsmax(sprite))
		
		if (equal(sprite, "hostage"))
			return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

// Block some text messages
public message_textmsg()
{
	static textmsg[32]
	get_msg_arg_string(2, textmsg, charsmax(textmsg))
	
	if (equal(textmsg, "#Terrorists_Win"))
	{
		// Send our own terrorists win sound
		message_begin(MSG_BROADCAST, g_msgSendAudio)
		write_byte(0)
		write_string("%!MRAD_terwin")
		write_short(100)
		message_end()
	}
	else if (equal(textmsg, "#Hostages_Not_Rescued"))
	{
		set_msg_arg_string(2, "#Round_Draw")
		
		// Send round draw sound
		message_begin(MSG_BROADCAST, g_msgSendAudio)
		write_byte(0)
		write_string("%!MRAD_rounddraw")
		write_short(100)
		message_end()
		
		g_cheatwins++
	}
	else if (equal(textmsg, "#Game_Commencing"))
	{
		g_cheatwins = 0
	}
}

// Send actual terrorist team score
public message_teamscore()
{
	static team[2]
	get_msg_arg_string(1, team, charsmax(team))
	
	if (team[0] == 'T')
	{
		set_msg_arg_int(2, get_msg_argtype(2), get_msg_arg_int(2)-g_cheatwins)
	}
}

// Sound Precache Forward
public fw_PrecacheSound(const sound[])
{
	// Block all those unneeeded hostage sounds
	if (equal(sound, "hostage", 7))
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}

// Emit Sound Forward
public fw_EmitSound(id, channel, const sample[], Float:volume, Float:attn, flags, pitch)
{
	// Block all those unneeeded hostage sounds
	if (sample[0] == 'h' && sample[1] == 'o' && sample[2] == 's' && sample[3] == 't' && sample[4] == 'a' && sample[5] == 'g' && sample[6] == 'e')
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}
