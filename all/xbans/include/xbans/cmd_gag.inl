#if defined _cmd_gag_included
    #endinput
#endif
#define _cmd_gag_included

public cmd_gag(id, level, cid)
{
	if (!cmd_access(id, level, cid, 3))
		return PLUGIN_HANDLED;
	
	new nickname[32], length[16], reason[64]
	read_argv(1, nickname, charsmax(nickname))
	read_argv(2, length, charsmax(length))
	read_argv(3, reason, charsmax(reason))
	
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
	
	// Player is already being banned
	if (g_beinggagged[player])
	{
		console_print(id, "[XBans] %L", id, "CLIENT_BEING_GAGGED", realnick)
		return PLUGIN_HANDLED;
	}
	
	gag(id, player, str_to_num(length), reason, charsmax(reason))
	return PLUGIN_HANDLED;
}

gag(id, player, gagtime, reason[], len)
{
	g_beinggagged[player] = true
	
	static player_ip[16], player_id[34], player_nick[65], admin_ip[16], admin_id[34], admin_nick[65]
	get_user_ip(player, player_ip, charsmax(player_ip), 1)
	get_user_authid(player, player_id, charsmax(player_id))
	get_user_name(player, player_nick, charsmax(player_nick))
	get_user_ip(id, admin_ip, charsmax(admin_ip), 1)
	get_user_authid(id, admin_id, charsmax(admin_id))
	get_user_name(id, admin_nick, charsmax(admin_nick))
	
	sql_escape_string(player_nick, charsmax(player_nick))
	sql_escape_string(admin_nick, charsmax(admin_nick))
	sql_escape_string(reason, len)
	if (player_id[7] != ':') player_id[0] = '^0'
	if (admin_id[7] != ':') admin_id[0] = '^0'
	
	static timestamp
	timestamp = get_systime()
	
	static query[1024]
	formatex(query, charsmax(query), "INSERT INTO `%s_gags` (`player_ip`, `player_id`, `player_nick`, `admin_ip`, `admin_id`, `admin_nick`, `admin_aid`, `ban_reason`, `ban_created`, `ban_length`, `server_sid`, `server_map`, `expired`, `no_ungag`, `cross_server`) \
			VALUES ('%s', '%s', '%s', '%s', '%s', '%s', %d, '%s', %d, %d, %d, '%s', 0, 0, %d)",
			g_sqlprefix, player_ip, player_id, player_nick, admin_ip, admin_id, admin_nick, g_adminid[id], reason, timestamp, gagtime,
			g_serverid, g_mapname, (access(id, ADMIN_LEVEL_G) ? 1 : 0))
	
	g_beinggagged[player] = false
}
