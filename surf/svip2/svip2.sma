#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <engine>
#include <fun>
#include <fakemeta>
#include <hamsandwich>
#include <nvault>

const VIP_FLAG = ADMIN_LEVEL_H

enum
{
	SCOREATTRIB_ARG_PLAYERID = 1,
	SCOREATTRIB_ARG_FLAGS
}

const SCOREATTRIB_FLAG_VIP = (1<<2)

// Menu keys
const KEYSMENU = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_8|MENU_KEY_9|MENU_KEY_0

// Weapon bitsums
const PRIMARY_WEAPONS_BIT_SUM = (1<<CSW_SCOUT)|(1<<CSW_XM1014)|(1<<CSW_MAC10)|(1<<CSW_AUG)|(1<<CSW_UMP45)|(1<<CSW_SG550)|(1<<CSW_GALIL)|(1<<CSW_FAMAS)|(1<<CSW_AWP)|(1<<CSW_MP5NAVY)|(1<<CSW_M249)|(1<<CSW_M3)|(1<<CSW_M4A1)|(1<<CSW_TMP)|(1<<CSW_G3SG1)|(1<<CSW_SG552)|(1<<CSW_AK47)|(1<<CSW_P90)
const SECONDARY_WEAPONS_BIT_SUM = (1<<CSW_P228)|(1<<CSW_ELITE)|(1<<CSW_FIVESEVEN)|(1<<CSW_USP)|(1<<CSW_GLOCK18)|(1<<CSW_DEAGLE)

// VIP Weapon IDs
new const VIP_WEAPONIDS[] = { 0, CSW_M3, CSW_XM1014, CSW_TMP, CSW_MAC10,
			CSW_MP5NAVY, CSW_UMP45, CSW_P90, CSW_GALIL, CSW_GALIL, CSW_AK47, CSW_SCOUT, CSW_M4A1, CSW_SG552, CSW_AUG, CSW_SG550, CSW_M249,
			CSW_G3SG1, CSW_AWP }

// VIP Weapon Entity Names
new const VIP_WEAPONENTNAMES[][] = { "", "weapon_m3",
			"weapon_xm1014", "weapon_tmp", "weapon_mac10", "weapon_mp5navy", "weapon_ump45", "weapon_p90", "weapon_galil", "weapon_galil", "weapon_ak47",
			"weapon_scout", "weapon_m4a1", "weapon_sg552", "weapon_aug", "weapon_sg550", "weapon_m249", "weapon_g3sg1", "weapon_awp" }

// VIP Weapon Ammo
new const VIP_WEAPONAMMO[] = { 0, 32, 32, 120, 100,
			120, 100, 100, 90, 90, 90, 90, 90, 90, 90, 90, 200,
			90, 30 }

new const sound_buyammo[] = "items/9mmclip1.wav"

new cvar_weaponsenabled, cvar_hpmax, cvar_hpkill, cvar_hphs, cvar_moneykill, cvar_moneyhs

new g_showdamagedone[33]
new g_weaponmenu[33]
new g_auth[33][32]

new g_lifesaver[33]

new g_vault
new g_HUDMsgSync
new g_maxplayers
new g_msgAmmoPickup

public plugin_precache()
{
	precache_sound(sound_buyammo)
}

public plugin_init()
{
	register_plugin("SVIP 2", "1.0", "FLWL")
	
	register_event("Damage", "event_Damage", "b", "2!0", "3=0", "4!0")
	register_event("DeathMsg", "event_DeathMsg", "a", "1>0")
	
	RegisterHam(Ham_Spawn, "player", "fw_SpawnPlayer_Post", 1)
	
	register_clcmd("say /vipmenu", "clcmd_sayvipmenu")
	register_clcmd("say_team /vipmenu", "clcmd_sayvipmenu")
	
	register_menu("Bonus Menu", KEYSMENU, "menu_bonus")
	register_menu("Secondary Menu", KEYSMENU, "menu_secondary")
	register_menu("VIP Menu", KEYSMENU, "menu_vip")
	
	g_msgAmmoPickup = get_user_msgid("AmmoPickup")
	
	register_message(get_user_msgid("ScoreAttrib"), "message_ScoreAttrib")
	
	cvar_weaponsenabled = register_cvar("vip_weapons_enabled", "1")
	cvar_hpmax = register_cvar("vip_hp_max", "100")
	cvar_hpkill = register_cvar("vip_hp_kill", "15")
	cvar_hphs = register_cvar("vip_hp_hs", "30")
	cvar_moneykill = register_cvar("vip_money_kill", "500")
	cvar_moneyhs = register_cvar("vip_money_hs", "800")
	
	g_HUDMsgSync = CreateHudSyncObj()
	g_maxplayers = get_maxplayers()
	
	register_touch("trigger_teleport", "player", "fw_TouchTeleport")
	register_touch("trigger_hurt", "player", "fw_TouchTeleport")
}

