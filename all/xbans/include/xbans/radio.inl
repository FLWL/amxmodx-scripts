#if defined _radio_included
	#endinput
#endif
#define _radio_included

public clcmd_radio(id)
{
	display_radiomenu(id)
}

display_radiomenu(id)
{
	static menuid, menu[128], buffer[2]
	
	// Title
	formatex(menu, charsmax(menu), "Radio\r")
	
	menuid = menu_create(menu, "radiomenu")
	
	for (new i; i < g_streamcount; i++)
	{
		ArrayGetString(g_streamnames, i, menu, charsmax(menu))
		
		// Add id
		buffer[0] = i
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

public radiomenu(id, menuid, item)
{
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		
		return PLUGIN_HANDLED;
	}
	
	static buffer[2], dummy, streamid
	menu_item_getinfo(menuid, item, dummy, buffer, sizeof(buffer), _, _, dummy)
	streamid = buffer[0]
	
	show_stream(id, streamid)
	return PLUGIN_CONTINUE;
}

show_stream(id, streamid)
{
	new message[128], header[64]
	formatex(message, charsmax(message), "<meta http-equiv=^"refresh^" content=^"0; url=http://www.example.com/resources/motd/stream.php?id=%d^">", ArrayGetCell(g_streamids, streamid))
	ArrayGetString(g_streamnames, streamid, header, charsmax(header))
	
	show_motd(id, message, header)
}

public clcmd_stopradio(id)
{
	show_motd(id, "You may now close this window.", "Radio Stopped")
}
