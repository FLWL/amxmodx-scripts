#include <amxmodx>
#include <amxmisc>
#include <fakemeta>
#include <hamsandwich>
#include <cstrike>
#include <engine>
#include <fun>
#include <time>
#include <sqlx>

/*================================================================================
 [Customization]
=================================================================================*/

new const SOUND_TOP1[] = "ownage.wav"
new const MAPS_FILE[] = "addons/amxmodx/configs/maps.ini"
new const WEB_URL[] = "http://example.com/resources/motd"

/*================================================================================
 [Constants, Offsets, Macros]
=================================================================================*/

new const PLUGIN_VERSION[] = "3.11"

// Tasks
enum (+= 100)
{
	TASK_TERRO_VAHETUS = 2000,
	TASK_FORCE_JOIN,
	TASK_WELCOME_MSG,
	TASK_LOGIN_REMINDER
}

// CS Teams
enum
{
	FM_CS_TEAM_UNASSIGNED = 0,
	FM_CS_TEAM_T,
	FM_CS_TEAM_CT,
	FM_CS_TEAM_SPECTATOR
}

// Menu keys
const KEYSMENU = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_8|MENU_KEY_9|MENU_KEY_0

// VIP Weapon IDs
new const VIP_WEAPONIDS[] = { 0, CSW_GLOCK18, CSW_USP, CSW_P228, CSW_DEAGLE, CSW_FIVESEVEN, CSW_ELITE, CSW_M3, CSW_XM1014, CSW_TMP, CSW_MAC10,
			CSW_MP5NAVY, CSW_UMP45, CSW_P90, CSW_GALIL, CSW_GALIL, CSW_AK47, CSW_SCOUT, CSW_M4A1, CSW_SG552, CSW_AUG, CSW_SG550, CSW_M249,
			CSW_G3SG1, CSW_AWP }

// VIP Weapon Names
new const VIP_WEAPONNAMES[][] = { "", "Glock 18C", "USP .45 ACP Tactical", "P228 Compact", "Desert Eagle .50 AE", "FiveseveN", "Dual Elite Berettas",
			"M3 Super 90", "XM1014 M4", "Schmidt TMP", "Ingram MAC-10", "MP5 Navy", "UMP 45", "ES P90", "IMI Galil", "IMI Galil", "AK-47 Kalashnikov",
			"Schmidt Scout", "M4A1 Carbine", "SG-552 Commando", "Steyr AUG A1", "SG-550 Auto-Sniper", "M249 Para Machinegun", "G3SG1 Auto-Sniper",
			"AWP Magnum Sniper" }

// VIP Weapon Entity Names
new const VIP_WEAPONENTNAMES[][] = { "", "weapon_glock18", "weapon_usp", "weapon_p228", "weapon_deagle", "weapon_fiveseven", "weapon_elite", "weapon_m3",
			"weapon_xm1014", "weapon_tmp", "weapon_mac10", "weapon_mp5navy", "weapon_ump45", "weapon_p90", "weapon_galil", "weapon_galil", "weapon_ak47",
			"weapon_scout", "weapon_m4a1", "weapon_sg552", "weapon_aug", "weapon_sg550", "weapon_m249", "weapon_g3sg1", "weapon_awp" }

// VIP Weapon Ammo
new const VIP_WEAPONAMMO[] = { 0, 120, 100, 52, 35, 100, 120, 32, 32, 120, 100,
			120, 100, 100, 90, 90, 90, 90, 90, 90, 90, 90, 200,
			90, 30 }


// Weapon 2 stuff
new const VIP_WEAPON2IDS[] = { 0, CSW_GLOCK18, CSW_P228, CSW_FIVESEVEN, CSW_ELITE, CSW_USP, CSW_DEAGLE}
new const VIP_WEAPON2NAMES[][] = { "", "Glock 18C", "P228 Compact", "FiveseveN", "Dual Elite Berettas", "USP .45 ACP Tactical", "Desert Eagle .50 AE" }
new const VIP_WEAPON2ENTNAMES[][] = { "", "weapon_glock18", "weapon_p228", "weapon_fiveseven", "weapon_elite", "weapon_usp", "weapon_deagle" }
new const VIP_WEAPON2AMMO[] = { 0, 120, 52, 100, 120, 100, 35 }

// Scoreboard flags
enum
{
	SCOREATTRIB_ARG_PLAYERID = 1,
	SCOREATTRIB_ARG_FLAGS
}
const SCOREATTRIB_FLAG_VIP = (1<<2)

// CS Player PData Offsets (win32)
const PDATA_SAFE = 2
const OFFSET_CSTEAMS = 114
const OFFSET_BUYZONE = 235

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds

// Some constants
const PEV_SPEC_TARGET = pev_iuser2

// HUD messages
const Float:HUD_SPECT_X = 0.02
const Float:HUD_SPECT_Y = 0.9
const Float:HUD_STATS_X = 0.02
const Float:HUD_STATS_Y = 0.9

// Damage stuff
const DMG_GRENADE = (1<<24)

/*================================================================================
 [Global Variables]
=================================================================================*/

new g_relv[33]
new g_relv2[33]
new g_relvalevel[33]
new g_elud[33]
new g_raha[33]
new g_id[33]
new g_auth[33][34]
new g_KasutanudElu[33]
new g_isconnected[33]
new g_isalive[33]
new g_TimeConnected[33]
new g_lastvisit[33]
new g_lastip[33][16]
new g_haspw[33]

//new Float:g_viimaneannetus[33]

// terro järjekord
new g_triedqueue[33]
new g_terroristqueue[32][1]
new g_queuecount

// map topid
new g_mapname[32]
new Float:g_spawntime[33]
new g_mapsCompleted[33]
new g_totalMaps
new g_usedScout[33]

new g_freerun
new g_round
new g_roundended
new Float:g_roundstarttime
new g_roundkills
new g_CallBack_Enabled
new g_CallBack_Disabled
new g_MsgSync
new g_msgSayText
new g_maxplayers
new Handle:g_sql_tuple
#define is_user_valid_connected(%1) (1 <= %1 <= g_maxplayers && g_isconnected[%1])
#define is_user_valid(%1) (1 <= %1 <= g_maxplayers)
#define is_user_playing(%1) (FM_CS_TEAM_UNASSIGNED < fm_cs_get_user_team(%1) < FM_CS_TEAM_SPECTATOR)

// Poe stuff
new g_shop_armor[33] // Armor
new g_bought_armor[33] // Kasutanud armorit?

/*================================================================================
 [Natives, Precache and Init]
=================================================================================*/

public plugin_natives()
{
	register_native("dr_get_lives", "native_dr_get_lives", 1)
	register_native("dr_set_lives", "native_dr_set_lives", 1)
	
	register_native("dr_get_money", "native_dr_get_money", 1)
	register_native("dr_set_money", "native_dr_set_money", 1)
}

public plugin_precache()
{
	precache_sound(SOUND_TOP1)
}

public plugin_init()
{
	register_plugin("Deathrun Manager", PLUGIN_VERSION, "FLWL")
	
	// Events
	register_event("HLTV", "EventNewRound", "a", "1=0", "2=0") // Round algab
	register_logevent("LogEventRoundEnd", 2, "1=Round_End") // Round lõppeb
	register_event("SendAudio", "EventTerroWin", "a", "2&%!MRAD_terwin") // Terroristid võitsid roundi
	
	// HAM Forwards
	RegisterHam(Ham_Spawn, "player", "fw_SpawnPlayer_Post", true)
	RegisterHam(Ham_TakeDamage, "player", "fw_PlayerTakeDamage")
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled")
	RegisterHam(Ham_Item_AddToPlayer, "weapon_scout", "fw_UsedScout", 1)
	
	// FM Forwards
	register_forward(FM_ClientDisconnect, "fw_ClientDisconnect")
	register_forward(FM_ClientKill, "fw_ClientKill")
	
	// Käsklused
	register_clcmd("radio1", "ClCmd_Radio")
	register_clcmd("radio2", "ClCmd_Radio")
	register_clcmd("radio3", "ClCmd_Radio")
	register_clcmd("chooseteam", "ClCmd_ChangeTeam")
	register_clcmd("jointeam", "ClCmd_ChangeTeam")
	register_clcmd("say /revive", "ClCmd_Revive")
	register_clcmd("say /respawn", "ClCmd_Revive")
	register_clcmd("say /donate", "ClCmd_Donate")
	register_clcmd("say", "ClCmd_Say")
	register_clcmd("say /shop", "ClCmd_Shop")
	register_clcmd("say /id", "ClCmd_ShowID")
	register_clcmd("say /pood", "ClCmd_Shop")
	register_clcmd("say /vipmenu", "ClCmd_VIPMenu")
	register_clcmd("say /showqueue", "ClCmd_ShowQueue")
	
	register_clcmd("say /sms", "ClCmd_SMS")
	register_clcmd("say /rules", "ClCmd_Rules")
	
	register_clcmd("say /top15", "ClCmd_Top15")
	register_clcmd("say /top", "ClCmd_Top")
	register_clcmd("say /maps", "ClCmd_Maps")
	register_clcmd("say /last", "ClCmd_Last")
	
	// Message IDs
	g_msgSayText = get_user_msgid("SayText")
	
	// Msg'd
	register_message(get_user_msgid("ShowMenu"), "MessageShowMenu")
	register_message(get_user_msgid("VGUIMenu"), "MessageVGUIMenu")
	register_message(get_user_msgid("StatusIcon"), "MessageStatusIcon")
	register_message(get_user_msgid("ScoreAttrib"), "MessageScoreAttrib")
	
	// Blokeerime msg'd
	set_msg_block(get_user_msgid("ClCorpse"), BLOCK_SET)
	
	// Menüüd
	register_menu("Main Menu", KEYSMENU, "MainMenu")
	register_menu("VIP Menu", KEYSMENU, "VIPMenu")
	register_menu("Revive Menu", KEYSMENU, "ReviveMenu")
	register_menu("Shop Menu", KEYSMENU, "ShopMenu")
	
	// Misc
	g_maxplayers = get_maxplayers()
	g_MsgSync = CreateHudSyncObj()
	g_CallBack_Enabled = menu_makecallback("CallBack_Enabled")
	g_CallBack_Disabled = menu_makecallback("CallBack_Disabled")
	get_mapname(g_mapname, charsmax(g_mapname))
	
	// Alustame taske
	set_task(1.0, "task_ShowHUD", _, _, _, "b")
	set_task(5.0, "task_CheckT", _, _, _, "b")
	
	// Initialiseerime SQL-i
	register_srvcmd("deathrun_sqlinit", "sql_init")
	server_cmd("deathrun_sqlinit")
}

