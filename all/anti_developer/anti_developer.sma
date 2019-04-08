#include <amxmodx>
#include <cstrike>

new g_msgSayText
new g_maxplayers
new g_valid_target[33]

public plugin_init()
{
	register_plugin("Anti-Developer", "1.0", "FLWL")
	
	g_msgSayText = get_user_msgid("SayText")
	
	g_maxplayers = get_maxplayers()
	
	set_task(1.0, "task_check", _, _, _, "b")
}

public client_putinserver(id)
{
	static auth[34]
	get_user_authid(id, auth, charsmax(auth))
	
	if (auth[7] == ':')
		g_valid_target[id] = true
	else
		g_valid_target[id] = false
}

public task_check()
{
	for (new id = 1; id <= g_maxplayers; id++)
	{
		if (g_valid_target[id] && is_user_alive(id))
		{
			query_client_cvar(id, "developer", "developer_result")
			query_client_cvar(id, "fps_override", "developer_result")
		}
	}
}

public developer_result(id, const cvar_name[], const cvar_value[])
{
	if (is_user_alive(id))
	{
		if (!equal(cvar_value, "0") && cvar_value[0] != 'B')
		{
			client_cmd(id, ";developer 0;fps_override 0;")
			
			user_kill(id)
			
			static nick[32], auth[34], ip[16]
			get_user_name(id, nick, charsmax(nick))
			get_user_authid(id, auth, charsmax(auth))
			get_user_ip(id, ip, charsmax(ip), 1)
			ChatColor(0, "^1[^4Anti-Developer^1]^3 %s^1 has been slain for using^4 developer^1 or^4 fps_override^1!", nick)
			
			log_to_file("developer.log", "<%s><%s><%s> has been slain for using: %s %s", auth, ip, nick, cvar_name, cvar_value)
		}
	}
}

// Color Chat
stock ChatColor(const id, const input[], any:...)
{
	new count = 1, players[32]
	static msg[193]
	vformat(msg, 190, input, 3)
	
	if(id) {
		players[0] = id;
		} else {
		get_players(players, count, "ch")
	}
	
	for(new i = 0; i < count; i++) {
		if(is_user_connected(players[i])) {
			message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, players[i])
			write_byte(players[i])
			write_string(msg)
			message_end()
		}
	}
}
