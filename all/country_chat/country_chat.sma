#include <amxmodx>
#include <cstrike>
#include <geoip>
#include <regex>

new const TEAM_NAMES[][] =
{
	"Unassigned",
	"Terrorist",
	"Counter-Terrorist",
	"Spectator"
}

new const BAD_CHARS[][] =
{
	"",
	"",
	"",
	""
}

new const SWEAR_WORDS[][] =
{
	"prick",
	"damn"
}

new const IP_PATTERN[] = "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"

new cvar_hidecommands, cvar_swearfilter, cvar_ipfilter, cvar_logchat

new bool:g_bIsConnected[33]
new g_szCountyCode[33][5]
new g_szSteamID[33][34]
new g_szIP[33][16]
new g_szLogDir[64]
new g_iMsgSayText
new g_iMaxplayers
new Regex:g_Pattern
new g_iRet

new Float:g_flLastMsg[33]
new Float:g_flFlooding[33]
new g_iFloodCount[33]

public plugin_init()
{
	register_plugin("Country Chat", "1.1", "Exolent / xPaw / FLWL")
	
	register_dictionary("antiflood.txt")
	
	cvar_hidecommands = register_cvar("country_chat_hide_commands", "0")
	cvar_swearfilter = register_cvar("country_chat_swear_filter", "1")
	cvar_ipfilter = register_cvar("country_chat_ip_filter", "1")
	cvar_logchat = register_cvar("country_chat_log", "1")
	
	register_clcmd("say", "CmdSay")
	register_clcmd("say_team", "CmdTeamSay")
	
	g_iMsgSayText = get_user_msgid("SayText")
	g_iMaxplayers = get_maxplayers()
	
	get_localinfo("amxx_logs", g_szLogDir, charsmax(g_szLogDir))
	add(g_szLogDir, charsmax(g_szLogDir), "/chat")
	if (!dir_exists(g_szLogDir)) mkdir(g_szLogDir)
	
	// Compile regex pattern
	new error[32]
	g_Pattern = regex_compile(IP_PATTERN, g_iRet, error, charsmax(error), "i")
	if (g_Pattern != REGEX_OK) set_fail_state("Failed to compile pattern.")
}

public client_putinserver(id)
{
	new name[32]
	get_user_name(id, name, charsmax(name))
	if (CheckSwear(name))
	{
		server_cmd("kick #%d ^"Check your nickname.^"", get_user_userid(id))
		return;
	}
	
	new szCode[3]
	get_user_ip(id, g_szIP[id], charsmax(g_szIP[]), 1)
	get_user_authid(id, g_szSteamID[id], charsmax(g_szSteamID[]))
	
	if (!geoip_code2_ex(g_szIP[id], szCode))
	{
		szCode[0] = '-'
		szCode[1] = '-'
	}
	
	g_szCountyCode[id][0] = szCode[0]
	g_szCountyCode[id][1] = szCode[1]
	
	g_iFloodCount[id] = 0
	
	g_bIsConnected[id] = true
}

public client_disconnect(id)
{
	g_bIsConnected[id] = false
}

