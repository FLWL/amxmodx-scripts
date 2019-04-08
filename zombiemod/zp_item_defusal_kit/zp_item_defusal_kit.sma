#include <amxmodx>
#include <cstrike>
#include <zombieplague>

new const ITEM_NAME[] = "Defusal Kit"
const ITEM_COST = 2

new g_ItemID

public plugin_init()
{
	register_plugin("[ZP] Item: Defusal Kit", "1.0", "FLWL")
	
	g_ItemID = zp_register_extra_item(ITEM_NAME, ITEM_COST, ZP_TEAM_HUMAN)
}

public zp_extra_item_selected(id, itemid)
{
	// This is not our item
	if (itemid != g_ItemID)
		return PLUGIN_CONTINUE;
	
	// Player already has defusal kit
	if (cs_get_user_defuse(id))
		return ZP_PLUGIN_HANDLED;
	
	// Give player defusal kit
	cs_set_user_defuse(id, 1)
	
	return PLUGIN_CONTINUE;
}
