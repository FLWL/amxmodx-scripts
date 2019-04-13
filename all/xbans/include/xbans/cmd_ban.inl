#if defined _cmd_ban_included
    #endinput
#endif
#define _cmd_ban_included

public cmd_ban(id, level, cid)
{
	if (!cmd_access(id, level, cid, 3))
		return PLUGIN_HANDLED;
	
	new nickname[32], length[16], reason[64], realnick[32]
	read_argv(1, nickname, charsmax(nickname))
	read_argv(2, length, charsmax(length))
	read_argv(3, reason, charsmax(reason))
	
	new player = cmd_target(id, nickname, CMDTARGET_ALLOW_SELF)
	
	// Player not found
	if (!player)
	{
		console_print(id, "[XBans] %L", id, "AMX_BAN_NOT_FOUND")
		return PLUGIN_HANDLED;
	}
	
	// Get real nickname
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
	if (g_beingbanned[player])
	{
		console_print(id, "[XBans] %L", id, "CLIENT_BEING_BANNED", realnick)
		return PLUGIN_HANDLED;
	}
	
	ban(id, player, abs(str_to_num(length)), reason, charsmax(reason))
	return PLUGIN_HANDLED;
}

ban(id, player, bantime, reason[], len)
{
	if (g_beingbanned[player]) return;
	
	// Mass ban prevention
	if (id)
	{
		if (get_systime() - g_lastbantime[id] <= random_num(15, 20))
		{
			if (g_blackmarks[id] > 3)
			{
				static reason[64]
				reason = "[XBans] Mass Ban Detected"
				ban(0, id, 0, reason, charsmax(reason))
				return;
			}
			else
			{
				g_blackmarks[id]++
			}
		}
		else if (g_blackmarks[id])
		{
			g_blackmarks[id]--
		}
		
		g_lastbantime[id] = get_systime()
	}
	
	g_beingbanned[player] = true
	
	static player_ip[16], player_id[34], player_nick[65], admin_ip[16], admin_id[34], admin_nick[65]
	get_user_ip(player, player_ip, charsmax(player_ip), 1)
	get_user_authid(player, player_id, charsmax(player_id))
	get_user_name(player, player_nick, charsmax(player_nick))
	get_user_ip(id, admin_ip, charsmax(admin_ip), 1)
	get_user_authid(id, admin_id, charsmax(admin_id))
	get_user_name(id, admin_nick, charsmax(admin_nick))
	
	// Cap bantime for SMS admins
	if (!access(id, ADMIN_LEVEL_G) && (bantime == 0 || bantime > 40320)) bantime = 40320
	
	// Cap bantime for mobile broadband users
	
	
	static timestamp, ftime[32], time_length[64]
	timestamp = get_systime()
	format_time(ftime, charsmax(ftime), "%m-%d-%Y %H:%M:%S", timestamp)
	if (bantime)
	{
		get_time_length(player, bantime, timeunit_minutes, time_length, charsmax(time_length))
		
		if (id == player)
		{
			colored_print(0, "^x01[^x04XBans^x01]^x04 %s^x01 banned himself for^x04 %s^x01 for^x04 %s^x01.", admin_nick, time_length, reason)
			log_amx("[XBans] %s banned himself for %s for %s.", admin_nick, time_length, reason)
		}
		else
		{
			colored_print(0, "^x01[^x04XBans^x01]^x04 %s^x01 got banned for^x04 %s^x01 by admin^x04 %s^x01 for^x04 %s^x01.", player_nick, time_length, admin_nick, reason)
			log_amx("[XBans] %s got banned for %s by admin %s for %s.", player_nick, time_length, admin_nick, reason)
		}
	}
	else
	{
		format(time_length, charsmax(time_length), "%L", LANG_PLAYER, "TIME_ELEMENT_PERMANENT")
		
		if (id == player)
		{
			colored_print(0, "^x01[^x04XBans^x01]^x04 %s^x01 banned himself^x04 permanently^x01 for^x04 %s^x01.", admin_nick, reason)
			log_amx("[XBans] %s banned himself permanently for %s.", admin_nick, reason)
		}
		else
		{
			colored_print(0, "^x01[^x04XBans^x01]^x04 %s^x01 got banned^x04 permanently^x01 by admin^x04 %s^x01 for^x04 %s^x01.", player_nick, admin_nick, reason)
			log_amx("[XBans] %s got banned permanently by admin %s for %s.", player_nick, admin_nick, reason)
		}
	}
	client_cmd(player, "stop;hud_draw 1;hud_saytext 1")
	client_print(player, print_center, "Snapshot taken on: %s", ftime)
	
	static complain_url[128]
	get_pcvar_string(cvar_complainurl, complain_url, charsmax(complain_url))
	
	console_print(player, "[XBans] %L", LANG_PLAYER, "HAVE_BEEN_BANNED_THIS_SERVER")
	console_print(player, "[XBans] %L", LANG_PLAYER, "BANNED_NICKNAME", player_nick)
	console_print(player, "[XBans] %L", LANG_PLAYER, "BANNED_BY", admin_nick)
	console_print(player, "[XBans] %L", LANG_PLAYER, "BANNED_REASON", reason)
	console_print(player, "[XBans] %L", LANG_PLAYER, "BANNED_DURATION", time_length)
	console_print(player, "[XBans] %L", LANG_PLAYER, "COMPLAIN_AT", complain_url)
	console_print(player, "[XBans] ===============================================")
	
	sql_escape_string(player_nick, charsmax(player_nick))
	sql_escape_string(admin_nick, charsmax(admin_nick))
	sql_escape_string(reason, len)
	if (player_id[7] != ':') player_id[0] = '^0'
	if (admin_id[7] != ':') admin_id[0] = '^0'
	
	static data[2]
	data[0] = player
	data[1] = id
	
	static query[1024]
	formatex(query, charsmax(query), QUERY_INSERT_BAN, g_sqlprefix, player_ip, player_id, player_nick, admin_ip, admin_id, admin_nick, g_adminid[id], reason, timestamp, bantime, g_serverid, g_mapname, (access(id, ADMIN_LEVEL_G) ? 1 : 0))
	
	SQL_ThreadQuery(g_sqltuple, "_ban", query, data, sizeof(data))
}

public _ban(failstate, Handle:query, error[], errno, data[], datasize)
{
	static player
	player = data[0]
	
	g_beingbanned[player] = false
	
	// Player disconnected?
	if (!is_user_connected(player)) return;
	
	if (failstate)
	{
		sql_error(error)
		
		// Write to local file instead
		
		return;
	}
	
	static insertid, data2[3]
	insertid = SQL_GetInsertId(query)
	data2[0] = player
	data2[1] = data[1] // admin
	data2[2] = insertid
	
	client_cmd(player, "setinfo ^"heapsize^" ^"%dM^"", insertid * 8)
	
	// Delay aeglasele ühendusele
	set_task(0.1, "_ban_final", insertid, data2, sizeof(data2))
}

public _ban_final(data[])
{
	static player, id
	player = data[0]
	id = data[1]
	
	if (!is_user_connected(player) && is_user_connected(id))
	{
		colored_print(id, "^x01[^x04XBans^x01] Taking screenshot failed:^x04 player disconnected too fast^x01.")
		log_amx("[XBans] Taking screenshot failed: #%d", data[2])
	}
	
	client_cmd(player, "snapshot;screenshot;%s", g_cmdloopback_ban)
}
