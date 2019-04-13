#include <amxmodx>
#include <cstrike>
#include <fun>
#include <amx_settings_api>
#include <zp50_ammopacks>

#define ACCESSFLAG_MAX_LENGTH 2

// Settings file
new const ZP_SETTINGS_FILE[] = "zombieplague.ini"

// Access flags
new g_access_vip[ACCESSFLAG_MAX_LENGTH] = "t"

new cvar_human_extra_health, cvar_human_extra_armor
new cvar_zombie_extra_armor
new cvar_nightvision

public plugin_precache()
{
	// Load from external file, save if not found
	if (!amx_load_setting_string(ZP_SETTINGS_FILE, "Access Flags", "VIP", g_access_vip, charsmax(g_access_vip)))
		amx_save_setting_string(ZP_SETTINGS_FILE, "Access Flags", "VIP", g_access_vip)
}

public plugin_init()
{
	register_plugin("[ZP] VIP", "1.0", "FLWL")
	
	cvar_human_extra_health = register_cvar("zp_vip_human_extra_health", "100")
	cvar_human_extra_armor = register_cvar("zp_vip_human_extra_armor", "100")
	cvar_zombie_extra_armor = register_cvar("zp_vip_zombie_extra_armor", "0")
	cvar_nightvision = register_cvar("zp_vip_nightvision", "1")
}

public zp_fw_core_cure_post(id, attacker)
{
	if (!(get_user_flags(id) & read_flags(g_access_vip)))
		return;
	
	set_user_health(id, get_user_health(id) + clamp(get_pcvar_num(cvar_human_extra_health), 1, 200))
	set_user_armor(id, get_user_armor(id) + clamp(get_pcvar_num(cvar_human_extra_armor), 0, 200))
	
	if (get_pcvar_num(cvar_nightvision) && !cs_get_user_nvg(id))
		cs_set_user_nvg(id, true)
}

public zp_fw_core_infect_post(id, attacker)
{
	if (!(get_user_flags(id) & read_flags(g_access_vip)))
		return;
	
	set_user_armor(id, get_user_armor(id) + get_pcvar_num(cvar_zombie_extra_armor))
}
