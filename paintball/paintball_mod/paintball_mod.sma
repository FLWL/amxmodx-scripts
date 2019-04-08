#include <amxmodx>
#include <amxmisc>
#include <hamsandwich>
#include <engine>
#include <fakemeta>
#include <cstrike>
#include <fun>
#include <xs>

const SHOTS = 100
const DEFAULT_VELOCITY = 2000
const BUYZONE_RADIUS = 512

new const BALL_MODEL[] = "models/w_paintball.mdl"
new const PAINT_SPRITE[] = "sprites/paintball.spr"

new const KNIFE_VMODEL[] = "models/v_pb_knife.mdl"
new const KNIFE_PMODEL[] = "models/p_pb_knife.mdl"

new const NADE_VMODEL[] = "models/v_pbnade.mdl"
new const NADE_PMODEL[] = "models/p_pbnade.mdl"
new const NADE_WMODEL[] = "models/w_pbnade.mdl"

const SECONDARY = 0
const PRIMARY = 1

enum
{
	WPN_GLOCK18 = 0,
	WPN_USP,
	WPN_P228,
	WPN_MARKER,
	WPN_SMG,
	WPN_SHOTGUN,
	WPN_LIGHTSNIPER,
	WPN_HEAVYSNIPER,
	
	WPN_LAUNCHER,
	WPN_MINIGUN,
	
	MAX_WEAPONS
}

new const WPN_NAME[][] =
{
	"Glock 18",
	"USP",
	"P228-Auto",
	"Standard Marker",
	"SMG",
	"Shotgun",
	"Light Sniper",
	"Heavy Sniper",
	
	"Launcher",
	"Minigun"
}

new const WPN_VIEWMODEL[][] =
{
	"models/v_pbglock.mdl",
	"models/v_pbusp.mdl",
	"models/v_pb_p228.mdl",
	"models/v_pbgun3.mdl",
	"models/v_pb_tmp.mdl",
	"models/v_pb_shotgun.mdl",
	"models/v_pb_light_sniper.mdl",
	"models/v_pb_heavy_sniper.mdl",
	
	"models/v_pb_launcher.mdl",
	"models/v_pb_minigun.mdl"
}
new const WPN_VIEWMODEL_CT[][] =
{
	"",
	"",
	"",
	"models/v_pbgun7.mdl",
	"",
	"",
	"",
	"",
	"",
	
	"",
	""
}

new const WPN_VMODELTOREPLACE[][] =
{
	"models/v_glock18.mdl",
	"models/v_usp.mdl",
	"models/v_p228.mdl",
	"models/v_mp5.mdl",
	"models/v_tmp.mdl",
	"models/v_xm1014.mdl",
	"models/v_scout.mdl",
	"models/v_awp.mdl",
	
	"models/v_m3.mdl",
	"models/v_m249.mdl"
}

new const WPN_PLAYERMODEL[][] =
{
	"models/p_pbglock.mdl",
	"models/p_pbusp.mdl",
	"",
	"models/p_pbgun1.mdl",
	"",
	"models/p_pb_shotgun.mdl",
	"",
	"",
	
	"models/p_pb_launcher.mdl",
	"models/p_pb_minigun.mdl"
}

new const WPN_WORLDMODEL[][] =
{
	"",
	"",
	"",
	"models/w_pbgun.mdl",
	"",
	"models/w_pb_shotgun.mdl",
	"",
	"",
	
	"models/w_pb_launcher.mdl",
	"models/w_pb_minigun.mdl"
}

new const WPN_WMODELTOREPLACE[][] =
{
	"",
	"",
	"",
	"models/w_mp5.mdl",
	"",
	"models/w_xm1014.mdl",
	"",
	"",
	
	"models/w_m3.mdl",
	"models/w_m249.mdl"
}

new const WPN_ENTNAMES[][] =
{
	"weapon_glock18",
	"weapon_usp",
	"weapon_p228",
	"weapon_mp5navy",
	"weapon_tmp",
	"weapon_xm1014",
	"weapon_scout",
	"weapon_awp",
	
	"weapon_m3",
	"weapon_m249"
}

new const WPN_CSW[] =
{
	CSW_GLOCK18,
	CSW_USP,
	CSW_P228,
	CSW_MP5NAVY,
	CSW_TMP,
	CSW_XM1014,
	CSW_SCOUT,
	CSW_AWP,
	
	CSW_M3,
	CSW_M249
}

new const WPN_KILLMSG[][] =
{
	"glock18",
	"usp",
	"p228",
	"mp5navy",
	"tmp",
	"xm1014",
	"scout",
	"awp",
	
	"launcher",
	"m249"
}

new const WPN_SHOOTANIM[] =
{
	5,
	9,
	1,
	3,
	3,
	2,
	1,
	1,
	
	1,
	1
}

new const WPN_VELOCITY[] =
{
	1400,
	1600,
	1650,
	2000,
	1600,
	1000,
	2800,
	3600,
	
	1500,
	2000
}

new const Float:WPN_GRAVITY[] =
{
	0.35,
	0.27,
	0.25,
	0.25,
	0.30,
	0.50,
	0.10,
	0.05,
	
	1.00,
	0.25
}

new const Float:WPN_FIRE_RATE[] =
{
	0.05,
	0.075,
	0.05,
	0.08,
	0.15,
	0.8,
	1.1,
	1.4,
	
	0.85,
	0.04
}

new const WPN_TRAIL_LIFE[] =
{
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	
	10,
	1,
}

new const WPN_TRAIL_WIDTH[] =
{
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	
	10,
	3,
}

new const WPN_IS_AUTOMATIC[] =
{
	false,
	false,
	true,
	true,
	true,
	true,
	true,
	true,
	
	true,
	true
}

new const WPN_CLIP[] =
{
	20,
	12,
	13,
	30,
	30,
	7,
	10,
	10,
	
	7,
	100
}

new const WPN_BPAMMO[] =
{
	120,
	90,
	26,
	120,
	120,
	36,
	90,
	30,
	
	8,
	200
}

new const WPN_ALLOWUNLIMITEDAMMO[] =
{
	true,
	true,
	false,
	true,
	true,
	true,
	true,
	true,
	
	false,
	true
}

new const WPN_SOUND_FIRE[][] =
{
	"misc/pbg.wav",
	"misc/pbg.wav",
	"misc/pbg.wav",
	"misc/pbg.wav",
	"misc/pbg.wav",
	"misc/pb_shotgun.wav",
	"misc/pb_light_sniper.wav",
	"misc/pb_light_sniper.wav",
	
	"misc/pb_launcher.wav",
	"misc/pbg.wav"
}

