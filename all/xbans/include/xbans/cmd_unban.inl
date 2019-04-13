#if defined _cmd_unban_included
    #endinput
#endif
#define _cmd_unban_included

public cmd_unban(id, level, cid)
{
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED;
	
	static args[34]
	read_args(args, charsmax(args))
	remove_quotes(args)
	
	if (!args[0])
	{
		client_print(id, print_console, "[XBans] Usage: amx_unban <#BanID/IP/SteamID/nickname>")
		return PLUGIN_HANDLED;
	}
	
	// Prevent SQL injection
	sql_escape_string(args, charsmax(args))
	
	static query[512], data[1]
	formatex(query, charsmax(query), QUERY_UNBAN_SEARCH, g_sqlprefix, ArrayGetCell(g_adminids, id), (access(id, ADMIN_CVAR) ? "1 = 1" : "1 = 0"), args, args, args, args)
	data[0] = id
	
	SQL_ThreadQuery(g_sqltuple, "_cmd_unban_searchban", query, data, sizeof(data))
	return PLUGIN_HANDLED;
}

public _cmd_unban_searchban(failstate, Handle:query, error[], errno, data[], datasize)
{
	static id
	id = data[0]
	
	if (failstate)
	{
		if (failstate == TQUERY_CONNECT_FAILED)
		{
			client_print(id, print_console, "[XBans] Could not connect to SQL server. Searching in local database instead...")
			
			// TODO: search in local database instead
		}
		else if (failstate == TQUERY_QUERY_FAILED)
		{
			client_print(id, print_console, "[XBans] An error occurred while proccessing your request. Please check XBans configuration file.")
			log_amx("[Unban] Error #%d occurred: %s", errno, error)
		}
		
		return;
	}
	
	if (!SQL_NumResults(query))
	{
		client_print(id, print_console, "[XBans] No matches found.")
		return;
	}
	
	static bid, ban_length, player_nick[32], admin_nick[32], ban_reason[64], time_length[32], unbanner_nick[32]
	bid = SQL_ReadResult(query, 0)
	ban_length = SQL_ReadResult(query, 4)
	SQL_ReadResult(query, 1, player_nick, charsmax(player_nick))
	SQL_ReadResult(query, 2, admin_nick, charsmax(admin_nick))
	SQL_ReadResult(query, 3, ban_reason, charsmax(ban_reason))
	get_user_name(id, unbanner_nick, charsmax(unbanner_nick))
	
	if (ban_length)
		get_time_length(id, ban_length, timeunit_minutes, time_length, charsmax(time_length))
	else
		format(time_length, charsmax(time_length), "%L", LANG_PLAYER, "TIME_ELEMENT_PERMANENT")
	
	client_print(id, print_console, "[XBans] Unbanned #%d: %s; %s; %s; %s", bid, player_nick, time_length, ban_reason, admin_nick)
	colored_print(id, "^x01[^x04XBans^x01]^x04 %s^x01 unbanned^x04 #%d^x01:", unbanner_nick, bid)
	colored_print(id, "^x01[^x04XBans^x01]^x04 %s^x01;;^x04 %s^x01;;^x04 %s^x01;;^x04 %s^x01.", player_nick, time_length, ban_reason, admin_nick)
	
	static pquery[128], pdata[2]
	formatex(pquery, charsmax(pquery), QUERY_UNBAN_UNBAN, bid)
	pdata[0] = id
	pdata[1] = bid
	
	SQL_ThreadQuery(g_sqltuple, "_cmd_unban_unban", pquery, pdata, sizeof(pdata))
}

public _cmd_unban_unban(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		client_print(data[0], print_console, "[XBans] An error occurred. Your request could not be completed.")
		log_amx("[Unban] Error #%d occurred: %s", errno, error)
		return;
	}
}
