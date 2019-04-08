#include <amxmodx>
#include <hamsandwich>
#include <fakemeta>
#include <cstrike>
#include <engine>
#include <fun>

// Sprites
new const sprite_smoke[] = "sprites/smoke.spr";
new const sprite_shockwave[] = "sprites/shockwave.spr";

// Models
new const model_glassgibs[] = "models/glassgibs.mdl"

// Sounds
new const sound_frostnova[] = "warcraft3/frostnova.wav";
new const sound_impalehit[] = "warcraft3/impalehit.wav";
new const sound_impalelaunch1[] = "warcraft3/impalelaunch1.wav";

const BREAK_GLASS = 0x01
const FFADE_IN = 0x0000
const FFADE_STAYOUT = 0x0004
const UNIT_SECOND = (1<<12)

// HACK: pev_ field used to store custom nade types and their values
const PEV_NADE_TYPE = pev_flTimeStepSound
const NADE_TYPE_FROST = 1111

const SCORE_ATTRIB_VIP = (1<<2)
const HIDE_MONEY = (1<<5)

const m_LastHitGroup = 75

// CS player PData offsets (win32)
const OFFSET_CSTEAMS = 114

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds

// CS Teams
enum
{
	FM_CS_TEAM_UNASSIGNED = 0,
	FM_CS_TEAM_T,
	FM_CS_TEAM_CT,
	FM_CS_TEAM_SPECTATOR
}

enum (+= 100)
{
	TASK_MONEY = 2000,
	TASK_FREEZE
}

new g_sprSmoke, g_sprShockwave, g_mdlGlassgibs

// Message IDs
new g_msgHideWeapon, g_msgCrosshair, g_msgScreenFade, g_msgDamage

// Player vars
new g_frozen[33]

// Global vars
new g_maxplayers
new g_hudsync1

#define is_user_valid_connected(%1) (1 <= %1 <= g_maxplayers && is_user_connected(%1))
#define is_user_valid_alive(%1) (1 <= %1 <= g_maxplayers && is_user_alive(%1))

public plugin_precache()
{
	// Precache sprites
	g_sprSmoke = engfunc(EngFunc_PrecacheModel, sprite_smoke)
	g_sprShockwave = engfunc(EngFunc_PrecacheModel, sprite_shockwave)
	
	// Precache models
	g_mdlGlassgibs = engfunc(EngFunc_PrecacheModel, model_glassgibs)
	
	// Precache sounds
	engfunc(EngFunc_PrecacheSound, sound_frostnova)
	engfunc(EngFunc_PrecacheSound, sound_impalehit)
	engfunc(EngFunc_PrecacheSound, sound_impalelaunch1)
}

public plugin_init()
{
	register_plugin("Deathmatch VIP", "1.1", "FLWL")
	
	// Events
	register_event("DeathMsg", "event_death", "a")
	register_event("Damage", "event_showdamage", "b", "2!0", "3=0", "4!0")
	
	// HAM forwards
	RegisterHam(Ham_Spawn, "player", "fw_SpawnPlayer_Post", 1)
	RegisterHam(Ham_Think, "grenade", "fw_ThinkGrenade")
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamagePlayer")
	
	// FM forwards
	register_forward(FM_SetModel, "fw_SetModel")
	register_forward(FM_PlayerPreThink, "fw_PlayerPreThink")
	
	// Message IDs
	g_msgHideWeapon = get_user_msgid("HideWeapon")
	g_msgCrosshair = get_user_msgid("Crosshair")
	g_msgScreenFade = get_user_msgid("ScreenFade")
	g_msgDamage = get_user_msgid("Damage")
	
	// Messages
	register_message(get_user_msgid("ScoreAttrib"), "message_score_attrib")
	
	// Misc
	g_maxplayers = get_maxplayers()
	g_hudsync1 = CreateHudSyncObj()
	
	// Remove some entities
	remove_entity_name("game_text")
	remove_entity_name("game_player_equip")
}

public fw_SpawnPlayer_Post(id)
{
	g_frozen[id] = false
	
	set_task(0.4, "task_hide_money", id + TASK_MONEY)
}

// Forward Player PreThink
public fw_PlayerPreThink(id)
{
	// Not alive
	if (!is_user_alive(id))
		return;
	
	if (g_frozen[id])
	{
		set_pev(id, pev_velocity, Float:{0.0, 0.0, 0.0}) // stop motion
		set_pev(id, pev_maxspeed, 1.0) // prevent from moving
	}
}

