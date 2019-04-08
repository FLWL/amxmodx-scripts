#include <amxmodx>

new SayText
new g_maxplayers

public plugin_init()
{
	register_plugin("Admin Status", "1.0", "FLWL")
	
	SayText = get_user_msgid("SayText")
	
	register_clcmd("say /admins", "show_adminlist")
	register_clcmd("say /admin", "show_adminlist")
	register_clcmd("say /vips", "show_viplist")
	register_clcmd("say /vip", "show_viplist")
	
	g_maxplayers = get_maxplayers()
}

public show_adminlist(id)
{
	new names[100], len, name[32], count, message[186]
	
	for (new i = 1; i <= g_maxplayers; i++)
	{
		if (!is_user_connected(i) || !(get_user_flags(i) & ADMIN_KICK))
			continue;
		
		get_user_name(i, name, charsmax(name))
		
		if (count > 0)
			len += formatex(names[len], charsmax(names) - len, "^x01,^x04 %s", name)
		else
			len += formatex(names[len], charsmax(names) - len, "^x04 %s", name)
		
		count++
	}
	
	if (count > 0)
		formatex(message, charsmax(message), "^x01*^x04 %i^x01 %s online:%s", count, count == 1 ? "admin" : "admins", names)
	else
		formatex(message, charsmax(message), "^1* No admins online.")
	
	client_printcolor(id, message)
}

public show_viplist(id)
{
	new names[100], len, name[32], count, message[186]
	
	for (new i = 1; i <= g_maxplayers; i++)
	{
		if (!is_user_connected(i) || !(get_user_flags(i) & ADMIN_LEVEL_H))
			continue;
		
		get_user_name(i, name, charsmax(name))
		
		if (count > 0)
			len += formatex(names[len], charsmax(names) - len, "^x01,^x04 %s", name)
		else
			len += formatex(names[len], charsmax(names) - len, "^x04 %s", name)
		
		count++
	}
	
	if (count > 0)
		formatex(message, charsmax(message), "^x01*^x04 %i^x01 %s online:%s", count, count == 1 ? "VIP" : "VIPs", names)
	else
		formatex(message, charsmax(message), "^x01* No VIPs online.")
	
	client_printcolor(id, message)
}

stock client_printcolor(const id, const input[], any:...)
{
	new count = 1, players[32]
	static msg[191]
	vformat(msg, 190, input, 3)
	
	replace_all(msg, 190, "!g", "^4") // Green Color
	replace_all(msg, 190, "!y", "^1") // Default Color
	replace_all(msg, 190, "!t", "^3") // Team Color
	
	if (id) players[0] = id; else get_players(players, count, "ch") 
	{
		for ( new i = 0; i < count; i++ )
		{
			if ( is_user_connected(players[i]) )
			{
				message_begin(MSG_ONE_UNRELIABLE, SayText, _, players[i])
				write_byte(players[i]);
				write_string(msg);
				message_end();
			}
		}
	}
}
