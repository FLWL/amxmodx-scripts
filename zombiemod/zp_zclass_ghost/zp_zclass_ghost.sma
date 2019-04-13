#include <amxmodx>
#include <fakemeta>
#include <engine>
#include <fun>
#include <zombieplague_xp>

new const VMODEL_NORMAL[] = "models/kzm/v_ghost.mdl"
new const VMODEL_INVISIBLE[] = "models/kzm/v_ghost2.mdl"
const Float:STEALTH_RADIUS = 300.0

const NADE_TYPE_WARD = 4555
const PEV_FLARE_DURATION = pev_flSwimTime
const PEV_NADE_TYPE = pev_flTimeStepSound

// Class IDs
new g_zclass
new g_fade[33][33]
new g_invisible[33]
new g_wards[32]
new g_wards_i

new g_maxplayers

// Zombie Classes MUST be registered on plugin_precache
public plugin_precache()
{
	g_zclass = zp_register_zombie_class("Ghost", "Undead stealthy zombie", "kzm_ghost2", VMODEL_NORMAL, 2000, 250, 0.9, 1.0, 12, 0.6, 1.0, 1.0)
	
	precache_model(VMODEL_INVISIBLE)
}

public plugin_init()
{
	register_plugin("[ZP] ZClass: Ghost", "1.0", "FLWL")
	
	register_forward(FM_AddToFullPack, "fw_AddToFullPack_Post", true)
	
	set_task(0.1, "task_CalcFade", _, _, _, "b")
	
	g_maxplayers = get_maxplayers()
}

public fw_AddToFullPack_Post(es_handle, e, ent, host, flags, player, pSet)
{
	if (player && !zp_get_user_zombie(host) && zp_get_user_zombie(ent) && zp_get_user_zombie_class(ent) == g_zclass && !zp_get_user_nemesis(ent) && g_fade[host][ent] < 255 && !zp_get_user_frozen(ent))
	{
		set_es(es_handle, ES_RenderMode, kRenderTransAlpha)
		set_es(es_handle, ES_RenderAmt, g_fade[host][ent])
		
		// This hides the player from hacks if their transparency is zero, but also makes them unable to get hit
		// if (g_fade[host][ent] == 0) set_es(es_handle, ES_Origin, Float:{8192.0, 8192.0 ,8192.0})
	}
}

public task_CalcFade()
{
	arrayset(g_invisible, true, sizeof(g_invisible))
	
	// Update ward positions
	update_wards()
	
	static id, i, fade
	for (id = 1; id <= g_maxplayers; id++)
	{
		arrayset(g_fade[id], 255, sizeof(g_fade[]))
		
		if (!is_user_alive(id) || zp_get_user_zombie(id))
			continue;
		
		for (i = 1; i <= g_maxplayers; i++)
		{
			if (!is_user_alive(i) || !zp_get_user_zombie(i) || zp_get_user_zombie_class(i) != g_zclass || zp_get_user_nemesis(i))
				continue;
			
			fade = calc_fade(id, i)
			
			if (fade > 0) g_invisible[i] = false
			g_fade[id][i] = fade
			update_claws(i)
		}
	}
}

calc_fade(id, i)
{
	new Float:wDistance = 9999.0, Float:tmpDistance, ward
	for (new ward_i = 0; ward_i < g_wards_i; ward_i++)
	{
		ward = g_wards[ward_i]
		
		// Reached the end
		if (ward == 0)
			break;
		
		// Invalid entity
		if (!is_valid_ent(ward))
			continue;
		
		// Distance
		tmpDistance = entity_range(i, ward)
		
		// Overwrite if closer
		if (tmpDistance < wDistance) wDistance = tmpDistance
	}
	
	// Overwrite with player distance if closer
	static Float:distance
	distance = floatmin(entity_range(id, i), wDistance)
	
	if (distance >= STEALTH_RADIUS)
		return 0;
	
	static Float:amount
	amount = distance * floatdiv(255.0, STEALTH_RADIUS)
	amount = 255.0 - amount
	
	return floatround(amount, floatround_ceil);
}

update_wards()
{
	// Reset wards
	arrayset(g_wards, 0, sizeof(g_wards))
	g_wards_i = 0
	
	static ent
	while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "grenade")) != 0)
	{
		// Nade not ward?
		if (pev(ent, PEV_NADE_TYPE) != NADE_TYPE_WARD)
			continue;
		
		// Not activated yet?
		if (pev(ent, PEV_FLARE_DURATION) <= 0)
			continue;
		
		// Prevent overflow
		if (g_wards_i >= sizeof(g_wards)-1)
			continue;
		
		// Add into array
		g_wards[g_wards_i++] = ent
	}
}

public zp_replace_weapon_models(id, wpn)
{
	if (wpn == CSW_KNIFE && zp_get_user_zombie(id) && zp_get_user_zombie_class(id) == g_zclass && !zp_get_user_nemesis(id))
		update_claws(id)
}

update_claws(id)
{
	if (get_user_weapon(id) == CSW_KNIFE)
		set_pev(id, pev_viewmodel2, (g_invisible[id] ? VMODEL_INVISIBLE : VMODEL_NORMAL))
}