new const WPN_TYPE[] =
{
	SECONDARY,
	SECONDARY,
	SECONDARY,
	PRIMARY,
	PRIMARY,
	PRIMARY,
	PRIMARY,
	PRIMARY,
	
	PRIMARY,
	PRIMARY
}

new const WPN_COST[] =
{
	400,
	500,
	-1,
	2500,
	1250,
	1700,
	2750,
	4750,
	
	8000,
	12000
}

// Weapon bitsums
const PRIMARY_WEAPONS_BIT_SUM = (1<<CSW_SCOUT)|(1<<CSW_XM1014)|(1<<CSW_MAC10)|(1<<CSW_AUG)|(1<<CSW_UMP45)|(1<<CSW_SG550)|(1<<CSW_GALIL)|(1<<CSW_FAMAS)|(1<<CSW_AWP)|(1<<CSW_MP5NAVY)|(1<<CSW_M249)|(1<<CSW_M3)|(1<<CSW_M4A1)|(1<<CSW_TMP)|(1<<CSW_G3SG1)|(1<<CSW_SG552)|(1<<CSW_AK47)|(1<<CSW_P90)
const SECONDARY_WEAPONS_BIT_SUM = (1<<CSW_P228)|(1<<CSW_ELITE)|(1<<CSW_FIVESEVEN)|(1<<CSW_USP)|(1<<CSW_GLOCK18)|(1<<CSW_DEAGLE)

// CS Player PData Offsets (win32)
const PDATA_SAFE = 2
const OFFSET_BUYZONE = 235
const OFFSET_CSMENUCODE = 205

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds

// Stuff
new g_msgDeathMsg
new g_sprBeam
new g_sprBlood
new g_sprBloodSpray

new g_maxplayers

// Player vars
new Float:g_lastshot[33]
new Float:g_nextattack[33]

new Float:g_spawnOrigin[33][3]
new Float:g_spawntime[33]

new g_unlimited_ammo[33]
new g_autobhop[33]

// Global vars
new g_bombmap
new g_freezetime
new g_paintball_count
new g_CallBack_Enabled
new g_CallBack_Disabled

// Ball ent vars
new g_paintballs[SHOTS+100]
new g_paintball_status[SHOTS+100]

public plugin_precache()
{
	static i
	for (i = 0; i < MAX_WEAPONS; i++)
	{
		if (WPN_PLAYERMODEL[i][0]) precache_model(WPN_PLAYERMODEL[i])
		if (WPN_VIEWMODEL[i][0]) precache_model(WPN_VIEWMODEL[i])
		if (WPN_VIEWMODEL_CT[i][0]) precache_model(WPN_VIEWMODEL_CT[i])
		if (WPN_WORLDMODEL[i][0]) precache_model(WPN_WORLDMODEL[i])
		
		if (WPN_SOUND_FIRE[i][0]) precache_sound(WPN_SOUND_FIRE[i])
	}
	
	precache_model(BALL_MODEL)
	precache_model(PAINT_SPRITE)
	
	precache_model(KNIFE_VMODEL)
	precache_model(KNIFE_PMODEL)
	
	precache_model(NADE_VMODEL)
	precache_model(NADE_PMODEL)
	precache_model(NADE_WMODEL)
	
	g_sprBeam = precache_model("sprites/laserbeam.spr")
	
	g_sprBlood = precache_model("sprites/blood.spr")
	g_sprBloodSpray = precache_model("sprites/bloodspray.spr")
	
	// Hardcoded stuff
	precache_sound("misc/pb1.wav")
	precache_sound("misc/pb2.wav")
	precache_sound("misc/pb3.wav")
	precache_sound("misc/pb4.wav")
	
	precache_sound("weapons/scout_fire-1.wav") // def
	precache_sound("weapons/dryfire_pistol.wav") // def
	precache_sound("weapons/scout_bolt.wav") // def
	precache_sound("weapons/draw.wav")
	precache_sound("weapons/insert.wav")
	precache_sound("weapons/magin.wav")
	precache_sound("weapons/magout.wav")
	precache_sound("weapons/magrel.wav")
	precache_sound("weapons/pullout.wav")
	precache_sound("weapons/roll.wav")
}

public plugin_init()
{
	register_plugin("Paintball Mod", "1.0", "FLWL")
	
	// Events
	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")
	register_logevent("logevent_round_start",2, "1=Round_Start")
	register_event("CurWeapon", "event_CurWeapon", "be")
	register_event("AmmoX", "event_AmmoX", "be")
	
	// Forwards
	RegisterHam(Ham_Spawn, "player", "fw_SpawnPlayer_Post", true)
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamagePlayer")
	
	register_forward(FM_SetModel, "fw_SetModel")
	register_forward(FM_UpdateClientData, "fw_UpdateClientData_Post", true)
	register_forward(FM_CmdStart, "fw_CmdStart", true)
	register_forward(FM_EmitSound, "fw_EmitSound", true)
	
	RegisterHam(Ham_Weapon_Reload, "weapon_xm1014", "fw_ReloadWeapon_Post", true)
	RegisterHam(Ham_Weapon_Reload, "weapon_m3", "fw_ReloadWeapon_Post", true)
	RegisterHam(Ham_Think, "grenade", "fw_ThinkGrenade")
	RegisterHam(Ham_Player_Jump, "player", "fw_PlayerJump")
	
	register_touch("grenade", "player", "grenadeTouchPlayer")
	
	register_touch("paintball", "*", "collide")
	register_touch("paintball_explosive", "*", "explosive_collide")
	register_think("paintball", "reset")
	register_think("paintball_explosive", "reset")
	
	g_msgDeathMsg = get_user_msgid("DeathMsg")
	
	register_message(get_user_msgid("StatusIcon"), "message_StatusIcon")
	
	g_CallBack_Enabled = menu_makecallback("CallBack_Enabled")
	g_CallBack_Disabled = menu_makecallback("CallBack_Disabled")
	
	// Precreate paintball entities because creating them realtime is too expensive
	for (new i; i < SHOTS; i++)
	{
		g_paintballs[i] = create_entity("info_target")
		g_paintball_count++
	}
	
	if (g_paintball_count < 1)
	{
		set_fail_state("Can't create paintball entities")
	}
	
	g_maxplayers = get_maxplayers()
	g_bombmap = is_valid_ent(find_ent_by_class(-1, "func_bomb_target"))
}

public grenadeTouchPlayer(ent, id)
{
	if (!is_user_alive(id))
		return;
	
	static attacker
	attacker = entity_get_edict(ent, EV_ENT_owner)
	
	if (!is_user_connected(attacker) || cs_get_user_team(id) == cs_get_user_team(attacker))
		return;
	
	set_msg_block(g_msgDeathMsg, BLOCK_SET)
	ExecuteHam(Ham_TakeDamage, id, attacker, attacker, 500.0, DMG_BLAST)
	set_msg_block(g_msgDeathMsg, BLOCK_SET)
	
	message_begin(MSG_BROADCAST, g_msgDeathMsg)
	write_byte(attacker)
	write_byte(id)
	write_byte(0)
	write_string("grenade")
	message_end()
}

