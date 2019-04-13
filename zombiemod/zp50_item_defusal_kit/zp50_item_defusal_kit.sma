#include <amxmodx>
#include <cstrike>
#include <zp50_core>
#include <zp50_items>

new const ITEM_NAME[] = "Defusal Kit"
const ITEM_COST = 3

new g_ItemID

public plugin_init()
{
	register_plugin("[ZP] Item: Defusal Kit", "1.0", "FLWL")
	
	g_ItemID = zp_items_register(ITEM_NAME, ITEM_COST)
}

public zp_fw_items_select_pre(id, itemid, ignorecost)
{
	// This is not our item
	if (itemid != g_ItemID)
		return ZP_ITEM_AVAILABLE;
	
	// Defusal kit only available to humans
	if (zp_core_is_zombie(id))
		return ZP_ITEM_DONT_SHOW;
	
	// Player already has defusal kit
	if (cs_get_user_defuse(id))
		return ZP_ITEM_NOT_AVAILABLE;
	
	return ZP_ITEM_AVAILABLE;
}

public zp_fw_items_select_post(id, itemid, ignorecost)
{
	// This is not our item
	if (itemid != g_ItemID)
		return;
	
	// Give player defusal kit
	cs_set_user_defuse(id, 1)
}
