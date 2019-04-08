#include <amxmodx>
#include <basebuilder>
#include <hamsandwich>
#include <fun>
#include <cstrike>

// VIP Zombie Attributes
new const zclass1_name[] = { "VIP Zombie" }
new const zclass1_info[] = { "Extra" }
new const zclass1_model[] = { "bb_classic" }
new const zclass1_clawmodel[] = { "v_bloodyhands" }
const zclass1_health = 4500
const zclass1_speed = 350
const Float:zclass1_gravity = 0.5
const zclass1_adminflags = ADMIN_LEVEL_H

new g_zclass1_id

// Zombie Classes MUST be registered on plugin_precache
public plugin_precache()
{
	register_plugin("[BB] VIP Zombie", "1.0", "FLWL")
	
	// Register all classes
	g_zclass1_id = bb_register_zombie_class(zclass1_name, zclass1_info, zclass1_model, zclass1_clawmodel, zclass1_health, zclass1_speed, zclass1_gravity, 0.0, zclass1_adminflags)
}

public plugin_init()
{
	RegisterHam(Ham_BloodColor, "player", "fw_BloodColorPlayer")
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
}

// Ham Blood Color Forward
public fw_BloodColorPlayer(id)
{
	if (bb_is_user_zombie(id) && bb_get_user_zombie_class(id) == g_zclass1_id)
	{
		SetHamReturnInteger(195)
		
		return HAM_SUPERCEDE;
	}
	
	return HAM_IGNORED;
}

public fw_TakeDamage(victim, inflictor, attacker, Float:damage, damagebits)
{
	if (is_user_alive(victim) && bb_is_user_zombie(victim) && bb_get_user_zombie_class(victim) == g_zclass1_id)
	{
		damage *= 0.5
		SetHamParamFloat(4, damage)
		return HAM_HANDLED;
	}
	
	return HAM_IGNORED;
}
