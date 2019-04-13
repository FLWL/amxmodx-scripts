#include <amxmodx>
#include <hamsandwich>
#include <fakemeta>
#include <engine>
#include <zombieplague_xp>
#include <xs>

new const VMODEL[] = "models/fzm/v_ak47launcher.mdl"
new const VMODEL2[] = "models/fzm/v_ak47launcher2.mdl"
new const WMODEL[] = "models/fzm/w_ak47launcher.mdl"
new const PMODEL[] = "models/fzm/p_ak47launcher.mdl"
new const GRENADE_MODEL[] = "models/fzm/s_grenade.mdl"
const Float:NADE_EXPLOSION_RADIUS = 400.0
const Float:NADE_EXPLOSION_DAMAGE = 1500.0

// CS Weapon CBase Offsets (win32)
const m_flNextPrimaryAttack = 46
const m_fInReload = 54

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds
const OFFSET_LINUX_WEAPONS = 4 // weapon offsets are only 4 steps higher on Linux
const m_flNextPrimaryAttack = 46

const UNIT_SECOND = (1<<12)
const DMG_HEGRENADE = (1<<24)
const FFADE_IN = 0x0000
enum _:Coord_e { Float:x, Float:y, Float:z };
#define VectorAdd(%0,%1,%2)    ( %2[ x ] = %0[ x ] + %1[ x ], %2[ y ] = %0[ y ] + %1[ y ], %2[ z ] = %0[ z ] + %1[ z ] )
#define is_user_valid_alive(%1) (1 <= %1 <= g_maxplayers && is_user_alive(%1))

const PEV_MODE = pev_iuser1
const PEV_SWITCHING = pev_iuser2
const PEV_BPAMMO = pev_iuser4

new g_maxplayers
new g_sprTrail, g_sprSmoke, g_sprExplo
new g_msgScreenFade, g_msgScreenShake
new g_extra_ammo

public plugin_precache()
{
	// Precache models
	precache_model(VMODEL)
	precache_model(VMODEL2)
	precache_model(WMODEL)
	precache_model(PMODEL)
	precache_model(GRENADE_MODEL)
	
	g_sprTrail = precache_model("sprites/smoke.spr")
	g_sprSmoke = precache_model("sprites/steam1.spr")
	g_sprExplo = precache_model("sprites/fexplo.spr")
}

public plugin_init()
{
	register_plugin("[ZP] Weapon: AK-47 Grenadier", "1.0", "FLWL")
	
	RegisterHam(Ham_Spawn, "player", "fw_SpawnPlayer_Post", 1)
	RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_ak47", "fw_PrimaryAttack")
	RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_ak47", "fw_PrimaryAttack_Post", 1)
	
	register_forward(FM_SetModel, "fw_SetModel")
	register_forward(FM_CmdStart, "fw_CmdStart")
	
	register_think("weapon_ak47", "think_ak47")
	
	register_touch("glnade", "*", "touch")
	
	g_msgScreenShake = get_user_msgid("ScreenShake")
	g_msgScreenFade = get_user_msgid("ScreenFade")
	
	g_extra_ammo = zp_register_extra_item("GP-25 Grenadier Ammo", 7, ZP_TEAM_HUMAN)
	
	g_maxplayers = get_maxplayers()
}

public zp_extra_item_selected(id, itemid)
{
	if (itemid != g_extra_ammo)
		return 0;
	
	// Check if player has ak47
	static ent
	ent = find_ent_by_owner(g_maxplayers+1, "weapon_ak47", id)
	if (!is_valid_ent(ent))
	{
		zp_colored_print(id, "^4[ZP]^1 You must own^4 AK-47 Grenadier^1 in order to buy this item.")
		return ZP_PLUGIN_HANDLED;
	}
	
	// add nades
	set_pev(ent, PEV_BPAMMO, pev(ent, PEV_BPAMMO) + 5)
	
	/*
	if (get_user_weapon(id) == CSW_AK47)
	{
		message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoX, _, id)
		write_byte(2)
		write_byte(pev(ent, PEV_BPAMMO))
		message_end()
	}
	*/
	
	return 0;
}

