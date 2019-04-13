#include <amxmodx>
#include <hamsandwich>
#include <fakemeta>
#include <zombieplague_xp>
#include <cstrike>
#include <engine>

new const VMODEL[] = "models/fzm/v_eldiablo.mdl"
new const PMODEL[] = "models/fzm/p_eldiablo.mdl"

const m_iFOV = 363

new g_zoom[33]

public plugin_precache()
{
	// Precache models
	precache_model(VMODEL)
	precache_model(PMODEL)
}

public plugin_init()
{
	register_plugin("[ZP] Weapon: El Diablo", "1.0", "FLWL")
	
	register_forward(FM_CmdStart, "fw_CmdStart")
	
	RegisterHam(Ham_Weapon_Reload, "weapon_deagle", "fw_Reload_Post", 1)
}

public fw_CmdStart(id, uc_handle, seed)
{
	if (!is_user_alive(id))
		return;
	
	static button, oldbuttons
	button = get_uc(uc_handle, UC_Buttons)
	oldbuttons = pev(id, pev_oldbuttons)
	
	if ((button & IN_ATTACK2) && !(oldbuttons & IN_ATTACK2) && get_user_weapon(id) == CSW_DEAGLE)
	{
		g_zoom[id] = !g_zoom[id]
		
		set_pdata_int(id, m_iFOV, (g_zoom[id] ? 35 : 90), 5)
		emit_sound(id, CHAN_ITEM, "weapons/zoom.wav", 0.20, 2.40, 0, 100)
	}
}

public fw_Reload_Post(ent)
{
	static id
	id = pev(ent, pev_owner)
	
	if (g_zoom[id])
	{
		g_zoom[id] = false
		
		set_pdata_int(id, m_iFOV, 90, 5)
		emit_sound(id, CHAN_ITEM, "weapons/zoom.wav", 0.20, 2.40, 0, 100)
	}
}

public zp_replace_weapon_models(id, wpn)
{
	if (wpn != CSW_DEAGLE)
		return;
	
	set_pev(id, pev_viewmodel2, VMODEL)
	set_pev(id, pev_weaponmodel2, PMODEL)
}