public plugin_cfg()
{
	g_vault = nvault_open("svip2")
	
	if (g_vault == INVALID_HANDLE)
		set_fail_state("Error opening nVault")
}

public plugin_end()
{
    nvault_close(g_vault)
}

public fw_TouchTeleport(ent, id)
{
	if (!g_lifesaver[id] || !is_user_alive(id))
		return PLUGIN_CONTINUE;
	
	static Float:mins[3], Float:maxs[3]
	entity_get_vector(ent, EV_VEC_mins, mins)
	entity_get_vector(ent, EV_VEC_maxs, maxs)
	
	static Float:xSize, Float:ySize
	xSize = floatabs(maxs[0] - mins[0])
	ySize = floatabs(maxs[1] - mins[1])
	
	if (xSize > 1000.0 && ySize > 1000.0)
	{
		g_lifesaver[id] = false
		
		static Float:velocity[3]
		entity_get_vector(id, EV_VEC_velocity, velocity)
		
		velocity[2] = floatabs(velocity[2])
		velocity[2] = floatmin(velocity[2], 1300.0)
		
		entity_set_vector(id, EV_VEC_velocity, velocity)
		
		//server_print("TOUCH: mins: (%f;%f;%f) maxs: (%f;%f;%f) x: %f ; y: %f", mins[0], mins[1], mins[2], maxs[0], maxs[1], maxs[2], xSize, ySize)
		return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

public event_Damage(id)
{
	static iAttacker, iWeapon, iHitzone, iSpectator
	iAttacker = get_user_attacker(id, iWeapon, iHitzone)
	static iDamage
	iDamage = read_data(2)
	
	if (is_user_connected(iAttacker) && (get_user_flags(iAttacker) & VIP_FLAG) && g_showdamagedone[iAttacker])
	{
		if (iHitzone == HIT_HEAD)
		{
			set_hudmessage(205, 50, 0, -1.0, 0.55, 0, 0.1, 1.0, 0.1, 1.0, -1)
			ShowSyncHudMsg(iAttacker, g_HUDMsgSync, "%i^n" , iDamage)
			
			for (iSpectator = 0; iSpectator < g_maxplayers; iSpectator++)
				if (is_user_connected(iSpectator) && !is_user_alive(iSpectator) && pev(iSpectator, pev_iuser2) == iAttacker)
					ShowSyncHudMsg(iSpectator, g_HUDMsgSync, "%i^n" , iDamage)
		}
		else
		{
			set_hudmessage(50, 205, 50, -1.0, 0.55, 0, 0.1, 1.0, 0.1, 1.0, -1)
			ShowSyncHudMsg(iAttacker, g_HUDMsgSync, "%i^n" , iDamage)
			
			for (iSpectator = 0; iSpectator < g_maxplayers; iSpectator++)
				if (is_user_connected(iSpectator) && !is_user_alive(iSpectator) && pev(iSpectator, pev_iuser2) == iAttacker)
					ShowSyncHudMsg(iSpectator, g_HUDMsgSync, "%i^n" , iDamage)
		}
	}
}

public event_DeathMsg()
{
	new iKiller
	iKiller = read_data(1)
	
	if (is_user_connected(iKiller) && (get_user_flags(iKiller) & VIP_FLAG))
	{
		static iMoney, iHealth, iArmor, iHPMax, iHS
		iHealth = get_user_health(iKiller)
		iArmor = get_user_armor(iKiller)
		iHPMax = get_pcvar_num(cvar_hpmax)
		iHS = read_data(3)
		iMoney = cs_get_user_money(iKiller)
		
		if (iMoney < 16000)
			cs_set_user_money(iKiller, clamp(iMoney - 300 + get_pcvar_num(iHS ? cvar_moneyhs : cvar_moneykill), 0, 16000))
		
		if (iHealth < iHPMax)
			set_user_health(iKiller, clamp(iHealth + get_pcvar_num(iHS ? cvar_hphs : cvar_hpkill), 0, iHPMax))
		
		if (iArmor < iHPMax)
			set_user_armor(iKiller, clamp(iHealth + get_pcvar_num(iHS ? cvar_hphs : cvar_hpkill), 0, iHPMax))
	}
}

public client_putinserver(id)
{
	get_user_authid(id, g_auth[id], charsmax(g_auth[]))
	
	if (g_auth[id][7] != ':')
		get_user_ip(id, g_auth[id], charsmax(g_auth[]), 1)
	
	if (get_user_flags(id) & VIP_FLAG)
		load_data(id)
}

public client_disconnect(id)
{
	if (get_user_flags(id) & VIP_FLAG)
		save_data(id)
}

public fw_SpawnPlayer_Post(id)
{
	if (!is_user_alive(id) || !get_pcvar_num(cvar_weaponsenabled))
		return;
	
	g_lifesaver[id] = false
	
	if (get_user_flags(id) & VIP_FLAG)
	{
		if (!user_has_weapon(id, CSW_HEGRENADE)) give_item(id, "weapon_hegrenade")
		
		cs_set_user_armor(id, 100, CS_ARMOR_VESTHELM)
		
		if (cs_get_user_team(id) == CS_TEAM_CT)
			cs_set_user_defuse(id, 1)
		
		if (g_weaponmenu[id])
			show_menu_secondary(id)
	}
}

public clcmd_sayvipmenu(id)
{
	if (get_user_flags(id) & VIP_FLAG)
		show_menu_vip(id)
	else
		client_print(id, print_chat, "^1[^4Kohila^1] Sa ei ole^4 VIP^1. Tellimiseks kirjuta^4 /sms^1.")
}

public message_ScoreAttrib(msg_id, msg_dest, msg_entity)
{
	static iPlayer
	iPlayer = get_msg_arg_int(SCOREATTRIB_ARG_PLAYERID)
	
	if ((get_user_flags(iPlayer) & VIP_FLAG) && !get_msg_arg_int(SCOREATTRIB_ARG_FLAGS))
		set_msg_arg_int(SCOREATTRIB_ARG_FLAGS, ARG_BYTE, SCOREATTRIB_FLAG_VIP)
}

show_menu_secondary(id)
{
	static menu[256], len, menukeys
	len = 0
	menukeys = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_5|MENU_KEY_0
	
	// Title
	len += formatex(menu, charsmax(menu) - len, "\yVIP Weapon Menu^n^n")
	
	// 1. Desert Eagle .50 AE
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Desert Eagle .50 AE^n")
	
	// 2. USP .45 ACP Tactical
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w USP .45 ACP Tactical^n")
	
	// 3. Glock 18C
	len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Glock 18C^n")
	
	// 4. Dual Elite Berettas
	if (cs_get_user_team(id) == CS_TEAM_T)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Dual Elite Berettas^n")
		menukeys |= MENU_KEY_4
	}
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d4. Dual Elite Berettas^n")
	
	// 5. P228 Compact
	len += formatex(menu[len], charsmax(menu) - len, "\r5.\w P228 Compact^n")
	
	// 6. FiveseveN
	if (cs_get_user_team(id) == CS_TEAM_CT)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r6.\w FiveseveN^n")
		menukeys |= MENU_KEY_6
	}
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d6. FiveseveN^n")
	
	// Spacers
	len += formatex(menu[len], charsmax(menu) - len, "^n^n")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0.\w Sule")
	
	show_menu(id, menukeys, menu, 15, "Secondary Menu")
}

