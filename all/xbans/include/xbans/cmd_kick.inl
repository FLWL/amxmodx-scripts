#if defined _cmd_kick_included
    #endinput
#endif
#define _cmd_kick_included

public cmd_kick(id, level, cid)
{
	if (!cmd_access(id, level, cid, 3))
		return PLUGIN_HANDLED;
	
	new nickname[32], reason[64]
	read_argv(1, nickname, charsmax(nickname))
	read_argv(2, reason, charsmax(reason))
	
	new player = cmd_target(id, nickname, CMDTARGET_ALLOW_SELF)
	
	// Player not found
	if (player == 0)
	{
		console_print(id, "[XBans] %L", id, "AMX_BAN_NOT_FOUND")
		return PLUGIN_HANDLED;
	}
	
	// Get real nickname
	new realnick[32]
	get_user_name(player, realnick, charsmax(realnick))
	
	// Player is a bot
	if (is_user_bot(player))
	{
		console_print(id, "[XBans] That action can't be performed on bot %s.", realnick)
		return PLUGIN_HANDLED;
	}
	
	// Player has immunity
	if (access(player, ADMIN_IMMUNITY) && !access(id, ADMIN_LEVEL_G))
	{
		console_print(id, "[XBans] %L", id, "CLIENT_IMM", realnick)
		return PLUGIN_HANDLED;
	}
	
	kick(id, player, reason, charsmax(reason))
	return PLUGIN_HANDLED;
}

public kick(id, player, reason[], len)
{
	// Fetch info
	static player_ip[16], player_id[34], player_nick[65], admin_ip[16], admin_id[34], admin_nick[65]
	get_user_ip(player, player_ip, charsmax(player_ip), 1)
	get_user_authid(player, player_id, charsmax(player_id))
	get_user_name(player, player_nick, charsmax(player_nick))
	get_user_ip(id, admin_ip, charsmax(admin_ip), 1)
	get_user_authid(id, admin_id, charsmax(admin_id))
	get_user_name(id, admin_nick, charsmax(admin_nick))
	
	// Log to file
	log_amx("Kick: ^"%s<%s><%s>^" kick ^"%s<%d><%s>^" (reason ^"%s^")", admin_nick, admin_id, admin_ip, player_nick, admin_id, admin_id, reason)
	
	// Actually kick the player
	server_cmd("kick #%d ^"%s^"", get_user_userid(player), reason)
	
	// Announce in the chat
	colored_print(0, "^x01[^x04XBans^x01]^x04 %s^x01 got kicked by admin^x04 %s^x01 for^x04 %s^x01.", player_nick, admin_nick, reason)
}
