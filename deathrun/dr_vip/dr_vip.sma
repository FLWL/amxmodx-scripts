#include <amxmodx>
#include <fun>
#include <hamsandwich>
#include <fakemeta>
#include <cstrike>

#define TASK_ITEMS 32442

const SCOREBOARD_FLAG_VIP = (1<<2)

public plugin_init()
{
	register_plugin("DeathRun VIP", "1.0", "FLWL")
	
	RegisterHam(Ham_Spawn, "player", "fw_PlayerSpawn_Post", 1)
	RegisterHam(Ham_TraceAttack, "func_button", "fw_TraceAttackButton")
	
	register_message(get_user_msgid("ScoreAttrib"), "message_score_attrib")
}

public fw_TraceAttackButton(victim, attacker, Float:damage, Float:direction[3], tracehandle, damagetype)
{
	if (!(get_user_flags(attacker) & ADMIN_LEVEL_H))
		return FMRES_IGNORED;
	
	dllfunc(DLLFunc_Use, victim, attacker)
	
	return FMRES_IGNORED;
}

public fw_PlayerSpawn_Post(id)
{
	// Not alive or didn't join a team yet
	if (!is_user_alive(id) || !cs_get_user_team(id))
		return;
	
	remove_task(id + TASK_ITEMS)
	
	set_task(0.2, "give_items_task", id + TASK_ITEMS)
}

public give_items_task(taskid)
{
	static id
	id = taskid - TASK_ITEMS
	
	if (get_user_flags(id) & ADMIN_LEVEL_H)
	{
		// Secondary weapon
		give_item(id, "weapon_deagle")
		
		// BPAmmo for secondary weapon
		cs_set_user_bpammo(id, CSW_DEAGLE, 35)
		
		// Grenades
		give_item(id, "weapon_hegrenade")
	}
}

public message_score_attrib(const msgid, const msgtype, const msgdest)
{
	static id
	id = get_msg_arg_int(1)
	
	if ((get_user_flags(id) & ADMIN_LEVEL_H) && !get_msg_arg_int(2))
		set_msg_arg_int(2, ARG_BYTE, SCOREBOARD_FLAG_VIP)
}