public fw_SpawnPlayer_Post(id)
{
	if (!is_user_alive(id))
		return;
	
	// Check if player has ak47
	static ent
	ent = find_ent_by_owner(id, "weapon_ak47", id)
	if (is_valid_ent(id)) return;
	
	// add nades
	set_pev(ent, PEV_BPAMMO, 5)
}

launch(id)
{
	if (get_user_weapon(id) != CSW_AK47)
		return;
	
	new glnade = create_entity("info_target")
	if (!glnade) return;
	set_pev(glnade, pev_classname, "glnade")
	engfunc(EngFunc_SetModel, glnade, GRENADE_MODEL)

	// Origin
	static Float:origin [ 3 ], Float:angle [ 3 ]
	engfunc ( EngFunc_GetAttachment, id, 0, origin, angle )
	entity_set_origin ( glnade, origin )
	
	// Size
	engfunc ( EngFunc_SetSize, glnade, Float:{ 0.0, 0.0, 0.0 }, Float:{ 0.0, 0.0, 0.0 } )
	
	// Interaction
	entity_set_int ( glnade, EV_INT_solid, SOLID_BBOX )
	
	// Movetype
	entity_set_int ( glnade, EV_INT_movetype, MOVETYPE_TOSS )
	
	// Owner
	entity_set_edict ( glnade, EV_ENT_owner, id )
	
	// Velocity
	static Float:fVelocity [ 3 ]
	VelocityByAim( id, 1500, fVelocity )
	
	// Add player velocity to nades velocity
	static Float:fPlayerVelocity[3]
	pev(id, pev_velocity, fPlayerVelocity)
	xs_vec_add(fVelocity, fPlayerVelocity, fVelocity)
	
	// Velocity
	entity_set_vector ( glnade, EV_VEC_velocity, fVelocity )
	
	// Angles
	static Float:flAngle [ 3 ]
	engfunc ( EngFunc_VecToAngles, fVelocity, flAngle )
	entity_set_vector ( glnade, EV_VEC_angles, flAngle )
	
	// Trail
	message_begin ( MSG_BROADCAST, SVC_TEMPENTITY )
	write_byte(TE_BEAMFOLLOW) // Temporary entity ID
	write_short(glnade) // Entity
	write_short( g_sprTrail ) // Sprite index
	write_byte(10) // Life
	write_byte(3) // Line width
	write_byte(200) // Red
	write_byte(200) // Green
	write_byte(200) // Blue
	write_byte(200) // Alpha
	message_end() 
}

public touch(ent)
{
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Effects
	create_blast(originF)
	
	// Collisions
	static victim, attacker
	victim = -1
	attacker = pev(ent, pev_owner)
	
	// Calculation specific vars
	static Float:adjustedDamage, Float:victimOriginF[3], Float:distance, duration
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, NADE_EXPLOSION_RADIUS)) != 0)
	{
		// Only affect alive zombies
		if (!is_user_valid_alive(victim))
			continue;
		
		// Get victim's origin
		pev(victim, pev_origin, victimOriginF)
		
		// Calculate distance between grenade and victim
		distance = get_distance_f(originF, victimOriginF)
		
		// Calculate screenshake / screenfade duration
		duration = floatround(GetRadiusDamageF(NADE_EXPLOSION_RADIUS, UNIT_SECOND * 1.0, distance), floatround_ceil)
		
		// Screenshake
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, victim)
		write_short(floatround(GetRadiusDamageF(NADE_EXPLOSION_RADIUS, UNIT_SECOND * 6.0, distance), floatround_ceil)) // amplitude
		write_short(duration) // duration
		write_short(UNIT_SECOND * 10) // frequency
		message_end()
		
		// Explosion can't see victim
		if (!is_visible(victim, ent))
			continue;
		
		// Gradually remove screen's red tint
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenFade, _, victim)
		write_short(duration) // duration
		write_short(0) // hold time
		write_short(FFADE_IN) // fade type
		write_byte(random_num(200, 250)) // red
		write_byte(random_num(0, 25)) // green
		write_byte(random_num(0, 25)) // blue
		write_byte(floatround(GetRadiusDamageF(NADE_EXPLOSION_RADIUS, 200.0, distance), floatround_ceil)) // alpha
		message_end()
		
		// Victim should not take damage
		if (!zp_get_user_zombie(victim))
			continue;
		
		// Calculate damage
		adjustedDamage = GetRadiusDamageF(NADE_EXPLOSION_RADIUS, NADE_EXPLOSION_DAMAGE, distance)
		
		// Actually take damage
		if (adjustedDamage) zp_takedamage(victim, attacker, "grenadier", adjustedDamage, DMG_HEGRENADE, true)
	}
	
	engfunc(EngFunc_RemoveEntity, ent)
}

