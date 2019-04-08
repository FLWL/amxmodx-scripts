#include <amxmodx>
#include <engine>

public plugin_init()
{
	register_plugin("Weaponbox Fix", "1.0", "FLWL")
	
	// Door vs. Weapon
	register_touch("func_door", "weaponbox", "block")
	register_touch("weaponbox", "func_door", "block")
	
	// Door vs. Grenade
	register_touch("func_door", "grenade", "block")
	register_touch("grenade", "func_door", "block")
	
	// Breakable vs. Grenade
	register_touch("func_breakable", "grenade", "block")
	register_touch("grenade", "func_breakable", "block")
}

public block(touched, toucher)
{
	return PLUGIN_HANDLED;
}
