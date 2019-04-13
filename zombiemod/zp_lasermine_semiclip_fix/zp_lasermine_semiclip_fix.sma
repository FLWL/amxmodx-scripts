#include <amxmodx>
#include <amxmisc>
#include <engine>
#include <hamsandwich>
#include <zombieplague>

new const LASERMINE_CLASS[] = "zp_lasermine"

public plugin_init()
{
	register_plugin("[ZP] Lasermine Semiclip Fix", "1.0", "FLWL")
	
	RegisterHam(Ham_TraceAttack, "player", "fw_TraceAttack_Post", 1)
}

public fw_TraceAttack_Post(victim, attacker, Float:damage, Float:direction[3], tracehandle, damage_type)
{
	// Non-player damage or self damage
	if (victim == attacker || !is_user_connected(attacker))
		return HAM_IGNORED;
	
	// Not zombie attacking an zombie
	if (zp_get_user_zombie(victim) != zp_get_user_zombie(attacker))
		return HAM_IGNORED;
	
	// Retrieve attacker's origin
	static Float:originF[3], classname[32]
	entity_get_vector(attacker, EV_VEC_origin, originF)
	
	// Check nearby lasermines
	new ent = -1
	while ((ent = find_ent_in_sphere(ent, originF, 32.0)))
	{
		entity_get_string(ent, EV_SZ_classname, classname, charsmax(classname))
		
		// lasermine found, break
		if (equal(classname, LASERMINE_CLASS)) break;
	}
	
	// No ents found
	if (!is_valid_ent(ent))
		return HAM_IGNORED;
	
	// Check if it's lasermine
	entity_get_string(ent, EV_SZ_classname, classname, charsmax(classname))
	if (!equal(classname, LASERMINE_CLASS))
		return HAM_IGNORED;
	
	static owner
	owner = entity_get_int(victim, EV_INT_iuser1)
	
	if (is_user_connected(owner))
	{
		static name[32]
		get_user_name(owner, name, charsmax(name))
		
		if (access(attacker, ADMIN_LEVEL_H))
			client_print(attacker, print_center, "%s's lasermine. Health: %d/500.", name, floatround(entity_get_float(victim, EV_FL_health)-damage))
		else
			client_print(attacker, print_center, "%s's lasermine.", name)
	}
	
	// Reduce lasermine's health
	entity_set_float(ent, EV_FL_health, entity_get_float(ent, EV_FL_health)-damage)
	return HAM_IGNORED;
}
