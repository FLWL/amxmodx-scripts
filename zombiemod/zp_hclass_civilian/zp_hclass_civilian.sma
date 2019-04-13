#include <amxmodx>
#include <zombieplague_xp>

public plugin_precache()
{
	zp_register_human_class("Civilian", "Would-be zombie hunter", "fzmcivilian", 100, 250, 1.0, 1, 0, 0.0)
}

public plugin_init()
{
	register_plugin("[ZP] HClass: Civilian", "1.0", "FLWL")
}
