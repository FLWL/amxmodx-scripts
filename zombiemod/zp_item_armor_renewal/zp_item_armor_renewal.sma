#include <amxmodx>
#include <fakemeta>
#include <cstrike>
#include <zombieplague>

// Item IDs
new g_id

public plugin_precache()
{
	precache_sound("items/tr_kevlar.wav")
}

public plugin_init()
{
	register_plugin("[ZP] Item: Armor Renewal", "1.0", "FLWL")
	
	g_id = zp_register_extra_item("Armor Renewal", 10, ZP_TEAM_HUMAN)
}

// Human buys our upgrade, give him some armor
public zp_extra_item_selected(id, itemid)
{
	if (itemid != g_id)
		return PLUGIN_CONTINUE;
	
	static Float:armor
	pev(id, pev_armorvalue, armor)
	
	if (armor > 0.0)
		return ZP_PLUGIN_HANDLED;
	
	cs_set_user_armor(id, 1, CS_ARMOR_VESTHELM)
	engfunc(EngFunc_EmitSound, id, CHAN_BODY, "items/tr_kevlar.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	return PLUGIN_CONTINUE;
}
