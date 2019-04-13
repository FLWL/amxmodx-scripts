#if defined _validate_player_included
    #endinput
#endif
#define _validate_player_included

validate_player(id)
{
	// Get and decode bid in client's setinfo
	static setinfokey[32], str_bid[32], bid
	get_pcvar_string(cvar_setinfokey, setinfokey, charsmax(setinfokey))
	get_user_info(id, setinfokey, str_bid, charsmax(str_bid))
	bid = str_to_num(str_bid) / 8
	bid = 0
	
	// Get player's info
	static authid[34], ip[16]
	get_user_authid(id, authid, charsmax(authid))
	get_user_ip(id, ip, charsmax(ip), 1)
	
	// Format query
	static query[2048]
	formatex(query, charsmax(query), QUERY_VALIDATE_PLAYER, g_sqlprefix, g_sqlprefix, ip, authid, bid)
	
	static data[2]
	data[0] = id
	
	SQL_ThreadQuery(g_sqltuple, "_validate_player", query, data, sizeof(data))
}

public _validate_player(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		sql_error(error)
		return;
	}
	
	if (!SQL_NumResults(query))
		return;
	
	static id
	id = data[0]
	
	static col_expired, col_ban_created, col_ban_length, col_server_sid, col_server_map, col_cross_server, col_player_nick, col_hostname,
				col_admin_nick, col_ban_reason
	col_expired = SQL_FieldNameToNum(query, "expired")
	col_ban_created = SQL_FieldNameToNum(query, "ban_created")
	col_ban_length = SQL_FieldNameToNum(query, "ban_length")
	col_server_sid = SQL_FieldNameToNum(query, "server_sid")
	col_server_map = SQL_FieldNameToNum(query, "server_map")
	col_cross_server = SQL_FieldNameToNum(query, "cross_server")
	col_player_nick = SQL_FieldNameToNum(query, "player_nick")
	col_hostname = SQL_FieldNameToNum(query, "hostname")
	col_admin_nick = SQL_FieldNameToNum(query, "admin_nick")
	col_ban_reason = SQL_FieldNameToNum(query, "ban_reason")
	
	new banned_count
	static expired, ban_created, ban_length, server_sid, cross_server, player_nick[32], admin_nick[32], ban_reason[128], server_map[32]
	
	while (SQL_MoreResults(query))
	{
		expired = SQL_ReadResult(query, col_expired)
		ban_created = SQL_ReadResult(query, col_ban_created)
		ban_length = SQL_ReadResult(query, col_ban_length)
		server_sid = SQL_ReadResult(query, col_server_sid)
		cross_server = SQL_ReadResult(query, col_cross_server)
		SQL_ReadResult(query, col_player_nick, player_nick, charsmax(player_nick))
		SQL_ReadResult(query, col_admin_nick, admin_nick, charsmax(admin_nick))
		SQL_ReadResult(query, col_ban_reason, ban_reason, charsmax(ban_reason))
		SQL_ReadResult(query, col_server_map, server_map, charsmax(server_map))
		
		// Is this ban active?
		if (!expired && (!ban_length || ban_created + ban_length * 60 > get_systime()) && (cross_server || server_sid == g_serverid))
		{
			static hostname[128], complain_url[128]
			SQL_ReadResult(query, col_hostname, hostname, charsmax(hostname))
			get_pcvar_string(cvar_complainurl, complain_url, charsmax(complain_url))
			
			client_cmd(id, "echo [XBans] %L", LANG_PLAYER, "HAVE_BEEN_BANNED_THIS_SERVER")
			client_cmd(id, "echo [XBans] %L", LANG_PLAYER, "BANNED_NICKNAME", player_nick)
			client_cmd(id, "echo [XBans] %L", LANG_PLAYER, "BANNED_BY", admin_nick)
			client_cmd(id, "echo [XBans] %L", LANG_PLAYER, "BANNED_REASON", ban_reason)
			if (ban_length)
			{
				new time_remaining[128]
				new ban_length_seconds = ban_length * 60
				new seconds_left = (ban_created + ban_length_seconds - get_systime())
				get_time_length(id, seconds_left, timeunit_seconds, time_remaining, charsmax(time_remaining))
				
				client_cmd(id, "echo [XBans] %L", LANG_PLAYER, "BAN_TIME_LEFT", time_remaining)
			}
			else
			{
				client_cmd(id, "echo [XBans] %L", LANG_PLAYER, "YOU_ARE_PERMANENTLY_BANNED")
			}
			client_cmd(id, "echo [XBans] %L", LANG_PLAYER, "BANNED_SERVER", hostname)
			client_cmd(id, "echo [XBans] %L", LANG_PLAYER, "BANNED_MAP", server_map)
			client_cmd(id, "echo [XBans] %L", LANG_PLAYER, "COMPLAIN_AT", complain_url)
			client_cmd(id, "echo [XBans] ===============================================")
			
			client_cmd(id, g_cmdloopback_ban)
			set_task(2.5, "task_kick_bypass", get_user_userid(id))
			return;
		}
		
		banned_count++
		SQL_NextRow(query)
	}
	
	if (get_pcvar_num(cvar_notifyonconnect))
	{
		static nickname[32], lastban[128], time_length[32]
		get_user_name(id, nickname, charsmax(nickname))
		if (ban_length)
			get_time_length(id, ban_length, timeunit_minutes, time_length, charsmax(time_length))
		else
			format(time_length, charsmax(time_length), "%L", LANG_PLAYER, "TIME_ELEMENT_PERMANENT")
		
		formatex(lastban, charsmax(lastban), "^x01[^x04XBans^x01]^x04 %s^x01;;^x04 %s^x01;;^x04 %s^x01;;^x04 %s^x01.", player_nick, time_length, ban_reason, admin_nick)
		
		static i
		for (i = 1; i <= g_maxplayers; i++)
		{
			if (!is_user_connected(i) || !access(i, ADMIN_BAN))
				continue;
			
			colored_print(i, "^x01[^x04XBans^x01]^x04 %s^x01 connected; banned^x04 %d^x01 time%s before. Last ban:", nickname, banned_count, (banned_count == 1 ? "" : "s"))
			colored_print(i, lastban)
		}
	}
}

public task_kick_bypass(userid)
{
	server_cmd("kick #%d ^"%L^"", userid, LANG_SERVER, "BAN_MESSAGE")
}
