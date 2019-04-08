#include <amxmodx>
#include <fakemeta>

new g_fwSpawn

public plugin_precache()
{
	// Prevent some entities from spawning
	g_fwSpawn = register_forward(FM_Spawn, "fw_Spawn")
}

public plugin_init()
{
	register_plugin("Entity Remover", "1.0", "FLWL")
	
	unregister_forward(FM_Spawn, g_fwSpawn)
}

// Entity Spawn Forward
public fw_Spawn(ent)
{
	// Invalid entity
	if (!pev_valid(ent)) return FMRES_IGNORED;
	
	// Get classname
	new classname[32]
	pev(ent, pev_classname, classname, charsmax(classname))
	
	if (equal(classname, "player_weaponstrip") || equal(classname, "game_player_equip") || equal(classname, "game_text"))
	{
		engfunc(EngFunc_RemoveEntity, ent)
		return FMRES_SUPERCEDE;
	}
	
	return FMRES_IGNORED;
}
