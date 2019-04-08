#include <amxmodx>
#include <amxmisc>
#include <hamsandwich>
#include <engine>
#include <cstrike>
#include <fun>

#define chance(%1) (%1 > random(100)) // %1 = probability

// Weapon Names
new const WEAPONNAMES[][] = { "", "P228 Compact", "", "Schmidt Scout", "HE-grenade", "XM1014 M4", "", "Ingram MAC-10", "Steyr AUG A1",
			"Frost Grenade", "Dual Elite Berettas", "FiveseveN", "UMP 45", "SG-550 Auto-Sniper", "IMI Galil", "Famas",
			"USP .45 ACP Tactical", "Glock 18C", "AWP Magnum Sniper", "MP5 Navy", "M249 Para Machinegun",
			"M3 Super 90", "M4A1 Carbine", "Schmidt TMP", "G3SG1 Auto-Sniper", "Flashbang", "Desert Eagle .50 AE",
			"SG-552 Commando", "AK-47 Kalashnikov", "", "ES P90" }

// Weapon entity names
new const WEAPONENTNAMES[][] = { "", "weapon_p228", "", "weapon_scout", "weapon_hegrenade", "weapon_xm1014", "weapon_c4", "weapon_mac10",
			"weapon_aug", "weapon_smokegrenade", "weapon_elite", "weapon_fiveseven", "weapon_ump45", "weapon_sg550",
			"weapon_galil", "weapon_famas", "weapon_usp", "weapon_glock18", "weapon_awp", "weapon_mp5navy", "weapon_m249",
			"weapon_m3", "weapon_m4a1", "weapon_tmp", "weapon_g3sg1", "weapon_flashbang", "weapon_deagle", "weapon_sg552",
			"weapon_ak47", "weapon_knife", "weapon_p90" }

const VMENU_HEALTH = 5000

new const VIPWEAPONLIST[] = { CSW_GLOCK18, CSW_USP, CSW_P228, CSW_DEAGLE, CSW_FIVESEVEN,
						CSW_ELITE, CSW_HEGRENADE, CSW_FLASHBANG, CSW_SMOKEGRENADE, VMENU_HEALTH }

const VIP_FLAG = ADMIN_LEVEL_H

new g_maxplayers
new g_msgSayText

public plugin_init()
{
	register_plugin("HNS Random Chance VIPMenu", "1.0", "FLWL")
	
	RegisterHam(Ham_Spawn, "player", "fw_SpawnPlayer_Post", true)
	
	g_msgSayText = get_user_msgid("SayText")
	g_maxplayers = get_maxplayers()
}

public fw_SpawnPlayer_Post(id)
{
	if (!access(id, VIP_FLAG) || !is_user_alive(id))
		return;
	
	remove_task(id)
	set_task(11.0, "handle_vipmenu", id)
}

public handle_vipmenu(id)
{
	static wpn
	wpn = VIPWEAPONLIST[random(sizeof(VIPWEAPONLIST))]
	if (wpn == VMENU_HEALTH)
	{
		set_user_health(id, get_user_health(id)+50)
		client_printc(id, "^1[^4VIP^1] You got^4 +50 HP")
	}
	else
	{
		give_wpn(id, wpn)
		client_printc(id, "^1[^4VIP^1] You got^4 %s", WEAPONNAMES[wpn])
	}
}

give_wpn(id, wpn)
{
	if (wpn == CSW_HEGRENADE || wpn == CSW_FLASHBANG || wpn == CSW_SMOKEGRENADE)
	{
		if (user_has_weapon(id, wpn))
			cs_set_user_bpammo(id, wpn, (cs_get_user_bpammo(id, wpn) + 1))
		else
			give_item(id, WEAPONENTNAMES[wpn])
	}
	else
	{
		if (user_has_weapon(id, wpn))
		{
			static ent
			ent = find_ent_by_owner(1, WEAPONENTNAMES[wpn], id)
			cs_set_weapon_ammo(ent, (cs_get_weapon_ammo(ent) + 1))
		}
		else
		{
			cs_set_weapon_ammo(give_item(id, WEAPONENTNAMES[wpn]), 1)
		}
	}
}

// Prints a colored message to target (use 0 for everyone), supports ML formatting.
// Note: I still need to make something like gungame's LANG_PLAYER_C to avoid unintended
// argument replacement when a function passes -1 (it will be considered a LANG_PLAYER)
stock client_printc(target, const message[], any:...)
{
	static buffer[190], i, argscount
	argscount = numargs()
	
	// Send to everyone
	if (!target)
	{
		static player
		for (player = 1; player <= g_maxplayers; player++)
		{
			// Not connected
			if (!is_user_connected(player))
				continue;
			
			// Remember changed arguments
			static changed[5] // [5] = max LANG_PLAYER occurencies
			new changedcount
			
			// Replace LANG_PLAYER with player id
			for (i = 2; i < argscount; i++)
			{
				if (getarg(i) == LANG_PLAYER)
				{
					setarg(i, 0, player)
					changed[changedcount] = i
					changedcount++
				}
			}
			
			// Format message for player
			vformat(buffer, charsmax(buffer), message, 3)
			replace_all(buffer, charsmax(buffer), "\y", "^x01")
			replace_all(buffer, charsmax(buffer), "\g", "^x04")
			
			// Send it
			message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, player)
			write_byte(player)
			write_string(buffer)
			message_end()
			
			// Replace back player id's with LANG_PLAYER
			for (i = 0; i < changedcount; i++)
				setarg(changed[i], 0, LANG_PLAYER)
		}
	}
	// Send to special target
	else
	{
		// Format message for player
		vformat(buffer, charsmax(buffer), message, 3)
		
		// Send it
		message_begin(MSG_ONE, g_msgSayText, _, target)
		write_byte(target)
		write_string(buffer)
		message_end()
	}
}
