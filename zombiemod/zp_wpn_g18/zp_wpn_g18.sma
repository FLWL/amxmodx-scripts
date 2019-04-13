#include <amxmodx>
#include <hamsandwich>
#include <fakemeta>

const Float:RATE_OF_FIRE = 0.14;
new const VMODEL[] = "models/fzm/v_g18.mdl"

// CS Weapon CBase Offsets (win32)
const m_flNextPrimaryAttack = 46
const m_iShotsFired = 64

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds
const OFFSET_LINUX_WEAPONS = 4 // weapon offsets are only 4 steps higher on Linux

public plugin_precache()
{
	precache_model(VMODEL)
}

public plugin_init()
{
	register_plugin("[ZP] Weapon: G18", "1.0", "FLWL")
	
	RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_glock18", "fw_PrimaryAttack_G18")
	RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_glock18", "fw_PrimaryAttack_G18_Post", 1)
	RegisterHam(Ham_Weapon_SecondaryAttack, "weapon_glock18", "fw_SecondaryAttack")
}

// G18 firing pre
public fw_PrimaryAttack_G18(ent)
{
	// Automatic fire
	set_pdata_int(ent, m_iShotsFired, -1, OFFSET_LINUX_WEAPONS)
}

// G18 firing post
public fw_PrimaryAttack_G18_Post(ent)
{
	// Get owner
	static id
	id = pev(ent, pev_owner)
	
	// Fire rate
	if (id) set_pdata_float(ent, m_flNextPrimaryAttack, RATE_OF_FIRE, OFFSET_LINUX_WEAPONS)
}

public fw_SecondaryAttack(ent)
{
	// Block it, I say, block it!
	return HAM_SUPERCEDE;
}

public zp_replace_weapon_models(id, wpn)
{
	if (wpn == CSW_GLOCK18)
	{
		set_pev(id, pev_viewmodel2, VMODEL)
	}
}
