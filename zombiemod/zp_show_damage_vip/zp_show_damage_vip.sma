#include <amxmodx>
#include <amxmisc>
#include <zombieplague>

new g_maxplayers

public plugin_init()
{
	register_plugin("[ZP] Addon: Show Damage (VIP)", "1.0", "FLWL")
	
	register_event("Damage", "event_damage", "b", "2!0", "3=0", "4!0")
	
	g_maxplayers = get_maxplayers()
}

public event_damage(id)
{
	static attacker
	attacker = get_user_attacker(id)
	
	if (!(1 <= attacker <= g_maxplayers) || !is_user_connected(attacker))
		return;
	
	if (zp_get_user_zombie(id) && access(attacker, ADMIN_LEVEL_H))
	{
		static iDamage
		iDamage = read_data(2)
		
		static name[32]
		get_user_name(id, name, charsmax(name))
		
		client_print(attacker, print_center, "%s - DMG: %d - HP: %d", name, iDamage, get_user_health(id))
	}
}
