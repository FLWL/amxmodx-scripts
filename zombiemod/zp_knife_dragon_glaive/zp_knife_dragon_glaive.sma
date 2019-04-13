#include <amxmodx>
#include <fakemeta>
#include <fun>
#include <xs>
#include <hamsandwich>
#include <zombieplague_xp>

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds
const OFFSET_LINUX_WEAPONS = 4 // weapon offsets are only 4 steps higher on Linux

// CS Weapon CBase Offsets (win32)
const m_flNextPrimaryAttack = 46
const m_flNextSecondaryAttack = 47

// Class IDs
new g_id

// Zombie Classes MUST be registered on plugin_precache
public plugin_precache()
{
	// Register all classes
	g_id = zp_register_knife("Dragon Glaive", "models/fzm/v_dragonsword.mdl", "models/fzm/p_dragonsword.mdl", 15, 148.0, 148.0)
}

public plugin_init()
{
	register_plugin("[ZP] Knife: Dragon Glaive", "1.0", "FLWL")
	
	RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_knife", "fw_Knife_PrimaryAttack_Post", 1)
	RegisterHam(Ham_Weapon_SecondaryAttack, "weapon_knife", "fw_Knife_SecondaryAttack_Post", 1)
}

public fw_Knife_PrimaryAttack_Post(ent)
{
	static id
	id = pev(ent, pev_owner)
	
	if (zp_get_user_zombie(id) || zp_get_user_knife(id) != g_id)
		return HAM_IGNORED;
	
	set_pdata_float(ent, m_flNextPrimaryAttack, 1.53, OFFSET_LINUX_WEAPONS)
	set_pdata_float(ent, m_flNextSecondaryAttack, 1.53, OFFSET_LINUX_WEAPONS)
	return HAM_OVERRIDE;
}

public fw_Knife_SecondaryAttack_Post(ent)
{
	static id
	id = pev(ent, pev_owner)
	
	if (zp_get_user_zombie(id) || zp_get_user_knife(id) != g_id)
		return HAM_IGNORED;
	
	set_pdata_float(ent, m_flNextPrimaryAttack, 1.23, OFFSET_LINUX_WEAPONS)
	set_pdata_float(ent, m_flNextSecondaryAttack, 1.23, OFFSET_LINUX_WEAPONS)
	return HAM_OVERRIDE;
}
