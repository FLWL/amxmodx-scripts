#include <amxmodx>
#include <engine>
#include <cstrike>
#include <hamsandwich>
#include <fun>

new g_msgDeathMsg, g_msgScreenFade

public plugin_init()
{
	register_plugin("Touchdowns", "1.0", "FLWL")
	
	register_touch("player", "player", "fw_TouchPlayer")
	
	g_msgDeathMsg = get_user_msgid("DeathMsg")
	g_msgScreenFade = get_user_msgid("ScreenFade")
}

public fw_TouchPlayer(id, target)
{
	// Jumper is not T or target is not CT
	if (cs_get_user_team(id) != CS_TEAM_T || cs_get_user_team(target) != CS_TEAM_CT)
		return;
	
	// Terrorist didn't land on top of a CT
	if (entity_get_edict(id, EV_ENT_groundentity) != target)
		return;
	
	static Float:velocity[3]
	entity_get_vector(id, EV_VEC_velocity, velocity)
	
	// Velocity is too small, terrorist's fall was too short
	if (velocity[2] > -400.0)
		return;
	
	// CT is ready to die
	set_msg_block(g_msgDeathMsg, BLOCK_SET)
	fakedamage(target, "touchdown", 10000.0, DMG_CRUSH)
	set_msg_block(g_msgDeathMsg, BLOCK_NOT)
	
	// Since fakedamage doesn't take an attacker, we must send our own death message
	message_begin(MSG_BROADCAST, g_msgDeathMsg)
	write_byte(id) // killer
	write_byte(target) // victim
	write_byte(0) // headshot flag
	write_string("touchdown") // killer's weapon
	message_end()
	
	// Add frags
	set_user_frags(id, get_user_frags(id)+1)
	
	// Short screenfade indicating that the terrorist has made a successful touchdown
	message_begin(MSG_ONE_UNRELIABLE, g_msgScreenFade, _, id)
	write_short(256)
	write_short(0)
	write_short(0x0001)
	write_byte(200)
	write_byte(200)
	write_byte(200)
	write_byte(200)
	message_end()
}
