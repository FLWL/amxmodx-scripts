#include <amxmodx>
#include <amxmisc>
#include <hamsandwich>
#include <fakemeta>
#include <zombieplague_xp>
#include <cstrike>
#include <engine>

new const VMODEL[] = "models/fzm/v_spas12_normal.mdl"
new const PMODEL[] = "models/fzm/p_spas12_normal.mdl"
new const WMODEL[] = "models/fzm/w_spas12_normal.mdl"

const Float:RECOIL = 12.0

// PData safe
const PDATA_SAFE = 2
const OFFSET_ACTIVE_ITEM = 373

// CS Weapon CBase Offsets (win32)
const m_flNextPrimaryAttack = 46

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds
const OFFSET_LINUX_WEAPONS = 4 // weapon offsets are only 4 steps higher on Linux

public plugin_precache()
{
	// Precache models
	precache_model(VMODEL)
	precache_model(PMODEL)
	precache_model(WMODEL)
}

public plugin_init()
{
	register_plugin("[ZP] Weapon: Franchi SPAS-12", "1.0", "FLWL")
	
	register_message(get_user_msgid("CurWeapon"), "message_cur_weapon")
	
	register_forward(FM_SetModel, "fw_SetModel")
	
	RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_m3", "fw_PrimaryAttack_Post", 1)
	
	zp_register_upgrade("Double Tap", "Increases shotguns' rate of fire by 25%.", 100, 20, "Human", "1100", 1377579600) // 27. august 2013
}

public fw_SetModel(ent, const model[])
{
	if (equal(model, "models/w_m3.mdl"))
	{
		entity_set_model(ent, WMODEL)
		return FMRES_SUPERCEDE;
	}
	
	return FMRES_IGNORED;
}

public fw_PrimaryAttack_Post(ent)
{
	if (pev_valid(ent) != PDATA_SAFE)
		return;
	
	set_pdata_float(ent, m_flNextPrimaryAttack, zp_user_has_upgrade(pev(ent, pev_owner), "1100") ? 0.9 : 1.2, OFFSET_LINUX_WEAPONS)
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
	
	if (weapon != CSW_M3)
		return;
	
	// Max out clip ammo
	static weapon_ent
	weapon_ent = fm_cs_get_current_weapon_ent(msg_entity)
	if (pev_valid(weapon_ent)) cs_set_weapon_ammo(weapon_ent, 8)
	
	// HUD should show full clip all the time
	set_msg_arg_int(3, get_msg_argtype(3), 1)
}

public zp_replace_weapon_models(id, wpn)
{
	if (wpn != CSW_M3)
		return;
	
	set_pev(id, pev_viewmodel2, VMODEL)
	set_pev(id, pev_weaponmodel2, PMODEL)
}

// Get User Current Weapon Entity
stock fm_cs_get_current_weapon_ent(id)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return -1;
	
	return get_pdata_cbase(id, OFFSET_ACTIVE_ITEM, OFFSET_LINUX);
}
