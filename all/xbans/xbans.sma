#include <amxmodx>
#include <amxmisc>
#include <sockets>
#include <sqlx>
#include <time>

#include "include/xbans/global_vars.inl"
#include "include/xbans/validate_player.inl"
#include "include/xbans/cmd_kick.inl"
#include "include/xbans/cmd_ban.inl"
#include "include/xbans/cmd_gag.inl"
#include "include/xbans/cmd_unban.inl"
#include "include/xbans/cmd_banmenu.inl"
#include "include/xbans/cmd_gagmenu.inl"
#include "include/xbans/colored_print.inl"
#include "include/xbans/messages.inl"
#include "include/xbans/radio.inl"

public plugin_init()
{
	register_plugin("XBans", XBANS_VERSION, "FLWL")
	register_cvar("xbans_version", XBANS_VERSION, FCVAR_SERVER|FCVAR_SPONLY)
	set_cvar_string("xbans_version", XBANS_VERSION)
	
	register_dictionary("xbans.txt")
	register_dictionary("admin.txt")
	register_dictionary("common.txt")
	register_dictionary("time.txt")
	
	register_clcmd("say /radio", "clcmd_radio")
	register_clcmd("say /raadio", "clcmd_radio")
	register_clcmd("say /music", "clcmd_radio")
	register_clcmd("say /stop", "clcmd_stopradio")
	register_clcmd("say /sms", "clcmd_sms")
	register_clcmd("say /rules", "clcmd_rules")
	
	register_clcmd("xbans_custom_ban_reason", "clcmd_custombanreason")
	register_clcmd("xbans_custom_ban_length", "clcmd_custombanlength")
	
	register_concmd("amx_kick", "cmd_kick", ADMIN_KICK, "<nickname/#UserID> <reason>")
	register_concmd("amx_banmenu", "cmd_banmenu", ADMIN_BAN, "- displays ban menu")
	register_concmd("amx_ban", "cmd_ban", ADMIN_BAN, "<nickname/#UserID> <time in minutes> <reason>")
	register_concmd("amx_addip", "cmd_ban", ADMIN_BAN, "<nickname/#UserID> <time in minutes> <reason>")
	register_concmd("amx_addban", "cmd_ban", ADMIN_BAN, "<nickname/#UserID> <time in minutes> <reason>")
	register_concmd("amx_voteban", "cmd_ban", ADMIN_BAN, "<nickname/#UserID> <time in minutes> <reason>")
	register_concmd("amx_gag", "cmd_gag", ADMIN_BAN, "<nickname/#UserID> <time in minutes> <reason>")
	register_concmd("amx_gagmenu", "cmd_gagmenu", ADMIN_BAN, "- displays gag menu")
	register_concmd("amx_unban", "cmd_unban", ADMIN_CVAR, "<#BanID/IP/SteamID/nickname>")
	register_concmd("amx_reloadadmins", "concmd_reloadadmins", ADMIN_CFG)
	register_concmd("amx_reloadbanreasons", "concmd_reloadbanreasons", ADMIN_CFG)
	register_concmd("amx_reloadstreams", "concmd_reloadstreams", ADMIN_CFG)
	
	cvar_mode = register_cvar("amx_mode", "1")
	cvar_passwordfield = register_cvar("amx_password_field", "_pw")
	cvar_defaultaccess = register_cvar("amx_default_access", "z", FCVAR_PROTECTED)
	
	cvar_sqlprefix = register_cvar("xbans_sql_prefix", "amx")
	cvar_serveraddr = register_cvar("xbans_server_address", "")
	cvar_loadadmins = register_cvar("xbans_load_admins", "1")
	cvar_setinfokey = register_cvar("xbans_setinfo_key", "heapsize")
	cvar_complainurl = register_cvar("xbans_complain_url", "www.example.com")
	cvar_threadedloading = register_cvar("xbans_threaded_loading", "0")
	cvar_notifyonconnect = register_cvar("xbans_notify_on_connect", "0")
	cvar_messageinterval = register_cvar("xbans_message_interval", "30")
	
	g_adminids = ArrayCreate(1)
	g_banreasons = ArrayCreate(32)
	g_banlengths = ArrayCreate(1)
	g_streamids = ArrayCreate(1)
	g_streamnames = ArrayCreate(32)
	
	register_cvar("amx_vote_ratio", "0.02")
	register_cvar("amx_vote_time", "10")
	register_cvar("amx_vote_answers", "1")
	register_cvar("amx_vote_delay", "60")
	register_cvar("amx_last_voting", "0")
	register_cvar("amx_show_activity", "2")
	register_cvar("amx_votekick_ratio", "0.40")
	register_cvar("amx_voteban_ratio", "0.40")
	register_cvar("amx_votemap_ratio", "0.40")
	set_cvar_float("amx_last_voting", 0.0)
	
	register_cvar("amx_sql_host", "127.0.0.1")
	register_cvar("amx_sql_user", "root")
	register_cvar("amx_sql_pass", "")
	register_cvar("amx_sql_db", "amx")
	register_cvar("amx_sql_type", "mysql")
	
	// Client commands
	formatex(g_cmdloopback, charsmax(g_cmdloopback), "amxauth%c%c%c%c", random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'))
	register_clcmd(g_cmdloopback, "clcmd_amxauth")
	formatex(g_cmdloopback_ban, charsmax(g_cmdloopback_ban), "amxban%c%c%c%c", random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'))
	register_clcmd(g_cmdloopback_ban, "clcmd_amxban")
	
	// Server commands
	register_srvcmd("xbans_sqlinit", "sql_init")
	
	// Remove 'user' flag from server rights
	remove_user_flags(0, read_flags("z"))
	
	get_configsdir(g_configsdir, charsmax(g_configsdir))
	
	g_msgSayText = get_user_msgid("SayText")
	//g_msgScreenFade = get_user_msgid("ScreenFade")
	
	// Execute main configuration files
	server_cmd("exec %s/amxx.cfg", g_configsdir)
	server_cmd("exec %s/sql.cfg", g_configsdir)
	
	new xbanscfgfile[64]
	formatex(xbanscfgfile, charsmax(xbanscfgfile), "%s/xbans.cfg", g_configsdir)
	if (!file_exists(xbanscfgfile) || !file_size(xbanscfgfile))
	{
		server_print("[XBans] Could not load configuration file. Creating new.")
		
		for (new i; i < sizeof(DEFAULT_CFG_FILE); i++)
			write_file(xbanscfgfile, DEFAULT_CFG_FILE[i])
	}
	server_cmd("exec %s", xbanscfgfile)
	
	g_maxplayers = get_maxplayers()
}

public plugin_cfg()
{
	get_mapname(g_mapname, charsmax(g_mapname))
	
	set_task(0.25, "delayed_plugin_cfg")
	set_task(5.0, "delayed_load")
	
	set_task(get_pcvar_float(cvar_messageinterval), "display_server_message", _, _, _, "b")
}

public delayed_plugin_cfg()
{
	if (find_plugin_byfile("admin.amxx") != INVALID_PLUGIN_ID)
	{
		log_amx("[XBans] WARNING: admin.amxx plugin running! Stopped.")
		pause("acd", "admin.amxx")
	}
	if (find_plugin_byfile("admin_sql.amxx") != INVALID_PLUGIN_ID)
	{
		log_amx("[XBans] WARNING: admin_sql.amxx plugin running! Stopped.")
		pause("acd", "admin_sql.amxx")
	}
	
	get_pcvar_string(cvar_sqlprefix, g_sqlprefix, charsmax(g_sqlprefix))
	get_pcvar_string(cvar_serveraddr, g_serveraddr, charsmax(g_serveraddr))
	if (strlen(g_serveraddr) < 10) get_user_ip(0, g_serveraddr, charsmax(g_serveraddr))
	
	new tmpport[6]
	strtok(g_serveraddr, g_serverip, charsmax(g_serverip), tmpport, charsmax(tmpport), ':')
	g_serverport = str_to_num(tmpport)
	
	server_cmd("xbans_sqlinit")
	server_exec()
}

public sql_init()
{
	if (g_sqltuple != Empty_Handle) SQL_FreeHandle(g_sqltuple)
	g_sqltuple = SQL_MakeStdTuple()
	
	if (!g_sqltuple)
	{
		log_amx("sql_init(): failed to initialize g_sqltuple")
		return;
	}
	
	load_admins()
	load_banreasons()
	load_streams()
}

public delayed_load()
{
	new buffer[32], configfile[64], i
	
	while (g_mapname[i] != '_' && g_mapname[i++] != '^0') { /* do nothing */ }
	
	if (g_mapname[i] == '_')
	{
		copy(buffer, charsmax(buffer), g_mapname)
		buffer[i] = '^0'
		formatex(configfile, charsmax(configfile), "%s/maps/prefix_%s.cfg", g_configsdir, buffer)
		
		if (file_exists(configfile))
			server_cmd("exec %s", configfile)
	}
	
	formatex(configfile, charsmax(configfile), "%s/maps/%s.cfg", g_configsdir, g_mapname)
	
	if (file_exists(configfile))
		server_cmd("exec %s", configfile)
}

public load_admins()
{
	g_admincount = 0
	
	switch (get_pcvar_num(cvar_loadadmins))
	{
		case 0: // Don't load admins
		{
			server_print("[XBans] %L", LANG_SERVER, "SQL_CANT_LOAD_ADMINS", "Loading disabled, check XBans configuration file.")
			return;
		}
		case 2: // Load admins from file
		{
			// TODO: backup to users.ini
			return;
		}
	}
	
	if (get_pcvar_num(cvar_threadedloading))
	{
		new query[256]
		formatex(query, charsmax(query), QUERY_LOAD_SID, g_sqlprefix, g_serverip, g_serverport)
		
		SQL_ThreadQuery(g_sqltuple, "threaded_load_sid", query)
		return;
	}
	else
	{
		new error[128], errno
		new Handle:sql = SQL_Connect(g_sqltuple, errno, error, charsmax(error))
		
		if (sql == Empty_Handle)
		{
			server_print("[XBans] %L", LANG_SERVER, "SQL_CANT_CON", error)
			
			// TODO: backup to users.ini
			return;
		}
		
		admins_flush()
		
		new Handle:query = SQL_PrepareQuery(sql, QUERY_LOAD_SID, g_sqlprefix, g_serverip, g_serverport)
		
		if (!SQL_Execute(query))
		{
			SQL_QueryError(query, error, charsmax(error))
			server_print("[XBans] Can't load server ID: %s", error)
			
			// TODO: backup to users.ini
			return;
		}
		else if (!SQL_NumResults(query))
		{
			SQL_FreeHandle(query)
			query = SQL_PrepareQuery(sql, QUERY_INSERT_SID, g_sqlprefix, g_serverip, g_serverport)
			
			if (SQL_Execute(query))
			{
				g_serverid = SQL_GetInsertId(query)
			}
			else
			{
				SQL_QueryError(query, error, charsmax(error))
				server_print("[XBans] Can't insert server ID: %s", error)
				
				// TODO: backup to users.ini
				return;
			}
		}
		else
		{
			g_serverid = SQL_ReadResult(query, 0)
		}
		
		SQL_FreeHandle(query)
		query = SQL_PrepareQuery(sql, QUERY_LOAD_ADMINS, g_sqlprefix, g_sqlprefix, g_sqlprefix, g_serverid)
		
		if (!SQL_Execute(query))
		{
			SQL_QueryError(query, error, charsmax(error))
			server_print("[XBans] %L", LANG_SERVER, "SQL_CANT_LOAD_ADMINS", error)
		}
		else if (!SQL_NumResults(query))
		{
			server_print("[XBans] %L", LANG_SERVER, "NO_ADMINS")
		}
		else
		{
			new colauth = SQL_FieldNameToNum(query, "auth")
			new colpass = SQL_FieldNameToNum(query, "password")
			new colaccess = SQL_FieldNameToNum(query, "access")
			new colremovedflags = SQL_FieldNameToNum(query, "removed_flags")
			new colid = SQL_FieldNameToNum(query, "id")
			
			new dauth[34]
			new dpass[32]
			new daccess[32]
			new dremovedflags[32]
			
			while (SQL_MoreResults(query))
			{
				SQL_ReadResult(query, colauth, dauth, charsmax(dauth))
				SQL_ReadResult(query, colpass, dpass, charsmax(dpass))
				SQL_ReadResult(query, colaccess, daccess, charsmax(daccess))
				SQL_ReadResult(query, colremovedflags, dremovedflags, charsmax(dremovedflags))
				
				admins_push(dauth, dpass, read_flags(daccess) &~ read_flags(dremovedflags), read_flags("a"))
				ArrayPushCell(g_adminids, SQL_ReadResult(query, colid))
				
				g_admincount++
				SQL_NextRow(query)
			}
			
			if (g_admincount == 1)
				server_print("[XBans] %L", LANG_SERVER, "SQL_LOADED_ADMIN")
			else
				server_print("[XBans] %L", LANG_SERVER, "SQL_LOADED_ADMINS", g_admincount)
		}
		SQL_FreeHandle(sql)
		
		reaccess_users()
	}
}

public threaded_load_sid(failstate, Handle:query, error[], errno)
{
	if (failstate)
	{
		server_print("[XBans] Can't load server ID: %s", error)
		
		// TODO: backup to users.ini
		return;
	}
	
	if (SQL_NumResults(query))
	{
		g_serverid = SQL_ReadResult(query, 0)
		
		new pquery[256]
		formatex(pquery, charsmax(pquery), QUERY_LOAD_ADMINS, g_sqlprefix, g_sqlprefix, g_sqlprefix, g_serverid)
		
		SQL_ThreadQuery(g_sqltuple, "threaded_load_admins", pquery)
	}
	else
	{
		new pquery[256]
		formatex(pquery, charsmax(pquery), QUERY_INSERT_SID, g_sqlprefix, g_serverip, g_serverport)
		
		SQL_ThreadQuery(g_sqltuple, "threaded_insert_sid", pquery)
	}
}

public threaded_insert_sid(failstate, Handle:query, error[], errno)
{
	if (failstate)
	{
		server_print("[XBans] Can't insert server ID: %s", error)
		
		// TODO: backup to users.ini
		return;
	}
	
	g_serverid = SQL_GetInsertId(query)
	
	new pquery[256]
	formatex(pquery, charsmax(pquery), "SELECT aa.`id`, aa.`auth`, aa.`password`, aas.`access` \
					FROM `%s_admins` AS aa, `%s_admins_servers` AS aas, `%s_servers` AS asi WHERE \
					((aas.admin_id = aa.id) AND (aas.server_id = asi.id) AND (asi.id = %d))", \
					g_sqlprefix, g_sqlprefix, g_sqlprefix, g_serverid)
	
	SQL_ThreadQuery(g_sqltuple, "threaded_load_admins", pquery)
}

public threaded_load_admins(failstate, Handle:query, error[], errno)
{
	if (failstate)
	{
		server_print("[XBans] %L", LANG_SERVER, "SQL_CANT_LOAD_ADMINS", error)
		
		// TODO: backup to users.ini
		return;
	}
	
	if (!SQL_NumResults(query))
	{
		server_print("[XBans] %L", LANG_SERVER, "NO_ADMINS")
		return;
	}
	
	new colauth = SQL_FieldNameToNum(query, "auth")
	new colpass = SQL_FieldNameToNum(query, "password")
	new colaccess = SQL_FieldNameToNum(query, "access")
	new colid = SQL_FieldNameToNum(query, "id")
	new colremoved = SQL_FieldNameToNum(query, "removed_flags")
	
	new dauth[34]
	new dpass[32]
	new daccess[32]
	new dremoved[32]
	
	while (SQL_MoreResults(query))
	{
		SQL_ReadResult(query, colauth, dauth, charsmax(dauth))
		SQL_ReadResult(query, colpass, dpass, charsmax(dpass))
		SQL_ReadResult(query, colaccess, daccess, charsmax(daccess))
		SQL_ReadResult(query, colremoved, dremoved, charsmax(dremoved))
		
		admins_push(dauth, dpass, read_flags(daccess) & ~read_flags(dremoved), read_flags("a"))
		
		ArrayPushCell(g_adminids, SQL_ReadResult(query, colid))
		
		g_admincount++
		SQL_NextRow(query)
	}
	
	if (g_admincount == 1)
		server_print("[XBans] %L", LANG_SERVER, "SQL_LOADED_ADMIN")
	else
		server_print("[XBans] %L", LANG_SERVER, "SQL_LOADED_ADMINS", g_admincount)
	
	reaccess_users()
}

public load_banreasons()
{
	if (get_pcvar_num(cvar_threadedloading))
	{
		
	}
	else
	{
		new error[128], errno
		new Handle:sql = SQL_Connect(g_sqltuple, errno, error, charsmax(error))
		
		if (sql == Empty_Handle)
		{
			server_print("[XBans] %L", LANG_SERVER, "SQL_CANT_CON", error)
			return;
		}
		
		new Handle:query = SQL_PrepareQuery(sql, QUERY_LOAD_BANREASONS, g_sqlprefix, g_sqlprefix, g_serverid)
		
		if (!SQL_Execute(query))
		{
			SQL_QueryError(query, error, charsmax(error))
			server_print("[XBans] %L", LANG_SERVER, "SQL_CANT_LOAD_REASONS", error)
		}
		else if (!SQL_NumResults(query))
		{
			server_print("[XBans] %L", LANG_SERVER, "NO_REASONS")
		}
		else
		{
			g_banreasoncount = 0
			ArrayClear(g_banreasons)
			ArrayClear(g_banlengths)
			
			new reason[32]
			while (SQL_MoreResults(query))
			{
				SQL_ReadResult(query, 0, reason, charsmax(reason))
				
				ArrayPushString(g_banreasons, reason)
				ArrayPushCell(g_banlengths, SQL_ReadResult(query, 1))
				
				SQL_NextRow(query)
				g_banreasoncount++
			}
			
			if (g_banreasoncount == 1)
			{
				server_print("[XBans] %L", LANG_SERVER, "SQL_LOADED_REASON")
			}
			else
			{
				server_print("[XBans] %L", LANG_SERVER, "SQL_LOADED_REASONS", g_banreasoncount)
			}
		}
		
		SQL_FreeHandle(query)
	}
}

load_streams()
{
	if (get_pcvar_num(cvar_threadedloading))
	{
		
	}
	else
	{
		new error[128], errno
		new Handle:sql = SQL_Connect(g_sqltuple, errno, error, charsmax(error))
		
		if (sql == Empty_Handle)
		{
			server_print("[XBans] %L", LANG_SERVER, "SQL_CANT_CON", error)
			return;
		}
		
		new Handle:query = SQL_PrepareQuery(sql, QUERY_LOAD_STREAMS)
		
		if (!SQL_Execute(query))
		{
			SQL_QueryError(query, error, charsmax(error))
			server_print("[XBans] %L", LANG_SERVER, "SQL_CANT_LOAD_STREAMS", error)
		}
		else if (!SQL_NumResults(query))
		{
			server_print("[XBans] %L", LANG_SERVER, "NO_STREAMS")
		}
		else
		{
			g_streamcount = 0
			ArrayClear(g_streamids)
			ArrayClear(g_streamnames)
			
			new name[64]
			while (SQL_MoreResults(query))
			{
				SQL_ReadResult(query, 1, name, charsmax(name))
				
				ArrayPushString(g_streamnames, name)
				ArrayPushCell(g_streamids, SQL_ReadResult(query, 0))
				
				SQL_NextRow(query)
				g_streamcount++
			}
			
			if (g_streamcount == 1)
			{
				server_print("[XBans] %L", LANG_SERVER, "SQL_LOADED_STREAM")
			}
			else
			{
				server_print("[XBans] %L", LANG_SERVER, "SQL_LOADED_STREAMS", g_streamcount)
			}
		}
		
		SQL_FreeHandle(query)
	}
}

public client_connect(id)
{
	g_casesensitivename[id] = false
}

public client_authorized(id)
{
	if (get_pcvar_num(cvar_mode))
		access_user(id)
	
	validate_player(id)
}

public client_putinserver(id)
{
	if (!is_dedicated_server() && id == 1 && get_pcvar_num(cvar_mode)) access_user(id)
}

public clcmd_amxauth(id)
{
	server_cmd("kick #%d ^"%L^"", get_user_userid(id), id, "NO_ENTRY")
	
	return PLUGIN_HANDLED;
}

public clcmd_amxban(id)
{
	server_cmd("kick #%d ^"%L^"", get_user_userid(id), id, "BAN_MESSAGE")
	
	return PLUGIN_HANDLED;
}

public concmd_reloadadmins(id, level, cid)
{
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED
	
	remove_user_flags(0, read_flags("z"))
	
	load_admins()
	
	if (is_user_connected(id))
	{
		if (g_admincount == 1)
			console_print(id, "[XBans] %L", LANG_SERVER, "SQL_LOADED_ADMIN")
		else
			console_print(id, "[XBans] %L", LANG_SERVER, "SQL_LOADED_ADMINS", g_admincount)
	}
	
	return PLUGIN_HANDLED;
}

public concmd_reloadbanreasons(id, level, cid)
{
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED
	
	load_banreasons()
	
	if (is_user_connected(id))
	{
		if (g_banreasoncount == 1)
			console_print(id, "[XBans] %L", LANG_SERVER, "SQL_LOADED_REASON")
		else
			console_print(id, "[XBans] %L", LANG_SERVER, "SQL_LOADED_REASONS", g_banreasoncount)
	}
	
	return PLUGIN_HANDLED;
}

public concmd_reloadstreams(id, level, cid)
{
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED
	
	load_streams()
	
	if (is_user_connected(id))
	{
		if (g_streamcount == 1)
			console_print(id, "[XBans] %L", LANG_SERVER, "SQL_LOADED_STREAM")
		else
			console_print(id, "[XBans] %L", LANG_SERVER, "SQL_LOADED_STREAMS", g_streamcount)
	}
	
	return PLUGIN_HANDLED;
}

public client_infochanged(id)
{
	if (!is_user_connected(id) || !get_pcvar_num(cvar_mode))
		return PLUGIN_CONTINUE;
	
	new newname[32], oldname[32]
	get_user_name(id, oldname, 31)
	get_user_info(id, "name", newname, 31)
	
	if (g_casesensitivename[id])
	{
		if (!equal(newname, oldname))
			access_user(id, newname)
	}
	else
	{
		if (!equali(newname, oldname))
			access_user(id, newname)
	}
	
	return PLUGIN_CONTINUE;
}

reaccess_users()
{
	for (new id = 1; id <= g_maxplayers; id++)
	{
		if (!is_user_connecting(id) && !is_user_connected(id))
			continue;
		
		access_user(id)
	}
}

access_user(id, name[] = "")
{
	remove_user_flags(id)
	
	new userip[32], userauthid[32], password[24], passfield[32], username[32]
	get_user_ip(id, userip, charsmax(userip), 1)
	get_user_authid(id, userauthid, charsmax(userauthid))
	get_pcvar_string(cvar_passwordfield, passfield, charsmax(passfield))
	get_user_info(id, passfield, password, charsmax(password))
	
	if (name[0])
		copy(username, charsmax(username), name)
	else
		get_user_name(id, username, charsmax(username))
	
	new result = get_access(id, username, userauthid, userip, password)
	
	if (result & 1)
	{
		client_cmd(id, "echo ^"* %L^"", id, "INV_PAS")
	}
	
	if (result & 2)
	{
		client_cmd(id, "%s", g_cmdloopback)
		
		return PLUGIN_HANDLED;
	}
	
	if (result & 4)
	{
		client_cmd(id, "echo ^"* %L^"", id, "PAS_ACC")
	}
	
	if (result & 8)
	{
		client_cmd(id, "echo ^"* %L^"", id, "PRIV_SET")
	}
	
	return PLUGIN_CONTINUE;
}

get_access(id, name[], authid[], ip[], password[])
{
	new index = -1
	new result = 0
	
	static Count;
	static Flags;
	static Access;
	static AuthData[44];
	static Password[32];
	
	g_casesensitivename[id] = false;
	
	Count=admins_num();
	for (new i = 0; i < Count; ++i)
	{
		Flags=admins_lookup(i,AdminProp_Flags);
		admins_lookup(i,AdminProp_Auth,AuthData,sizeof(AuthData)-1);
		
		if (Flags & FLAG_AUTHID)
		{
			if (equal(authid, AuthData))
			{
				index = i
				break
			}
		}
		else if (Flags & FLAG_IP)
		{
			new c = strlen(AuthData)
			
			if (AuthData[c - 1] == '.')		/* check if this is not a xxx.xxx. format */
			{
				if (equal(AuthData, ip, c))
				{
					index = i
					break
				}
			}									/* in other case an IP must just match */
			else if (equal(ip, AuthData))
			{
				index = i
				break
			}
		} 
		else 
		{
			if (Flags & FLAG_CASE_SENSITIVE)
			{
				if (Flags & FLAG_TAG)
				{
					if (contain(name, AuthData) != -1)
					{
						index = i
						g_casesensitivename[id] = true
						break
					}
				}
				else if (equal(name, AuthData))
				{
					index = i
					g_casesensitivename[id] = true
					break
				}
			}
			else
			{
				if (Flags & FLAG_TAG)
				{
					if (containi(name, AuthData) != -1)
					{
						index = i
						break
					}
				}
				else if (equali(name, AuthData))
				{
					index = i
					break
				}
			}
		}
	}
	
	if (index != -1)
	{
		Access=admins_lookup(index,AdminProp_Access);

		if (Flags & FLAG_NOPASS)
		{
			result |= 8
			new sflags[32]
			
			get_flags(Access, sflags, 31)
			set_user_flags(id, Access)
			g_adminid[id] = ArrayGetCell(g_adminids, index)
			
			log_amx("Login: ^"%s<%d><%s><>^" became an admin (account ^"%s^") (access ^"%s^") (address ^"%s^")", name, get_user_userid(id), authid, AuthData, sflags, ip)
		}
		else 
		{
		
			admins_lookup(index,AdminProp_Password,Password,sizeof(Password)-1);

			if (equal(password, Password))
			{
				result |= 12
				set_user_flags(id, Access)
				g_adminid[id] = ArrayGetCell(g_adminids, index)
				
				new sflags[32]
				get_flags(Access, sflags, 31)
				
				log_amx("Login: ^"%s<%d><%s><>^" became an admin (account ^"%s^") (access ^"%s^") (address ^"%s^")", name, get_user_userid(id), authid, AuthData, sflags, ip)
			} 
			else 
			{
				result |= 1
				
				if (Flags & FLAG_KICK)
				{
					result |= 2
					log_amx("Login: ^"%s<%d><%s><>^" kicked due to invalid password (account ^"%s^") (address ^"%s^")", name, get_user_userid(id), authid, AuthData, ip)
				}
			}
		}
	}
	else if (get_pcvar_float(cvar_mode) == 2.0)
	{
		result |= 2
	} 
	else 
	{
		new defaccess[32]
		
		get_pcvar_string(cvar_defaultaccess, defaccess, 31)
		
		if (!strlen(defaccess))
		{
			copy(defaccess, 32, "z")
		}
		
		new idefaccess = read_flags(defaccess)
		
		if (idefaccess)
		{
			result |= 8
			set_user_flags(id, idefaccess)
		}
	}
	
	return result;
}

sql_error(error[])
{
	log_amx("[XBans] %L", LANG_SERVER, "SQL_ERROR", error)
}

sql_escape_string(string[], len)
{
	replace_all(string, len, "\", "\\")
	replace_all(string, len, "'", "\'")
	replace_all(string, len, "^"", "\^"")
}

public clcmd_sms(id)
{
	if (g_serverid == 3) return;
	new message[128], name[32]
	get_user_name(id, name, charsmax(name))
	formatex(message, charsmax(message), "<meta http-equiv=^"refresh^" content=^"0; url=http://www.example.com/resources/motd/?s=%d&n=%s^">", g_serverid, name)
	
	show_motd(id, message, "SMS")
}

public clcmd_rules(id)
{
	new message[128]
	formatex(message, charsmax(message), "<meta http-equiv=^"refresh^" content=^"0; url=http://www.example.com/resources/motd/rules.php?s=%d^">", g_serverid)
	
	show_motd(id, message, "Rules")
}