show_menu_bonus(id)
{
	static menu[256], len, menukeys
	len = 0
	menukeys = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_0
	
	// Title
	len += formatex(menu, charsmax(menu) - len, "\yVIP Bonus Menu^n^n")
	
	// 1. Random Primary Weapon
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Random Primary Weapon^n")
	
	// 2. Extra HE-Grenade
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Extra HE-Grenade^n")
	
	// 3. +25HP
	len += formatex(menu[len], charsmax(menu) - len, "\r3.\w +25HP^n")
	
	// 4. Lifesaver
	len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Lifesaver^n")
	
	// Spacers
	len += formatex(menu[len], charsmax(menu) - len, "^n^n^n^n")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0.\w Sule")
	
	show_menu(id, menukeys, menu, 15, "Bonus Menu")
}

show_menu_vip(id)
{
	static menu[256], len, menukeys
	len = 0
	menukeys = MENU_KEY_1|MENU_KEY_2|MENU_KEY_0
	
	// Title
	len += formatex(menu, charsmax(menu) - len, "\yVIP Menu^n^n")
	
	// 1. Show damage done
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Show damage done%s^n", (g_showdamagedone[id] ? "\y [Enabled]" : "\r [Disabled]"))
	
	// 2. Weapon Menu
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Weapon menu%s^n", (g_weaponmenu[id] ? "\y [Enabled]" : "\r [Disabled]"))
	
	// Spacers
	len += formatex(menu[len], charsmax(menu) - len, "^n^n^n^n^n^n")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0.\w Exit")
	
	show_menu(id, menukeys, menu, -1, "VIP Menu")
}

