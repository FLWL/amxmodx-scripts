#include <amxmodx>
#include <fakemeta>
#include <zombieplague>

new g_itemid1
new g_itemid2

public plugin_init()
{
	register_plugin("[ZP] Extra Item: HP", "1.0", "FLWL")
	
	g_itemid1 = zp_register_extra_item("2000 HP", 5, ZP_TEAM_ZOMBIE)
	g_itemid2 = zp_register_extra_item("200 HP", 10, ZP_TEAM_HUMAN)
}

public plugin_precache()
{
	precache_sound("items/smallmedkit1.wav")
}

public zp_extra_item_selected(id, item)
{
	if (item == g_itemid1)
	{
		set_pev(id, pev_health, pev(id, pev_health) + 2000.0)
		emit_sound(id, CHAN_VOICE, "items/smallmedkit1.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	else if (item == g_itemid2)
	{
		set_pev(id, pev_health, pev(id, pev_health) + 200.0)
		emit_sound(id, CHAN_VOICE, "items/smallmedkit1.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
}