// Ham Take Damage Forward
public fw_TakeDamagePlayer(victim, inflictor, attacker, Float:damage, damage_type)
{
	if (g_frozen[victim])
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Forward Set Model
public fw_SetModel(entity, const model[])
{
	// We don't care
	if (strlen(model) < 8 || model[7] != 'w' || model[8] != '_')
		return;
	
	// Get damage time of grenade
	static Float:dmgtime
	pev(entity, pev_dmgtime, dmgtime)
	
	// Grenade not yet thrown
	if (dmgtime == 0.0)
		return;
	
	if (model[9] == 'h' && model[10] == 'e') // HE Grenade
	{
		// Give it a glow
		fm_set_rendering(entity, kRenderFxGlowShell, 200, 0, 0, kRenderNormal, 16)
		
		// And a colored trail
		message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
		write_byte(TE_BEAMFOLLOW) // TE id
		write_short(entity) // entity
		write_short(g_sprSmoke) // sprite
		write_byte(10) // life
		write_byte(10) // width
		write_byte(200) // r
		write_byte(0) // g
		write_byte(0) // b
		write_byte(200) // brightness
		message_end()
	}
	else if (model[9] == 'f' && model[10] == 'l') // Flashbang
	{
		// Give it a glow
		fm_set_rendering(entity, kRenderFxGlowShell, 255, 255, 255, kRenderNormal, 16);
		
		// And a colored trail
		message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
		write_byte(TE_BEAMFOLLOW) // TE id
		write_short(entity) // entity
		write_short(g_sprSmoke) // sprite
		write_byte(10) // life
		write_byte(10) // width
		write_byte(255) // r
		write_byte(255) // g
		write_byte(255) // b
		write_byte(200) // brightness
		message_end()
	}
	else if (model[9] == 's' && model[10] == 'm') // Frost Grenade
	{
		// Give it a glow
		fm_set_rendering(entity, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 16);
		
		// And a colored trail
		message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
		write_byte(TE_BEAMFOLLOW) // TE id
		write_short(entity) // entity
		write_short(g_sprSmoke) // sprite
		write_byte(10) // life
		write_byte(10) // width
		write_byte(0) // r
		write_byte(100) // g
		write_byte(200) // b
		write_byte(200) // brightness
		message_end()
		
		// Set grenade type on the thrown grenade entity
		set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_FROST)
	}
}

// Ham Grenade Think Forward
public fw_ThinkGrenade(entity)
{
	// Invalid entity
	if (!pev_valid(entity))
		return HAM_IGNORED;
	
	// Get damage time of grenade
	static Float:dmgtime, Float:current_time
	pev(entity, pev_dmgtime, dmgtime)
	current_time = get_gametime()
	
	// Check if it's time to go off
	if (dmgtime > current_time)
		return HAM_IGNORED;
	
	// Check if it's one of our custom nades
	switch (pev(entity, PEV_NADE_TYPE))
	{
		case NADE_TYPE_FROST: // Frost Grenade
		{
			// Frost grenade explosion
			frost_explode(entity)
			return HAM_SUPERCEDE;
		}
	}
	
	return HAM_IGNORED;
}

public event_showdamage(victim)
{
	static attacker, damage
	attacker = get_user_attacker(victim)
	damage = read_data(2)
	
	if (victim == attacker || !is_user_valid_connected(attacker) || !(get_user_flags(attacker) & ADMIN_LEVEL_H) || damage <= 0)
		return;
	
	static hitzone, red, green, blue
	hitzone = get_pdata_int(victim, m_LastHitGroup)
	
	if (hitzone == HIT_HEAD)
	{
		red = 200
		green = 0
		blue = 0
	}
	else
	{
		red = 50
		green = 205
		blue = 50
	}
	
	set_hudmessage(red, green, blue, -1.0, 0.55, 2, 0.1, 2.0, 0.02, 0.02, -1)
	ShowSyncHudMsg(attacker, g_hudsync1, "%d", damage)
}

public event_death(id)
{
	static killer
	killer = read_data(1)
	
	if (killer == id || !is_user_connected(killer))
		return;
	
	if (!(get_user_flags(killer) & ADMIN_LEVEL_H))
		return;
	
	static hpadd
	
	if ((read_data(3) == 1) && (read_data(5) == 0))
		hpadd = 30
	else
		hpadd = 15
	
	static killerhp, killerap
	killerhp = get_user_health(killer)
	killerap = get_user_armor(killer)
	killerhp += hpadd
	killerap += hpadd
	
	if (killerhp > 999)
		killerhp = 999
	
	if (killerap > 999)
		killerap = 999
	
	set_user_health(killer, killerhp)
	set_user_armor(killer, killerap)
}

// Show VIP status on scoreboard
public message_score_attrib(const msgid, const msgtype, const msgdest)
{
	if ((get_user_flags(get_msg_arg_int(1)) & ADMIN_LEVEL_H) && !get_msg_arg_int(2))
		set_msg_arg_int(2, ARG_BYTE, SCORE_ATTRIB_VIP)
}

public task_hide_money(taskid)
{
	static id
	id = taskid - TASK_MONEY
	
	if (!is_user_alive(id))
		return;
	
	// Hide money
	message_begin(MSG_ONE, g_msgHideWeapon, _, id)
	write_byte(HIDE_MONEY) // what to hide bitsum
	message_end()
	
	// Hide the HL crosshair that's drawn
	message_begin(MSG_ONE, g_msgCrosshair, _, id)
	write_byte(0) // toggle
	message_end()
}

