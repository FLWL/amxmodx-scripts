#include <amxmodx>
#include <zombieplague_xp>

public plugin_precache()
{
	zp_register_human_class("Survivalist", "++ Melee combat / shotguns", "fzmkate", 110, 260, 0.85, 17, 50, 0.1)
}

public plugin_init()
{
	register_plugin("[ZP] HClass: Survivalist", "1.0", "FLWL")
}
