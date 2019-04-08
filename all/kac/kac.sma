#include <amxmodx>
#include <amxmisc>

new const CMD_CDHACK[][] = { "cd_choke", "cd_fps", "cd_sound", "cd_version" }
new const CMD_XHACK[][] = { "xHack_do", "xHack_in", "xHack_fastrun", "xHack_bhop" }
new const CMD_KZHACK[][] = { "kzh_exec", "kzh_bhop", "kzh_speed", "kzh_noflash" }
new const CMD_BIOTECKHACK[][] = { ".developer", ".speed", ".jumpbug_auto", ".jumpbug_fps" }

new g_CDHack_Cmd[256]
new g_CDHack_ConfirmCmd[16]
new g_CDHack_Passed[33]
new g_CDHack_Confirmed[33]

new g_XHack_Cmd[256]
new g_XHack_ConfirmCmd[16]
new g_XHack_Passed[33]
new g_XHack_Confirmed[33]

new g_KZHack_Cmd[256]
new g_KZHack_ConfirmCmd[16]
new g_KZHack_Passed[33]
new g_KZHack_Confirmed[33]

new g_BiotecKHack_Cmd[256]
new g_BiotecKHack_ConfirmCmd[16]
new g_BiotecKHack_Passed[33]
new g_BiotecKHack_Confirmed[33]

new g_State[33]
new g_Valid_Id[33]

