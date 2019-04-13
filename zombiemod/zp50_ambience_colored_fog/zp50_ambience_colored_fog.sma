#include <amxmodx>
#include <amx_settings_api>
#include <zp50_gamemodes>

#define FOG_VALUE_MAX_LENGTH 16

// Settings file
new const ZP_SETTINGS_FILE[] = "zombieplague.ini"

new g_ambience_fog_density_str[FOG_VALUE_MAX_LENGTH] = "0.0018"
new g_ambience_fog_density
new g_ambience_fog_color_str[FOG_VALUE_MAX_LENGTH] = "128 128 128"
new g_ambience_fog_color[3]

new const g_fog_density_offset[][] =
{
				{ 0, 0, 0, 0 }, { 23, -73, -47, 56 }, { 23, -73, 81, 57 }, { 82, 73, -99, 57 },
				{ 23, -73, -47, 57 }, { 111, 18, 3, 58 }, { 82, 73, 29, 58 }, { 52, -128, 55, 58 },
				{ 23, -73, 81, 58 }, { -6, -19, 107, 58 }, { 111, 18, -125, 58 }, { -32, 45, -112, 58 },
				{ 82, 73, -99, 58 }, { -61, 100, -86, 58 }, { 52, -128, -73, 58 }, { -90, -101, -60, 58 },
				{ 23, -73, -47, 58 }, { -119, -46, -34, 58 }, { -6, -19, -21, 58 }, { 108, 9, -7, 58 },
				{ 111, 18, 3, 59 }, { 39, -96, 9, 59 }, { -32, 45, 16, 59 }, { -103, -69, 22, 59 },
				{ 82, 73, 29, 59 }, { 10, -41, 35, 59 }, { -61, 100, 42, 59 }, { 124, -14, 48, 59 },
				{ 52, -128, 55, 59 }, { -19, 13, 62, 59 }, { -90, -101, 68, 59 }, { 95, 41, 75, 59 },
				{ 23, -73, 81, 59 }, { -48, 68, 88, 59 }, { -119, -46, 94, 59 }, { 66, 96, 101, 59 },
				{ -6, -19, 107, 59 }, { -77, 123, 114, 59 }, { 108, 9, 121, 59 }, { 36, -105, 127, 59 },
				{ 111, 18, -125, 59 }, { 75, 89, -122, 59 }, { 39, -96, -119, 59 }, { 4, -25, -116, 59 },
				{ -32, 45, -112, 59 }, { -68, 116, -109, 59 }, { -103, -69, -106, 59 }, { 117, 2, -102, 59 },
				{ 82, 73, -99, 59 }, { 46, -112, -96, 59 }, { 10, -41, -93, 59 }, { -25, 29, -89, 59 },
				{ -61, 100, -86, 59 }, { -97, -85, -83, 59 }, { 124, -14, -80, 59 }, { 88, 57, -76, 59 },
				{ 52, -128, -73, 59 }, { 17, -57, -70, 59 }, { -19, 13, -66, 59 }, { -54, 84, -63, 59 },
				{ -90, -101, -60, 59 }, { -126, -30, -57, 59 }, { 95, 41, -53, 59 }, { 59, 112, -50, 59 },
				{ 23, -73, -47, 59 }, { -12, -3, -44, 59 }, { -48, 68, -40, 59 }, { -84, -117, -37, 59 },
				{ -119, -46, -34, 59 }, { 101, 25, -30, 59 }, { 66, 96, -27, 59 }, { 30, -89, -24, 59 },
				{ -6, -19, -21, 59 }, { -41, 52, -17, 59 }, { -77, 123, -14, 59 }, { -113, -62, -11, 59 },
				{ 108, 9, -7, 59 }, { 72, 80, -4, 59 }, { 36, -105, -1, 59 }, { 0, 111, 1, 60 },
				{ 111, 18, 3, 60 }, { -35, -75, 4, 60 }, { 75, 89, 6, 60 }, { -71, -4, 7, 60 },
				{ 39, -96, 9, 60 }, { -106, 67, 11, 60 }, { 4, -25, 12, 60 }, { 114, -118, 14, 60 },
				{ -32, 45, 16, 60 }, { 78, -47, 17, 60 }, { -68, 116, 19, 60 }, { 43, 24, 21, 60 },
				{ -103, -69, 22, 60 }, { 7, 95, 24, 60 }, { 117, 2, 26, 60 }, { -29, -91, 27, 60 },
				{ 82, 73, 29, 60 }, { -64, -20, 30, 60 }, { 46, -112, 32, 60 }, { -100, 51, 34, 60 }
}

new g_msgFog

