#include <amxmodx>
#include <zombieplague_xp>

public plugin_precache()
{
	zp_register_human_class("Juggernaut", "Heavily armored unit", "fzmjuggernaut", 200, 200, 1.0, 10, 300, 1.0)
}

public plugin_init()
{
	register_plugin("[ZP] HClass: Juggernaut", "1.0", "FLWL")
}