public menu_secondary(id, key)
{
	switch (key)
	{
		case 0: // 1. Desert Eagle .50 AE
		{
			drop_weapons(id, 2)
			
			give_item(id, "weapon_deagle")
			cs_set_user_bpammo(id, CSW_DEAGLE, 35)
		}
		case 1: // 2. USP .45 ACP Tactical
		{
			drop_weapons(id, 2)
			
			give_item(id, "weapon_usp")
			cs_set_user_bpammo(id, CSW_USP, 100)
		}
		case 2: // 3. Glock 18C
		{
			drop_weapons(id, 2)
			
			give_item(id, "weapon_glock18")
			cs_set_user_bpammo(id, CSW_GLOCK18, 120)
		}
		case 3: // 4. Dual Elite Berettas
		{
			drop_weapons(id, 2)
			
			give_item(id, "weapon_elite")
			cs_set_user_bpammo(id, CSW_ELITE, 120)
		}
		case 4: // 5. P228 Compact
		{
			drop_weapons(id, 2)
			
			give_item(id, "weapon_p228")
			cs_set_user_bpammo(id, CSW_P228, 52)
		}
		case 5: // 6. FiveseveN
		{
			drop_weapons(id, 2)
			
			give_item(id, "weapon_fiveseven")
			cs_set_user_bpammo(id, CSW_FIVESEVEN, 100)
		}
	}
	
	show_menu_bonus(id)
}

public menu_bonus(id, key)
{
	switch (key)
	{
		case 0: // 1. Random Primary Weapon
		{
			drop_weapons(id, 1)
			
			static wpn
			wpn = random_num(1, charsmax(VIP_WEAPONIDS))
			
			give_item(id, VIP_WEAPONENTNAMES[wpn])
			cs_set_user_bpammo(id, VIP_WEAPONIDS[wpn], VIP_WEAPONAMMO[wpn])
		}
		case 1: // 3. Extra HE-Grenade
		{
			if (user_has_weapon(id, CSW_HEGRENADE))
			{
				// Add +1
				cs_set_user_bpammo(id, CSW_HEGRENADE, cs_get_user_bpammo(id, CSW_HEGRENADE)+1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(12) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
			else
				give_item(id, "weapon_hegrenade")
		}
		case 2: // 2. +25 HP
		{
			set_user_health(id, get_user_health(id)+25)
		}
		case 3:
		{
			g_lifesaver[id] = true
		}
	}
}

public menu_vip(id, key)
{
	switch (key)
	{
		case 0:
		{
			g_showdamagedone[id] = !g_showdamagedone[id]
			
			show_menu_vip(id)
		}
		case 1:
		{
			g_weaponmenu[id] = !g_weaponmenu[id]
			
			show_menu_vip(id)
		}
	}
}

load_data(id)
{
	static data[40]
	
	if (nvault_get(g_vault, g_auth[id], data, charsmax(data)))
	{
		static strshowdmg[8], strweapmenu[8]
		parse(data, strshowdmg, charsmax(strshowdmg), strweapmenu, charsmax(strweapmenu))
		
		g_showdamagedone[id] = str_to_num(strshowdmg)
		g_weaponmenu[id] = str_to_num(strweapmenu)
	}
	else
	{
		g_showdamagedone[id] = true
		g_weaponmenu[id] = true
	}
}

save_data(id)
{
	static data[40]
	formatex(data, charsmax(data), "%d %d", g_showdamagedone[id], g_weaponmenu[id])
	
	nvault_set(g_vault, g_auth[id], data)
}

// Drop primary/secondary weapons
stock drop_weapons(id, dropwhat)
{
	// Get user weapons
	static weapons[32], num, i, weaponid
	num = 0 // reset passed weapons count (bugfix)
	get_user_weapons(id, weapons, num)
	
	// Loop through them and drop primaries or secondaries
	for (i = 0; i < num; i++)
	{
		// Prevent re-indexing the array
		weaponid = weapons[i]
		
		if ((dropwhat == 1 && ((1<<weaponid) & PRIMARY_WEAPONS_BIT_SUM)) || (dropwhat == 2 && ((1<<weaponid) & SECONDARY_WEAPONS_BIT_SUM)))
		{
			// Get weapon entity
			static wname[32]
			get_weaponname(weaponid, wname, charsmax(wname))
			
			// Player drops the weapon and looses his bpammo
			engclient_cmd(id, "drop", wname)
		}
	}
}