public CmdSay(id)
{
	if (!g_bIsConnected[id])
		return PLUGIN_HANDLED;
	
	if (CheckFlood(id))
		return PLUGIN_HANDLED;
	
	new szText[192]
	read_args(szText, charsmax(szText))
	remove_quotes(szText)
	
	if (szText[0] == '/' && get_pcvar_num(cvar_hidecommands))
		return PLUGIN_HANDLED_MAIN;
	
	if (!IsValidMessage(szText))
		return PLUGIN_HANDLED;
	
	new i;
	for (i = 0; i < sizeof(BAD_CHARS); i++)
		if (contain(szText, BAD_CHARS[i]))
			replace_all(szText, charsmax(szText), BAD_CHARS[i], "")
	
	// Remove double spaces / %s
	while (replace(szText, charsmax(szText), "  ", " ")) {}
	
	// Get user name
	new szName[32], szMessage[192]
	get_user_name(id, szName, charsmax(szName))
	
	// Format chat tag
	new szTag[8] // don't change to static
	if (!is_user_alive(id))
		copy(szTag, charsmax(szTag), "*DEAD* ")
	if (cs_get_user_team(id) == CS_TEAM_SPECTATOR)
		copy(szTag, charsmax(szTag), "*SPEC* ")
	
	// Get user flags
	static flags
	flags = get_user_flags(id)
	
	// Format chat message
	if (flags & ADMIN_CVAR)
		formatex(szMessage, charsmax(szMessage), "^4[%s]^1 %s^3%s^1:^4 %s", g_szCountyCode[id], szTag, szName, szText)
	else if (flags & ADMIN_LEVEL_G)
		formatex(szMessage, charsmax(szMessage), "^4[^3%s^4]^1 %s^3%s^1:^4 %s", g_szCountyCode[id], szTag, szName, szText)
	else if (flags & ADMIN_CHAT)
		formatex(szMessage, charsmax(szMessage), "^3[%s]^1 %s^3%s^1:^4 %s", g_szCountyCode[id], szTag, szName, szText)
	else
		formatex(szMessage, charsmax(szMessage), "^3[%s]^1 %s^3%s^1: %s", g_szCountyCode[id], szTag, szName, szText)
	
	// Check for swearwords
	static bool:bBlocked
	bBlocked = CheckSwear(szText)
	
	if (isBlocked(id)) bBlocked = true;
	
	if (bBlocked)
	{
		message_begin(MSG_ONE_UNRELIABLE, g_iMsgSayText, _, id)
		write_byte(id)
		write_string(szMessage)
		message_end()
	}
	else
	{
		for (i = 1; i <= g_iMaxplayers; i++)
		{
			if (g_bIsConnected[i])
			{
				message_begin(MSG_ONE_UNRELIABLE, g_iMsgSayText, _, i)
				write_byte(id)
				write_string(szMessage)
				message_end()
			}
		}
	}
	
	if (get_pcvar_num(cvar_logchat))
	{
		// Get needed info for logging
		static szLogMessage[512], szLogFile[64], szDate[32], szTime[32]
		get_time("%Y.%m.%d", szDate, charsmax(szDate))
		get_time("%H:%M:%S", szTime, charsmax(szTime))

		// Format log message
		formatex(szLogMessage, charsmax(szLogMessage), "<%s><%s>%s[%s] %s%s: %s", g_szSteamID[id], g_szIP[id], (bBlocked ? " BLOCKED: " : " "), g_szCountyCode[id], szTag, szName, szText)

		// Log to file
		formatex(szLogFile, charsmax(szLogFile), "%s/%s.log", g_szLogDir, szDate)
		log_to_file(szLogFile, szLogMessage)
	}
	
	return PLUGIN_HANDLED_MAIN;
}

public CmdTeamSay(id)
{
	if (!g_bIsConnected[id])
		return PLUGIN_HANDLED;
	
	if (CheckFlood(id))
		return PLUGIN_HANDLED;
	
	new szText[192]
	read_args(szText, charsmax(szText))
	remove_quotes(szText)
	
	if (szText[0] == '/' && get_pcvar_num(cvar_hidecommands))
		return PLUGIN_HANDLED_MAIN;
	
	if (!IsValidMessage(szText))
		return PLUGIN_HANDLED;
	
	new i;
	for (i = 0; i < sizeof(BAD_CHARS); i++)
		if (contain(szText, BAD_CHARS[i]))
			replace_all(szText, charsmax(szText), BAD_CHARS[i], "")
	
	// Remove double spaces / %s
	while (replace(szText, charsmax(szText), "  ", " ")) {}
	
	new szName[32], szTag[8], szMessage[192]
	new iTeam = _:cs_get_user_team(id)
	get_user_name(id, szName, charsmax(szName))
	
	if (iTeam != 3 && !is_user_alive(id))
		copy(szTag, charsmax(szTag), "*DEAD* ")
	
	new flags = get_user_flags(id)
	
	if (flags & ADMIN_CVAR)
		formatex(szMessage, charsmax(szMessage), "^4[%s]^1 %s(%s)^3 %s^1:^x04 %s", g_szCountyCode[id], szTag, TEAM_NAMES[iTeam], szName, szText)
	else if (flags & ADMIN_LEVEL_G)
		formatex(szMessage, charsmax(szMessage), "^4[^3%s^4]^1 %s(%s)^3 %s^1:^x04 %s", g_szCountyCode[id], szTag, TEAM_NAMES[iTeam], szName, szText)
	else if (flags & ADMIN_CHAT)
		formatex(szMessage, charsmax(szMessage), "^3[%s]^1 %s(%s)^3 %s^1:^x04 %s", g_szCountyCode[id], szTag, TEAM_NAMES[iTeam], szName, szText)
	else
		formatex(szMessage, charsmax(szMessage), "^3[%s]^1 %s(%s)^3 %s^1: %s", g_szCountyCode[id], szTag, TEAM_NAMES[iTeam], szName, szText)
	
	// Check for swearwords
	static bool:bBlocked
	bBlocked = CheckSwear(szText)
	
	if (isBlocked(id)) bBlocked = true;
	
	if (bBlocked)
	{
		message_begin(MSG_ONE_UNRELIABLE, g_iMsgSayText, _, id)
		write_byte(id)
		write_string(szMessage)
		message_end()
	}
	else
	{
		for (i = 1; i <= g_iMaxplayers; i++)
		{
			if (g_bIsConnected[i])
			{
				if (_:cs_get_user_team(i) == iTeam || cs_get_user_team(i) == CS_TEAM_SPECTATOR)
				{
					message_begin(MSG_ONE_UNRELIABLE, g_iMsgSayText, _, i)
					write_byte(id)
					write_string(szMessage)
					message_end()
				}
			}
		}
	}
	
	if (get_pcvar_num(cvar_logchat))
	{
		// Get needed info for logging
		static szLogMessage[512], szLogFile[64], szDate[32], szTime[32]
		get_time("%Y.%m.%d", szDate, charsmax(szDate))
		get_time("%H:%M:%S", szTime, charsmax(szTime))
		
		// Format log message
		formatex(szLogMessage, charsmax(szLogMessage), "<%s><%s>%s[%s] %s(%s) %s: %s", g_szSteamID[id], g_szIP[id], (bBlocked ? " BLOCKED: " : " "), g_szCountyCode[id], szTag, TEAM_NAMES[iTeam], szName, szText)
		
		// Log to file
		formatex(szLogFile, charsmax(szLogFile), "%s/%s.log", g_szLogDir, szDate)
		log_to_file(szLogFile, szLogMessage)
	}
	
	return PLUGIN_HANDLED_MAIN;
}

