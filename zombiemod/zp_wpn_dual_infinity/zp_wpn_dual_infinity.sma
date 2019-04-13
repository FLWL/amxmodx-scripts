#include <amxmodx>
#include <hamsandwich>
#include <fakemeta>
#include <engine>

new const VMODEL[] = "models/fzm/v_dualinfinity.mdl"
new const PMODEL[] = "models/fzm/p_dualinfinity.mdl"
new const WMODEL[] = "models/fzm/w_dualinfinity.mdl"

// CS Weapon CBase Offsets (win32)
const m_flNextPrimaryAttack = 46

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds
const OFFSET_LINUX_WEAPONS = 4 // weapon offsets are only 4 steps higher on Linux

public plugin_precache()
{
	precache_model(VMODEL)
	precache_model(PMODEL)
	precache_model(WMODEL)
}

public plugin_init()
{
	register_plugin("[ZP] Weapon: Dual Infinity", "1.0", "FLWL")
	
	register_forward(FM_SetModel, "fw_SetModel")
	
	RegisterHam(Ham_Item_Deploy, "weapon_elite", "fw_DeployDualInfinity_Post", 1)
}

public fw_SetModel(ent, const model[])
{
	if (equal(model, "models/w_elite.mdl"))
	{
		entity_set_model(ent, WMODEL)
		return FMRES_SUPERCEDE;
	}
	
	return FMRES_IGNORED;
}

public fw_DeployDualInfinity_Post(ent)
{
	set_pdata_float(ent, m_flNextPrimaryAttack, 1.2, OFFSET_LINUX_WEAPONS)
}

public zp_replace_weapon_models(id, wpn)
{
	if (wpn == CSW_ELITE)
	{
		set_pev(id, pev_viewmodel2, VMODEL)
		set_pev(id, pev_weaponmodel2, PMODEL)
	}
}
