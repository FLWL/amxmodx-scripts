#include <amxmodx>
#include <fakemeta>
#include <fun>
#include <zombieplague_xp>

// Zombie Classes MUST be registered on plugin_precache
public plugin_precache()
{
	// Register all classes
	zp_register_zombie_class("Skeleton", "The undead warrior", "fzmskeleton", "models/fzm/v_skeleton.mdl", 4000, 260, 0.9, 1.0, 1, 0.6, 1.0, 1.0)
}

public plugin_init()
{
	register_plugin("[ZP] ZClass: Skeleton", "1.0", "FLWL")
}