public isBlocked(id)
{
	// to block any specific players maybe
	return false;
}

bool:CheckSwear(szSaid[])
{
	// Backup the text
	static szText[192]
	copy(szText, charsmax(szText), szSaid)
	
	// Variable o.O
	static i
	
	// Fix text
	replace_all(szText, charsmax(szText), " ", "")
	
	// Get length
	static len
	len = strlen(szText)
	
	// Check if it contains IPs
	if (get_pcvar_num(cvar_ipfilter))
	{
		// Contains IPs
		if (len > 4)
			if (regex_match_c(szText, g_Pattern, g_iRet) > 0)
				return true;
	}
	
	// Leet filter
	for (i = 0; i < len; i++)
	{
		switch (szText[i])
		{
			case '@': szText[i] = 'a';
			case '$': szText[i] = 's';
			case '!': szText[i] = 'i';
			case '3': szText[i] = 'e';
			case -61:
			{
				if (szText[i+1] == -68 || szText[i+1] == -100)
				{
					szText[i] = 'y'
					szText[i+1] = ' '
				}
			}
		}
	}
	
	// Special chars
	replace_all(szText, charsmax(szText), "ü", "y")
	replace_all(szText, charsmax(szText), "Ü", "y")
	replace_all(szText, charsmax(szText), " ", "")
	
	if (get_pcvar_num(cvar_swearfilter))
	{
		// Contains swearwords
		for (i = 0; i < sizeof(SWEAR_WORDS); i++)
			if (containi(szText, SWEAR_WORDS[i]) != -1)
				return true;
	}
	
	// Negative
	return false;
}

bool:CheckFlood(id)
{
	new Float:flGametime = get_gametime()
	
	if (g_flLastMsg[id] + 0.25 > flGametime)
		return true;
	
	g_flLastMsg[id] = flGametime
	
	if (g_flFlooding[id] > flGametime)
	{
		if (g_iFloodCount[id] >= 3)
		{
			client_print(id, print_notify, "** %L **", id, "STOP_FLOOD")
			client_print(id, print_center, "** %L **", id, "STOP_FLOOD")
			
			g_flFlooding[id] = flGametime + 3.75
			
			return true;
		}
		
		g_iFloodCount[id]++
	}
	else if (g_iFloodCount[id])
		g_iFloodCount[id]--
	
	g_flFlooding[id] = flGametime + 0.75
	return false;
}

bool:IsValidMessage(const szText[])
{
	new iLen = strlen(szText)
	if (!iLen)
		return false;
	
	for (new i; i < iLen; i++)
		if (szText[i] != ' ')
			return true;
	
	return false;
}
