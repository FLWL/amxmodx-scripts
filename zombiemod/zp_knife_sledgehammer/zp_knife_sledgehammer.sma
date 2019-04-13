#include <amxmodx>
#include <fakemeta>
#include <fun>
#include <xs>
#include <hamsandwich>
#include <zombieplague_xp>

const Float:KNOCKBACK_POWER = 800.0

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds
const OFFSET_LINUX_WEAPONS = 4 // weapon offsets are only 4 steps higher on Linux

// CS Weapon CBase Offsets (win32)
const m_flNextPrimaryAttack = 46
const m_flNextSecondaryAttack = 47

// Class IDs
new g_id

// Zombie Classes MUST be registered on plugin_precache
public plugin_precache()
{
	// Register all classes
	g_id = zp_register_knife("Sledgehammer", "models/fzm/v_sledgehammer.mdl", "models/fzm/p_sledgehammer.mdl", 7, 96.0, 64.0)
}

public plugin_init()
{
	register_plugin("[ZP] Knife: Sledgehammer", "1.0", "FLWL")
	
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage_Post", 1)
	RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_knife", "fw_Knife_PrimaryAttack_Post", 1)
	RegisterHam(Ham_Weapon_SecondaryAttack, "weapon_knife", "fw_Knife_SecondaryAttack_Post", 1)
}

public fw_Knife_PrimaryAttack_Post(ent)
{
	static id
	id = pev(ent, pev_owner)
	
	if (zp_get_user_zombie(id) || zp_get_user_knife(id) != g_id)
		return HAM_IGNORED;
	
	set_pdata_float(ent, m_flNextPrimaryAttack, 2.0, OFFSET_LINUX_WEAPONS)
	return HAM_OVERRIDE;
}

public fw_Knife_SecondaryAttack_Post(ent)
{
	static id
	id = pev(ent, pev_owner)
	
	if (zp_get_user_zombie(id) || zp_get_user_knife(id) != g_id)
		return HAM_IGNORED;
	
	set_pdata_float(ent, m_flNextPrimaryAttack, 3.0, OFFSET_LINUX_WEAPONS)
	set_pdata_float(ent, m_flNextSecondaryAttack, 3.0, OFFSET_LINUX_WEAPONS)
	
	return HAM_OVERRIDE;
}

public fw_TakeDamage_Post(victim, inflictor, attacker)
{
	if (!is_user_alive(victim) || !is_user_alive(attacker))
		return HAM_IGNORED;
	
	if (zp_get_user_zombie(attacker) || !zp_get_user_zombie(victim))
		return HAM_IGNORED;
	
	if (get_user_weapon(attacker) != CSW_KNIFE)
		return HAM_IGNORED;
	
	if (zp_get_user_knife(attacker) != g_id)
		return HAM_IGNORED;
	
	// get victim's origin
	static Float:originF[3], Float:victimOriginF[3], Float:velocity[3]
	pev(attacker, pev_origin, originF)
	pev(victim, pev_origin, victimOriginF)
	
	// calculate velocity
	get_speed_vector(originF, victimOriginF, KNOCKBACK_POWER, velocity)
	
	// limit z vector
	velocity[2] = 300.0
	
	// set velocity
	set_pev(victim, pev_velocity, velocity)
	return HAM_HANDLED;
}

stock get_speed_vector(const Float:origin1[3], const Float:origin2[3], Float:speed, Float:new_velocity[3])
{
	new_velocity[0] = origin2[0] - origin1[0]
	new_velocity[1] = origin2[1] - origin1[1]
	new_velocity[2] = origin2[2] - origin1[2]
	static Float:num; num = floatsqroot(speed*speed / (new_velocity[0]*new_velocity[0] + new_velocity[1]*new_velocity[1] + new_velocity[2]*new_velocity[2]))
	new_velocity[0] *= num
	new_velocity[1] *= num
	new_velocity[2] *= num
	
	return 1;
}
