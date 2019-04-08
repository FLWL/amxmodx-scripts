#include <amxmodx>
#include <cstrike>

const MAX_PING = 150
new const WARNING_SOUND[] = "buttons/blip2.wav"
new const CS_TEAM_NAMES[][] = { "UNASSIGNED", "TERRORIST", "CT", "SPECTATOR" }

new g_msgSayText, g_msgTeamInfo

new g_checks[33]
new g_maxplayers

public plugin_precache()
{
	precache_sound(WARNING_SOUND)
}

public plugin_init()
{
	register_plugin("Ping Checker", "1.0", "FLWL")
	
	g_msgSayText = get_user_msgid("SayText")
	g_msgTeamInfo = get_user_msgid("TeamInfo")
	
	g_maxplayers = get_maxplayers()
	
	set_task(8.0, "task_check", _, _, _, "b")
}

public client_connect(id)
	g_checks[id] = 0

public task_check()
{
	static id
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (!is_user_connected(id))
			continue;
		
		static team
		team = _:cs_get_user_team(id)
		
		if (!(0 < team < 3))
			continue;
		
		static ping, loss
		get_user_ping(id, ping, loss)
		
		if (ping > MAX_PING)
		{
			g_checks[id]++
			
			if (g_checks[id] >= 3 && !(get_user_flags(id) & ADMIN_IMMUNITY))
			{
				server_cmd("kick #%d ^"You were kicked for having ping above %dms for 3 consecutive checks.^"", get_user_userid(id), MAX_PING)
			}
			else
			{
				static buffer[192]
				if (get_user_flags(id) & ADMIN_IMMUNITY)
					formatex(buffer, charsmax(buffer), "^1[^4Ping^1]^3 WARNING:^x01 Your ping is above^x04 %dms (%dms)!", MAX_PING, ping)
				else
					formatex(buffer, charsmax(buffer), "^1[^4Ping^1]^3 WARNING:^x01 Your ping is above^x04 %dms (%dms)! (Check %d/3)", MAX_PING, ping, g_checks[id])
				
				if (team != 1)
				{
					message_begin(MSG_ONE_UNRELIABLE, g_msgTeamInfo, _, id)
					write_byte(id)
					write_string("TERRORIST")
					message_end()
				}
				
				message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, id)
				write_byte(id)
				write_string(buffer)
				message_end()
				
				if (team != 1)
				{
					message_begin(MSG_ONE_UNRELIABLE, g_msgTeamInfo, _, id)
					write_byte(id)
					write_string(CS_TEAM_NAMES[team])
					message_end()
				}
				
				client_cmd(id, "spk %s", WARNING_SOUND)
			}
		}
		else if (g_checks[id])
		{
			g_checks[id]--
		}
	}
}