public plugin_precache()
{
	// Load from external file, save if not found
	if (!amx_load_setting_string(ZP_SETTINGS_FILE, "Weather Effects", "FOG DENSITY", g_ambience_fog_density_str, charsmax(g_ambience_fog_density_str)))
		amx_save_setting_string(ZP_SETTINGS_FILE, "Weather Effects", "FOG DENSITY", g_ambience_fog_density_str)
	if (!amx_load_setting_string(ZP_SETTINGS_FILE, "Weather Effects", "FOG COLOR", g_ambience_fog_color_str, charsmax(g_ambience_fog_color_str)))
		amx_save_setting_string(ZP_SETTINGS_FILE, "Weather Effects", "FOG COLOR", g_ambience_fog_color_str)
	
	// Parse fog density
	replace(g_ambience_fog_density_str, charsmax(g_ambience_fog_density_str), "0.00", "")
	g_ambience_fog_density = str_to_num(g_ambience_fog_density_str)
	
	// Parse fog color
	new str_r[8], str_g[8], str_b[8]
	parse(g_ambience_fog_color_str, str_r, charsmax(str_r), str_g, charsmax(str_g), str_b, charsmax(str_b))
	g_ambience_fog_color[0] = str_to_num(str_r)
	g_ambience_fog_color[1] = str_to_num(str_g)
	g_ambience_fog_color[2] = str_to_num(str_b)
}

public plugin_init()
{
	register_plugin("[ZP] Colored Fog", "1.0", "FLWL")
	
	g_msgFog = get_user_msgid("Fog")
	
	register_message(g_msgFog, "message_fog")
}

public client_putinserver(id)
	client_cmd(id, "gl_fog 1")

public message_fog(msg_id, msg_dest, msg_entity)
{
	static fog[4], density
	fog = get_fog()
	density = fog[3]
	
	if (get_msg_arg_int(1) != fog[0]) set_msg_arg_int(1, ARG_BYTE, fog[0])
	if (get_msg_arg_int(2) != fog[1]) set_msg_arg_int(2, ARG_BYTE, fog[1])
	if (get_msg_arg_int(3) != fog[2]) set_msg_arg_int(3, ARG_BYTE, fog[2])
	if (get_msg_arg_int(4) != g_fog_density_offset[density][0]) set_msg_arg_int(4, ARG_BYTE, g_fog_density_offset[density][0])
	if (get_msg_arg_int(5) != g_fog_density_offset[density][1]) set_msg_arg_int(5, ARG_BYTE, g_fog_density_offset[density][1])
	if (get_msg_arg_int(6) != g_fog_density_offset[density][2]) set_msg_arg_int(6, ARG_BYTE, g_fog_density_offset[density][2])
	if (get_msg_arg_int(7) != g_fog_density_offset[density][3]) set_msg_arg_int(7, ARG_BYTE, g_fog_density_offset[density][3])
}

public zp_fw_gamemodes_start(game_mode_id)
{
	static fog[4]
	fog = get_fog(game_mode_id)
	
	set_fog(0, fog[0], fog[1], fog[2], fog[3])
}

public zp_fw_gamemodes_end(game_mode_id)
{
	set_fog(0, g_ambience_fog_color[0], g_ambience_fog_color[1], g_ambience_fog_color[2], g_ambience_fog_density)
}

get_fog(game_mode_id = -1)
{
	static fog[4]
	fog[0] = g_ambience_fog_color[0]
	fog[1] = g_ambience_fog_color[1]
	fog[2] = g_ambience_fog_color[2]
	fog[3] = g_ambience_fog_density
	
	if (game_mode_id < 0) game_mode_id = zp_gamemodes_get_current()
	if (game_mode_id < 0)
		return fog;
	
	static game_mode_name[32]
	zp_gamemodes_get_name(game_mode_id, game_mode_name, charsmax(game_mode_name))
	
	if (equal(game_mode_name, "Nemesis Mode"))
	{
		fog[0] = 128
		fog[1] = 0
		fog[2] = 0
		fog[3] = 30
	}
	else if (equal(game_mode_name, "Survivor Mode"))
	{
		fog[0] = 0
		fog[1] = 0
		fog[2] = 128
		fog[3] = 30
	}
	else if (equal(game_mode_name, "Multiple Infection Mode"))
	{
		fog[3] = 30
	}
	
	return fog;
}

// 0 - clear the fog
set_fog(id, r, g, b, density)
{
	client_cmd(id ? id : 0, "gl_fog 1")
	density = clamp(density, 0, 99)
	
	message_begin(id ? MSG_ONE_UNRELIABLE : MSG_BROADCAST, g_msgFog, _, id ? id : 0)
	write_byte(r) // Red
	write_byte(g) // Green
	write_byte(b) // Blue
	write_byte(g_fog_density_offset[density][0]) // SD
	write_byte(g_fog_density_offset[density][1]) // ED
	write_byte(g_fog_density_offset[density][2]) // D1
	write_byte(g_fog_density_offset[density][3]) // D2
	message_end()
}
