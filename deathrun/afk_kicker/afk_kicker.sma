#include <amxmodx>
#include <cstrike>
#include <fakemeta>

new g_maxplayers
new g_oldorigin[33][3]
new g_afktime[33]

public plugin_init()
{
	register_plugin("Deathrun AFK Kicker", "1.0", "FLWL")
	
	set_task(15.0, "task_check_afk", _, _, _, "b")
	
	g_maxplayers = get_maxplayers()
}

public task_check_afk()
{
	static origin[3]
	
	if (get_playersnum() <= 3)
		return;
	
	for (new id; id <= g_maxplayers; id++)
	{
		if (!is_user_alive(id) || cs_get_user_team(id) != CS_TEAM_CT)
			continue;
		
		get_user_origin(id, origin)
		
		if (origin[0] == g_oldorigin[id][0] && origin[1] == g_oldorigin[id][1] && origin[2] == g_oldorigin[id][2])
		{
			g_afktime[id] += 15
			
			// drop the bomb if needed
			if (user_has_weapon(id, CSW_C4))
			{
				engclient_cmd(id, "drop", "weapon_c4")
			}
			
			if (g_afktime[id] >= 45)
			{
				if (g_maxplayers - get_playersnum() <= 3)
				{
					server_cmd("kick #%d ^"You were kicked for being AFK longer than 45 seconds^"", get_user_userid(id))
				}
				else
				{
					if (is_user_alive(id))
					{
						// Kill him before he switches teams
						dllfunc(DLLFunc_ClientKill, id)
					}
					
					cs_set_user_team(id, CS_TEAM_SPECTATOR)
				}
			}
		}
		else
		{
			g_oldorigin[id][0] = origin[0]
			g_oldorigin[id][1] = origin[1]
			g_oldorigin[id][2] = origin[2]
			g_afktime[id] = 0
		}
	}
}