// Frost Grenade Explosion
frost_explode(ent)
{
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Make the explosion
	create_blast3(originF)
	
	// Frost nade explode sound
	emit_sound(ent, CHAN_WEAPON, sound_frostnova, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	// Collisions
	static victim
	victim = -1
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, 240.0)) != 0)
	{
		if (!is_user_valid_alive(victim) || fm_cs_get_user_team(victim) != FM_CS_TEAM_CT || g_frozen[victim])
			continue;
		
		message_begin(MSG_ONE_UNRELIABLE, g_msgDamage, _, victim)
		write_byte(0) // damage save
		write_byte(0) // damage take
		write_long(DMG_DROWN) // damage type - DMG_FREEZE
		write_coord(0) // x
		write_coord(0) // y
		write_coord(0) // z
		message_end()
		
		// Light blue glow while frozen
		set_user_rendering(victim, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 25)
		
		// Freeze sound
		emit_sound(victim, CHAN_BODY, sound_impalehit, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Add a blue tint to their screen
		message_begin(MSG_ONE, g_msgScreenFade, _, victim)
		write_short(0) // duration
		write_short(0) // hold time
		write_short(FFADE_STAYOUT) // fade type
		write_byte(0) // red
		write_byte(50) // green
		write_byte(200) // blue
		write_byte(100) // alpha
		message_end()
		
		// Prevent from jumping
		if (pev(victim, pev_flags) & FL_ONGROUND)
			set_pev(victim, pev_gravity, 999999.9) // set really high
		else
			set_pev(victim, pev_gravity, 0.000001) // no gravity
		
		// Set a task to remove the freeze
		g_frozen[victim] = true;
		set_task(3.0, "task_remove_freeze", victim + TASK_FREEZE)
	}
	
	// Get rid of the grenade
	engfunc(EngFunc_RemoveEntity, ent)
}

// Frost Grenade: Freeze Blast
create_blast3(const Float:originF[3])
{
	// Smallest ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+385.0) // z axis
	write_short(g_sprShockwave) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(0) // red
	write_byte(100) // green
	write_byte(200) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Medium ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+470.0) // z axis
	write_short(g_sprShockwave) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(0) // red
	write_byte(100) // green
	write_byte(200) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Largest ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+555.0) // z axis
	write_short(g_sprShockwave) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(0) // red
	write_byte(100) // green
	write_byte(200) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
}

// Remove freeze task
public task_remove_freeze(taskid)
{
	static id
	id = taskid - TASK_FREEZE
	
	// Not alive or not frozen anymore
	if (!is_user_alive(id) || !g_frozen[id])
		return;
	
	// Unfreeze
	g_frozen[id] = false;
	
	// Restore gravity
	set_pev(id, pev_gravity, 1.0)
	
	// Restore maxspeed
	set_user_maxspeed(id, 250.0)
	
	// Restore rendering
	set_user_rendering(id)
	
	// Gradually remove screen's blue tint
	message_begin(MSG_ONE, g_msgScreenFade, _, id)
	write_short(UNIT_SECOND) // duration
	write_short(0) // hold time
	write_short(FFADE_IN) // fade type
	write_byte(0) // red
	write_byte(50) // green
	write_byte(200) // blue
	write_byte(100) // alpha
	message_end()
	
	// Broken glass sound
	emit_sound(id, CHAN_BODY, sound_impalelaunch1, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	// Get player's origin
	static origin2[3]
	get_user_origin(id, origin2)
	
	// Glass shatter
	message_begin(MSG_PVS, SVC_TEMPENTITY, origin2)
	write_byte(TE_BREAKMODEL) // TE id
	write_coord(origin2[0]) // x
	write_coord(origin2[1]) // y
	write_coord(origin2[2]+24) // z
	write_coord(16) // size x
	write_coord(16) // size y
	write_coord(16) // size z
	write_coord(random_num(-50, 50)) // velocity x
	write_coord(random_num(-50, 50)) // velocity y
	write_coord(25) // velocity z
	write_byte(10) // random velocity
	write_short(g_mdlGlassgibs) // model
	write_byte(10) // count
	write_byte(25) // life
	write_byte(BREAK_GLASS) // flags
	message_end()
}

// Get User Team
stock fm_cs_get_user_team(id)
{
	return get_pdata_int(id, OFFSET_CSTEAMS, OFFSET_LINUX);
}

// Set entity's rendering type (from fakemeta_util)
stock fm_set_rendering(entity, fx = kRenderFxNone, r = 255, g = 255, b = 255, render = kRenderNormal, amount = 16)
{
	static Float:color[3]
	color[0] = float(r)
	color[1] = float(g)
	color[2] = float(b)
	
	set_pev(entity, pev_renderfx, fx)
	set_pev(entity, pev_rendercolor, color)
	set_pev(entity, pev_rendermode, render)
	set_pev(entity, pev_renderamt, float(amount))
}