public plugin_cfg()
{
	// Loeme kokku kõik serveris olevad mapid
	new f = fopen(MAPS_FILE, "r")
	if (!f) return;
	
	static buffer[128]
	while (!feof(f))
	{
		fgets(f, buffer, charsmax(buffer))
		g_totalMaps++;
	}
	
	fclose(f)
}

public sql_init()
{
	if (g_sql_tuple != Empty_Handle)
		return;
	
	SQL_SetAffinity("mysql")
	g_sql_tuple = SQL_MakeStdTuple()
}

/*================================================================================
 [Main Events]
=================================================================================*/

// Round algab
public EventNewRound()
{
	// Round on alanud
	g_roundended = false
	g_round++
	g_roundstarttime = get_gametime()
	g_roundkills = 0
	
	// Nullime mõned muutujad
	arrayset(g_KasutanudElu, false, sizeof(g_KasutanudElu))
	arrayset(g_triedqueue, false, sizeof(g_triedqueue))
}

// Round lõppeb
public LogEventRoundEnd()
{
	// Round on lõppenud
	g_roundended = true
	
	// Vahetame terroristi 4.5 sekundi pärast (0.5 sekundit enne uue roundi algust)
	if (!task_exists(TASK_TERRO_VAHETUS)) set_task(4.5, "TerroVahetus", TASK_TERRO_VAHETUS)
}

// Terroristid võitsid roundi
public EventTerroWin()
{
	// Ennetame elude 'farmimist'
	// Serveris on liiga vähe mängijaid ning roundi algusest on möödas vähem kui 60 sekundit
	if (!g_roundkills && fnGetTs() > 0 && fnGetPlaying() < 5 && get_gametime() - g_roundstarttime < 60.0)
	{
		ChatColor(0, "^1[^4DRM v%s^1] No rewards were given out because either the round was too short or there weren't enough players.", PLUGIN_VERSION)
		return;
	}
	
	// Premeerime terroriste
	for (new id = 1; id <= g_maxplayers; id++)
	{
		if (!g_isconnected[id] || !g_isalive[id])
			continue;
		
		if (fm_cs_get_user_team(id) == FM_CS_TEAM_T)
		{
			// VIPid saavad topelt
			if (access(id, ADMIN_LEVEL_H))
			{
				g_elud[id] += 2
				g_raha[id] += 100
				
				ChatColor(id, "^1[^4DRM v%s^1] You got^4 2 lifes^1 and^4 $100^1 for winning the round.", PLUGIN_VERSION)
			}
			else
			{
				g_elud[id] += 1
				g_raha[id] += 50
				
				ChatColor(id, "^1[^4DRM v%s^1] You got^4 1 life^1 and^4 $50^1 for winning the round.", PLUGIN_VERSION)
			}
			
			// Fragid, VIPid ei saa topelt
			set_user_frags(id, get_user_frags(id) + 1)
		}
	}
}

/*================================================================================
 [Main Forwards]
=================================================================================*/

// Mängija liitub serveriga
public client_putinserver(id)
{
	// Mängija on serveriga ühendatud
	g_isconnected[id] = true
	g_TimeConnected[id] = get_systime()
	
	// Nullime
	g_id[id] = -1
	g_elud[id] = 0
	g_raha[id] = 0
	g_relv[id] = 1
	g_relv2[id] = 25
	g_relvalevel[id] = 6
	g_KasutanudElu[id] = false
	g_mapsCompleted[id] = 0
	g_haspw[id] = false
	remove_task(id+TASK_LOGIN_REMINDER)
	
	// Generate auth
	get_user_authid(id, g_auth[id], charsmax(g_auth[]))
	
	// Kontrollime parooli kui mängija kasutab SteamID'd
	if (isSteamer(id))
	{
		// Steamer, kontrollime kas parool on peal
		static query[128]
		formatex(query, charsmax(query), "SELECT `password`, `ip` FROM `dr_stats` WHERE `auth` = '%s'", g_auth[id])
		
		static data[1]
		data[0] = id
		
		SQL_ThreadQuery(g_sql_tuple, "_CheckForPassword", query, data, sizeof(data))
	}
	else // Nonner, võtame IP ja laeme kohe elud
	{
		get_user_ip(id, g_auth[id], charsmax(g_auth[]), true)
		LoadElud(id)
	}
}

public _CheckForPassword(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	// First time
	if (!SQL_NumResults(query))
	{
		g_id[id] = 0
		return;
	}
	
	static password[16], last_ip[16], ip[16]
	SQL_ReadResult(query, SQL_FieldNameToNum(query, "password"), password, charsmax(password))
	SQL_ReadResult(query, SQL_FieldNameToNum(query, "ip"), last_ip, charsmax(last_ip))
	get_user_ip(id, ip, charsmax(ip), 1)
	
	if (strlen(password) < 4) // pole parooli
	{
		set_task(30.0, "task_login_reminder", id+TASK_LOGIN_REMINDER, _, _, "b")
		
		LoadElud(id)
		return;
	}
	else if (equal(last_ip, ip)) // parool on olemas, eelnevalt on logitud sama IP-ga, jätkame sessionit
	{
		LoadElud(id)
		return;
	}
	
	// käsime kasutajal sisse logida
	g_haspw[id] = true
	g_id[id] = -2
	set_task(8.0, "task_login_reminder", id+TASK_LOGIN_REMINDER, _, _, "b")
}

public task_login_reminder(id)
{
	id -= TASK_LOGIN_REMINDER
	
	if (g_id[id] < 0)
		ChatColor(id, "^1[^4Auth v%s^1]^4 This account is password protected^1. Use^4 /login YourPasswordHere^1 to continue.", PLUGIN_VERSION)
	else
	{
		ChatColor(id, "^1[^4Auth v%s^1]^4 Your account is insecure^1. Use^4 /register YourPassword ConfirmPassword^1 to protect your account with a password.", PLUGIN_VERSION)
	}
}

// Mängija lahkub serverist (ka mapivahetuse ajal)
public client_disconnect(id)
{
	// Salvestame elud, kui need on eelnevalt laetud
	if (g_id[id] >= 0) SaveElud(id)
	
	remove_task(id+TASK_LOGIN_REMINDER)
}

// Mängija spawnib
public fw_SpawnPlayer_Post(id)
{
	// Surnud või ei ole veel tiimiga liitunud
	if (!is_user_alive(id) || !fm_cs_get_user_team(id))
		return;
	
	// Nullime muutujad
	g_usedScout[id] = false
	g_shop_armor[id] = 0
	g_bought_armor[id] = false
	set_user_rendering(id)
	
	// Mängija on elus
	g_isalive[id] = true
	
	// Määrame spawn aja
	g_spawntime[id] = get_gametime()
	
	// Anname mängijale noa
	strip_user_weapons(id)
	give_item(id, "weapon_knife")
	
	// Pickup fix by ConnorMcLeod
	set_pdata_int(id, 116, 0)
	
	// VIPidele kama
	if (access(id, ADMIN_LEVEL_H))
	{
		// Mängija valitud relvad
		static relv
		relv = g_relv[id]
		
		// Anname relva ning kuulid
		give_item(id, VIP_WEAPONENTNAMES[relv])
		cs_set_user_bpammo(id, VIP_WEAPONIDS[relv], VIP_WEAPONAMMO[relv])
		
		// Granaadid
		give_item(id, "weapon_hegrenade")
		give_item(id, "weapon_flashbang")
		cs_set_user_bpammo(id, CSW_FLASHBANG, 2) // 2 flashbangi
		give_item(id, "weapon_smokegrenade")
		
		// NVG
		cs_set_user_nvg(id, true)
		
		// Teine relv
		if (g_relvalevel[id] > 24 && g_relv[id] > 6)
		{
			relv = g_relv2[id]-24
			
			// Anname relva ning kuulid
			give_item(id, VIP_WEAPON2ENTNAMES[relv])
			cs_set_user_bpammo(id, VIP_WEAPON2IDS[relv], VIP_WEAPON2AMMO[relv])
		}
	}
}

// Mängija saab viga
public fw_PlayerTakeDamage(victim, inflictor, attacker, Float:damage, damage_type)
{
	// Terro ei saa kukkudes viga
	if ((damage_type & DMG_FALL) && fm_cs_get_user_team(victim) == FM_CS_TEAM_T)
		return HAM_SUPERCEDE;
	
	if (((damage_type & DMG_GRENADE) || (damage_type & DMG_BULLET)) && fm_cs_get_user_team(victim) == FM_CS_TEAM_CT && g_shop_armor[victim] > 0)
	{
		g_shop_armor[victim] -= floatround(damage, floatround_ceil)
		
		if (g_shop_armor[victim] <= 0)
		{
			g_shop_armor[victim] = 0
			set_user_rendering(victim)
		}
		
		return HAM_SUPERCEDE;
	}
	
	// Round on lõppenud
	if (g_roundended && ((damage_type & DMG_GRENADE) || (damage_type & DMG_BULLET)))
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Mängija sureb
public fw_PlayerKilled(victim, attacker)
{
	// Mängija ei ole enam elus
	g_isalive[victim] = false
	
	// Sureja tiim
	static victimTeam
	victimTeam = fm_cs_get_user_team(victim)
	
	// CT sureb, terrodele raha
	if (victimTeam == FM_CS_TEAM_CT)
	{
		for (new id = 1; id <= g_maxplayers; id++)
		{
			if (!g_isconnected[id] || !g_isalive[id])
				continue;
			
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_T)
			{
				// VIPid saavad topelt
				if (access(id, ADMIN_LEVEL_H))
				{
					// Lisame
					g_raha[id] += 2
				}
				else
				{
					// Lisame
					g_raha[id] += 1
				}
			}
		}
	}
	
	// Revive menüü
	if (CallBack_CanRevive(victim))
		ShowReviveMenu(victim)
	
	// Ründaja ei ole mängija
	if (!is_user_valid_connected(attacker))
		return;
	
	// Enesetapp
	if (victim == attacker)
		return;
	
	g_roundkills++
	
	// Tiimid
	static attackerTeam
	attackerTeam = fm_cs_get_user_team(attacker)
	
	// CT-d saavad terroristi tapmise eest elusid ja raha
	if (attackerTeam == FM_CS_TEAM_CT && victimTeam == FM_CS_TEAM_T)
	{
		// VIPid saavad poole rohkem elusid ja raha
		if (access(attacker, ADMIN_LEVEL_H))
		{
			// Lisame
			g_elud[attacker] += 2
			g_raha[attacker] += 100
			
			// Ning teavitame
			ChatColor(attacker, "^1[^4DRM v%s^1] You got^4 2 lifes^1 and^4 $100^1 for killing an enemy.", PLUGIN_VERSION)
		}
		else
		{
			// Lisame
			g_elud[attacker] += 1
			g_raha[attacker] += 50
			
			// Ning teavitame
			ChatColor(attacker, "^1[^4DRM v%s^1] You got^4 1 life^1 and^4 $50^1 for killing an enemy.", PLUGIN_VERSION)
		}
		
		// Map Topid
		MapFinished(attacker)
	}
	else if (attackerTeam == FM_CS_TEAM_T && victimTeam == FM_CS_TEAM_CT)
	{
		// Map Topid
		MapFinished(victim)
	}
}