// Explosive Blast
create_blast(Float:originF[3])
{
	// create effect exp
	engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_EXPLOSION)
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	write_short(g_sprExplo) // sprites
	write_byte(15) // scale in 0.1's
	write_byte(30) // framerate
	write_byte(TE_EXPLFLAG_NONE) // flags
	message_end() // message end
	
	// Smoke
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_SMOKE)
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	write_short(g_sprSmoke)
	write_byte(15)
	write_byte(5)
	message_end()
}

stock msg_beam_follow(ent, r, g, b, iBullet = 0)
{
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
	write_byte(TE_BEAMFOLLOW)
	write_short(ent)
	write_short(g_sprTrail)
	write_byte(iBullet ? 3 : 5)
	write_byte(iBullet ? 2 : 3)
	write_byte(r)
	write_byte(g)
	write_byte(b)
	write_byte(iBullet ? 100 : 150)
	message_end()
}

// delay
public fw_PrimaryAttack(ent)
{
	if (pev(ent, PEV_MODE))
	{
		static bpammo, owner
		bpammo = pev(ent, PEV_BPAMMO)
		owner = pev(ent, pev_owner)
		
		if (bpammo)
		{
			set_pev(ent, PEV_BPAMMO, bpammo - 1)
			launch(owner)
			
			if (bpammo == 1)
			{
				set_user_weaponanim(owner, 8)
				set_pdata_float(ent, m_flNextPrimaryAttack, 0.7, OFFSET_LINUX_WEAPONS)
			}
			else
			{
				set_pdata_float(ent, m_flNextPrimaryAttack, 2.8, OFFSET_LINUX_WEAPONS)
			}
		}
		
		return HAM_SUPERCEDE;
	}
	
	return HAM_IGNORED;
}

public fw_PrimaryAttack_Post(ent)
{
	if (pev(ent, PEV_MODE))
	{
		set_pdata_float(ent, m_flNextPrimaryAttack, 2.8, OFFSET_LINUX_WEAPONS)
	}
}

public fw_SetModel(ent, const model[])
{
	if (equal(model, "models/w_ak47.mdl"))
	{
		engfunc(EngFunc_SetModel, ent, WMODEL)
		return FMRES_SUPERCEDE;
	}
	
	return FMRES_IGNORED;
}

public fw_CmdStart(id, handle)
{
	if (!is_user_alive(id))
		return;
	
	if (get_user_weapon(id) != CSW_AK47)
		return;
	
	static ent
	ent = find_ent_by_owner(-1, "weapon_ak47", id)
	if (!is_valid_ent(ent)) return;
	if (!pev(ent, PEV_MODE) && !pev(ent, PEV_BPAMMO)) return;
	
	if (pev(ent, PEV_MODE) && !pev(ent, PEV_SWITCHING) && !pev(ent, PEV_BPAMMO) && get_pdata_float(ent, m_flNextPrimaryAttack, OFFSET_LINUX_WEAPONS) <= 0.0)
	{
		set_pev(ent, PEV_SWITCHING, 1)
		set_user_weaponanim(id, 6)
		
		set_pdata_float(ent, m_flNextPrimaryAttack, 1.5, OFFSET_LINUX_WEAPONS)
		set_pev(ent, pev_nextthink, get_gametime()+1.5)
		return;
	}
	
	static buttons, oldbuttons
	buttons = get_uc(handle, UC_Buttons)
	oldbuttons = pev(id, pev_oldbuttons)
	
	if (buttons & IN_ATTACK2 && !(oldbuttons & IN_ATTACK2)) // started pressing ATTACK2
	{
		// start switching animation
		if (get_pdata_float(ent, m_flNextPrimaryAttack, OFFSET_LINUX_WEAPONS) == -1.0)
		{
			set_pev(ent, PEV_SWITCHING, 1)
			set_user_weaponanim(id, 6)
			
			set_pdata_float(ent, m_flNextPrimaryAttack, 1.5, OFFSET_LINUX_WEAPONS)
			set_pev(ent, pev_nextthink, get_gametime()+1.5)
		}
	}
}