public plugin_cfg()
{
	set_cvar_num("sv_maxvelocity", 5000)
}

public event_round_start()
{
	g_freezetime = true;
	
	// Reset all paintballs
	for (new a = 1; a <= g_paintball_count; a++)
		if (g_paintball_status[a] != 0)
			reset(g_paintballs[a])
}

public logevent_round_start()
{
	g_freezetime = false;
}

public fw_SpawnPlayer_Post(id)
{
	if (!is_user_alive(id))
		return;
	
	entity_get_vector(id, EV_VEC_origin, g_spawnOrigin[id])
	g_spawntime[id] = get_gametime()
	
	g_unlimited_ammo[id] = false
	g_autobhop[id] = false
	set_user_gravity(id)
	
	if (!HasUserWeaponSlot(id, 2))
	{
		if (cs_get_user_team(id) == CS_TEAM_CT)
		{
			give_item(id, "weapon_usp")
			engclient_cmd(id, "weapon_knife")
			engclient_cmd(id, "weapon_usp")
		}
		else
		{
			give_item(id, "weapon_glock18")
			engclient_cmd(id, "weapon_knife")
			engclient_cmd(id, "weapon_glock18")
		}
	}
	
	if (is_user_bot(id))
	{
		static wpn
		wpn = WPN_MINIGUN //random(MAX_WEAPONS)
		
		give_item(id, WPN_ENTNAMES[wpn])
		cs_set_user_bpammo(id, WPN_CSW[wpn], WPN_BPAMMO[wpn])
	}
	
	if (access(id, ADMIN_LEVEL_H))
	{
		if (!user_has_weapon(id, CSW_HEGRENADE)) give_item(id, "weapon_hegrenade")
		if (!cs_get_user_defuse(id)) cs_set_user_defuse(id, true)
	}
	
	// Refill all guns
	refill_ammo(id)
	
	// Enable cl_lw
	client_cmd(id, "cl_lw 1; room_type 0; stopsound;")
	
	show_menu_primary(id)
}