// Scout detector
public fw_UsedScout(ent, id)
{
	g_usedScout[id] = true
	
	static name[32]
	get_user_name(id, name, 31)
	client_print(0, print_console, "%s picked up a scout", name)
}

// Mängija lahkub serverist (mitte mapivahetuse ajal)
public fw_ClientDisconnect(id)
{
	if (fm_cs_get_user_team(id) == FM_CS_TEAM_T) TerroLahkus(id)
	
	// Eemaldame mängija järjekorrast
	QueueRemove(id)
	
	// Nullime muutujad
	g_isalive[id] = false
	g_isconnected[id] = false
}

// Mängija üritab teha enesetappu
public fw_ClientKill(id)
{
	// Mängija on juba surnud
	if (!g_isalive[id])
		return FMRES_IGNORED;
	
	// Blokeerime (terro) enesetapu
	client_print(id, print_center, "You can't kill yourself!")
	return FMRES_SUPERCEDE;
}

/*================================================================================
 [Main Functions]
=================================================================================*/

// Terrorist lahkus serverist
TerroLahkus(id)
{
	// Terroriste veel jagub
	if (fnGetTs() > 1)
		return;
	
	// Lahkunud terro nimi
	static idName[32]
	get_user_name(id, idName, charsmax(idName))
	
	// CT-d
	new CTs[32], iCTs
	get_players(CTs, iCTs, "ceh", "CT")
	
	// Pole piisavalt mängijaid
	if (iCTs < 2)
	{
		ChatColor(0, "^1[^4DRM v%s^1]^4 %s^1 has left the game, not enough players to start^4 DeathRun^1.", PLUGIN_VERSION, idName)
		return;
	}
	
	// CTsid on 2 või enam, valime 1 õnneliku
	static newTerr
	newTerr = CTs[random(iCTs)]
	
	if (!is_user_valid_connected(newTerr))
	{
		ChatColor(0, "^1[^4DRM v%s^1]^4 %s^1 has left the game, internal error occurred^1.", PLUGIN_VERSION, idName)
		return;
	}
	
	// Teeme äsja valitud mängija uueks terroks
	cs_set_user_team(newTerr, CS_TEAM_T)
	ExecuteHamB(Ham_CS_RoundRespawn, newTerr)
	
	// Teatame mängijatele
	static targetName[32]
	get_user_name(newTerr, targetName, charsmax(targetName))
	ChatColor(0, "^1[^4DRM v%s^1]^4 %s^1 has left the game,^4 %s^1 is the new terrorist.", PLUGIN_VERSION, idName, targetName)
}

// Terroristi vahetus
public TerroVahetus()
{
	// Midagi läks valesti
	if (!g_roundended)
		return;
	
	// Mängus olevate mängijate arv
	static iPlaying
	iPlaying = fnGetPlaying()
	
	// Liiga vähe mängijaid
	if (iPlaying < 2)
	{
		ChatColor(0, "^1[^4DRM v%s^1] Not enough players to start^4 DeathRun^1.", PLUGIN_VERSION)
		return;
	}
	
	// Muutuja
	static id
	
	// Teeme terrode tiimi puhtaks, tõstame kõik mängijad CT tiimi
	for (id = 1; id <= g_maxplayers; id++)
	{
		// Mängija ei ole ühendatud, jätame vahele
		if (!is_user_connected(id))
			continue;
		
		// Mängija on terroristide tiimis, tõstame ümber
		if (fm_cs_get_user_team(id) == FM_CS_TEAM_T)
			cs_set_user_team(id, CS_TEAM_CT)
	}
	
	// Kontrollime, kas järjekorras on mängijaid
	static fromqueue
	id = g_terroristqueue[0][0]
	if (g_queuecount && is_user_valid_connected(id) && is_user_playing(id))
	{
		QueueRemove(id) // Eemaldame mängija järjekorrast (ilma teavituseta)
		fromqueue = true // Sõnumi kuvamiseks
	}
	else
	{
		id = fnGetRandomPlaying(random_num(1, iPlaying)) // Valime uue terro suvaliselt
		if (id == -1)
		{
			ChatColor(0, "^1[^4DRM v%s^1] Failed to find new terrorist.", PLUGIN_VERSION)
			return; // Midagi läks valesti, terrot ei leitud
		}
		
		fromqueue = false
	}
	
	// Tõstame ta terrode tiimi
	cs_set_user_team(id, CS_TEAM_T)
	cs_reset_user_model(id)
	
	// Teavitame mängijaid
	static terrName[32]
	get_user_name(id, terrName, charsmax(terrName))
	ChatColor(0, "^1[^4DRM v%s^1]^3 %s^1 is the new terrorist%s.", PLUGIN_VERSION, terrName, (fromqueue ? " (^4from queue^1)" : ""))
}

// Mängija kasutab elu
Revive(id)
{
	// Eemaldame elu
	g_elud[id]--
	
	// Mängija kasutas elu
	g_KasutanudElu[id] = true
	
	// Respawnime mängija
	ExecuteHamB(Ham_CS_RoundRespawn, id)
	
	// Teavitame
	ChatColor(id, "^1[^4DRM v%s^1] You have been revived. Lifes left:^4 %d^1.", PLUGIN_VERSION, g_elud[id])
}

/*================================================================================
 [Elude Haldamine]
=================================================================================*/

// Laadime elud andmebaasist
LoadElud(id)
{
	// Query
	static query[512]
	formatex(query, charsmax(query), "SELECT `id`, `lifes`, `money`, `vip_weapon`, `vip_weapon2`, `weapon_level`, `timestamp`, `ip`, `password` FROM `dr_stats` WHERE `auth` = ^"%s^"", g_auth[id])
	
	// Andmed
	static data[1]
	data[0] = id
	
	SQL_ThreadQuery(g_sql_tuple, "_LoadElud", query, data, sizeof(data))
}
public _LoadElud(failstate, Handle:query, error[], errno, data[], datasize)
{
	// Midagi läks valesti
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	// Uus mängija
	if (!SQL_NumResults(query))
	{
		g_id[id] = 0
		return;
	}
	
	// Juba tuntud mängija
	g_id[id] = SQL_ReadResult(query, SQL_FieldNameToNum(query, "id"))
	
	// Kontrollime, et serveris ei oleks korraga 2 sama ID-ga kasutajat
	for (new i = 1; i <= g_maxplayers; i++)
	{
		if (g_isconnected[i] && i != id && g_id[id] == g_id[i])
		{
			if (isSteamer(id) && isSteamer(i))
			{
				// Keegi on sama SteamID'ga sees, kickime ta välja sisse logides
				server_cmd("kick #%d ^"Someone else logged in with your ID.^"", get_user_userid(i))
			}
			else
			{
				// Keegi on sama IP'ga juba sisse logitud, meie ei saa
				g_id[id] = -1
				return;
			}
		}
	}
	
	// Muud andmed
	g_elud[id] = SQL_ReadResult(query, SQL_FieldNameToNum(query, "lifes"))
	g_raha[id] = SQL_ReadResult(query, SQL_FieldNameToNum(query, "money"))
	g_relvalevel[id] = min(SQL_ReadResult(query, SQL_FieldNameToNum(query, "weapon_level")), 30)
	g_relv[id] = clamp(SQL_ReadResult(query, SQL_FieldNameToNum(query, "vip_weapon")), 1, g_relvalevel[id])
	g_relv2[id] = SQL_ReadResult(query, SQL_FieldNameToNum(query, "vip_weapon2"))
	g_lastvisit[id] = SQL_ReadResult(query, SQL_FieldNameToNum(query, "timestamp"))
	SQL_ReadResult(query, SQL_FieldNameToNum(query, "ip"), g_lastip[id], charsmax(g_lastip[]))
	
	if (g_relv2[id] < 25) g_relv2[id] = 25
	
	// Tervitussõnum mängijale endale
	if (g_lastvisit[id] > 0 && get_user_time(id) < 60)
		set_task(5.0, "task_welcome_msg", TASK_WELCOME_MSG+id)
	
	// Lõpetatud mappide arv/tervitussõnum VIP'idele
	LoadCompletedMaps(id)
}

// Salvestame elud
SaveElud(id)
{
	// Vajalikud andmed
	static timestamp, ip[16], nick[32], played
	timestamp = get_systime()
	get_user_ip(id, ip, charsmax(ip), true)
	get_user_name(id, nick, charsmax(nick))
	played = timestamp - g_TimeConnected[id]
	
	// Query
	static query[1024], len
	len = formatex(query, charsmax(query), "INSERT INTO `dr_stats` (`auth`, `lifes`, `money`, `timestamp`, `ip`, `nickname`, `vip_weapon`, `vip_weapon2`, `time_played`) ")
	len += formatex(query[len], charsmax(query) - len, "VALUES (^"%s^", %d, %d, %d, ^"%s^", ^"%s^", %d, %d, %d) ON DUPLICATE KEY UPDATE ", g_auth[id], g_elud[id], g_raha[id], timestamp, ip, nick, g_relv[id], g_relv2[id], played)
	len += formatex(query[len], charsmax(query) - len, "`lifes` = %d + `add_lifes`, `money` = %d + `add_money`, `timestamp` = %d, `ip` = ^"%s^", `nickname` = ^"%s^", `vip_weapon` = %d, `vip_weapon2` = %d, `time_played` = %d + `time_played`, `add_lifes` = 0, `add_money` = 0", g_elud[id], g_raha[id], timestamp, ip, nick, g_relv[id], g_relv2[id], played)
	
	SQL_ThreadQuery(g_sql_tuple, "_SaveElud", query)
}
public _SaveElud(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
}

