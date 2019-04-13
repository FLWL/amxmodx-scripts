#include <amxmodx>
#include <zombieplague_xp>

public plugin_precache()
{
	zp_register_human_class("KCT", "Special unit", "fzmkct", 110, 255, 0.9, 3, 50, 0.25)
}

public plugin_init()
{
	register_plugin("[ZP] HClass: KCT", "1.0", "FLWL")
}
