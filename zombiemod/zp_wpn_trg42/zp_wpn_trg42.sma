#include <amxmodx>
#include <hamsandwich>
#include <fakemeta>
#include <zombieplague_xp>
#include <cstrike>
#include <engine>

new const VMODEL[] = "models/fzm/v_trg42.mdl"
new const PMODEL[] = "models/fzm/p_trg42.mdl"

public plugin_precache()
{
	// Precache models
	precache_model(VMODEL)
	precache_model(PMODEL)
}

public plugin_init()
{
	register_plugin("[ZP] Weapon: Sako TRG", "1.0", "FLWL")
}

public zp_replace_weapon_models(id, wpn)
{
	if (wpn != CSW_AWP)
		return;
	
	set_pev(id, pev_viewmodel2, VMODEL)
	set_pev(id, pev_weaponmodel2, PMODEL)
}