public think_ak47(ent)
{
	static id
	id = pev(ent, pev_owner)
	
	if (!(1 <= id <= g_maxplayers) || !is_user_alive(id) || get_user_weapon(id) != CSW_AK47)
		return;
	
	if (pev(ent, PEV_SWITCHING))
	{
		set_pev(ent, PEV_SWITCHING, 0)
		
		if (pev(ent, PEV_MODE))
		{
			set_pev(ent, PEV_MODE, 0)
			set_pev(id, pev_viewmodel2, VMODEL)
			set_user_weaponanim(id, 0)
		}
		else
		{
			set_pev(ent, PEV_MODE, 1)
			set_pev(id, pev_viewmodel2, VMODEL2)
			set_user_weaponanim(id, 0)
		}
	}
}

public zp_replace_weapon_models(id, wpn)
{
	if (wpn != CSW_AK47)
		return;
	
	if (pev(find_ent_by_owner(-1, "weapon_ak47", id), PEV_MODE))
		set_pev(id, pev_viewmodel2, VMODEL2)
	else
		set_pev(id, pev_viewmodel2, VMODEL)
	
	set_pev(id, pev_weaponmodel2, PMODEL)
}

stock set_user_weaponanim(id, anim)
{
	if (!is_user_connected(id))
		return false;
	
	set_pev(id, pev_weaponanim, anim)
	message_begin(MSG_ONE, SVC_WEAPONANIM, _, id)
	write_byte(anim)
	write_byte(pev(id, pev_body))
	message_end()
	
	return true;
}

stock Float:GetRadiusDamageF(Float:radius, Float:damage, Float:distance)
{
	static Float:adjustedDamage
	adjustedDamage = distance * (radius ? floatdiv(damage, radius) : 1.0)
	adjustedDamage = damage - adjustedDamage
	
	return (adjustedDamage > 0.0) ? adjustedDamage : 0.0;
}

// Prints a colored message to target (use 0 for everyone), supports ML formatting.
// Note: I still need to make something like gungame's LANG_PLAYER_C to avoid unintended
// argument replacement when a function passes -1 (it will be considered a LANG_PLAYER)
stock zp_colored_print(target, const message[], any:...)
{
	static buffer[512], i, argscount
	argscount = numargs()
	
	// Send to everyone
	if (!target)
	{
		static player
		for (player = 1; player <= get_maxplayers(); player++)
		{
			// Not connected
			if (!is_user_connected(player))
				continue;
			
			// Remember changed arguments
			static changed[5], changedcount // [5] = max LANG_PLAYER occurencies
			changedcount = 0
			
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
			
			// Send it
			message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, player)
			write_byte(player)
			write_string(buffer)
			message_end()
			
			// Replace back player id's with LANG_PLAYER
			for (i = 0; i < changedcount; i++)
				setarg(changed[i], 0, LANG_PLAYER)
		}
	}
	// Send to specific target
	else
	{
		/*
		// Not needed since you should set the ML argument
		// to the player's id for a targeted print message
		
		// Replace LANG_PLAYER with player id
		for (i = 2; i < argscount; i++)
		{
			if (getarg(i) == LANG_PLAYER)
				setarg(i, 0, target)
		}
		*/
		
		// Format message for player
		vformat(buffer, charsmax(buffer), message, 3)
		
		// Send it
		message_begin(MSG_ONE, get_user_msgid("SayText"), _, target)
		write_byte(target)
		write_string(buffer)
		message_end()
	}
}