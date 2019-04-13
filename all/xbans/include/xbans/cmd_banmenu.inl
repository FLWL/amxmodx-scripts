#if defined _cmd_banmenu_included
    #endinput
#endif
#define _cmd_banmenu_included

public cmd_banmenu(id, level, cid)
{
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED;
	
	display_banmenu(id)
	
	return PLUGIN_HANDLED;
}

display_banmenu(id)
{
	static menuid, menu[128], name[32], player, korrapidaja, buffer[1]
	korrapidaja = (get_user_flags(id) & ADMIN_LEVEL_G)
	
	// Title
	formatex(menu, charsmax(menu), "%L\r", id, "MENU_BAN_PLAYER")
	
	menuid = menu_create(menu, "banmenu")
	
	// Player List
	for (player = 1; player <= g_maxplayers; player++)
	{
		// Skip if not connected
		if (!is_user_connected(player))
			continue;
		
		get_user_name(player, name, charsmax(name))
		buffer[0] = player
		
		if (is_user_bot(player) || ((access(player, ADMIN_IMMUNITY) && !korrapidaja)))
		{
			formatex(menu, charsmax(menu), "\d%s", name)
			menu_additem(menuid, menu, buffer, _, menu_makecallback("menucallback_disabled"))
		}
		else
		{
			formatex(menu, charsmax(menu), "%s", name)
			menu_additem(menuid, menu, buffer)
		}
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	menu_display(id, menuid)
}

public banmenu(id, menuid, item)
{
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	static buffer[1], dummy, player
	menu_item_getinfo(menuid, item, dummy, buffer, sizeof(buffer), _, _, dummy)
	player = buffer[0]
	
	// Mängija on juba lahkunud või tema access on muutunud
	if (!is_user_connected(player) || (access(player, ADMIN_IMMUNITY) && !access(id, ADMIN_LEVEL_G)))
	{
		colored_print(id, "^x01[^x04XBans^x01] That player is already disconnected.")
		
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	g_playerbanuserid[id] = get_user_userid(player)
	
	// Move on to the reason menu
	display_banreasonmenu(id, player)
	
	menu_destroy(menuid)
	return PLUGIN_CONTINUE;
}

display_banreasonmenu(id, player)
{
	g_custombanplayer[id] = 0
	g_custombanreason[id] = "^0"
	
	static menuid, menu[128], reason[32], length, time_length[32], buffer[2]
	
	// Title
	formatex(menu, charsmax(menu), "%L\r", id, "MENU_BAN_REASON")
	
	menuid = menu_create(menu, "banreasonmenu")
	
	// Custom reason
	buffer[0] = player
	buffer[1] = -1
	menu_additem(menuid, "Custom Reason\y (custom length)", buffer)
	
	for (new i; i < g_banreasoncount; i++)
	{
		ArrayGetString(g_banreasons, i, reason, charsmax(reason))
		length = ArrayGetCell(g_banlengths, i)
		
		if (length)
			get_time_length(player, length, timeunit_minutes, time_length, charsmax(time_length))
		else
			time_length = "permanent"
		
		formatex(menu, charsmax(menu), "%s\y (%s)", reason, time_length)
		
		// Add reason
		buffer[0] = player
		buffer[1] = i
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	menu_display(id, menuid)
}

public banreasonmenu(id, menuid, item)
{
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		
		return PLUGIN_HANDLED;
	}
	
	static buffer[2], dummy, player, reasonid
	menu_item_getinfo(menuid, item, dummy, buffer, sizeof(buffer), _, _, dummy)
	player = buffer[0]
	reasonid = buffer[1]
	
	// Mängija on juba lahkunud või tema access on muutunud
	if (!is_user_connected(player) || (access(player, ADMIN_IMMUNITY) && !access(id, ADMIN_LEVEL_G)) || get_user_userid(player) != g_playerbanuserid[id])
	{
		colored_print(id, "^x01[^x04XBans^x01] That player is already disconnected.")
		
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	if (reasonid == -1) // Custom reason
	{
		g_custombanplayer[id] = player
		
		client_cmd(id, "messagemode xbans_custom_ban_reason")
	}
	else
	{
		static reason[32]
		ArrayGetString(g_banreasons, reasonid, reason, charsmax(reason))
		
		ban(id, player, ArrayGetCell(g_banlengths, reasonid), reason, charsmax(reason))
	}
	
	return PLUGIN_CONTINUE;
}

public clcmd_custombanreason(id)
{
	if (!access(id, ADMIN_BAN) || !g_custombanplayer[id] || get_user_userid(g_custombanplayer[id]) != g_playerbanuserid[id])
		return PLUGIN_HANDLED;
	
	read_args(g_custombanreason[id], charsmax(g_custombanreason[]))
	remove_quotes(g_custombanreason[id])
	
	if (!g_custombanreason[id][0])
		return PLUGIN_HANDLED;
	
	client_cmd(id, "messagemode xbans_custom_ban_length")
	return PLUGIN_HANDLED;
}

public clcmd_custombanlength(id)
{
	if (!access(id, ADMIN_BAN) || !g_custombanplayer[id] || !g_custombanreason[id][0] || get_user_userid(g_custombanplayer[id]) != g_playerbanuserid[id])
		return PLUGIN_HANDLED;
	
	static msg[8]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	ban(id, g_custombanplayer[id], abs(str_to_num(msg)), g_custombanreason[id], charsmax(g_custombanreason[]))
	return PLUGIN_HANDLED;
}

public menucallback_disabled() return ITEM_DISABLED;