public plugin_init()
{
	register_plugin("KAC", "1.2", "FLWL")
	
	formatex(g_CDHack_ConfirmCmd, charsmax(g_CDHack_ConfirmCmd), "kac_cdhack%c%c%c%c", random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'))
	register_clcmd(g_CDHack_ConfirmCmd, "cmd_cdhack_confirm")
	formatex(g_XHack_ConfirmCmd, charsmax(g_XHack_ConfirmCmd), "kac_xhack%c%c%c%c", random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'))
	register_clcmd(g_XHack_ConfirmCmd, "cmd_xhack_confirm")
	formatex(g_KZHack_ConfirmCmd, charsmax(g_KZHack_ConfirmCmd), "kac_kzhack%c%c%c%c", random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'))
	register_clcmd(g_KZHack_ConfirmCmd, "cmd_kzhack_confirm")
	formatex(g_BiotecKHack_ConfirmCmd, charsmax(g_BiotecKHack_ConfirmCmd), "kac_bioteckhack%c%c%c%c", random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'), random_num('A', 'Z'))
	register_clcmd(g_BiotecKHack_ConfirmCmd, "cmd_bioteckhack_confirm")
	
	// CDHack
	new i, len
	for (i = 0; i < sizeof(CMD_CDHACK); i++)
	{
		len += formatex(g_CDHack_Cmd[len], charsmax(g_CDHack_Cmd) - len, "%s;", CMD_CDHACK[i])
		register_clcmd(CMD_CDHACK[i], "cmd_cdhack_passed")
	}
	formatex(g_CDHack_Cmd[len], charsmax(g_CDHack_Cmd) - len, "%s", g_CDHack_ConfirmCmd)
	
	// XHack
	len = 0
	for (i = 0; i < sizeof(CMD_XHACK); i++)
	{
		len += formatex(g_XHack_Cmd[len], charsmax(g_XHack_Cmd) - len, "%s;", CMD_XHACK[i])
		register_clcmd(CMD_XHACK[i], "cmd_xhack_passed")
	}
	formatex(g_XHack_Cmd[len], charsmax(g_XHack_Cmd) - len, "%s", g_XHack_ConfirmCmd)
	
	// KZHack
	len = 0
	for (i = 0; i < sizeof(CMD_KZHACK); i++)
	{
		len += formatex(g_KZHack_Cmd[len], charsmax(g_KZHack_Cmd) - len, "%s;", CMD_KZHACK[i])
		register_clcmd(CMD_KZHACK[i], "cmd_kzhack_passed")
	}
	formatex(g_KZHack_Cmd[len], charsmax(g_KZHack_Cmd) - len, "%s", g_KZHack_ConfirmCmd)
	
	// BiotecK Hack
	len = 0
	for (i = 0; i < sizeof(CMD_BIOTECKHACK); i++)
	{
		len += formatex(g_BiotecKHack_Cmd[len], charsmax(g_BiotecKHack_Cmd) - len, "%s;", CMD_BIOTECKHACK[i])
		register_clcmd(CMD_BIOTECKHACK[i], "cmd_bioteckhack_passed")
	}
	formatex(g_BiotecKHack_Cmd[len], charsmax(g_BiotecKHack_Cmd) - len, "%s", g_BiotecKHack_ConfirmCmd)
}

public client_disconnect(id)
{
	remove_task(id)
}

public client_putinserver(id)
{
	static authid[34]
	get_user_authid(id, authid, charsmax(authid))
	
	if (authid[7] == ':')
		g_Valid_Id[id] = true
	else
		g_Valid_Id[id] = false
	
	if (g_Valid_Id[id])
		g_State[id] = 3
	else
		g_State[id] = 1 // Send CDHack commands
	
	g_CDHack_Passed[id] = false
	g_CDHack_Confirmed[id] = false
	
	g_XHack_Passed[id] = false
	g_XHack_Confirmed[id] = false
	
	set_task(2.5, "task_checkcheats", id, _, _, "b")
}

public task_checkcheats(id)
{
	switch (g_State[id])
	{
		case 1: // Send CDHack commands
		{
			g_State[id] = 2 // Check CDHack response
			client_cmd(id, g_CDHack_Cmd)
		}
		case 2: // Check CDHack response
		{
			if (g_CDHack_Confirmed[id]) // Response from player
			{
				if (g_CDHack_Passed[id]) // Player is clean
				{
					g_State[id] = 3 // Go to next test
				}
				else
				{
					static name[32]
					get_user_name(id, name, charsmax(name))
					
					server_cmd("amx_ban #%d 10080 ^"[KAC] CDHack Detected^"", get_user_userid(id))
				}
			}
			else
			{
				g_State[id] = 1 // Send commands again
			}
		}
		case 3: // Send XHack commands
		{
			g_State[id] = 4 // Check XHack response
			client_cmd(id, g_XHack_Cmd)
		}
		case 4: // Check XHack response
		{
			if (g_XHack_Confirmed[id]) // Response from player
			{
				if (g_XHack_Passed[id]) // Player is clean
				{
					g_State[id] = 5 // Go to next test
				}
				else
				{
					static name[32]
					get_user_name(id, name, charsmax(name))
					
					server_cmd("amx_ban #%d 10080 ^"[KAC] XHack Detected^"", get_user_userid(id))
				}
			}
			else
			{
				g_State[id] = 3 // Send commands again
			}
		}
		case 5: // Send KZHack commands
		{
			g_State[id] = 6 // Check KZHack response
			client_cmd(id, g_KZHack_Cmd)
		}
		case 6: // Check KZHack response
		{
			if (g_KZHack_Confirmed[id]) // Response from player
			{
				if (g_KZHack_Passed[id]) // Player is clean
				{
					g_State[id] = 7 // Go to next test
				}
				else
				{
					static name[32]
					get_user_name(id, name, charsmax(name))
					
					server_cmd("amx_ban #%d 10080 ^"[KAC] KZHack Detected^"", get_user_userid(id))
				}
			}
			else
			{
				g_State[id] = 5 // Send commands again
			}
		}
		case 7: // Send BiotecKHack commands
		{
			g_State[id] = 8 // Check BiotecKHack response
			client_cmd(id, g_BiotecKHack_Cmd)
		}
		case 8: // Check BiotecKHack response
		{
			if (g_BiotecKHack_Confirmed[id]) // Response from player
			{
				if (g_BiotecKHack_Passed[id]) // Player is clean
				{
					g_State[id] = 9 // Go to next test
				}
				else
				{
					static name[32]
					get_user_name(id, name, charsmax(name))
					
					server_cmd("amx_ban #%d 10080 ^"[KAC] BiotecK Hack Detected^"", get_user_userid(id))
				}
			}
			else
			{
				g_State[id] = 7 // Send commands again
			}
		}
		case 9: remove_task(id)
	}
}

public cmd_cdhack_passed(id) { g_CDHack_Passed[id] = true; return PLUGIN_HANDLED; }
public cmd_cdhack_confirm(id) { g_CDHack_Confirmed[id] = true; return PLUGIN_HANDLED; }

public cmd_xhack_passed(id) { g_XHack_Passed[id] = true; return PLUGIN_HANDLED; }
public cmd_xhack_confirm(id) { g_XHack_Confirmed[id] = true; return PLUGIN_HANDLED; }

public cmd_kzhack_passed(id) { g_KZHack_Passed[id] = true; return PLUGIN_HANDLED; }
public cmd_kzhack_confirm(id) { g_KZHack_Confirmed[id] = true; return PLUGIN_HANDLED; }

public cmd_bioteckhack_passed(id) { g_BiotecKHack_Passed[id] = true; return PLUGIN_HANDLED; }
public cmd_bioteckhack_confirm(id) { g_BiotecKHack_Confirmed[id] = true; return PLUGIN_HANDLED; }
