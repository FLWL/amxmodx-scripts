#include <amxmodx>
#include <engine>
#include <cstrike>
#include <fakemeta>

new g_maxplayers

public plugin_init()
{
	register_plugin("Automatic Unstuck", "1.6", "NL)Ramon(NL / FLWL")
	
	register_forward(FM_Blocked, "fw_Blocked", false)
	
	g_maxplayers = get_maxplayers()
	
	set_task(0.2, "checkstuck", 0, "", 0, "b")
}

public fw_Blocked(iBlocked, iBlocker)
{
	if (!(1 <= iBlocked <= 32) && !is_user_alive(iBlocked) && 1 <= iBlocker <= 32 && is_user_alive(iBlocker) && cs_get_user_team(iBlocker) == CS_TEAM_CT)
	{
		static name[32], auth[34]
		get_user_name(iBlocker, name, 31)
		get_user_authid(iBlocker, auth, 33)
		
		fakedamage(iBlocker, "crusher", 1000.0, DMG_CRUSH)
	}
	
	return FMRES_IGNORED;
}

public checkstuck()
{
	static Float:origin[3]
	
	for (new id; id < g_maxplayers; id++)
	{
		if (!is_user_alive(id) || cs_get_user_team(id) != CS_TEAM_CT) continue;
		entity_get_vector(id, EV_VEC_origin, origin)
		
		if (!(entity_get_int(id, EV_INT_solid) & SOLID_NOT) && !is_hull_vacant(origin, (entity_get_int(id, EV_INT_flags) & FL_DUCKING) ? HULL_HEAD : HULL_HUMAN, id))
		{
			fakedamage(id, "wall", 1000.0, DMG_CRUSH)
		}
	}
}

is_hull_vacant(const Float:origin[3], hull, id)
{
	static tr
	engfunc(EngFunc_TraceHull, origin, origin, IGNORE_MONSTERS, hull, id, tr)
	
	if (!get_tr2(tr, TR_StartSolid) || !get_tr2(tr, TR_AllSolid))
		return true;
	
	return false;
}