public show_menu_primary(id)
{
	new money, canBuySomething, isVip
	money = cs_get_user_money(id)
	isVip = access(id, ADMIN_LEVEL_H)
	for (new i; i < MAX_WEAPONS; i++)
		if (WPN_TYPE[i] == PRIMARY && ((money > WPN_COST[i] && WPN_COST[i] > -1) || isVip && WPN_COST[i] == -1))
			canBuySomething = true
	
	if (!canBuySomething)
	{
		show_menu_secondary(id)
		return;
	}
	
	static menuid, menu[128], buffer[2], enabled, velocity, drop
	
	// Title
	formatex(menu, charsmax(menu), "Buy Primary Weapon\d (Osta Relv)")
	menuid = menu_create(menu, "menu_primary")
	
	// Skip option
	buffer[0] = -1
	menu_additem(menuid, "Skip --->^n", buffer)
	
	for (new wpn; wpn < MAX_WEAPONS; wpn++)
	{
		if (WPN_TYPE[wpn] != PRIMARY)
			continue;
		
		velocity = floatround(100.0 / DEFAULT_VELOCITY * WPN_VELOCITY[wpn])
		drop = floatround(WPN_GRAVITY[wpn] * 100.0)
		
		if (user_has_weapon(id, WPN_CSW[wpn]))
		{
			if (WPN_COST[wpn] == -1)
				formatex(menu, charsmax(menu), "--> %s (VIP Only) [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], velocity, drop)
			else
				formatex(menu, charsmax(menu), "--> %s ($%d) [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], WPN_COST[wpn], velocity, drop)
			
			enabled = false
		}
		else if (cs_get_user_money(id) < WPN_COST[wpn])
		{
			formatex(menu, charsmax(menu), "%s\r ($%d)\d [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], WPN_COST[wpn], velocity, drop)
			enabled = false
		}
		else if (WPN_COST[wpn] == -1 && !isVip)
		{
			formatex(menu, charsmax(menu), "%s\r (VIP Only)\d [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], velocity, drop)
			enabled = false
		}
		else
		{
			if (WPN_COST[wpn] == -1)
				formatex(menu, charsmax(menu), "%s\y (VIP Only)\d [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], velocity, drop)
			else
				formatex(menu, charsmax(menu), "%s\y ($%d)\d [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], WPN_COST[wpn], velocity, drop)
			
			enabled = true
		}
		
		buffer[0] = wpn
		menu_additem(menuid, menu, buffer, _, enabled ? g_CallBack_Enabled : g_CallBack_Disabled)
	}
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

public menu_primary(id, menuid, item)
{
	// Player disconnected?
	if (!is_user_alive(id))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	static Float:originF[3]
	entity_get_vector(id, EV_VEC_origin, originF)
	if (get_distance_f(originF, g_spawnOrigin[id]) > BUYZONE_RADIUS)
	{
		menu_destroy(menuid)
		client_print(id, print_chat, "* You have left the buyzone.")
		if (access(id, ADMIN_LEVEL_H)) show_menu_vip(id)
		return PLUGIN_HANDLED;
	}
	else if (get_gametime()-g_spawntime[id] > 10.0)
	{
		menu_destroy(menuid)
		client_print(id, print_chat, "* Buytime has expired.")
		if (access(id, ADMIN_LEVEL_H)) show_menu_vip(id)
		return PLUGIN_HANDLED;
	}
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_secondary(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve wpn
	static buffer[2], dummy, wpn
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	wpn = buffer[0]
	
	if (wpn > -1 && !user_has_weapon(id, WPN_CSW[wpn]) && cs_get_user_money(id) >= WPN_COST[wpn])
	{
		drop_weapons(id, 1)
		if (WPN_COST[wpn] > 0) cs_set_user_money(id, cs_get_user_money(id)-WPN_COST[wpn])
		
		give_item(id, WPN_ENTNAMES[wpn])
		cs_set_user_bpammo(id, WPN_CSW[wpn], WPN_BPAMMO[wpn])
		
		engclient_cmd(id, "weapon_knife")
		engclient_cmd(id, WPN_ENTNAMES[wpn])
	}
	
	menu_destroy(menuid)
	show_menu_secondary(id)
	return PLUGIN_CONTINUE;
}

public show_menu_secondary(id)
{
	new money, canBuySomething, isVip
	money = cs_get_user_money(id)
	isVip = access(id, ADMIN_LEVEL_H)
	for (new i; i < MAX_WEAPONS; i++)
		if (WPN_TYPE[i] == SECONDARY && ((money > WPN_COST[i] && WPN_COST[i] > -1) || isVip && WPN_COST[i] == -1))
			canBuySomething = true
	
	if (!canBuySomething)
	{
		show_menu_extra(id)
		return;
	}
	
	static menuid, menu[128], buffer[2], enabled, velocity, drop
	
	// Title
	formatex(menu, charsmax(menu), "Buy Secondary Weapon")
	menuid = menu_create(menu, "menu_secondary")
	
	// Skip option
	buffer[0] = -1
	menu_additem(menuid, "Skip --->^n", buffer)
	
	for (new wpn; wpn < MAX_WEAPONS; wpn++)
	{
		if (WPN_TYPE[wpn] != SECONDARY)
			continue;
		
		velocity = floatround(100.0 / DEFAULT_VELOCITY * WPN_VELOCITY[wpn])
		drop = floatround(WPN_GRAVITY[wpn] * 100.0)
		
		if (user_has_weapon(id, WPN_CSW[wpn]))
		{
			if (WPN_COST[wpn] == -1)
				formatex(menu, charsmax(menu), "--> %s (VIP Only) [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], velocity, drop)
			else
				formatex(menu, charsmax(menu), "--> %s ($%d) [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], WPN_COST[wpn], velocity, drop)
			
			enabled = false
		}
		else if (cs_get_user_money(id) < WPN_COST[wpn])
		{
			formatex(menu, charsmax(menu), "%s\r ($%d)\d [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], WPN_COST[wpn], velocity, drop)
			enabled = false
		}
		else if (WPN_COST[wpn] == -1 && !isVip)
		{
			formatex(menu, charsmax(menu), "%s\r (VIP Only)\d [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], velocity, drop)
			enabled = false
		}
		else
		{
			if (WPN_COST[wpn] == -1)
				formatex(menu, charsmax(menu), "%s\y (VIP Only)\d [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], velocity, drop)
			else
				formatex(menu, charsmax(menu), "%s\y ($%d)\d [Speed: %d%%] [Drop: %d%%]", WPN_NAME[wpn], WPN_COST[wpn], velocity, drop)
			
			enabled = true
		}
		
		buffer[0] = wpn
		menu_additem(menuid, menu, buffer, _, enabled ? g_CallBack_Enabled : g_CallBack_Disabled)
	}
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

public menu_secondary(id, menuid, item)
{
	// Player disconnected?
	if (!is_user_alive(id))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	static Float:originF[3]
	entity_get_vector(id, EV_VEC_origin, originF)
	if (get_distance_f(originF, g_spawnOrigin[id]) > BUYZONE_RADIUS)
	{
		menu_destroy(menuid)
		client_print(id, print_chat, "* You have left the buyzone.")
		if (access(id, ADMIN_LEVEL_H)) show_menu_vip(id)
		return PLUGIN_HANDLED;
	}
	else if (get_gametime()-g_spawntime[id] > 10.0)
	{
		menu_destroy(menuid)
		client_print(id, print_chat, "* Buytime has expired.")
		if (access(id, ADMIN_LEVEL_H)) show_menu_vip(id)
		return PLUGIN_HANDLED;
	}
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_extra(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve wpn
	static buffer[2], dummy, wpn
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	wpn = buffer[0]
	
	if (wpn > -1 && !user_has_weapon(id, WPN_CSW[wpn]) && cs_get_user_money(id) >= WPN_COST[wpn])
	{
		drop_weapons(id, 2)
		if (WPN_COST[wpn] > 0) cs_set_user_money(id, cs_get_user_money(id)-WPN_COST[wpn])
		
		give_item(id, WPN_ENTNAMES[wpn])
		cs_set_user_bpammo(id, WPN_CSW[wpn], WPN_BPAMMO[wpn])
		
		engclient_cmd(id, "weapon_knife")
		engclient_cmd(id, WPN_ENTNAMES[wpn])
	}
	
	menu_destroy(menuid)
	show_menu_extra(id)
	return PLUGIN_CONTINUE;
}

public show_menu_extra(id)
{
	if (cs_get_user_money(id) < 200 || user_has_weapon(id, CSW_HEGRENADE) && (!g_bombmap || cs_get_user_team(id) == CS_TEAM_T || cs_get_user_defuse(id)))
	{
		if (access(id, ADMIN_LEVEL_H)) show_menu_vip(id)
		return;
	}
	
	// Title
	static menuid, buffer[2]
	menuid = menu_create("Buy Equipment", "menu_extra")
	
	// Skip option
	buffer[0] = -1
	menu_additem(menuid, "Ready --->^n", buffer)
	
	buffer[0] = 0
	if (user_has_weapon(id, CSW_HEGRENADE))
		menu_additem(menuid, "--> Grenade ($300)", buffer, _, g_CallBack_Disabled)
	else if (cs_get_user_money(id) < 300)
		menu_additem(menuid, "Grenade\r ($300)", buffer, _, g_CallBack_Disabled)
	else
		menu_additem(menuid, "Grenade\y ($300)", buffer, _, g_CallBack_Enabled)
	
	buffer[0] = 1
	if (!g_bombmap || cs_get_user_team(id) != CS_TEAM_CT)
		menu_additem(menuid, "Defusal Kit ($200)", buffer, _, g_CallBack_Disabled)
	else if (cs_get_user_defuse(id))
		menu_additem(menuid, "--> Defusal Kit ($200)", buffer, _, g_CallBack_Disabled)
	else if (cs_get_user_money(id) < 200)
		menu_additem(menuid, "Defusal Kit\r ($200)", buffer, _, g_CallBack_Disabled)
	else
		menu_additem(menuid, "Defusal Kit\y ($200)", buffer, _, g_CallBack_Enabled)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

public menu_extra(id, menuid, item)
{
	// Player disconnected?
	if (!is_user_alive(id))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	static Float:originF[3]
	entity_get_vector(id, EV_VEC_origin, originF)
	if (get_distance_f(originF, g_spawnOrigin[id]) > BUYZONE_RADIUS)
	{
		menu_destroy(menuid)
		client_print(id, print_chat, "* You have left the buyzone.")
		if (access(id, ADMIN_LEVEL_H)) show_menu_vip(id)
		return PLUGIN_HANDLED;
	}
	else if (get_gametime()-g_spawntime[id] > 10.0)
	{
		menu_destroy(menuid)
		client_print(id, print_chat, "* Buytime has expired.")
		if (access(id, ADMIN_LEVEL_H)) show_menu_vip(id)
		return PLUGIN_HANDLED;
	}
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		if (access(id, ADMIN_LEVEL_H)) show_menu_vip(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve wpn
	static buffer[2], dummy, wpn
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	wpn = buffer[0]
	
	switch (wpn)
	{
		case 0:
		{
			if (!user_has_weapon(id, CSW_HEGRENADE) && cs_get_user_money(id) >= 300)
			{
				cs_set_user_money(id, cs_get_user_money(id) - 300)
				give_item(id, "weapon_hegrenade")
			}
		}
		case 1:
		{
			if (g_bombmap && !cs_get_user_defuse(id) && cs_get_user_team(id) == CS_TEAM_CT && cs_get_user_money(id) >= 200)
			{
				cs_set_user_money(id, cs_get_user_money(id) - 200)
				cs_set_user_defuse(id, true)
			}
		}
	}
	
	menu_destroy(menuid)
	if (wpn > -1)
		show_menu_extra(id)
	else if (access(id, ADMIN_LEVEL_H))
		show_menu_vip(id)
	
	return PLUGIN_CONTINUE;
}

public show_menu_vip(id)
{
	// Title
	static menuid, buffer[2]
	menuid = menu_create("VIP Menu", "menu_vip")
	
	buffer[0] = 0
	menu_additem(menuid, "Unlimited Ammo", buffer)
	
	buffer[0] = 1
	menu_additem(menuid, "Gravity", buffer)
	
	buffer[0] = 2
	menu_additem(menuid, "Auto Bhop", buffer)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

public menu_vip(id, menuid, item)
{
	// Player disconnected?
	if (!is_user_alive(id))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	static buffer[2], dummy, bonus
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	bonus = buffer[0]
	
	switch (bonus)
	{
		case 0: // unlimited ammo
		{
			g_unlimited_ammo[id] = true
			client_print(id, print_chat, "You chose: UNLIMITED AMMO")
		}
		case 1: // gravity
		{
			set_user_gravity(id, 0.8)
			client_print(id, print_chat, "You chose: GRAVITY")
		}
		case 2: // auto bhop
		{
			g_autobhop[id] = true
			client_print(id, print_chat, "You chose: AUTO BHOP")
		}
	}
	
	menu_destroy(menuid)
	return PLUGIN_CONTINUE;
}

public fw_EmitSound(id, channel, const sample[], Float:volume, Float:attn, flags, pitch)
{
	if (!is_user_alive(id))
		return;
	
	// Someone attacks with knife
	if (sample[8] == 'k' && sample[9] == 'n' && sample[10] == 'i')
	{
		if (sample[14] == 'h' && sample[15] == 'i' && sample[16] == 't') // hit
		{
			static Float:startPosF[3], tempPos[3], Float:endPosF[3]
			get_user_origin(id, tempPos, 1)
			IVecFVec(tempPos, startPosF)
			
			get_user_origin(id, tempPos, 3)
			IVecFVec(tempPos, endPosF)
			
			static Float:vecFromStartToEnd[3]
			xs_vec_sub(endPosF, startPosF, vecFromStartToEnd)
			
			xs_vec_mul_scalar(vecFromStartToEnd, 0.9, vecFromStartToEnd)
			
			if (vector_length(vecFromStartToEnd) > 64.0)
				return;
			
			xs_vec_add(startPosF, vecFromStartToEnd, endPosF)
			
			paintspray(endPosF, id, 3, false)
		}
	}
}

public fw_PlayerJump(id)
{
	if (!g_autobhop[id] || !is_user_alive(id))
		return;
	
	static oldbuttons
	oldbuttons = entity_get_int(id, EV_INT_oldbuttons)
	
	if (oldbuttons & IN_JUMP && entity_get_int(id, EV_INT_flags) & FL_ONGROUND)
	{
		oldbuttons &= ~IN_JUMP
		entity_set_int(id, EV_INT_oldbuttons, oldbuttons)
		entity_set_int(id, EV_INT_gaitsequence, 6)
		entity_set_float(id, EV_FL_frame, 0.0)
	}
}

public fw_ReloadWeapon_Post(ent)
{
	static id
	id = entity_get_edict(ent, EV_ENT_owner)
	
	g_lastshot[id] = get_gametime()
	
	message_begin(MSG_ONE_UNRELIABLE, SVC_WEAPONANIM, _, id)
	write_byte(3)
	write_byte(0)
	message_end()
}

// Ham Grenade Think Forward
public fw_ThinkGrenade(ent)
{
	// Invalid entity
	if (!is_valid_ent(ent))
		return HAM_IGNORED;
	
	if (entity_get_int(ent, EV_INT_oldbuttons) != 1337)
		return HAM_IGNORED;
	
	// Get damage time of grenade
	static Float:dmgtime, Float:current_time
	dmgtime = entity_get_float(ent, EV_FL_dmgtime)
	current_time = get_gametime()
	
	// Check if it's time to go off
	if (dmgtime <= current_time)
	{
		grenade_explode(ent, 150.0)
		remove_entity(ent)
		return HAM_SUPERCEDE;
	}
	
	return HAM_IGNORED;
}

grenade_explode(ent, Float:radius)
{
	static attacker, Float:originF[3], Float:targetOriginF[3], CsTeams:attackerTeam
	attacker = entity_get_edict(ent, EV_ENT_owner)
	attackerTeam = cs_get_user_team(attacker)
	entity_get_vector(ent, EV_VEC_origin, originF)
	
	if (!is_user_connected(attacker))
		return;
	
	for (new id = 1; id <= g_maxplayers; id++)
	{
		if (!is_user_alive(id) || cs_get_user_team(id) == attackerTeam)
			continue;
		
		entity_get_vector(id, EV_VEC_origin, targetOriginF)
		
		if (get_distance_f(originF, targetOriginF) > radius || !is_visible(id, ent))
			continue;
		
		set_msg_block(g_msgDeathMsg, BLOCK_SET)
		ExecuteHam(Ham_TakeDamage, id, attacker, attacker, 500.0, DMG_BLAST)
		set_msg_block(g_msgDeathMsg, BLOCK_SET)
		
		message_begin(MSG_BROADCAST, g_msgDeathMsg)
		write_byte(attacker)
		write_byte(id)
		write_byte(0)
		write_string("grenade")
		message_end()
	}
	
	paintspray(originF, attacker, 40)
	
	emit_sound(ent, CHAN_VOICE, "weapons/sg_explode.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
}

public fw_TakeDamagePlayer(id, inflictor, attacker, Float:damage, damagebits)
{
	if (!is_user_alive(attacker))
		return;
	
	if (damagebits != DMG_BLAST && get_user_weapon(attacker) == CSW_KNIFE)
	{
		SetHamParamFloat(4, 100.0)
	}
}

public event_AmmoX(id)
{
	if (!g_unlimited_ammo[id])
		return;
	
	static wpn, amount
	wpn = get_wpn(get_user_weapon(id))
	amount = read_data(2)
	
	if (wpn == -1)
		return;
	
	if (!WPN_ALLOWUNLIMITEDAMMO[wpn])
		return;
	
	if (amount < WPN_BPAMMO[wpn])
	{
		static args[1]
		args[0] = wpn
		set_task(0.1, "refill_bpammo", id, args, sizeof args)
	}
}

public refill_bpammo(args[], id)
{
	static wpn
	wpn = args[0]
	
	cs_set_user_bpammo(id, WPN_CSW[wpn], WPN_BPAMMO[wpn])
}

public event_CurWeapon(id)
{
	static model[64]
	entity_get_string(id, EV_SZ_viewmodel, model, charsmax(model))
	
	static wpn
	wpn = -1
	
	for (new i; i < MAX_WEAPONS; i++)
		if (equal(model, WPN_VMODELTOREPLACE[i]))
			wpn = i;
	
	if (wpn != -1)
	{
		//g_lastshot[id] = 0.0
		
		if (WPN_PLAYERMODEL[wpn][0])
			entity_set_string(id, EV_SZ_weaponmodel, WPN_PLAYERMODEL[wpn])
		
		if (WPN_VIEWMODEL_CT[wpn][0] && cs_get_user_team(id) == CS_TEAM_CT)
			entity_set_string(id, EV_SZ_viewmodel, WPN_VIEWMODEL_CT[wpn])
		else
			entity_set_string(id, EV_SZ_viewmodel, WPN_VIEWMODEL[wpn])
	}
	else if (equal(model, "models/v_knife.mdl"))
	{
		entity_set_string(id, EV_SZ_weaponmodel, KNIFE_PMODEL)
		entity_set_string(id, EV_SZ_viewmodel, KNIFE_VMODEL)
	}
	else if (equal(model, "models/v_hegrenade.mdl"))
	{
		entity_set_string(id, EV_SZ_weaponmodel, NADE_PMODEL)
		entity_set_string(id, EV_SZ_viewmodel, NADE_VMODEL)
	}
}

public fw_SetModel(ent, model[])
{
	// We don't care
	if (strlen(model) < 9)
		return FMRES_IGNORED;
	
	// Narrow down our matches a bit
	if (model[7] != 'w' || model[8] != '_')
		return FMRES_IGNORED;
	
	for (new i; i < MAX_WEAPONS; i++)
	{
		if (WPN_WORLDMODEL[i][0] && equal(model, WPN_WMODELTOREPLACE[i]))
		{
			entity_set_model(ent, WPN_WORLDMODEL[i])
			return FMRES_SUPERCEDE;
		}
	}
	
	if (equal(model, "models/w_hegrenade.mdl"))
	{
		if (entity_get_float(ent, EV_FL_dmgtime) == 0.0)
			return FMRES_IGNORED;
		
		entity_set_model(ent, NADE_WMODEL)
		entity_set_int(ent, EV_INT_oldbuttons, 1337)
		
		// Glow
		new r, g, b
		if (cs_get_user_team(entity_get_edict(ent, EV_ENT_owner)) == CS_TEAM_T)
			r = 255
		else
			b = 255
		
		set_rendering(ent, kRenderFxGlowShell, r, g, b, kRenderNormal, 50)
		
		// Trail
		message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
		write_byte(TE_BEAMFOLLOW)
		write_short(ent)
		write_short(g_sprBeam)
		write_byte(10)
		write_byte(10)
		write_byte(r)
		write_byte(g)
		write_byte(b)
		write_byte(255)
		message_end()
		
		return FMRES_SUPERCEDE;
	}
	
	return FMRES_IGNORED;
}

public fw_UpdateClientData_Post(id, sw, cd_handle)
{
	if (cd_handle && get_user_pbgun(id) != -1 && !is_user_bot(id))
	{
		set_cd(cd_handle, CD_ID, CSW_P90)
		
		get_cd(cd_handle, CD_flNextAttack, g_nextattack[id])
	}
}

public fw_CmdStart(id, uc_handle, seed)
{
	if (!is_user_alive(id))
		return FMRES_IGNORED;
	
	static buttons
	buttons = get_uc(uc_handle, UC_Buttons)
	
	if (buttons & IN_ATTACK)
	{
		static csw, ammo, wpn
		csw = get_user_weapon(id, ammo)
		wpn = get_wpn(csw)
		
		if (wpn == -1)
			return FMRES_IGNORED;
		
		buttons &= ~IN_ATTACK
		set_uc(uc_handle, UC_Buttons, buttons)
		
		if (!ammo || g_freezetime)
			return FMRES_IGNORED;
		
		// Weapon entity index needed for some functions
		static ent
		ent = find_ent_by_owner(1, WPN_ENTNAMES[wpn], id)
		
		static burst
		burst = cs_get_weapon_burst(ent)
		
		static canfire
		canfire = !(entity_get_int(id, EV_INT_oldbuttons) & IN_ATTACK) || WPN_IS_AUTOMATIC[wpn] || burst && wpn == WPN_GLOCK18
		
		if (!canfire)
			return FMRES_IGNORED;
		
		static Float:gametime
		gametime = get_gametime()
		
		if ((!is_user_bot(id) && g_nextattack[id] >= 0.0) || gametime - g_lastshot[id] < WPN_FIRE_RATE[wpn])
			return FMRES_IGNORED;
		
		static loss, zoom
		loss = 1
		zoom = cs_get_user_zoom(id)
		
		static fired
		if (wpn == WPN_SHOTGUN)
			fired = fire_shotgun(id, wpn)
		else if (zoom == CS_SET_NO_ZOOM && (wpn == WPN_LIGHTSNIPER || wpn == WPN_HEAVYSNIPER))
		{
			static Float:dispersion[3]
			dispersion[0] = random_float(-700.0, 700.0)
			dispersion[1] = random_float(-700.0, 700.0)
			dispersion[2] = random_float(-700.0, 700.0)
			fired = fire_normal(id, wpn, _, dispersion)
		}
		else if (burst && wpn == WPN_GLOCK18)
		{
			fired = loss = fire_burst(id, wpn, min(ammo, 2))
		}
		else if (wpn == WPN_LAUNCHER)
			fired = fire_launcher(id, wpn)
		else if (wpn == WPN_MINIGUN)
		{
			static Float:dispersion[3]
			dispersion[0] = random_float(-140.0, 140.0)
			dispersion[1] = random_float(-140.0, 140.0)
			dispersion[2] = random_float(-140.0, 140.0)
			fired = fire_normal(id, wpn, _, dispersion)
		}
		else
			fired = fire_normal(id, wpn)
		
		if (fired)
		{
			// Mark the current time
			g_lastshot[id] = burst ? gametime + 0.3 : gametime
			
			// Sound
			emit_sound(id, CHAN_VOICE, WPN_SOUND_FIRE[wpn], 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			// Decrease ammo
			cs_set_weapon_ammo(ent, ammo-loss)
			
			// Firing animation
			message_begin(MSG_ONE_UNRELIABLE, SVC_WEAPONANIM, _, id)
			write_byte(WPN_SHOOTANIM[wpn])
			write_byte(0)
			message_end()
			
			// Recoil
			//entity_set_vector(id, EV_VEC_punchangle, Float:{5.0, 0.0, 0.0})
		}
	}
	
	return FMRES_IGNORED;
}

fire_burst(id, wpn, num)
{
	new fired, Float:originOffset[3], Float:velocityOffset[3]
	for (new shot; shot < num; shot++)
	{
		originOffset[0] = random_float(-5.0, 5.0)
		originOffset[1] = random_float(-5.0, 5.0)
		originOffset[2] = shot * 5.0
		
		velocityOffset[0] = random_float(-75.0, 75.0)
		velocityOffset[1] = random_float(-75.0, 75.0)
		
		if (fire_normal(id, wpn, originOffset, velocityOffset))
			fired++
	}
	
	return fired;
}

fire_launcher(id, wpn)
{
	static Float:spread[3]
	spread[0] = random_float(-50.0, 50.0)
	spread[1] = random_float(-50.0, 50.0)
	spread[2] = random_float(-50.0, 50.0)
	
	static ent
	ent = fire_normal(id, wpn, _, spread)
	
	if (!ent)
		return false;
	
	// Change classname
	entity_set_string(ent, EV_SZ_classname, "paintball_explosive")
	entity_set_size(ent, Float:{-3.0, -3.0, -3.0}, Float:{3.0, 3.0, 3.0})
	entity_set_model(ent, NADE_WMODEL)
	
	return true;
}

public explosive_collide(ent, target)
{
	grenade_explode(ent, 150.0)
	reset(ent)
}

fire_shotgun(id, wpn)
{
	new fired, Float:originOffset[3], Float:velocityOffset[3]
	for (new shot; shot < 5; shot++)
	{
		originOffset[0] = random_float(-5.0, 5.0)
		originOffset[1] = random_float(-5.0, 5.0)
		originOffset[2] = shot * 5.0
		
		velocityOffset[0] = random_float(-150.0, 150.0)
		velocityOffset[1] = random_float(-150.0, 150.0)
		
		if (fire_normal(id, wpn, originOffset, velocityOffset))
			fired++
	}
	
	return fired;
}

fire_normal(id, wpn, Float:originOffset[3] = {0.0, 0.0, 0.0}, Float:velocityOffset[3] = {0.0, 0.0, 0.0})
{
	new a, ent
	while (a++ < g_paintball_count - 1 && !ent)
		if (g_paintball_status[a] == 0)
			ent = g_paintball_status[a] = g_paintballs[a];
	
	if (!ent)
		while (a-- > 1 && !ent)
			if (g_paintball_status[a] == 2)
				ent = g_paintball_status[a] = g_paintballs[a];
	
	if (!is_valid_ent(ent))
		return false;
	
	// General stuff
	static Float:vAngles[3], Float:nVelocity[3], Float:vOriginF[3], vOrigin[3]
	entity_set_string(ent, EV_SZ_classname, "paintball")
	entity_set_edict(ent, EV_ENT_owner, id)
	entity_set_model(ent, BALL_MODEL)
	entity_set_size(ent, Float:{-1.0, -1.0, -1.0}, Float:{1.0, 1.0, 1.0})
	entity_set_int(ent, EV_INT_skin, (cs_get_user_team(id) == CS_TEAM_T ? 0 : 1))
	entity_set_int(ent, EV_INT_iuser4, wpn)
	
	// Set origin
	get_user_origin(id, vOrigin, 1)
	IVecFVec(vOrigin, vOriginF)
	xs_vec_add(vOriginF, originOffset, vOriginF)
	entity_set_origin(ent, vOriginF)
	
	// Random angle
	vAngles[0] = random_float(-180.0, 180.0)
	vAngles[1] = random_float(-180.0, 180.0)
	entity_set_vector(ent, EV_VEC_angles, vAngles)
	
	// Used to splat the paint afterwards
	entity_get_vector(id, EV_VEC_v_angle, vAngles)
	entity_set_vector(ent, EV_VEC_v_angle, vAngles)
	entity_get_vector(id, EV_VEC_view_ofs, vAngles)
	entity_set_vector(ent, EV_VEC_view_ofs, vAngles)
	
	// Movement properties
	entity_set_int(ent, EV_INT_solid, SOLID_BBOX)
	entity_set_int(ent, EV_INT_movetype, MOVETYPE_TOSS)
	entity_set_float(ent, EV_FL_gravity, WPN_GRAVITY[wpn])
	
	// Make it visible
	entity_set_int(ent, EV_INT_effects, 0)
	
	// Move it
	velocity_by_aim(id, WPN_VELOCITY[wpn], nVelocity)
	xs_vec_add(nVelocity, velocityOffset, nVelocity)
	
	//static Float:pVel[3]
	//entity_get_vector(id, EV_VEC_velocity, pVel)
	//xs_vec_add(nVelocity, pVel, nVelocity)
	
	entity_set_vector(ent, EV_VEC_velocity, nVelocity)
	
	// Glow
	new r, g, b
	if (cs_get_user_team(id) == CS_TEAM_T)
		r = 255
	else
		b = 255
	
	set_rendering(ent, kRenderFxGlowShell, r, g, b, kRenderNormal, 50)
	
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
	write_byte(TE_BEAMFOLLOW)
	write_short(ent)
	write_short(g_sprBeam)
	write_byte(WPN_TRAIL_LIFE[wpn])
	write_byte(WPN_TRAIL_WIDTH[wpn])
	write_byte(r)
	write_byte(g)
	write_byte(b)
	write_byte(255)
	message_end()
	
	// Reset after certain time
	set_task(3.0, "reset", ent)
	
	return ent;
}

public collide(ball, target)
{
	static attacker
	attacker = entity_get_edict(ball, EV_ENT_owner)
	
	if (attacker == target)
		return;
	
	static targetAlive
	targetAlive = is_user_alive(target)
	
	if (targetAlive && cs_get_user_team(attacker) != cs_get_user_team(target) && entity_get_float(target, EV_FL_takedamage) != DAMAGE_NO)
	{
		// Enemy hit, kill him
		set_msg_block(g_msgDeathMsg, BLOCK_SET)
		ExecuteHam(Ham_TakeDamage, target, attacker, attacker, 100.0, 4098)
		set_msg_block(g_msgDeathMsg, BLOCK_NOT)
		
		message_begin(MSG_BROADCAST, g_msgDeathMsg)
		write_byte(attacker)
		write_byte(target)
		write_byte(0)
		write_string(WPN_KILLMSG[entity_get_int(ball, EV_INT_iuser4)])
		message_end()
	}
	
	// Emit sound
	static sound[64]
	formatex(sound, charsmax(sound), targetAlive ? "player/pl_pain%d.wav" : "misc/pb%d.wav", targetAlive ? random_num(4,7) : random_num(1,4))
	emit_sound(ball, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	static targetClass[32]
	entity_get_string(target, EV_SZ_classname, targetClass, charsmax(targetClass))
	
	if (!target || equali(targetClass, "func_wall")) // map itself or wall
	{
		splat(ball)
	}
	else
	{
		if (!targetAlive && entity_get_float(target, EV_FL_health) > 0.0 && !(entity_get_int(target, EV_INT_spawnflags) & SF_BREAK_TRIGGER_ONLY))
			ExecuteHam(Ham_TakeDamage, target, attacker, attacker, 30.0, 0)
		
		if (is_user_connected(attacker))
		{
			static Float:originF[3]
			entity_get_vector(ball, EV_VEC_origin, originF)
			paintspray(originF, attacker, 7, false)
		}
		reset(ball)
	}
}

public splat(ent)
{
	static Float:origin[3], Float:nOrigin[3], Float:viewOfs[3], Float:angles[3], Float:normal[3], Float:aiming[3]
	entity_get_vector(ent, EV_VEC_origin, origin)
	entity_get_vector(ent, EV_VEC_view_ofs, viewOfs)
	entity_get_vector(ent, EV_VEC_v_angle, angles)
	
	// Throw some paint into air
	static owner
	owner = entity_get_edict(ent, EV_ENT_owner)
	if (is_user_connected(owner)) paintspray(origin, owner, 7, false)
	
	nOrigin[0] = origin[0] + viewOfs[0]
	nOrigin[1] = origin[1] + viewOfs[1]
	nOrigin[2] = origin[2] + viewOfs[2]
	aiming[0] = nOrigin[0] + floatcos(angles[1], degrees) * 1000.0
	aiming[1] = nOrigin[1] + floatsin(angles[1], degrees) * 1000.0
	aiming[2] = nOrigin[2] + floatsin(-angles[0], degrees) * 1000.0
	
	new trace
	engfunc(EngFunc_TraceLine, nOrigin, aiming, 0, ent, trace)
	get_tr2(trace, TR_vecPlaneNormal, normal)
	
	vector_to_angle(normal, angles)
	angles[1] += 180.0
	if (angles[1] >= 360.0) angles[1] -= 360.0
	entity_set_vector(ent, EV_VEC_angles, angles)
	
	origin[0] += (normal[0] * random_float(0.3, 2.7))
	origin[1] += (normal[1] * random_float(0.3, 2.7))
	origin[2] += (normal[2] * random_float(0.3, 2.7))
	entity_set_origin(ent, origin)
	
	// Convert ball to paint
	entity_set_string(ent, EV_SZ_classname, "paint")
	entity_set_int(ent, EV_INT_movetype, MOVETYPE_NONE)
	entity_set_int(ent, EV_INT_solid, SOLID_NOT)
	entity_set_model(ent, PAINT_SPRITE)
	
	// Set random splatter
	static skin
	skin = entity_get_int(ent, EV_INT_skin)
	entity_set_float(ent, EV_FL_frame, float(random_num((skin * 18), (skin * 18)+17)))
	
	// Mark as paint
	new a, findpb
	while (a++ < g_paintball_count && !findpb)
		if (g_paintballs[a] == ent)
			findpb = g_paintball_status[a] = 2;
	
	// Reset rendering
	set_rendering(ent)
}

public reset(ent)
{
	// Mark this ball as available
	new a, findpb = 1
	while (a++ <= g_paintball_count && findpb)
		if (g_paintballs[a] == ent)
			findpb = g_paintball_status[a] = 0;
	
	// Make the ball invisible and prevent it from moving
	engfunc(EngFunc_SetOrigin, ent, Float:{-8000.0, -8000.0, -8000.0})
	entity_set_vector(ent, EV_VEC_velocity, Float:{0.0, 0.0, 0.0})
	entity_set_int(ent, EV_INT_effects, EF_NODRAW)
	entity_set_int(ent, EV_INT_solid, SOLID_NOT)
	entity_set_int(ent, EV_INT_movetype, MOVETYPE_NONE)
	set_rendering(ent)
}

paintspray(Float:originF[3], id, count, compensate = true)
{
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
	write_byte(TE_BLOODSPRITE)
	engfunc(EngFunc_WriteCoord, originF[0])
	engfunc(EngFunc_WriteCoord, originF[1])
	engfunc(EngFunc_WriteCoord, originF[2]+(compensate ? 20.0 : 0.0))
	write_short(g_sprBloodSpray)
	write_short(g_sprBlood)
	write_byte(cs_get_user_team(id) == CS_TEAM_CT ? 208 : 247)
	write_byte(count)
	message_end()
}

// Block buyzone
public message_StatusIcon(msg_id, msg_dest, msg_entity)
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

refill_ammo(id)
{
	for (new wpn; wpn < MAX_WEAPONS; wpn++)
	{
		if (!user_has_weapon(id, WPN_CSW[wpn]))
			continue;
		
		cs_set_user_bpammo(id, WPN_CSW[wpn], WPN_BPAMMO[wpn])
		cs_set_weapon_ammo(find_ent_by_owner(1, WPN_ENTNAMES[wpn], id), WPN_CLIP[wpn])
	}
}

public CallBack_Enabled() return ITEM_ENABLED;
public CallBack_Disabled() return ITEM_DISABLED;

stock get_wpn(weapon_id)
{
	switch (weapon_id)
	{
		case CSW_GLOCK18: return WPN_GLOCK18;
		case CSW_USP: return WPN_USP;
		case CSW_P228: return WPN_P228;
		case CSW_MP5NAVY: return WPN_MARKER;
		case CSW_TMP: return WPN_SMG;
		case CSW_XM1014: return WPN_SHOTGUN;
		case CSW_SCOUT: return WPN_LIGHTSNIPER;
		case CSW_AWP: return WPN_HEAVYSNIPER;
		
		case CSW_M3: return WPN_LAUNCHER;
		case CSW_M249: return WPN_MINIGUN;
	}
	
	return -1;
}

stock get_user_pbgun(id)
{
	return get_wpn(get_user_weapon(id));
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

stock HasUserWeaponSlot(id, slot)
{
	static const m_rgpPlayerItems_CBasePlayer[6] = {367,368,...}
	return get_pdata_cbase(id, m_rgpPlayerItems_CBasePlayer[slot]) > 0;
}
