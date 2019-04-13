#include <amxmodx>
#include <fakemeta>
#include <fun>
#include <xs>
#include <hamsandwich>
#include <zombieplague_xp>

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
	g_id = zp_register_knife("Executioner's Axe", "models/fzm/v_executioners_axe.mdl", "models/fzm/p_executioners_axe.mdl", 6, 96.0, 64.0)
}

public plugin_init()
{
	register_plugin("[ZP] Knife: Executioner's Axe", "1.0", "FLWL")
	
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
	
	set_pdata_float(ent, m_flNextPrimaryAttack, 5.0, OFFSET_LINUX_WEAPONS)
	set_pdata_float(ent, m_flNextSecondaryAttack, 5.0, OFFSET_LINUX_WEAPONS)
	
	stab(id)
	return HAM_OVERRIDE;
}

stab(id)
{
	static target, body, Float:distance
	distance = get_user_aiming(id, target, body, 150)
	
	if (!is_user_alive(target) || !zp_get_user_zombie(target) || zp_get_user_frozen(target))
		return;
	
	static Float:attackerOrigin[3], Float:targetOrigin[3]
	pev(id, pev_origin, attackerOrigin)
	pev(target, pev_origin, targetOrigin)
	
	static Float:velocity[3]
	get_speed_vector(targetOrigin, attackerOrigin, (distance * 10.0), velocity)
	set_pev(target, pev_velocity, velocity)
	
	// Calculate damage
	static Float:missing_health
	missing_health = Float:zp_calculate_zhealth(target, false) - pev(target, pev_health)
	
	if (missing_health < 0.0) return;
	
	static Float:damage
	damage = missing_health*0.25
	
	zp_takedamage(target, id, "knife", damage, DMG_BULLET, true)
}

stock get_speed_vector(const Float:origin1[3],const Float:origin2[3],Float:speed, Float:new_velocity[3])
{
	new_velocity[0] = origin2[0] - origin1[0]
	new_velocity[1] = origin2[1] - origin1[1]
	new_velocity[2] = origin2[2] - origin1[2]
	new Float:num = floatsqroot(speed*speed / (new_velocity[0]*new_velocity[0] + new_velocity[1]*new_velocity[1] + new_velocity[2]*new_velocity[2]))
	new_velocity[0] *= num
	new_velocity[1] *= num
	new_velocity[2] *= num

	return 1;
}