// Callback INSERT käsklustele
public _Insert(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
}

/*================================================================================
 [Client Commands]
=================================================================================*/

// Mängija üritab kasutada raadiokäsklusi
public ClCmd_Radio(id)
{
	// Blokeerime, et mitte segada teisi mängijaid
	return PLUGIN_HANDLED_MAIN;
}

// Mängija üritab minna teise tiimi
public ClCmd_ChangeTeam(id)
{
	// Lubame vaid juhul, kui see on serverisse lisanduv mängija
	if (fm_cs_get_user_team(id) == FM_CS_TEAM_UNASSIGNED)
		return PLUGIN_CONTINUE;
	
	// Blokeerime käskluse, näitame hoopis DR peamenüüd
	ShowMainMenu(id)
	return PLUGIN_HANDLED;
}

// Mängija üritab kasutada elu
public ClCmd_Revive(id)
{
	if (CallBack_CanRevive(id))
		Revive(id)
	else
		ChatColor(id, "^1[^4DRM v%s^1] You can't respawn right now.", PLUGIN_VERSION)
}

// Mängija tahab annetada elusid/raha
public ClCmd_Donate(id)
{
	ChatColor(id, "^1[^4DRM v%s^1] Use:^4 /donatelifes^1 or^4 /donatemoney^1.", PLUGIN_VERSION)
}

