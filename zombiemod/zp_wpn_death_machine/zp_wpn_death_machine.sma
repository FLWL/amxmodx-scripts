#include <amxmodx>
#include <hamsandwich>
#include <fakemeta>
#include <zombieplague_xp>
#include <cstrike>
#include <engine>

new const VMODEL[] = "models/fzm/v_deathmachine.mdl"
new const PMODEL[] = "models/fzm/p_deathmachine.mdl"

// PData safe
const PDATA_SAFE = 2

// CS Weapon CBase Offsets (win32)
const m_flNextPrimaryAttack = 46
const m_flAccuracy = 62
const OFFSET_ACTIVE_ITEM = 373

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds
const OFFSET_LINUX_WEAPONS = 4 // weapon offsets are only 4 steps higher on Linux

const PEV_HEAT = pev_iuser3

new g_msgCurWeapon

public plugin_precache()
{
	// Precache models
	precache_model(VMODEL)
	precache_model(PMODEL)
}

public plugin_init()
{
	register_plugin("[ZP] Weapon: Death Machine", "1.0", "FLWL")
	
	RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_m249", "fw_PrimaryAttack_Post", 1)
	
	g_msgCurWeapon = get_user_msgid("CurWeapon")
	register_message(g_msgCurWeapon, "message_cur_weapon")
	register_message(get_user_msgid("AmmoX"), "message_ammo_x")
	
	// Upgrades
	zp_register_upgrade("DM Heat Plating", "Increases Death Machine's heat capacity by 20% and cooling speed by 50%.", 220, 37, "Human", "1000", 0)
}

public fw_PrimaryAttack_Post(ent)
{
	if (pev_valid(ent) != 2)
		return;
	
	// Owner
	static owner
	owner = pev(ent, pev_owner)
	
	if (pev_valid(owner) != 2 || !is_user_alive(owner))
		return;
	
	// No recoil
	set_pev(owner, pev_punchangle, Float:{0.0, 0.0, 0.0})
	
	// survivor's gun shouldn't overheat
	if (zp_get_user_survivor(owner))
		return;
	
	// Heat
	static heat, maxheat
	heat = pev(ent, PEV_HEAT)
	set_pev(ent, PEV_HEAT, ++heat)
	
	maxheat = zp_user_has_upgrade(owner, "1000") ? 120 : 100
	
	// Overheated?
	if (heat >= maxheat && !zp_get_user_survivor(owner))
		set_pdata_float(ent, m_flNextPrimaryAttack, 1.1, OFFSET_LINUX_WEAPONS)
	
	// Cooldown task
	remove_task(ent)
	set_task(1.0, "think_deathmachine", ent)
}

public think_deathmachine(ent)
{
	// Entity is no longer valid
	if (pev_valid(ent) != PDATA_SAFE)
		return;
	
	// Get classname
	static classname[32]
	pev(ent, pev_classname, classname, charsmax(classname))
	
	// Check if our death machine has not been replaced by other entity
	if (!equali(classname, "weapon_m249"))
		return;
	
	// Get owner
	static id
	id = pev(ent, pev_owner)
	
	if (!is_user_connected(id))
		return;
	
	// Heat
	static heat
	heat = pev(ent, PEV_HEAT)
	
	// Reduce by 10
	heat -= zp_user_has_upgrade(id, "1000") ? 15 : 10
	
	// Our gun shouldn't freeze
	if (heat <= 0) heat = 0
	
	// Set new heat
	set_pev(ent, PEV_HEAT, heat)
	
	if (is_user_alive(id))
	{
		// Update HUD if necessary
		message_begin(MSG_ONE_UNRELIABLE, g_msgCurWeapon, _, id)
		write_byte((get_user_weapon(id) == CSW_M249) ? 1 : 0)
		write_byte(CSW_M249)
		write_byte(heat)
		message_end()
	}
	
	// Continue task if heat is still present
	if (heat)
		set_task(1.0, "think_deathmachine", ent)
}

public zp_replace_weapon_models(id, wpn)
{
	if (wpn != CSW_M249)
		return;
	
	set_pev(id, pev_viewmodel2, VMODEL)
	set_pev(id, pev_weaponmodel2, PMODEL)
}

// Current Weapon info
public message_cur_weapon(msg_id, msg_dest, msg_entity)
{
	// Not alive or zombie
	if (!is_user_alive(msg_entity) || zp_get_user_zombie(msg_entity))
		return;
	
	// Not an active weapon
	if (get_msg_arg_int(1) != 1)
		return;
	
	// Get weapon's id
	static weapon
	weapon = get_msg_arg_int(2)
	
	if (weapon != CSW_M249)
		return;
	
	// Max out clip ammo
	static weapon_ent
	weapon_ent = fm_cs_get_current_weapon_ent(msg_entity)
	if (pev_valid(weapon_ent)) cs_set_weapon_ammo(weapon_ent, zp_user_has_upgrade(msg_entity, "1000") ? 120 : 100)
	
	// HUD should show full clip all the time
	set_msg_arg_int(3, get_msg_argtype(3), pev(weapon_ent, PEV_HEAT))
}

public message_ammo_x(msg_id, msg_dest, msg_entity)
{
	if (get_user_weapon(msg_entity) != CSW_M249)
		return;
	
	if (get_msg_arg_int(1) != 3)
		return;
	
	set_msg_arg_int(2, get_msg_argtype(2), zp_user_has_upgrade(msg_entity, "1000") ? 120 : 100)
}

// Get User Current Weapon Entity
stock fm_cs_get_current_weapon_ent(id)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return -1;
	
	return get_pdata_cbase(id, OFFSET_ACTIVE_ITEM, OFFSET_LINUX);
}
