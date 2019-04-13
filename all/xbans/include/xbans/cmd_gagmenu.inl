#if defined _cmd_gagmenu_included
    #endinput
#endif
#define _cmd_gagmenu_included

public cmd_gagmenu(id, level, cid)
{
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED;
	
	// Not really implemented as of now
	//display_gagmenu(id)
	
	return PLUGIN_HANDLED;
}