// Say handler
public ClCmd_Say(id)
{
	// Loeme kogu rea, eemaldame jutumärgid
	new line[128]
	read_args(line, charsmax(line))
	remove_quotes(line)
	
	// Eraldame käskluse ning argumendid
	new command[16], args[64]
	strbreak(line, command, charsmax(command), args, charsmax(args))
	
	if (equali(command, "/register", 9))
	{
		if (!isSteamer(id))
		{
			ChatColor(id, "^1[^4Auth v%s^1] Only players with a^4 Steam ID^1 can use a password.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		if (g_id[id] <= 0)
		{
			ChatColor(id, "^1[^4Auth v%s^1] Registration is not available for you at the moment.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		if (g_haspw[id])
		{
			ChatColor(id, "^1[^4Auth v%s^1] You are already registered.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		new newPw[16], confirmedPassword[16]
		strbreak(args, newPw, charsmax(newPw), confirmedPassword, charsmax(confirmedPassword))
		strtolower(newPw)
		strtolower(confirmedPassword)
		
		if (!newPw[0] || !confirmedPassword[0])
		{
			ChatColor(id, "^1[^4Auth v%s^1] Usage:^4 /register <pw> <confirm pw>^1.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		if (!equali(newPw, confirmedPassword))
		{
			ChatColor(id, "^1[^4Auth v%s^1] Registration failed:^4 passwords do not match^1.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		for (new i = 0; i < strlen(confirmedPassword); i++)
		{
			if (!(confirmedPassword[i] >= '0' && confirmedPassword[i] <= '9') && !(confirmedPassword[i] >= 'a' && confirmedPassword[i] <= 'z'))
			{
				ChatColor(id, "^1[^4Auth v%s^1] Registration failed:^4 invalid character: '%c'^1.", PLUGIN_VERSION, confirmedPassword[i])
				return PLUGIN_HANDLED;
			}
		}
		
		if (strlen(confirmedPassword) < 4)
		{
			ChatColor(id, "^1[^4Auth v%s^1] Registration failed:^4 password must be at least 4 characters long^1.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		new query[128], data[2]
		formatex(query, charsmax(query), "UPDATE `dr_stats` SET `password` = '%s' WHERE `id` = %d", confirmedPassword, g_id[id])
		data[0] = id
		SQL_ThreadQuery(g_sql_tuple, "_Register", query, data, sizeof(data))
		return PLUGIN_HANDLED;
	}
	else if (equali(command, "/login", 6))
	{
		if (g_id[id] != -2)
		{
			ChatColor(id, "^1[^4Auth v%s^1] You are already logged in.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		new pw[16]
		copy(pw, charsmax(pw), args)
		
		trim(pw)
		remove_quotes(pw)
		strtolower(pw)
		
		if (!pw[0])
		{
			ChatColor(id, "^1[^4Auth v%s^1] Usage:^4 /login <pw>^1.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		for (new i = 0; i < strlen(pw); i++)
		{
			if (!(pw[i] >= '0' && pw[i] <= '9') && !(pw[i] >= 'a' && pw[i] <= 'z'))
			{
				ChatColor(id, "^1[^4Auth v%s^1] Password cannot contain the character^4 %c^1.", PLUGIN_VERSION, pw[i])
				return PLUGIN_HANDLED;
			}
		}
		
		new query[128], data[32]
		formatex(query, charsmax(query), "SELECT `password` FROM `dr_stats` WHERE `auth` = '%s'", g_auth[id])
		formatex(data, charsmax(data), "^"%d^" ^"%s^"", id, pw)
		SQL_ThreadQuery(g_sql_tuple, "_CheckLogin", query, data, sizeof(data))
		return PLUGIN_HANDLED;
	}
	else if (equali(command, "/changepassword", 15))
	{
		if (!isSteamer(id))
		{
			ChatColor(id, "^1[^4Auth v%s^1] Only players with a^4 Steam ID^1 can use a password.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		if (g_id[id] <= 0)
		{
			ChatColor(id, "^1[^4Auth v%s^1] You must be logged in to change your password^1.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		if (!g_haspw[id])
		{
			ChatColor(id, "^1[^4Auth v%s^1] You must first register to change your password.^1.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		new newPw[16], confirmedPassword[16]
		strbreak(args, newPw, charsmax(newPw), confirmedPassword, charsmax(confirmedPassword))
		strtolower(newPw)
		strtolower(confirmedPassword)
		
		if (!newPw[0] || !confirmedPassword[0])
		{
			ChatColor(id, "^1[^4Auth v%s^1] Usage:^4 /changepassword <pw> <confirm pw>^1.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		if (!equali(newPw, confirmedPassword))
		{
			ChatColor(id, "^1[^4Auth v%s^1] Password change failed:^4 passwords do not match^1.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		for (new i = 0; i < strlen(confirmedPassword); i++)
		{
			if (!(confirmedPassword[i] >= '0' && confirmedPassword[i] <= '9') && !(confirmedPassword[i] >= 'a' && confirmedPassword[i] <= 'z'))
			{
				ChatColor(id, "^1[^4Auth v%s^1] Password change failed:^4 invalid character: %c^1.", PLUGIN_VERSION, confirmedPassword[i])
				return PLUGIN_HANDLED;
			}
		}
		
		if (strlen(confirmedPassword) < 4)
		{
			ChatColor(id, "^1[^4Auth v%s^1] Password change failed:^4 password must be at least 4 characters long^1.", PLUGIN_VERSION)
			return PLUGIN_HANDLED;
		}
		
		new query[128], data[2]
		formatex(query, charsmax(query), "UPDATE `dr_stats` SET `password` = '%s' WHERE `id` = %d", confirmedPassword, g_id[id])
		data[0] = id
		SQL_ThreadQuery(g_sql_tuple, "_ChangePassword", query, data, sizeof(data))
		return PLUGIN_HANDLED;
	}
	else if (equali(command, "/donatelifes", 12))
	{
		// Loeme saaja nime ning summa
		new saajaNimi[32], summaSZ[10], summa
		strbreak(args, saajaNimi, charsmax(saajaNimi), summaSZ, charsmax(summaSZ))
		summa = str_to_num(summaSZ)
		
		// Mängija elud ei ole laetud.
		if (g_id[id] <= 0)
		{
			ChatColor(id, "^1[^4DRM v%s^1] You can't donate in^4 OFFLINE MODE^1. Please try reconnecting.", PLUGIN_VERSION)
			return PLUGIN_HANDLED_MAIN;
		}
		
		// Leiame saaja ning summa
		static saaja
		saaja = cmd_target(id, saajaNimi, CMDTARGET_NO_BOTS)
		
		
		// Iseendale ei saa annetada
		if (id == saaja)
		{
			ChatColor(id, "^1[^4DRM v%s^1] You can't donate to yourself.", PLUGIN_VERSION)
			return PLUGIN_HANDLED_MAIN;
		}
		// Negatiivne suurus
		if (summa <= 0)
		{
			ChatColor(id, "^1[^4DRM v%s^1] You can't donate^4 negative^1 amount.", PLUGIN_VERSION)
			return PLUGIN_HANDLED_MAIN;
		}
		// Pole piisavalt elusid
		if (g_elud[id] < summa)
		{
			ChatColor(id, "^1[^4DRM v%s^1] You don't have^4 enough lifes^1. Balance:^4 %d - %d = %d^1. You can buy lifes by typing ^4 /sms^1.", PLUGIN_VERSION, g_elud[id], summa, g_elud[id] - summa)
			return PLUGIN_HANDLED_MAIN;
		}
		// Mängijat ei leitud
		if (!saaja)
		{
			ChatColor(id, "^1[^4DRM v%s^1] There is no such player as^4 %s^1.", PLUGIN_VERSION, saajaNimi)
			return PLUGIN_HANDLED_MAIN;
		}
		
		// Saaja tegelik nimi
		get_user_name(saaja, saajaNimi, charsmax(saajaNimi))
		
		// Saaja on OFFLINE MODE'is
		if (g_id[saaja] <= 0)
		{
			ChatColor(id, "^1[^4DRM v%s^1]^4 %s^1 is in^4 OFFLINE MODE^1.", PLUGIN_VERSION, saajaNimi)
			return PLUGIN_HANDLED_MAIN;
		}
		
		// Teeme ära annetuse
		g_elud[id] -= summa
		g_elud[saaja] += summa
		
		// Sisestame andmebaasi
		static query[256]
		formatex(query, charsmax(query), "INSERT INTO `dr_donations` (`donator`, `target`, `lifes`, `money`, `timestamp`) VALUES (%d, %d, %d, 0, %d)", g_id[id], g_id[saaja], summa, get_systime())
		SQL_ThreadQuery(g_sql_tuple, "_Insert", query)
		
		// Teavitame kõiki
		static annetajaNimi[32]
		get_user_name(id, annetajaNimi, charsmax(annetajaNimi))
		ChatColor(0, "^1[^4DRM v%s^1]^4 %s^1 donated^4 %d^1 lifes to^4 %s^1.", PLUGIN_VERSION, annetajaNimi, summa, saajaNimi)
		return PLUGIN_HANDLED_MAIN;
	}
	else if (equali(command, "/donatemoney", 12))
	{
		// Loeme saaja nime ning summa
		new saajaNimi[32], summaSZ[10], summa
		strbreak(args, saajaNimi, charsmax(saajaNimi), summaSZ, charsmax(summaSZ))
		summa = str_to_num(summaSZ)
		
		// Mängija raha ei ole laetud.
		if (g_id[id] <= 0)
		{
			ChatColor(id, "^1[^4DRM v%s^1] You can't donate in^4 OFFLINE MODE^1. Please try reconnecting.", PLUGIN_VERSION)
			return PLUGIN_HANDLED_MAIN;
		}
		
		// Leiame saaja ning summa
		static saaja
		saaja = cmd_target(id, saajaNimi, CMDTARGET_NO_BOTS)
		
		// Iseendale ei saa annetada
		if (id == saaja)
		{
			ChatColor(id, "^1[^4DRM v%s^1] You can't donate to yourself.", PLUGIN_VERSION)
			return PLUGIN_HANDLED_MAIN;
		}
		// Negatiivne suurus
		if (summa <= 0)
		{
			ChatColor(id, "^1[^4DRM v%s^1] You can't donate^4 negative^1 amount.", PLUGIN_VERSION)
			return PLUGIN_HANDLED_MAIN;
		}
		// Pole piisavalt raha
		if (g_raha[id] < summa)
		{
			ChatColor(id, "^1[^4DRM v%s^1] You don't have^4 enough money^1. Balance:^4 $%d - $%d = $%d^1. You can buy money by typing ^4 /sms^1.", PLUGIN_VERSION, g_raha[id], summa, g_raha[id] - summa)
			return PLUGIN_HANDLED_MAIN;
		}
		// Mängijat ei leitud
		if (!saaja)
		{
			ChatColor(id, "^1[^4DRM v%s^1] There is no such player as^4 %s^1.", PLUGIN_VERSION, saajaNimi)
			return PLUGIN_HANDLED_MAIN;
		}
		
		// Saaja tegelik nimi
		get_user_name(saaja, saajaNimi, charsmax(saajaNimi))
		
		// Saaja on OFFLINE MODE'is
		if (g_id[saaja] <= 0)
		{
			ChatColor(id, "^1[^4DRM v%s^1]^4 %s^1 is in^4 OFFLINE MODE^1.", PLUGIN_VERSION, saajaNimi)
			return PLUGIN_HANDLED_MAIN;
		}
		
		// Teeme ära annetuse
		g_raha[id] -= summa
		g_raha[saaja] += summa
		
		// Sisestame andmebaasi
		static query[256]
		formatex(query, charsmax(query), "INSERT INTO `dr_donations` (`donator`, `target`, `lifes`, `money`, `timestamp`) VALUES (%d, %d, 0, %d, %d)", g_id[id], g_id[saaja], summa, get_systime())
		SQL_ThreadQuery(g_sql_tuple, "_Insert", query)
		
		// Teavitame kõiki
		static annetajaNimi[32]
		get_user_name(id, annetajaNimi, charsmax(annetajaNimi))
		ChatColor(0, "^1[^4DRM v%s^1]^4 %s^1 donated^4 $%d^1 to^4 %s^1.", PLUGIN_VERSION, annetajaNimi, summa, saajaNimi)
		return PLUGIN_HANDLED_MAIN;
	}
	else if (equali(command, "/lifes", 6) || equali(command, "/elud", 5))
	{
		// Leiame targeti
		static target
		target = cmd_target(id, args, CMDTARGET_NO_BOTS)
		
		// Targetit ei leitud
		if (!target || target == id)
		{
			ChatColor(id, "^1[^4DRM v%s^1] You have^4 %d lifes^1.", PLUGIN_VERSION, g_elud[id])
			return PLUGIN_HANDLED_MAIN;
		}
		
		// Targeti reaalne nimi
		static targetName[32]
		get_user_name(target, targetName, charsmax(targetName))
		
		// Kuvame antud mängija raha
		ChatColor(id, "^1[^4DRM v%s^1]^4 %s^1 has^4 %d lifes^1.", PLUGIN_VERSION, targetName, g_elud[target])
		return PLUGIN_HANDLED_MAIN;
	}
	else if (equali(command, "/money", 6) || equali(command, "/raha", 5))
	{
		// Leiame targeti
		static target
		target = cmd_target(id, args, CMDTARGET_NO_BOTS)
		
		// Targetit ei leitud
		if (!target || target == id)
		{
			// Format money
			static szRaha[32]
			num_format(g_raha[id], szRaha, charsmax(szRaha))
			ChatColor(id, "^1[^4DRM v%s^1] You have^4 $%s^1.", PLUGIN_VERSION, szRaha)
			return PLUGIN_HANDLED_MAIN;
		}
		
		// Targeti reaalne nimi
		static targetName[32]
		get_user_name(target, targetName, charsmax(targetName))
		
		// Format money
		static szRaha[32]
		num_format(g_raha[target], szRaha, charsmax(szRaha))
		
		// Kuvame antud mängija raha
		ChatColor(id, "^1[^4DRM v%s^1]^4 %s^1 has^4 $%s^1.", PLUGIN_VERSION, targetName, szRaha)
		return PLUGIN_HANDLED_MAIN;
	}
	else if (equali(command, "/profile", 8))
	{
		// Leiame targeti
		static target
		target = cmd_target(id, args, CMDTARGET_NO_BOTS)
		
		// Targetit ei leitud
		if (!target)
		{
			if (args[0]) // ... kuigi nimi sisestati
			{
				ChatColor(id, "^1[^4DRM v%s^1] Player^4 %s^1 was not found.", PLUGIN_VERSION, args)
				return PLUGIN_HANDLED_MAIN;
			}
			else
				target = id // nime ei sisestatud, kuvame enda profiili
		}
		
		// Target leiti, võtame täpse nime
		static targetName[32]
		get_user_name(target, targetName, charsmax(targetName))
		
		// Target pole sisse loginud või on offline modes
		if (g_id[target] <= 0)
		{
			ChatColor(id, "^1[^4DRM v%s^1] Player^4 %s^1 hasn't logged in or is in offline mode.", PLUGIN_VERSION, targetName)
			return PLUGIN_HANDLED_MAIN;
		}
		
		// URL
		static profileUrl[128]
		formatex(profileUrl, charsmax(profileUrl), "%s/dr_profile.php?id=%d", WEB_URL, g_id[target])
		
		// Kuvame antud mängija profiili
		show_motd(id, profileUrl, targetName)
		return PLUGIN_HANDLED_MAIN;
	}
	
	return PLUGIN_HANDLED_MAIN;
}

public ClCmd_ShowLifes(id)
{
	ChatColor(id, "^1[^4DRM v%s^1] You have^4 %d lifes^1.", PLUGIN_VERSION, g_elud[id])
	return PLUGIN_HANDLED_MAIN;
}

public ClCmd_ShowMoney(id)
{
	ChatColor(id, "^1[^4DRM v%s^1] You have^4 $%d^1.", PLUGIN_VERSION, g_raha[id])
	return PLUGIN_HANDLED_MAIN;
}

public ClCmd_ShowID(id)
{
	ChatColor(id, "^1[^4DRM v%s^1] ID:^4 %d^1 | Auth:^4 %s^1 | WPN level:^4 %d^1 /^4 30^1.", PLUGIN_VERSION, g_id[id], g_auth[id], g_relvalevel[id])
	return PLUGIN_HANDLED_MAIN;
}

public ClCmd_Shop(id)
{
	ShowShopMenu(id)
	return PLUGIN_HANDLED_MAIN;
}

public ClCmd_VIPMenu(id)
{
	ShowVIPMenu(id)
	return PLUGIN_HANDLED_MAIN;
}

public ClCmd_SMS(id)
{
	static name[32], message[256]
	get_user_name(id, name, charsmax(name))
	
	formatex(message, charsmax(message), "%s/index.php?s=3&id=%d&c=en&n=%s", WEB_URL, g_id[id], name)
	show_motd(id, message, "SMS Services")
}

public ClCmd_Rules(id)
{
	static message[128]
	formatex(message, charsmax(message), "%s/rules.php?server=3", WEB_URL)
	
	show_motd(id, message, "Rules")
}

public ClCmd_Top15(id)
{
	static message[128]
	formatex(message, charsmax(message), "%s/dr_top15.php?map=%s", WEB_URL, g_mapname)
	
	show_motd(id, message, g_mapname)
}

public ClCmd_Top(id)
{
	static message[128]
	formatex(message, charsmax(message), "%s/dr_top.php?id=%d", WEB_URL, g_id[id])
	
	show_motd(id, message, "Top Players")
}

public ClCmd_Maps(id)
{
	static message[128]
	formatex(message, charsmax(message), "%s/dr_maps.php?map=%s", WEB_URL, g_mapname)
	
	show_motd(id, message, "Maps")
}

public ClCmd_Last(id)
{
	static message[128]
	formatex(message, charsmax(message), "%s/motd/dr_last.php", WEB_URL)
	
	show_motd(id, message, "Last")
}

public ClCmd_ShowQueue(id)
{
	if (!g_queuecount)
	{
		ChatColor(id, "^1[^4DRM v%s^1]^4 Terrorist queue^1 is^4 empty^1.", PLUGIN_VERSION)
		return;
	}
	
	static count, name[16], message[192], len
	count = 0
	len = formatex(message, charsmax(message), "^1Terrorist queue;")
	
	while (count < g_queuecount)
	{
		count++
		
		get_user_name(g_terroristqueue[count-1][0], name, charsmax(name))
		len += formatex(message[len], charsmax(message) - len, " %d.^4 %s^1;", count, name)
	}
	
	ChatColor(id, message)
}

/*================================================================================
 [Menus]
=================================================================================*/

// Peamenüü
ShowMainMenu(id)
{
	// Loome menüü
	static menu[512], len, keys
	len = formatex(menu, charsmax(menu), "\yDRM v%s^n^n", PLUGIN_VERSION)
	keys = MENU_KEY_9|MENU_KEY_0|MENU_KEY_2
	
	// 1. Revive
	if (CallBack_CanRevive(id))
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Revive^n")
		keys |= MENU_KEY_1
	}
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d1. Revive^n")
	
	// 2. Shop
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Shop^n")
	
	// 3. Terrorist Queue
	static queuepos
	queuepos = GetQueuePos(id)
	if (g_triedqueue[id] || !is_user_playing(id))
		len += formatex(menu[len], charsmax(menu) - len, "\d3. Join Terrorist Queue [%d %s]^n", g_queuecount, g_queuecount == 1 ? "player" : "players")
	else if (queuepos == -1)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Join Terrorist Queue\y [%d %s]^n", g_queuecount, g_queuecount == 1 ? "player" : "players")
		keys |= MENU_KEY_3
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Leave Terrorist Queue\y [%d of %d]^n", queuepos + 1, g_queuecount)
		keys |= MENU_KEY_3
	}
	// -- Terrorist Queue
	
	// Spacers
	len += formatex(menu[len], charsmax(menu) - len, "^n^n")
	
	// Spec/CT tiimide vahel vahetamine
	switch (fm_cs_get_user_team(id))
	{
		case FM_CS_TEAM_CT:
		{
			len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Spectate^n")
			keys |= MENU_KEY_6
		}
		case FM_CS_TEAM_SPECTATOR:
		{
			len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Join Game^n")
			keys |= MENU_KEY_6
		}
		default: len += formatex(menu[len], charsmax(menu) - len, "^n")
	}
	
	// Spacers
	len += formatex(menu[len], charsmax(menu) - len, "^n")
	
	// 9. VIP Menu
	len += formatex(menu[len], charsmax(menu) - len, "\r9.\w VIP Menu^n")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w Exit")
	
	// Näitame menüüd mängijale
	show_menu(id, keys, menu, -1, "Main Menu")
}

// Peamenüü handler
public MainMenu(id, key)
{
	switch (key)
	{
		case 0: // 1. Revive
		{
			// Kontrollime veel kord, kas mängija ikka saab respawnida
			if (CallBack_CanRevive(id))
				Revive(id)
		}
		case 1: // 2. Shop
		{
			ShowShopMenu(id)
		}
		case 2: // 3. Join Terrorist Queue
		{
			if (is_user_playing(id))
			{
				if (GetQueuePos(id) == -1) // Mängija ei ole järjekorras, lisame
				{
					QueueAdd(id)
				}
				else // Mängija on juba järjekoerras, eemaldame
				{
					QueueRemove(id)
					g_triedqueue[id] = true // ennetame spammimist
				}
			}
		}
		case 5: // 6. Spec/CT tiimide vahel vahetamine
		{
			switch (fm_cs_get_user_team(id))
			{
				case FM_CS_TEAM_CT:
				{
					// Tapame mängija enne tiimi vahetamist
					if (g_isalive[id]) user_silentkill(id)
					
					// Eemaldame ta järjekorrast
					QueueRemove(id)
					
					// Tõstame ta speci
					cs_set_user_team(id, CS_TEAM_SPECTATOR)
				}
				case FM_CS_TEAM_SPECTATOR:
				{
					// Tõstame CT tiimi
					cs_set_user_team(id, CS_TEAM_CT)
				}
			}
		}
		case 8: // 9. VIP Menu
		{
			ShowVIPMenu(id)
		}
	}
}

// Pood
ShowShopMenu(id)
{
	static menu[128], buffer[1], menuid
	formatex(menu, charsmax(menu), "Shop\r")
	menuid = menu_create(menu, "ShopMenu")
	
	buffer[0] = 1 // NVG
	if (CallBack_NVG(id))
		menu_additem(menuid, "\wNVG\y ($100)", buffer, _, g_CallBack_Enabled)
	else
		menu_additem(menuid, "\dNVG ($100)", buffer, _, g_CallBack_Disabled)
	buffer[0] = 2 // Armor (CT)
	if (CallBack_Armor(id))
		menu_additem(menuid, "\wArmor (absorbs up to 100 damage)\y ($500)", buffer, _, g_CallBack_Enabled)
	else
		menu_additem(menuid, "\dArmor (absorbs up to 100 damage) ($500)", buffer, _, g_CallBack_Disabled)
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "Previous")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "Next")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "Back")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Näitame menüüd
	menu_display(id, menuid)
}

public ShopMenu(id, menuid, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		ShowMainMenu(id)
		return PLUGIN_HANDLED;
	}
	
	static buffer[1], dummy
	menu_item_getinfo(menuid, item, dummy, buffer, sizeof(buffer), _, _, dummy)
	
	switch (buffer[0])
	{
		case 1: // 1. NVG
		{
			if (CallBack_NVG(id))
			{
				// Eemaldame raha, anname NVG
				g_raha[id] -= 100
				cs_set_user_nvg(id, true)
				
				ChatColor(id, "^1[^4DRM v%s^1] You bought^4 NVG^1 for^4 $100^1. Money left:^4 $%d^1.", PLUGIN_VERSION, g_raha[id])
			}
		}
		case 2: // 2. Armor
		{
			if (CallBack_Armor(id))
			{
				// Eemaldame raha, anname armori
				g_raha[id] -= 500
				g_shop_armor[id] = 100
				g_bought_armor[id] = true
				
				// Helendus
				set_user_rendering(id, kRenderFxGlowShell, 255, 255, 255, kRenderTransColor, 1)
				
				ChatColor(id, "^1[^4DRM v%s^1] You bought^4 Armor^1 for^4 $500^1. Money left:^4 $%d^1.", PLUGIN_VERSION, g_raha[id])
			}
		}
	}
	
	menu_destroy(menuid)
	ShowShopMenu(id)
	return PLUGIN_HANDLED;
}

// VIP Menüü
ShowVIPMenu(id)
{
	// Loome menüü
	static menu[512], len, keys
	len = formatex(menu, charsmax(menu), "\yVIP Menu^n^n")
	keys = MENU_KEY_2|MENU_KEY_1|MENU_KEY_0
	
	// 1. Weapon
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w 1st Weapon:\r #%d\y %s^n", g_relv[id], VIP_WEAPONNAMES[g_relv[id]])
	
	// Spacers
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w 2nd Weapon:\r #%d\y %s^n^n^n^n^n^n^n", g_relv2[id], VIP_WEAPON2NAMES[g_relv2[id]-24])
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w Back")
	
	// Näitame menüüd mängijale
	show_menu(id, keys, menu, -1, "VIP Menu")
}

// VIP Menüü handler
public VIPMenu(id, key)
{
	switch (key)
	{
		case 0: // 1. 1st Weapon
		{
			ShowWeaponMenu(id)
		}
		case 1: // 2. 2nd Weapon
		{
			ShowWeaponMenu2(id)
		}
		case 9: // 0. Back
		{
			ShowMainMenu(id)
		}
	}
}

// Revive Menüü
ShowReviveMenu(id)
{
	// Loome menüü
	static menu[512], len, keys
	len = formatex(menu, charsmax(menu), "\yRevive?^n^n")
	keys = MENU_KEY_1|MENU_KEY_2
	
	// 1. Yes
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Yes^n")
	
	// 2. No
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w No^n")
	
	// Näitame menüüd mängijale
	show_menu(id, keys, menu, 10, "Revive Menu")
}

// Revive Menüü handler
public ReviveMenu(id, key)
{
	switch (key)
	{
		case 0: // 1. Yes
		{
			if (CallBack_CanRevive(id))
				Revive(id)
		}
	}
}

// VIP Relvamenüü
ShowWeaponMenu(id)
{
	static menu[128], buffer[1], menuid
	formatex(menu, charsmax(menu), "1st Weapon\r")
	menuid = menu_create(menu, "WeaponMenu")
	
	for (new i = 1; i < sizeof(VIP_WEAPONIDS); i++)
	{
		buffer[0] = i
		
		if (i <= g_relvalevel[id])
		{
			formatex(menu, charsmax(menu), "\y#%d:\w %s", i, VIP_WEAPONNAMES[i])
			menu_additem(menuid, menu, buffer, _, g_CallBack_Enabled)
		}
		else
		{
			formatex(menu, charsmax(menu), "\d#%d: %s", i, VIP_WEAPONNAMES[i])
			menu_additem(menuid, menu, buffer, _, g_CallBack_Disabled)
		}
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "Previous")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "Next")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "Back")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Näitame menüüd
	menu_display(id, menuid)
}

// VIP Relvamenüü handler
public WeaponMenu(id, menuid, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		ShowVIPMenu(id)
		return PLUGIN_HANDLED;
	}
	
	static buffer[1], dummy
	menu_item_getinfo(menuid, item, dummy, buffer, sizeof(buffer), _, _, dummy)
	
	g_relv[id] = buffer[0]
	
	menu_destroy(menuid)
	ShowVIPMenu(id)
	return PLUGIN_HANDLED;
}

// VIP Relvamenüü #2
ShowWeaponMenu2(id)
{
	static menu[128], buffer[1], menuid
	formatex(menu, charsmax(menu), "2nd Weapon\r")
	menuid = menu_create(menu, "WeaponMenu2")
	
	for (new i = 1; i < sizeof(VIP_WEAPON2IDS); i++)
	{
		buffer[0] = i
		
		if (i+24 <= g_relvalevel[id])
		{
			formatex(menu, charsmax(menu), "\y#%d:\w %s", i+24, VIP_WEAPON2NAMES[i])
			menu_additem(menuid, menu, buffer, _, g_CallBack_Enabled)
		}
		else
		{
			formatex(menu, charsmax(menu), "\d#%d: %s", i+24, VIP_WEAPON2NAMES[i])
			menu_additem(menuid, menu, buffer, _, g_CallBack_Disabled)
		}
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "Previous")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "Next")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "Back")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Näitame menüüd
	menu_display(id, menuid)
}

// VIP Relvamenüü handler #2
public WeaponMenu2(id, menuid, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		ShowVIPMenu(id)
		return PLUGIN_HANDLED;
	}
	
	static buffer[1], dummy
	menu_item_getinfo(menuid, item, dummy, buffer, sizeof(buffer), _, _, dummy)
	
	g_relv2[id] = 24+buffer[0]
	
	menu_destroy(menuid)
	ShowVIPMenu(id)
	return PLUGIN_HANDLED;
}

// Mängija saab respawnida?
public CallBack_CanRevive(id)
{
	// Mängijal ei ole respawnimiseks elusid
	if (g_elud[id] < 1)
		return false;
	
	// Mängija on juba elus
	if (g_isalive[id])
		return false;
	
	// Ainult CT-d saavad kasutada elusid
	if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT)
		return false;
	
	// Round on lõppenud
	if (g_roundended)
		return false;
	
	// Mängija on sel roundil juba elu kasutanud
	if (g_KasutanudElu[id])
		return false;
	
	// Elus on liiga vähe CTsid
	switch (fnGetCTs())
	{
		case 1..9: if (fnGetAliveCTs() <= 1) return false;
		case 10..19: if (fnGetAliveCTs() <= 2) return false;
		case 20..31: if (fnGetAliveCTs() <= 3) return false;
	}
	
	// Mängija saab respawnida
	return true;
}

public CallBack_Enabled() return ITEM_ENABLED;
public CallBack_Disabled() return ITEM_DISABLED;

public CallBack_NVG(id) return (!g_isalive[id] || cs_get_user_nvg(id) || g_raha[id] < 100) ? false : true;
public CallBack_Armor(id) return (!g_isalive[id] || g_bought_armor[id] || fm_cs_get_user_team(id) != FM_CS_TEAM_CT || g_raha[id] < 500) ? false : true;

/*================================================================================
 [Tiimide Haldamine]
=================================================================================*/

public MessageShowMenu(msg_id, msg_dest, id)
{
	// Mängija on juba tiimis
	if (fm_cs_get_user_team(id))
		return PLUGIN_CONTINUE;
	
	static code[32]
	get_msg_arg_string(4, code, charsmax(code))
	
	// Pole meile vajalik msg
	if (!equal(code, "#Team_Select"))
		return PLUGIN_CONTINUE;
	
	// Task
	static data[2]
	data[0] = msg_id
	set_task(0.1, "TaskForceTeamJoin", id+TASK_FORCE_JOIN, data, sizeof(data))
	return PLUGIN_HANDLED;
}

public MessageVGUIMenu(msg_id, msg_dest, id)
{
	// Mängija on juba tiimis
	if (fm_cs_get_user_team(id))
		return PLUGIN_CONTINUE;
	
	// Pole meile vajalik VGUI menüü
	if (get_msg_arg_int(1) != 2)
		return PLUGIN_CONTINUE;
	
	// Task
	static data[2]
	data[0] = msg_id
	set_task(0.1, "TaskForceTeamJoin", id+TASK_FORCE_JOIN, data, sizeof(data))
	return PLUGIN_HANDLED;
}

public TaskForceTeamJoin(data[], id)
{
	// Kalkuleerime mängija id
	id -= TASK_FORCE_JOIN
	
	// Mängija on juba leidnud omale tiimi
	if (fm_cs_get_user_team(id))
		return;
	
	// Blockime msg
	static defaultBlock
	defaultBlock = get_msg_block(data[0])
	set_msg_block(data[0], BLOCK_SET)
	
	// Valime tiimi
	if (fnGetCTs() && !fnGetTs())
		engclient_cmd(id, "jointeam", "1")
	else
		engclient_cmd(id, "jointeam", "2")
	
	// Valime classi (random)
	static class[2]
	formatex(class, charsmax(class), "%d", random_num(1, 4))
	engclient_cmd(id, "joinclass", class)
	
	// Unblockime msg
	set_msg_block(data[0], defaultBlock)
}

public MessageStatusIcon(msg_id, msg_dest, msg_entity)
{
	new icon[8]
	get_msg_arg_string(2, icon, charsmax(icon))
	
	if (equal(icon, "buyzone") && pev_valid(msg_entity) == PDATA_SAFE)
	{
		set_pdata_int(msg_entity, OFFSET_BUYZONE, get_pdata_int(msg_entity, OFFSET_BUYZONE, OFFSET_LINUX) & ~(1<<0), OFFSET_LINUX)
		return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

public MessageScoreAttrib(msg_id, msg_dest, msg_entity)
{
	static iPlayer
	iPlayer = get_msg_arg_int(SCOREATTRIB_ARG_PLAYERID)
	
	if ((get_user_flags(iPlayer) & ADMIN_LEVEL_H) && !get_msg_arg_int(SCOREATTRIB_ARG_FLAGS))
		set_msg_arg_int(SCOREATTRIB_ARG_FLAGS, ARG_BYTE, SCOREATTRIB_FLAG_VIP)
}

/*================================================================================
 [Terro Järjekord]
=================================================================================*/

GetQueuePos(id)
{
	static count
	count = 0
	
	while (count < g_queuecount)
	{
		if (g_terroristqueue[count][0] == id)
			return count;
		
		count++
	}
	
	return -1;
}

QueueAdd(id)
{
	static count
	count = 0
	
	while (count < g_queuecount)
	{
		if (g_terroristqueue[count][0] == id)
			return;
		
		count++
	}
	
	g_terroristqueue[g_queuecount][0] = id
	g_queuecount++
}

QueueRemove(id)
{
	new count
	
	while (count < g_queuecount)
	{
		if (g_terroristqueue[count][0] == id)
		{
			g_terroristqueue[count][0] = -1
			
			while ((count + 1) < g_queuecount)
			{
				g_terroristqueue[count][0] = g_terroristqueue[count + 1][0]
				count++
			}
			
			g_queuecount--
			
			break;
		}
		
		count++
	}
}

MapFinished(id)
{
	// Isik on juba antud mapi läbinud?
	static query[256], data[32]
	formatex(query, charsmax(query), "SELECT `time` FROM `dr_top` WHERE `id` = %d AND `map` = '%s'", g_id[id], g_mapname)
	formatex(data, charsmax(data), "^"%d^" ^"%f^" ^"%d^"", id, get_gametime() - g_spawntime[id], g_usedScout[id])
	SQL_ThreadQuery(g_sql_tuple, "_PreviousTime", query, data, sizeof(data))
}

public _PreviousTime(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	// Andmed
	static id, Float:runtime, scout, idSz[4], runtimeSz[16], scoutSz[16]
	parse(data, idSz, charsmax(idSz), runtimeSz, charsmax(runtimeSz), scoutSz, charsmax(scoutSz))
	id = str_to_num(idSz)
	runtime = str_to_float(runtimeSz)
	scout = str_to_num(scoutSz)
	
	// Mängija ei ole registreeritud
	if (g_id[id] <= 0)
	{
		// Näitame lihtsalt msg, andmebaasi ei lisa
		ShowFinishMsg(id, runtime, -1.0, scout)
	}
	
	// On juba varem mapi läbinud?
	if (SQL_NumResults(query))
	{
		// Eelmine aeg
		static Float:oldtime
		SQL_ReadResult(query, SQL_FieldNameToNum(query, "time"), oldtime)
		
		// Uus aeg on parem?
		if (runtime < oldtime)
		{
			// Asendame vana aja uuega
			static query2[256], data2[2]
			formatex(query2, charsmax(query2), "UPDATE `dr_top` SET `time` = '%f', `date` = %d, `scout` = %d WHERE `id` = %d AND `map` = '%s'", runtime, get_systime(), scout, g_id[id], g_mapname)
			data2[0] = id
			SQL_ThreadQuery(g_sql_tuple, "_TimeSaved", query2, data2, sizeof(data2))
		}
		
		// Lõpu sõnum
		ShowFinishMsg(id, runtime, oldtime, scout)
	}
	else
	{
		// Läbis mapi esimest korda
		g_mapsCompleted[id]++
		
		// Lõpu sõnum
		ShowFinishMsg(id, runtime, -1.0, scout)
		
		// Lisame lihtsalt andmebaasi
		static query2[256], data2[2]
		formatex(query2, charsmax(query2), "INSERT INTO `dr_top` (`map`, `id`, `time`, `date`, `scout`) VALUES ('%s', %d, '%f', %d, %d)", g_mapname, g_id[id], runtime, get_systime(), scout)
		data2[0] = id
		SQL_ThreadQuery(g_sql_tuple, "_TimeSaved", query2, data2, sizeof(data2))
	}
}

public _TimeSaved(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	// Kuvame uue TOP15 koha
	static query2[256]
	formatex(query2, charsmax(query2), "SELECT `id` FROM `dr_top` WHERE `map` = '%s' ORDER BY `time`", g_mapname)
	SQL_ThreadQuery(g_sql_tuple, "_CheckTop", query2, data, datasize)
}

public _CheckTop(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	// Info about player
	static id, rank
	id = data[0]
	rank = 1
	
	while (SQL_MoreResults(query))
	{
		if (SQL_ReadResult(query, 0) == g_id[id])
		{
			// Player is in top15
			static name[32]
			get_user_name(id, name, charsmax(name))
			
			ChatColor(0, "^1[^4DRM v%s^1]^3 %s^1 is now^4 #%d^1 in^4 %s^1.", PLUGIN_VERSION, name, rank, g_mapname)
			
			// Sound if #1
			if (rank == 1) client_cmd(0, "spk ^"sound/%s^"", SOUND_TOP1)
			break;
		}
		
		// Next rank
		rank++
		SQL_NextRow(query)
	}
}

ShowFinishMsg(id, Float:runtime, Float:oldtime, scout)
{
	// Mängija nimi
	static name[32]
	get_user_name(id, name, charsmax(name))
	
	// Konverteerime sekundid loetavaks ajaks
	static minutes, seconds, milliseconds
	minutes = floatround(runtime / 60.0, floatround_floor)
	seconds = floatround(runtime - minutes * 60.0, floatround_floor)
	milliseconds = floatround((runtime - (minutes * 60.0 + seconds)) * 100.0, floatround_floor)
	
	if (oldtime == -1.0) // Mängija lõpetas esimest korda
	{
		ChatColor(0, "^1[^4DRM v%s^1]^3 %s^1 finished^4 %s^1 in^4 %02i:%02i.%02i^1. [Weapon:^4 %s^1]", PLUGIN_VERSION, name, g_mapname, minutes, seconds, milliseconds, scout ? "Scout" : "Knife")
		return;
	}
	
	// Kalkuleerime erinevuse
	static Float:difference, dminutes, dseconds, dmilliseconds
	difference = floatabs(runtime - oldtime)
	
	dminutes = floatround(difference / 60.0, floatround_floor)
	dseconds = floatround(difference - dminutes * 60.0, floatround_floor)
	dmilliseconds = floatround((difference - (dminutes * 60.0 + dseconds)) * 100.0, floatround_floor)
	
	if (runtime < oldtime) // Parandas aega
	{
		ChatColor(0, "^1[^4DRM v%s^1]^3 %s^1 finished in^4 %02i:%02i.%02i^1 (^4improved^1 their best by^4 %02i:%02i.%02i^1). [Weapon:^4 %s^1]", PLUGIN_VERSION, name, minutes, seconds, milliseconds, dminutes, dseconds, dmilliseconds, scout ? "Scout" : "Knife")
	}
	else if (runtime > oldtime) // Failis
	{
		ChatColor(0, "^1[^4DRM v%s^1]^3 %s^1 finished in^4 %02i:%02i.%02i^1 (^4failed^1 to their best by^4 %02i:%02i.%02i^1). [Weapon:^4 %s^1]", PLUGIN_VERSION, name, minutes, seconds, milliseconds, dminutes, dseconds, dmilliseconds, scout ? "Scout" : "Knife")
	}
}

LoadCompletedMaps(id)
{
	static query[256], data[2]
	formatex(query, charsmax(query), "SELECT COUNT(`id`) FROM `dr_top` WHERE `id` = %d", g_id[id])
	data[0] = id
	SQL_ThreadQuery(g_sql_tuple, "_LoadCompletedMaps", query, data, sizeof(data))
}

public _LoadCompletedMaps(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	if (SQL_NumResults(query))
	{
		static id
		id = data[0]
		
		g_mapsCompleted[id] = SQL_ReadResult(query, 0)
		
		// Welcome message for VIPs
		if (access(id, ADMIN_LEVEL_H))
		{
			static name[32]
			get_user_name(id, name, charsmax(name))
			ChatColor(0, "^1[^4DRM v%s^1]^3 VIP^4 %s^1, who has completed^4 %d^1 map%s, joined the server.", PLUGIN_VERSION, name, g_mapsCompleted[id], g_mapsCompleted[id] == 1 ? "" : "s")
		}
	}
}

public _Register(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	remove_task(id+TASK_LOGIN_REMINDER)
	g_haspw[id] = true
	ChatColor(id, "^1[^4Auth v%s^1] Successfully registered.", PLUGIN_VERSION)
}


public _ChangePassword(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	ChatColor(id, "^1[^4Auth v%s^1]^4 Password changed^1.", PLUGIN_VERSION)
}

public _CheckLogin(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id, idSz[16], enteredPw[16]
	parse(data, idSz, charsmax(idSz), enteredPw, charsmax(enteredPw))
	id = str_to_num(idSz)
	
	if (!SQL_NumResults(query))
	{
		ChatColor(id, "^1[^4Auth v%s^1]^4 You must register first^1.", PLUGIN_VERSION)
		return;
	}
	
	new pw[16]
	SQL_ReadResult(query, SQL_FieldNameToNum(query, "password"), pw, charsmax(pw))
	
	if (strlen(pw) < 4)
	{
		ChatColor(id, "^1[^4Auth v%s^1]^4 You must register first^1.", PLUGIN_VERSION)
		return;
	}
	
	if (!equal(pw, enteredPw))
	{
		ChatColor(id, "^1[^4Auth v%s^1]^4 Wrong password^1.", PLUGIN_VERSION)
		return;
	}
	
	remove_task(id+TASK_LOGIN_REMINDER)
	LoadElud(id)
	ChatColor(id, "^1[^4Auth v%s^1] Successfully logged in.", PLUGIN_VERSION)
}

/*================================================================================
 [Other Functions and Tasks]
=================================================================================*/

// HUD
public task_ShowHUD()
{
	// Vars
	static id, name[32]
	
	for (new player = 1; player <= g_maxplayers; player++)
	{
		// Mängija ei ole ühendatud, jätame vahele
		if (!g_isconnected[player] || is_user_bot(player))
			continue;
		
		id = player
		
		// Player died?
		if (!g_isalive[id])
		{
			// Get spectating target
			id = pev(id, PEV_SPEC_TARGET)
			
			// Target not alive
			if (!g_isalive[id]) continue;
		}
		
		// Spectating someone else?
		if (id != player)
		{
			// Get name
			get_user_name(id, name, charsmax(name))
			
			// Format money
			static szRaha[32]
			num_format(g_raha[id], szRaha, charsmax(szRaha))
			
			// Show name, health, money and lifes
			set_hudmessage(255, 255, 255, HUD_SPECT_X, HUD_SPECT_Y, 0, 6.0, 1.2, 0.0, 0.0, -1)
			ShowSyncHudMsg(player, g_MsgSync, "Spectating: %s^nHP: %d - Lifes: %d - Money: $%s^nMaps: %d/%d%s", name, pev(id, pev_health), g_elud[id], szRaha, g_mapsCompleted[id], g_totalMaps, g_id[id] <= 0 ? " [OFFLINE MODE]" : "")
		}
		else
		{
			// Format money
			static szRaha[32]
			num_format(g_raha[player], szRaha, charsmax(szRaha))
			
			// Show health, money and lifes
			set_hudmessage(34, 139, 34, HUD_STATS_X, HUD_STATS_Y, 0, 6.0, 1.2, 0.0, 0.0, -1)
			ShowSyncHudMsg(player, g_MsgSync, "%s^nHP: %d - Lifes: %d - Money: $%s - Maps: %d/%d", (g_freerun ? "Freerun!" : ""), pev(player, pev_health), g_elud[player], szRaha, g_mapsCompleted[player], g_totalMaps)
		}
	}
}

// Kontrollime kas T on olemas
public task_CheckT()
{
	if (fnGetTs() <= 0 && fnGetCTs() > 1)
	{
		ChatColor(0, "^1[^4DRM v%s^1] No terrorist found.^4 Restarting round^1.", PLUGIN_VERSION)
		slayAll()
	}
}

// Elus CTde arv
fnGetAliveCTs()
{
	static iCTs, id
	iCTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
		if (g_isalive[id])
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_CT)
				iCTs++
	
	return iCTs;
}

// CTde arv
fnGetCTs()
{
	static iCTs, id
	iCTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
		if (g_isconnected[id])
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_CT)
				iCTs++
	
	return iCTs;
}

// Suvaline CT
/*fnGetRandomCT(n)
{
	static iCT, id
	iCT = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (!g_isconnected[id])
			continue;
		
		if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT)
			continue;
		
		if (g_isalive[id])
			iCT++
		
		if (iCT == n)
			return id;
	}
	
	return -1;
}*/

// Terrode arv
fnGetTs()
{
	static iTs, id
	iTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
		if (g_isconnected[id])
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_T)
				iTs++
	
	return iTs;
}

// Mängus olevate mängijate arv
fnGetPlaying()
{
	new iPlaying, id
	iPlaying = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (!g_isconnected[id])
			continue;
		
		if (is_user_playing(id))
			iPlaying++
	}
	
	return iPlaying;
}

// Mängus olevate mängijate arv
fnGetRandomPlaying(n)
{
	static iP, id
	iP = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (!g_isconnected[id])
			continue;
		
		if (FM_CS_TEAM_UNASSIGNED < fm_cs_get_user_team(id) < FM_CS_TEAM_SPECTATOR)
			iP++
		
		if (iP == n)
			return id;
	}
	
	return -1;
}


slayAll()
{
	static id, Float:flFrags
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (!g_isalive[id])
			continue;
		
		pev(id, pev_frags, flFrags)
		set_pev(id, pev_frags, ++flFrags)
		
		user_silentkill(id)
	}
}

public task_welcome_msg(id)
{
	id -= TASK_WELCOME_MSG
	
	static time_remaining[128], playername[32]
	get_time_length(id, get_systime()-g_lastvisit[id], timeunit_seconds, time_remaining, charsmax(time_remaining))
	get_user_name(id, playername, charsmax(playername))
	
	ChatColor(id, "^1[^4DRM v%s^1] Welcome,^4 %s^1! You last connected^4 %s ago^1 from^4 %s^1.", PLUGIN_VERSION, playername, time_remaining, g_lastip[id])
}

isSteamer(id) return g_auth[id][7] == ':';

num_format(num, szNum[], szNumLen)
{
	num_to_str(num, szNum, szNumLen)
	
	for (new i = strlen(szNum); i > 0; i -= 3)
	{
		for (new j = strlen(szNum)+1; j > i; j--)
		{
			szNum[j] = szNum[j-1]
		}
		
		szNum[i] = ' ';
	}
}

/*================================================================================
 [Custom Natives]
=================================================================================*/

public native_dr_get_lives(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[DR] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_elud[id];
}

public native_dr_set_lives(id, lives)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[DR] Invalid Player (%d)", id)
		return false;
	}
	
	g_elud[id] = lives
	return true;
}

public native_dr_get_money(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[DR] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_raha[id];
}

public native_dr_set_money(id, money)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[DR] Invalid Player (%d)", id)
		return false;
	}
	
	g_raha[id] = money
	return true;
}

/*================================================================================
 [Stocks]
=================================================================================*/

// Get User Team
stock fm_cs_get_user_team(id)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return FM_CS_TEAM_UNASSIGNED;
	
	return get_pdata_int(id, OFFSET_CSTEAMS, OFFSET_LINUX);
}

// Color Chat
stock ChatColor(const id, const input[], any:...)
{
	new count = 1, players[32]
	static msg[193]
	vformat(msg, 190, input, 3)
	
	if(id) {
		players[0] = id;
		} else {
		get_players(players, count, "ch")
	}
	
	for(new i = 0; i < count; i++) {
		if(is_user_connected(players[i])) {
			message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, players[i])
			write_byte(players[i])
			write_string(msg)
			message_end()
		}
	}
}
