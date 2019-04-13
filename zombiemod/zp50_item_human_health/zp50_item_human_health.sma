#include <amxmodx>
#include <cstrike>
#include <fun>
#include <zp50_core>
#include <zp50_items>
#include <zp50_class_survivor>

new const ITEM_NAME[] = "Health"
const ITEM_COST = 5
const HEALTH_AMOUNT = 100
const MAX_HEALTH = 250

new g_ItemID

public plugin_init()
{
	register_plugin("[ZP] Item: Human Health", "1.0", "FLWL")
	
	g_ItemID = zp_items_register(ITEM_NAME, ITEM_COST)
}

public zp_fw_items_select_pre(id, itemid, ignorecost)
{
	// This is not our item
	if (itemid != g_ItemID)
		return ZP_ITEM_AVAILABLE;
	
	// Health only available to humans
	if (zp_core_is_zombie(id) || zp_class_survivor_get(id))
		return ZP_ITEM_DONT_SHOW;
	
	// Player already has max. health
	if (get_user_health(id) >= MAX_HEALTH)
		return ZP_ITEM_NOT_AVAILABLE;
	
	return ZP_ITEM_AVAILABLE;
}

public zp_fw_items_select_post(id, itemid, ignorecost)
{
	// This is not our item
	if (itemid != g_ItemID)
		return;
	
	// Give player health
	set_user_health(id, clamp(get_user_health(id) + HEALTH_AMOUNT, 1, MAX_HEALTH))
}
