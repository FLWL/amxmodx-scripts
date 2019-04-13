#include <amxmodx>
#include <amxmisc>
#include <time>
#include <sqlx>

#include <colorchat>

new const SMF_DATABASE[] = "smf_db"
new const SMF_PREFIX[] = "smf"

new const REWARD_NAME[] = "Premium"
new const REWARD_FLAGS[][] = { "abcdefg", "abcdefg", "abcdefg", "abcdefg" }
new const REWARD_SERVERS[] = { 1, 2, 3, 4 }

new const PLUGIN_VERSION[] = "1.1"

// Menu keys
const KEYSMENU = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_8|MENU_KEY_9|MENU_KEY_0

new cvar_min_pw_length, cvar_min_name_length, cvar_reward_on_register

new Handle:g_sql_tuple
new g_maxplayers
new g_serverip[32]

new g_show_menu_after_logout[33]
new g_autolog_after_saving[33]
new g_system_busy[33]
new g_saving_data[33]
new g_connected_at[33]
new g_auth[33][34]
new g_id[33]
new g_activated[33]
new g_temp_id[33]
new g_login_username[33][32]
new g_login_password[33][64]
new g_remember_me[33]

new g_register_username[33][32]
new g_register_password[33][64]
new g_register_confirmation[33][64]
new g_register_email[33][64]
new g_forgot_password_email[33][64]

new g_current_password[33][64]
new g_new_username[33][64]
new g_new_password[33][64]
new g_new_password2[33][64]
new g_new_email[33][64]
new g_real_member_name[33][32]
new g_real_email[33][64]

new Array:g_num_name, Array:g_num_default, g_num_i
new Array:g_string_name, Array:g_string_default, g_string_i
new g_arrays_created, g_arrays_created2

new Array:g_nums[33], Array:g_strings[33]

public plugin_natives()
{
	register_native("bullet_register_num", "native_register_num", 1)
	register_native("bullet_register_float", "native_register_float", 1)
	register_native("bullet_register_string", "native_register_string", 1)
	
	register_native("bullet_get_num", "native_get_num", 1)
	register_native("bullet_get_float", "native_get_float", 1)
	register_native("bullet_get_string", "native_get_string", 1)
	
	register_native("bullet_set_num", "native_set_num", 1)
	register_native("bullet_set_float", "native_set_float", 1)
	register_native("bullet_set_string", "native_set_string", 1)
	
	register_native("bullet_find_num", "native_find_num", 1)
	register_native("bullet_find_string", "native_find_string", 1)
	
	register_native("bullet_is_activated", "native_is_activated", 1)
	register_native("bullet_get_id", "native_get_id", 1)
	
	register_native("bullet_ban_account", "native_ban_account", 1)
}

public native_get_id(id)
{
	return g_id[id];
}

public native_ban_account(id, length, const reason[], const by[])
{
	if (!logged_in(id))
		return;
	
	param_convert(3)
	param_convert(4)
	
	static safe_reason[72], safe_by[72]
	copy(safe_reason, charsmax(safe_reason), reason)
	copy(safe_by, charsmax(safe_by), by)
	sql_escape_string(safe_reason, charsmax(safe_reason))
	sql_escape_string(safe_by, charsmax(safe_by))
	
	static query[512]
	formatex(query, charsmax(query), "UPDATE `%s`.`%s_members` SET `seed` = RAND(), `srv_disabled_length` = %d, `srv_disabled_reason` = ^"%s^", `srv_disabled_by` = ^"%s^", `srv_disabled_at` = %d WHERE `id_member` = %d", SMF_DATABASE, SMF_PREFIX, length, safe_reason, safe_by, get_systime(), g_id[id])
	
	static data2[1]
	data2[0] = id
	SQL_ThreadQuery(g_sql_tuple, "_ban_account", query, data2, sizeof(data2))
}
public _ban_account(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	if (logged_in(id))
	{
		logout(id)
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Your account has been banned.")
	}
}

public native_is_activated(id)
{
	return logged_in(id) && g_activated[id];
}

public native_set_num(id, index, value)
{
	if (!g_arrays_created2)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't get because arrays haven't been created yet")
		return;
	}
	
	ArraySetCell(g_nums[id], index, float(value));
}
public set_num(id, index, value)
{
	ArraySetCell(g_nums[id], index, float(value));
}
public native_set_float(id, index, Float:value)
{
	if (!g_arrays_created2)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't get because arrays haven't been created yet")
		return;
	}
	
	ArraySetCell(g_nums[id], index, value);
}
public set_float(id, index, Float:value)
{
	ArraySetCell(g_nums[id], index, value);
	
}
public native_set_string(id, index, const value[])
{
	if (!g_arrays_created2)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't get because arrays haven't been created yet")
		return;
	}
	
	ArraySetString(g_nums[id], index, value);
}
public set_string2(id, index, const value[])
{
	ArraySetString(g_strings[id], index, value);
}

logged_in(id)
{
	return (0 < g_id[id] <= 1000000) && is_user_connected(id);
}

clear_nums(id)
{
	for (new i; i < g_num_i; i++)
		ArraySetCell(g_nums[id], i, Float:ArrayGetCell(g_num_default, i))
}

clear_strings(id)
{
	for (new i; i < g_string_i; i++)
	{
		static default_value[64]
		ArrayGetString(g_string_default, i, default_value, charsmax(default_value))
		ArraySetString(g_strings[id], i, default_value)
	}
}

public native_find_num(const name[])
{
	param_convert(1)
	
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't find yet (%s)", name)
		return -1;
	}
	
	for (new i; i < g_num_i; i++)
	{
		static field_name[32]
		ArrayGetString(g_num_name, i, field_name, charsmax(field_name))
		
		if (equal(field_name, name))
			return i;
	}
	
	return -1;
}

public native_find_string(const name[])
{
	param_convert(1)
	
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't find yet (%s)", name)
		return -1;
	}
	
	for (new i; i < g_string_i; i++)
	{
		static field_name[32]
		ArrayGetString(g_string_name, i, field_name, charsmax(field_name))
		
		if (equal(field_name, name))
			return i;
	}
	
	return -1;
}


public native_get_num(id, index)
{
	if (!g_arrays_created2)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't get because arrays haven't been created yet")
		return -1;
	}
	
	if (!is_user_connected(id))
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't get num: player not connected")
		return -1;
	}
	
	return floatround(Float:ArrayGetCell(g_nums[id], index));
}
public get_num(id, index)
{
	return floatround(Float:ArrayGetCell(g_nums[id], index));
}

public Float:native_get_float(id, index)
{
	if (!g_arrays_created2)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't get because arrays haven't been created yet")
		return -1.0;
	}
	
	if (!is_user_connected(id))
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't get float: player not connected")
		return -1.0;
	}
	
	return Float:ArrayGetCell(g_nums[id], index);
}
public Float:get_float(id, index)
{
	return Float:ArrayGetCell(g_nums[id], index);
}

public native_get_string(id, index, string[], len)
{
	if (!g_arrays_created2)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't get because arrays haven't been created yet")
		return;
	}
	
	if (!is_user_connected(id))
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't get string: player not connected")
		return;
	}
	
	param_convert(3)
	ArrayGetString(g_strings[id], index, string, len)
}
public get_string2(id, index, string[], len)
{
	ArrayGetString(g_strings[id], index, string, len)
}

public native_register_num(const name[], default_value)
{
	// Strings passed byref
	param_convert(1)
	
	// Arrays not yet initialized
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't register anything yet (%s)", name)
		return -1;
	}
	
	new index, item_name[32]
	for (index = 0; index < g_num_i; index++)
	{
		ArrayGetString(g_num_name, index, item_name, charsmax(item_name))
		if (equali(name, item_name))
		{
			log_error(AMX_ERR_NATIVE, "[Bullet Login] Num already registered (%s)", name)
			return -1;
		}
	}
	
	ArrayPushString(g_num_name, name)
	ArrayPushCell(g_num_default, default_value)
	
	// Increase counter
	g_num_i++
	
	return g_num_i-1;
}
public native_register_num2(name[], default_value)
{
	ArrayPushString(g_num_name, name)
	ArrayPushCell(g_num_default, default_value)
	
	g_num_i++
	return g_num_i-1;
}

public native_register_float(const name[], Float:default_value)
{
	// Strings passed byref
	param_convert(1)
	
	// Arrays not yet initialized
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't register anything yet (%s)", name)
		return -1;
	}
	
	new index, item_name[32]
	for (index = 0; index < g_num_i; index++)
	{
		ArrayGetString(g_num_name, index, item_name, charsmax(item_name))
		if (equali(name, item_name))
		{
			log_error(AMX_ERR_NATIVE, "[Bullet Login] Float already registered (%s)", name)
			return -1;
		}
	}
	
	ArrayPushString(g_num_name, name)
	ArrayPushCell(g_num_default, default_value)
	
	// Increase counter
	g_num_i++
	
	return g_num_i-1;
}
public native_register_float2(name[], Float:default_value)
{
	ArrayPushString(g_num_name, name)
	ArrayPushCell(g_num_default, default_value)
	
	g_num_i++
	return g_num_i-1;
}

public native_register_string(const name[], const default_value[])
{
	// Strings passed byref
	param_convert(1)
	param_convert(2)
	
	// Arrays not yet initialized
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[Bullet Login] Can't register anything yet (%s)", name)
		return -1;
	}
	
	new index, item_name[32]
	for (index = 0; index < g_string_i; index++)
	{
		ArrayGetString(g_string_name, index, item_name, charsmax(item_name))
		if (equali(name, item_name))
		{
			log_error(AMX_ERR_NATIVE, "[Bullet Login] String already registered (%s)", name)
			return -1;
		}
	}
	
	ArrayPushString(g_string_name, name)
	ArrayPushString(g_string_default, default_value)
	
	// Increase counter
	g_string_i++
	
	return g_string_i-1;
}
public native_register_string2(name[], default_value[])
{
	ArrayPushString(g_string_name, name)
	ArrayPushString(g_string_default, default_value)
	
	g_string_i++
	return g_string_i-1;
}

public plugin_precache()
{
	g_num_name = ArrayCreate(32, 1)
	g_num_default = ArrayCreate(1, 1)
	
	g_string_name = ArrayCreate(32, 1)
	g_string_default = ArrayCreate(64, 1)
	
	g_arrays_created = true
	
	// Built-in fields
	native_register_num2("dps", 0)
}

hide_password(password[], hidden[], len)
{
	static length
	length = strlen(password)
	if (length > len) length = len
	
	for (new i; i < len; i++)
	{
		hidden[i] = (i < length) ? '*' : 0;
	}
}

public plugin_init()
{
	register_plugin("Bullet SQL", PLUGIN_VERSION, "FLWL")
	
	register_dictionary("time.txt")
	
	cvar_min_name_length = register_cvar("bullet_sql_min_name_length", "3")
	cvar_min_pw_length = register_cvar("bullet_sql_min_pw_length", "5")
	cvar_reward_on_register = register_cvar("bullet_sql_reward_on_register", "0")
	
	register_menu("Bullet SQL Main Menu", KEYSMENU, "handle_menu_main")
	register_menu("Bullet SQL Logged In Menu", KEYSMENU, "handle_menu_loggedin")
	
	register_clcmd("say /login", "show_menu_main")
	register_clcmd("say /register", "show_menu_main")
	register_clcmd("say /logout", "show_menu_main")
	register_clcmd("show_login_menu", "show_menu_main")
	
	register_clcmd("login_username", "set_login_username")
	register_clcmd("login_password", "set_login_password")
	
	register_clcmd("register_username", "set_register_username")
	register_clcmd("register_password", "set_register_password")
	register_clcmd("register_confirm", "set_register_confirmation")
	register_clcmd("register_email", "set_register_email")
	
	register_clcmd("enter_current_password", "set_current_password")
	
	register_clcmd("new_username", "set_new_username")
	register_clcmd("new_password", "set_new_password")
	register_clcmd("confirm_new_password", "confirm_new_password")
	register_clcmd("new_email", "set_new_email")
	
	register_clcmd("please_enter_your_email", "forgot_password")
	
	register_srvcmd("show_login_menu", "srvcmd_show_login_menu")
	
	// Misc
	g_maxplayers = get_maxplayers()
	get_user_ip(0, g_serverip, charsmax(g_serverip), false)
	
	// Init SQL
	register_srvcmd("bullet_sqlinit", "sql_init")
	server_cmd("bullet_sqlinit")
	
	// Build arrays for every player
	for (new i = 1; i <= g_maxplayers; i++)
	{
		g_nums[i] = ArrayCreate(1, 1)
		g_strings[i] = ArrayCreate(64, 1)
		
		for (new j; j < g_num_i; j++)
			ArrayPushCell(g_nums[i], Float:ArrayGetCell(g_num_default, j))
		
		for (new j; j < g_string_i; j++)
		{
			static value[64]
			ArrayGetString(g_string_default, j, value, charsmax(value))
			ArrayPushString(g_strings[i], value)
		}
	}
	
	g_arrays_created2 = true
}

public srvcmd_show_login_menu()
{
	static arg[8], id
	read_argv(1, arg, charsmax(arg))
	id = str_to_num(arg)
	
	if (is_user_connected(id))
		show_menu_main(id)
}

public sql_init()
{
	g_sql_tuple = SQL_MakeStdTuple()
}

public plugin_end()
{
	SQL_FreeHandle(g_sql_tuple)
}

public show_menu_loggedin(id)
{
	if (!logged_in(id))
		return;
	
	static menu[512], len, menukeys
	len = formatex(menu, charsmax(menu), "\y[Bullet Login v%s]^n\dYou are logged in as:\y %s^n^n", PLUGIN_VERSION, g_real_member_name[id])
	menukeys = MENU_KEY_0|MENU_KEY_1|MENU_KEY_9
	
	new password_error[64], pw_ok, hidden_password[64]
	pw_ok = check_password(g_current_password[id], password_error, charsmax(password_error))
	hide_password(g_current_password[id], hidden_password, charsmax(hidden_password))
	
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Enter Current Password:\y %s%s^n", hidden_password, password_error)
	
	if (pw_ok)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Change Username^n")
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Change Password^n")
		len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Change E-Mail\y [Current:\d %s]^n", g_real_email[id])
		menukeys |= MENU_KEY_2|MENU_KEY_3|MENU_KEY_4
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d2. Change Username^n")
		len += formatex(menu[len], charsmax(menu) - len, "\d3. Change Password^n")
		len += formatex(menu[len], charsmax(menu) - len, "\d4. Change E-Mail [Current: %s]^n", g_real_email[id])
	}
	
	len += formatex(menu[len], charsmax(menu) - len, "^n\r9.\w Log Out^n")
	
	len += formatex(menu[len], charsmax(menu) - len, "\r0.\w Back")
	
	show_menu(id, menukeys, menu, -1, "Bullet SQL Logged In Menu")
}
public handle_menu_loggedin(id, key)
{
	switch (key)
	{
		case 0: // 1. Enter Current Password
		{
			client_cmd(id, "messagemode enter_current_password")
		}
		case 1: // 2. Change Username
		{
			client_cmd(id, "messagemode new_username")
		}
		case 2: // 3. Change Password
		{
			client_cmd(id, "messagemode new_password")
		}
		case 3: // 4. Change E-Mail
		{
			client_cmd(id, "messagemode new_email")
		}
		case 8: // 2. Log Out
		{
			g_autolog_after_saving[id] = 2
			logout(id)
		}
		case 9: // Back
		{
			client_cmd(id, "bullet_sql_return")
		}
	}
}

public show_menu_main(id)
{
	if (logged_in(id))
	{
		show_menu_loggedin(id)
		return PLUGIN_HANDLED;
	}
	
	static menu[512], len, menukeys
	len = formatex(menu, charsmax(menu), "\y[Bullet Login v%s]^n\d%s^n^n", PLUGIN_VERSION, g_id[id] == -1 ? "You progress is not saved unless you log in." : "Your progress is being saved to a Guest account.")
	menukeys = MENU_KEY_0|MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_9
	
	// Login check
	new username_error[64], password_error[64], name_ok, pw_ok, hidden_password[64]
	name_ok = check_username(g_login_username[id], username_error, charsmax(username_error))
	pw_ok = check_password(g_login_password[id], password_error, charsmax(password_error))
	hide_password(g_login_password[id], hidden_password, charsmax(hidden_password))
	
	len += formatex(menu[len], charsmax(menu) - len, "\d---- LOGIN ----^n")
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Username:\y %s%s^n", g_login_username[id], username_error)
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Password:\y %s%s^n", hidden_password, password_error)
	len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Remember Me: %s^n", g_remember_me[id] ? "\yYES" : "\rNO")
	
	if (name_ok && pw_ok)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Login^n^n")
		menukeys |= MENU_KEY_4
	}
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d4. Login^n^n")
	
	// Registration check
	new email_ok, username_error2[64], password_error2[64], email_error2[64], hidden_password2[64]
	name_ok = check_username(g_register_username[id], username_error2, charsmax(username_error2))
	pw_ok = check_password(g_register_password[id], password_error2, charsmax(password_error2))
	email_ok = check_email(g_register_email[id], email_error2, charsmax(email_error2))
	hide_password(g_register_password[id], hidden_password2, charsmax(hidden_password2))
	
	// Extra check for registration
	if (pw_ok && !equal(g_register_password[id], g_register_confirmation[id]))
	{
		formatex(password_error2, charsmax(password_error2), "\r [confirmation does not match]")
		pw_ok = false
	}
	
	len += formatex(menu[len], charsmax(menu) - len, "\d---- CREATE A NEW ACCOUNT ----^n")
	len += formatex(menu[len], charsmax(menu) - len, "\r5.\w Username:\y %s%s^n", g_register_username[id], username_error2)
	len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Password:\y %s%s^n", hidden_password2, password_error2)
	len += formatex(menu[len], charsmax(menu) - len, "\r7.\w E-Mail:\y %s%s^n", g_register_email[id], email_error2)
	
	if (name_ok && pw_ok && email_ok)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r8.\w Create Account^n^n")
		menukeys |= MENU_KEY_8
	}
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d8. Create Account^n^n")
	
	len += formatex(menu[len], charsmax(menu) - len, "\r9.\w Forgot Password?^n")
	
	len += formatex(menu[len], charsmax(menu) - len, "\r0.\w Back")
	
	show_menu(id, menukeys, menu, -1, "Bullet SQL Main Menu")
	return PLUGIN_HANDLED;
}

check_username(username[32], error[], len)
{
	if (strlen(username) == 0)
	{
		formatex(error, len, "\r[enter a username]")
		return false;
	}
	else if (strlen(username) < get_pcvar_num(cvar_min_name_length))
	{
		formatex(error, len, "\r [must be at least %d characters]", get_pcvar_num(cvar_min_name_length))
		return false;
	}
	
	return true;
}

check_password(password[64], error[], len)
{
	if (strlen(password) == 0)
	{
		formatex(error, len, "\r[enter password]")
		return false;
	}
	else if (strlen(password) < get_pcvar_num(cvar_min_pw_length))
	{
		formatex(error, len, "\r [must be at least 5 characters]")
		return false;
	}
	
	return true;
}

check_email(email[64], error[], len)
{
	if (strlen(email) == 0)
	{
		formatex(error, len, "\r[enter an e-mail]")
		return false;
	}
	else if (!is_valid_email(email))
	{
		formatex(error, len, "\r [invalid e-mail]")
		return false;
	}
	
	return true;
}

is_valid_email(const email_address[])
{
	new pos_at, pos_dot, temp[128]
	replace_all(temp, copy(temp , strlen(email_address), email_address) , " " , "")
	
	pos_at = strfind(temp, "@")
	pos_dot = strfind(temp, ".")
	
	return ((pos_at > 0) && (pos_dot > (pos_at + 1)) && strlen(temp[pos_dot + 1]));
}

public handle_menu_main(id, key)
{
	switch (key)
	{
		case 0: // 1. Username
		{
			client_cmd(id, "messagemode login_username")
		}
		case 1: // 2. Password
		{
			client_cmd(id, "messagemode login_password")
		}
		case 2: // 3. Remember Me
		{
			g_remember_me[id] = !g_remember_me[id]
			show_menu_main(id)
		}
		case 3: // 4. Finish login
		{
			if (g_id[id] == 0 || g_id[id] > 1000000)
			{
				g_autolog_after_saving[id] = 1
				logout(id)
			}
			else
				login(id, false)
		}
		case 4: // 5. register Username
		{
			client_cmd(id, "messagemode register_username")
		}
		case 5: // 6. register Password
		{
			client_cmd(id, "messagemode register_password")
		}
		case 6: // 7. register E-Mail
		{
			client_cmd(id, "messagemode register_email")
		}
		case 7: // 8. Create account
		{
			create_account(id)
		}
		case 8: // 9. Forgot Password?
		{
			client_cmd(id, "messagemode please_enter_your_email")
		}
		case 9: // 0. Back
		{
			client_cmd(id, "bullet_sql_return")
		}
	}
}

create_account(id)
{
	static safe_name[50], safe_email[72]
	copy(safe_name, charsmax(safe_name), g_register_username[id])
	copy(safe_email, charsmax(safe_email), g_register_email[id])
	sql_escape_string(safe_name, charsmax(safe_name))
	sql_escape_string(safe_email, charsmax(safe_email))
	
	static query[512]
	formatex(query, charsmax(query), "SELECT `id_member` FROM `%s`.`%s_members` WHERE (`member_name` = ^"%s^" OR (`email_address` = ^"%s^" AND `is_activated` = 1))", SMF_DATABASE, SMF_PREFIX, safe_name, safe_email)
	
	static data[1]
	data[0] = id
	SQL_ThreadQuery(g_sql_tuple, "_create_account_check", query, data, sizeof(data))
}
public _create_account_check(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	if (SQL_NumResults(query))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Registration failed:^1 Account name or e-mail is already in use.")
		show_menu_main(id)
		return;
	}
	
	static safe_name[50], safe_password[72], ip[16], safe_email[72]
	get_user_ip(id, ip, charsmax(ip), true)
	copy(safe_name, charsmax(safe_name), g_register_username[id])
	copy(safe_password, charsmax(safe_password), g_register_password[id])
	copy(safe_email, charsmax(safe_email), g_register_email[id])
	sql_escape_string(safe_name, charsmax(safe_name))
	sql_escape_string(safe_password, charsmax(safe_password))
	sql_escape_string(safe_email, charsmax(safe_email))
	
	static query2[512]
	formatex(query2, charsmax(query2), "INSERT INTO `%s`.`%s_members` (`member_name`, `real_name`, `date_registered`, `passwd`, `member_ip`, `member_ip2`, `email_address`, `id_post_group`, `hide_email`, `is_activated`, `cron_send_email`) VALUES (^"%s^", ^"%s^", %d, SHA1(CONCAT(LOWER(^"%s^"), ^"%s^")), '%s', '%s', ^"%s^", 4, 1, 0, 1)", SMF_DATABASE, SMF_PREFIX, safe_name, safe_name, get_systime(), safe_name, safe_password, ip, ip, safe_email)
	
	SQL_ThreadQuery(g_sql_tuple, "_create_account", query2, data, datasize)
}
public _create_account(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Account created:^1 You may login now.^3 Please note that in order to access the full range of")
	client_print_color(id, 0, "^3features you might have to verify your e-mail account by clicking on a link sent to^4 %s^3's inbox.", g_register_email[id])
	show_menu_main(id)
	
	reward_on_register(id, SQL_GetInsertId(query))
}

reward_on_register(id, account_id)
{
	static amount
	amount = get_pcvar_num(cvar_reward_on_register)
	
	if (amount <= 0 || account_id <= 0)
		return;
	
	static created, expired
	created = get_systime()
	expired = created + amount * 86400
	
	static query1[512]
	formatex(query1, charsmax(query1), "UPDATE `%s`.`%s_members` SET ashow = 1, days = %d, created = %d, expired = %d, access = ^"%s^" WHERE id_member = %d", SMF_DATABASE, SMF_PREFIX, amount, created, expired, REWARD_FLAGS[0], account_id)
	SQL_ThreadQuery(g_sql_tuple, "_reward_on_register", query1)
	
	for (new i; i < sizeof(REWARD_SERVERS); i++)
	{
		formatex(query1, charsmax(query1), "INSERT INTO `%s`.`amx_admins_servers` (admin_id, server_id, custom_flags, use_static_bantime) VALUES (%d, %d, ^"%s^", 'yes')", SMF_DATABASE, account_id, REWARD_SERVERS[i], REWARD_FLAGS[i])
		SQL_ThreadQuery(g_sql_tuple, "_reward_on_register", query1)
	}
	
	client_print_color(id, 0, "^1[^4Bullet Login^1] You have been personally selected by ^4 Bullet Management^1 as a participant of our^4 exclusive %d-month %s service trial^1!", amount, REWARD_NAME)
	client_print_color(id, 0, "^1[^4Bullet Login^1] Login with your freshly created account and enjoy^1!", amount, REWARD_NAME)
}
public _reward_on_register(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
}

public set_login_username(id)
{
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_login_username[id], charsmax(g_login_username[]), data)
	show_menu_main(id)
	return PLUGIN_HANDLED;
}
public set_login_password(id)
{
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_login_password[id], charsmax(g_login_password[]), data)
	show_menu_main(id)
	return PLUGIN_HANDLED;
}
public set_register_username(id)
{
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_register_username[id], charsmax(g_register_username[]), data)
	show_menu_main(id)
	return PLUGIN_HANDLED;
}
public set_register_password(id)
{
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_register_password[id], charsmax(g_register_password[]), data)
	client_cmd(id, "messagemode register_confirm")
	return PLUGIN_HANDLED;
}
public set_register_confirmation(id)
{
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_register_confirmation[id], charsmax(g_register_confirmation[]), data)
	show_menu_main(id)
	return PLUGIN_HANDLED;
}
public set_register_email(id)
{
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_register_email[id], charsmax(g_register_email[]), data)
	show_menu_main(id)
	return PLUGIN_HANDLED;
}

public set_current_password(id)
{
	if (!logged_in(id))
		return PLUGIN_HANDLED;
	
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_current_password[id], charsmax(g_current_password[]), data)
	show_menu_loggedin(id)
	return PLUGIN_HANDLED;
}
public set_new_password(id)
{
	if (!logged_in(id))
		return PLUGIN_HANDLED;
	
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_new_password[id], charsmax(g_new_password[]), data)
	client_cmd(id, "messagemode confirm_new_password")
	return PLUGIN_HANDLED;
}
public confirm_new_password(id)
{
	if (!logged_in(id))
		return PLUGIN_HANDLED;
	
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_new_password2[id], charsmax(g_new_password2[]), data)
	
	if (!equal(g_new_password[id], g_new_password2[id]))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Password change failed:^1 Passwords do not match.")
		show_menu_loggedin(id)
		return PLUGIN_HANDLED;
	}
	else if (strlen(g_new_password[id]) < get_pcvar_num(cvar_min_pw_length))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Password change failed:^1 Password must be at least^4 %d characters long^1.", get_pcvar_num(cvar_min_pw_length))
		show_menu_loggedin(id)
		return PLUGIN_HANDLED;
	}
	
	if (g_remember_me[id])
		client_cmd(id, "setinfo _bpw ^"%s^"", g_new_password[id])
	
	static query[512], safe_new_password[72], safe_name[72], safe_password[72]
	copy(safe_new_password, charsmax(safe_new_password), g_current_password[id])
	copy(safe_name, charsmax(safe_name), g_real_member_name[id])
	copy(safe_password, charsmax(safe_password), g_new_password[id])
	sql_escape_string(safe_new_password, charsmax(safe_new_password))
	sql_escape_string(safe_name, charsmax(safe_name))
	sql_escape_string(safe_password, charsmax(safe_password))
	formatex(query, charsmax(query), "UPDATE `%s`.`%s_members` SET `passwd` = SHA1(CONCAT(LOWER(^"%s^"), ^"%s^")), `seed` = RAND() WHERE `id_member` = %d AND `passwd` = SHA1(CONCAT(LOWER(^"%s^"), ^"%s^"))", SMF_DATABASE, SMF_PREFIX, safe_name, safe_new_password, g_id[id], safe_name, safe_password)
	
	static data2[1]
	data2[0] = id
	SQL_ThreadQuery(g_sql_tuple, "_change_password", query, data2, sizeof(data2))
	return PLUGIN_HANDLED;
}
public _change_password(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	if (SQL_AffectedRows(query))
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Password changed^1.")
	else
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Password change failed:^1 Invalid current password.")
	
	show_menu_main(id)
}
public set_new_username(id)
{
	if (!logged_in(id))
		return PLUGIN_HANDLED;
	
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_new_username[id], charsmax(g_new_username[]), data)
	
	if (strlen(g_new_username[id]) < get_pcvar_num(cvar_min_name_length))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Username change failed:^1 Username must be at least^4 %d characters long^1.", get_pcvar_num(cvar_min_name_length))
		show_menu_loggedin(id)
		return PLUGIN_HANDLED;
	}
	
	static safe_new_name[72]
	copy(safe_new_name, charsmax(safe_new_name), g_new_username[id])
	
	static query[512]
	formatex(query, charsmax(query), "SELECT `id_member` FROM `%s`.`%s_members` WHERE `member_name` = ^"%s^"", SMF_DATABASE, SMF_PREFIX, safe_new_name)
	
	static data2[1]
	data2[0] = id
	SQL_ThreadQuery(g_sql_tuple, "_change_username_check", query, data2, sizeof(data2))
	return PLUGIN_HANDLED;
}
public _change_username_check(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	if (SQL_NumResults(query))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Username change failed:^1 Account with that name already exists.")
		show_menu_main(id)
		return;
	}
	
	if (g_remember_me[id])
		client_cmd(id, "setinfo _bname ^"%s^"", g_new_username[id])
	
	static query[512], safe_new_name[72], safe_name[72], safe_password[72]
	copy(safe_new_name, charsmax(safe_new_name), g_new_username[id])
	copy(safe_name, charsmax(safe_name), g_real_member_name[id])
	copy(safe_password, charsmax(safe_password), g_current_password[id])
	sql_escape_string(safe_new_name, charsmax(safe_new_name))
	sql_escape_string(safe_name, charsmax(safe_name))
	sql_escape_string(safe_password, charsmax(safe_password))
	formatex(query, charsmax(query), "UPDATE `%s`.`%s_members` SET `member_name` = ^"%s^", `real_name` = ^"%s^", `passwd` = SHA1(CONCAT(LOWER(^"%s^"), ^"%s^")), `seed` = RAND() WHERE `id_member` = %d AND `passwd` = SHA1(CONCAT(LOWER(^"%s^"), ^"%s^"))", SMF_DATABASE, SMF_PREFIX, safe_new_name, safe_new_name, safe_new_name, safe_password, g_id[id], safe_name, safe_password)
	
	static data2[1]
	data2[0] = id
	SQL_ThreadQuery(g_sql_tuple, "_change_username", query, data2, sizeof(data2))
}
public _change_username(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	if (SQL_AffectedRows(query))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Username changed^1.")
		copy(g_real_member_name[id], charsmax(g_real_member_name[]), g_new_username[id])
	}
	else
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Username change failed:^1 Invalid current password.")
	
	show_menu_main(id)
}
public set_new_email(id)
{
	if (!logged_in(id))
		return PLUGIN_HANDLED;
	
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_new_email[id], charsmax(g_new_email[]), data)
	
	if (!is_valid_email(data))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 E-Mail change failed:^1 Invalid e-mail.")
		
		show_menu_main(id)
		return PLUGIN_HANDLED;
	}
	
	static safe_new_email[72]
	copy(safe_new_email, charsmax(safe_new_email), g_new_email[id])
	
	static query[512]
	formatex(query, charsmax(query), "SELECT `id_member` FROM `%s`.`%s_members` WHERE `email_address` = ^"%s^" AND `is_activated` = 1", SMF_DATABASE, SMF_PREFIX, safe_new_email)
	
	static data2[1]
	data2[0] = id
	SQL_ThreadQuery(g_sql_tuple, "_change_email_check", query, data2, sizeof(data2))
	return PLUGIN_HANDLED;
}

public _change_email_check(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	if (SQL_NumResults(query))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 E-mail change failed:^1 Account with that e-mail already exists.")
		show_menu_main(id)
		return;
	}
	
	static query2[512], safe_email[72], safe_name[72], safe_password[72]
	copy(safe_email, charsmax(safe_email), g_new_email[id])
	copy(safe_name, charsmax(safe_name), g_real_member_name[id])
	copy(safe_password, charsmax(safe_password), g_current_password[id])
	sql_escape_string(safe_email, charsmax(safe_email))
	sql_escape_string(safe_name, charsmax(safe_name))
	sql_escape_string(safe_password, charsmax(safe_password))
	formatex(query2, charsmax(query2), "UPDATE `%s`.`%s_members` SET `email_address` = ^"%s^", `cron_send_email` = 1, `is_activated` = 0, `seed` = RAND() WHERE `id_member` = %d AND `passwd` = SHA1(CONCAT(LOWER(^"%s^"), ^"%s^"))", SMF_DATABASE, SMF_PREFIX, safe_email, g_id[id], safe_name, safe_password)
	
	static data2[1]
	data2[0] = id
	SQL_ThreadQuery(g_sql_tuple, "_change_email", query2, data2, sizeof(data2))
}
public _change_email(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	if (SQL_AffectedRows(query))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 E-Mail changed^1.")
		copy(g_real_email[id], charsmax(g_real_email[]), g_new_email[id])
	}
	else
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 E-Mail change failed:^1 Invalid current password.")
	
	show_menu_main(id)
}
public forgot_password(id)
{
	static data[72]
	read_args(data, charsmax(data))
	remove_quotes(data)
	
	copy(g_forgot_password_email[id], charsmax(g_forgot_password_email[]), data)
	
	static safe_email[72]
	copy(safe_email, charsmax(safe_email), g_forgot_password_email[id])
	sql_escape_string(safe_email, charsmax(safe_email))
	
	static query[512]
	formatex(query, charsmax(query), "UPDATE `%s`.`%s_members` SET `seed` = RAND(), `cron_req_recovery` = 1 WHERE `email_address` = ^"%s^"", SMF_DATABASE, SMF_PREFIX, safe_email)
	
	static data2[1]
	data2[0] = id
	SQL_ThreadQuery(g_sql_tuple, "_forgot_password", query, data2, sizeof(data2))
	return PLUGIN_HANDLED;
}
public _forgot_password(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	if (SQL_AffectedRows(query))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 An e-mail with instructions on how to reset your password has been sent to^3 %s^1.", g_forgot_password_email[id])
		copy(g_real_email[id], charsmax(g_real_email[]), g_new_email[id])
	}
	else
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Password recovery failed:^1 No account with e-mail^3 %s^1.", g_forgot_password_email[id])
	
	show_menu_main(id)
}

login(id, auto = true)
{
	if (g_system_busy[id] || g_saving_data[id] || !is_user_connected(id))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Login system is busy, please try again later...")
		return;
	}
	
	client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Logging in...")
	g_system_busy[id] = true
	
	// Save credentials to client's memory if remember me is selected
	if (g_remember_me[id])
	{
		client_cmd(id, "setinfo _bname ^"%s^"", g_login_username[id])
		client_cmd(id, "setinfo _bpw ^"%s^"", g_login_password[id])
	}
	
	static safe_name[50], safe_password[72]
	copy(safe_name, charsmax(safe_name), g_login_username[id])
	copy(safe_password, charsmax(safe_password), g_login_password[id])
	sql_escape_string(safe_name, charsmax(safe_name))
	sql_escape_string(safe_password, charsmax(safe_password))
	
	static query[1024], len
	len = formatex(query, charsmax(query), "SELECT `sm`.`id_member`, `sm`.`member_name`, `sm`.`email_address`, `sm`.`is_activated`, `sm`.`srv_disabled_length`, `sm`.`srv_disabled_reason`, `sm`.`srv_disabled_by`, `sm`.`srv_disabled_at`, `sm`.`access`, `aas`.`custom_flags`, `aas`.`use_static_bantime`, `bd`.`id` FROM `%s`.`%s_members` AS `sm`", SMF_DATABASE, SMF_PREFIX)
	len += formatex(query[len], charsmax(query) - len,  "LEFT JOIN `%s`.`amx_serverinfo` AS `asi` ON (`asi`.`address` = '%s')", SMF_DATABASE, g_serverip)
	len += formatex(query[len], charsmax(query) - len,  "LEFT JOIN `%s`.`amx_admins_servers` AS `aas` ON (`sm`.`id_member` = `aas`.`admin_id` AND `aas`.`server_id` = `asi`.`id`)", SMF_DATABASE)
	len += formatex(query[len], charsmax(query) - len,  "LEFT JOIN `bullet_data` AS `bd` ON (`sm`.`id_member` = `bd`.`id`) ", SMF_DATABASE)
	len += formatex(query[len], charsmax(query) - len,  "WHERE `sm`.`member_name` = ^"%s^" AND `sm`.`passwd` = SHA1(CONCAT(LOWER(^"%s^"), ^"%s^"))", safe_name, safe_name, safe_password)
	
	static data[3]
	data[0] = id
	data[1] = auto
	SQL_ThreadQuery(g_sql_tuple, "_login", query, data, sizeof(data))
}
public _login(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		g_system_busy[data[0]] = false
		return;
	}
	
	static id, auto
	id = data[0]
	auto = data[1]
	
	if (!SQL_NumResults(query))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Login failed:^1 Invalid username and/or password...")
		g_system_busy[id] = false
		
		if (g_id[id] == -1)
		{
			if (!auto)
				g_show_menu_after_logout[id] = true
			
			login_as_a_guest(id)
		}
		
		return;
	}
	
	static disabled_length, disabled_at, disabled_ends
	disabled_length = SQL_ReadResult(query, SQL_FieldNameToNum(query, "srv_disabled_length"))
	disabled_at = SQL_ReadResult(query, SQL_FieldNameToNum(query, "srv_disabled_at"))
	disabled_ends = disabled_at + (disabled_length * 60)
	
	if (disabled_ends > get_systime() || disabled_at > 0 && disabled_length == 0)
	{
		static disabled_reason[64], disabled_by[32]
		SQL_ReadResult(query, SQL_FieldNameToNum(query, "srv_disabled_reason"), disabled_reason, charsmax(disabled_reason))
		SQL_ReadResult(query, SQL_FieldNameToNum(query, "srv_disabled_by"), disabled_by, charsmax(disabled_by))
		
		if (disabled_length == 0)
		{
			client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Login failed:^1 Your account is disabled^4 permanently^1 for^4 %s^1 by^3 %s^1.", disabled_reason, disabled_by)
		}
		else
		{
			static time_remaining[64]
			get_time_length(id, disabled_ends - get_systime(), timeunit_seconds, time_remaining, charsmax(time_remaining))
			
			client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Login failed:^1 Your account is disabled for another^4 %s^1 for^4 %s^1 by^3 %s^1.", time_remaining, disabled_reason, disabled_by)
		}
		
		g_system_busy[id] = false
		
		if (g_id[id] == -1)
		{
			if (!auto)
				g_show_menu_after_logout[id] = true
			
			login_as_a_guest(id)
		}
		
		return;
	}
	
	// Correct credentials
	g_temp_id[id] = SQL_ReadResult(query, SQL_FieldNameToNum(query, "id_member"))
	SQL_ReadResult(query, SQL_FieldNameToNum(query, "member_name"), g_real_member_name[id], charsmax(g_real_member_name[]))
	SQL_ReadResult(query, SQL_FieldNameToNum(query, "email_address"), g_real_email[id], charsmax(g_real_email[]))
	g_activated[id] = SQL_ReadResult(query, SQL_FieldNameToNum(query, "is_activated"))
	
	if (!g_activated[id])
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^3 Please note that your e-mail^4 %s^1 is not verified. Please check your inbox", g_real_email[id])
		client_print_color(id, 0, "^1and activate your account in order to access the full range of features this server has to offer.")
	}
	
	static custom_flags[32], access_flags[32], static_bantime
	SQL_ReadResult(query, SQL_FieldNameToNum(query, "custom_flags"), custom_flags, charsmax(custom_flags))
	SQL_ReadResult(query, SQL_FieldNameToNum(query, "access"), access_flags, charsmax(access_flags))
	static_bantime = SQL_ReadResult(query, SQL_FieldNameToNum(query, "use_static_bantime"))
	
	if (strlen(custom_flags) > 0 || strlen(access_flags) > 0)
	{
		remove_user_flags(id)
		
		if (strlen(custom_flags) > 0)
			set_user_flags(id, read_flags(custom_flags))
		else if (strlen(access_flags) > 0)
			set_user_flags(id, read_flags(access_flags))
		
		static amxlog_name[32], amxlog_authid[34], amxlog_ip[16]
		get_user_name(id, amxlog_name, charsmax(amxlog_name))
		get_user_authid(id, amxlog_authid, charsmax(amxlog_authid))
		get_user_ip(id, amxlog_ip, charsmax(amxlog_ip), true)
		
		log_amx("Login: ^"%s<%d><%s><>^" became an admin (account ^"%s^") (access ^"%s^") (address ^"%s^") (static %d)", \
				amxlog_name, get_user_userid(id), amxlog_authid, g_real_member_name[id], (strlen(custom_flags) > 0) ? custom_flags : access_flags, amxlog_ip,static_bantime)
	}
	
	// Maybe someone is already logged in with this very account, who knows?
	for (new i = 1; i <= g_maxplayers; i++)
	{
		if (is_user_connected(i) && i != id && (g_temp_id[id] == g_id[i] || g_temp_id[id] == g_temp_id[i]))
		{
			static other_name[32]
			get_user_name(i, other_name, charsmax(other_name))
			client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Login failed: %s^1 is already logged in with this account^1...", other_name)
			
			g_temp_id[id] = -1
			g_system_busy[id] = false
			
			if (g_id[id] == -1)
			{
				if (!auto)
					g_show_menu_after_logout[id] = true
				
				login_as_a_guest(id)
			}
			
			return;
		}
	}
	
	static check_duplicate_login
	check_duplicate_login = SQL_ReadResult(query, SQL_FieldNameToNum(query, "id"))
	
	load_data(id, check_duplicate_login)
}

login_as_a_guest(id)
{
	if (g_system_busy[id] || g_saving_data[id] || !is_user_connected(id))
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Login system is busy, please try again later...")
		return;
	}
	
	client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Logging in as a^3 Guest^1...")
	g_system_busy[id] = true
	
	static query[512]
	formatex(query, charsmax(query), "SELECT `id`, `lock_server` FROM `%s`.`bullet_data` WHERE `auth` = ^"%s^" AND `id` > 1000000", SMF_DATABASE, g_auth[id])
	
	static data[1]
	data[0] = id
	SQL_ThreadQuery(g_sql_tuple, "_login_as_a_guest", query, data, sizeof(data))
}
public _login_as_a_guest(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		g_system_busy[data[0]] = false
		return;
	}
	
	static id
	id = data[0]
	
	if (!SQL_NumResults(query)) // New guest
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Logged in as a new^3 Guest^1.")
		g_id[id] = 0
		g_temp_id[id] = -1
		g_system_busy[id] = false
		
		show_menu_main(id)
		return;
	}
	
	// Juba tuntud mängija
	g_temp_id[id] = SQL_ReadResult(query, SQL_FieldNameToNum(query, "id"))
	
	// Kontrollime, et serveris ei oleks korraga 2 sama ID-ga kasutajat
	for (new i = 1; i <= g_maxplayers; i++)
	{
		if (is_user_connected(i) && i != id && (g_temp_id[id] == g_id[i] || g_temp_id[id] == g_temp_id[i]))
		{
			if (has_id(id) && has_id(i))
			{
				// Keegi on sama ID'ga sees, kickime ta välja sisse logides
				server_cmd("kick #%d ^"Someone else logged in with your ID.^"", get_user_userid(i))
			}
			else
			{
				// Keegi on sama IP'ga juba sisse logitud, meie ei saa
				g_id[id] = -1
				g_temp_id[id] = -1
				g_system_busy[id] = false
				return;
			}
		}
	}
	
	load_data(id)
}

public client_putinserver(id)
{
	g_id[id] = -1
	g_temp_id[id] = -1
	g_activated[id] = false
	g_remember_me[id] = true
	g_show_menu_after_logout[id] = false
	clear_nums(id)
	clear_strings(id)
	
	g_current_password[id] = ""
	g_register_password[id] = ""
	g_register_confirmation[id] = ""
	g_register_email[id] = ""
	g_real_member_name[id] = ""
	g_real_email[id] = ""
	g_new_email[id] = ""
	g_new_password[id] = ""
	g_new_password2[id] = ""
	g_new_username[id] = ""
	g_forgot_password_email[id] = ""
	
	get_user_name(id, g_register_username[id], charsmax(g_register_username[]))
	get_user_info(id, "_bname", g_login_username[id], charsmax(g_login_username[]))
	get_user_info(id, "_bpw", g_login_password[id], charsmax(g_login_password[]))
	
	get_user_authid(id, g_auth[id], charsmax(g_auth[]))
	if (!has_id(id)) get_user_ip(id, g_auth[id], charsmax(g_auth[]), true)
	
	// We have name and password, login right away
	if (g_login_username[id][0] && g_login_password[id][0])
		login(id)
	else
		login_as_a_guest(id)
	
	remove_user_flags(id)
	static def_access[32]
	get_cvar_string("amx_default_access", def_access, charsmax(def_access))
	set_user_flags(id, read_flags(def_access))
}

public client_disconnect(id)
{
	logout(id)
}

public logout(id)
{
	if (g_id[id] == -1)
		return;
	
	remove_user_flags(id)
	static def_access[32]
	get_cvar_string("amx_default_access", def_access, charsmax(def_access))
	set_user_flags(id, read_flags(def_access))
	
	save_data(id)
	g_id[id] = -1
	g_temp_id[id] = -1
}

has_id(id) return g_auth[id][7] == ':';

sql_escape_string(string[], len)
{
	replace_all(string, len, "\", "\\")
	replace_all(string, len, "^"", "\^"")
}

load_data(id, check_duplicate = true)
{
	static data[3]
	data[0] = id
	data[1] = check_duplicate
	
	static query[1024]
	formatex(query, charsmax(query), "UPDATE `%s`.`bullet_data` SET `lock_server` = '%s', `dps` = `dps`+`dps_buffer`, `dps_buffer` = 0, `seed` = RAND() WHERE `id` = %d AND (`lock_server` = '' OR `lock_server` = '%s')", SMF_DATABASE, g_serverip, g_temp_id[id], g_serverip)
	
	SQL_ThreadQuery(g_sql_tuple, "_load_data_lock", query, data, sizeof(data))
}
public _load_data_lock(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		g_system_busy[data[0]] = false
		return;
	}
	
	static id
	id = data[0]
	
	if (!SQL_AffectedRows(query) && data[1])
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Login failed:^1 your IP or SteamID is already being used in an another server.")
		g_temp_id[id] = -1;
		g_system_busy[id] = false
		return;
	}
	
	g_connected_at[id] = get_systime()
	
	static query2[512]
	formatex(query2, charsmax(query2), "SELECT * FROM `%s`.`bullet_data` WHERE `id` = %d", SMF_DATABASE, g_temp_id[id])
	
	SQL_ThreadQuery(g_sql_tuple, "_load_data", query2, data, datasize)
}

public _load_data(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		g_system_busy[data[0]] = false
		return;
	}
	
	static id
	id = data[0]
	
	if (!SQL_NumResults(query) && g_temp_id[id] > 1000000)
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Welcome to the server for the first time,^3 Guest^1!")
		g_system_busy[id] = false
		return;
	}
	else if (SQL_NumResults(query))
	{
		for (new i; i < g_num_i; i++)
		{
			static field_name[32]
			ArrayGetString(g_num_name, i, field_name, charsmax(field_name))
			
			static field_value[64]
			SQL_ReadResult(query, SQL_FieldNameToNum(query, field_name), field_value, charsmax(field_value))
			set_float(id, i, str_to_float(field_value))
		}
		
		for (new i; i < g_string_i; i++)
		{
			static field_name[32]
			ArrayGetString(g_string_name, i, field_name, charsmax(field_name))
			
			static field_value[64]
			SQL_ReadResult(query, SQL_FieldNameToNum(query, field_name), field_value, charsmax(field_value))
			set_string2(id, i, field_value)
		}
	}
	
	g_id[id] = g_temp_id[id]
	g_temp_id[id] = -1
	g_system_busy[id] = false
	
	if (g_id[id] > 1000000)
	{
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Logged in as a^3 Guest^1.")
		if (g_show_menu_after_logout[id])
		{
			show_menu_main(id)
			g_show_menu_after_logout[id] = false
		}
	}
	else
		client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Logged in as:^3 %s^1.", g_real_member_name[id])
}

save_data(id)
{
	g_saving_data[id] = true
	
	static query[4096], len
	
	// Core vars
	static name[32], ip[16]
	get_user_name(id, name, charsmax(name))
	get_user_ip(id, ip, charsmax(ip), true)
	sql_escape_string(name, charsmax(name))
	
	// initialization and core stuff
	len = formatex(query, charsmax(query), "INSERT INTO `%s`.`bullet_data` (`id`, `auth`, `ip`, `name`, `last_visit`, `time_played`%s", SMF_DATABASE, (g_num_i || g_string_i) ? ", " : "")
	
	for (new i; i < g_num_i; i++) // num names
	{
		static field_name[32]
		ArrayGetString(g_num_name, i, field_name, charsmax(field_name))
		
		len += formatex(query[len], charsmax(query) - len, "`%s`%s", field_name, (i == g_num_i-1) ? "" : ", ")
	}
	
	if (g_string_i)
		len += formatex(query[len], charsmax(query) - len, ", ")
	
	for (new i; i < g_string_i; i++) // string names
	{
		static field_name[32]
		ArrayGetString(g_string_name, i, field_name, charsmax(field_name))
		
		len += formatex(query[len], charsmax(query) - len, "`%s`%s", field_name, (i == g_string_i-1) ? "" : ", ")
	}
	
	static sz_id[256]
	if (g_id[id] > 0) // old account
		formatex(sz_id, charsmax(sz_id), "VALUES (%d", g_id[id])
	else
		formatex(sz_id, charsmax(sz_id), "(SELECT 1 + GREATEST(1000000, COALESCE((SELECT MAX(id) FROM `%s`.`bullet_data`), 0))", SMF_DATABASE)
	
	len += formatex(query[len], charsmax(query) - len, ") %s, '%s', '%s', ^"%s^", %d, %d%s", sz_id, g_auth[id], ip, name, get_systime(), get_systime() - g_connected_at[id], (g_num_i || g_string_i) ? ", " : "")
	
	for (new i; i < g_num_i; i++) // actual nums
	{
		len += formatex(query[len], charsmax(query) - len, "%d%s", get_num(id, i), (i == g_num_i-1) ? "" : ", ")
	}
	
	if (g_string_i)
		len += formatex(query[len], charsmax(query) - len, ", ")
	
	for (new i; i < g_string_i; i++) // actual strings
	{
		static field_value[64]
		get_string2(id, i, field_value, charsmax(field_value))
		
		len += formatex(query[len], charsmax(query) - len, "^"%s^"%s", field_value, (i == g_string_i-1) ? "" : ", ")
	}
	
	len += formatex(query[len], charsmax(query) - len, ") ON DUPLICATE KEY UPDATE `auth` = '%s', `ip` = '%s', `name` = ^"%s^", `last_visit` = %d, `time_played` = `time_played` + %d, `lock_server` = ''%s", g_auth[id], ip, name, get_systime(), get_systime() - g_connected_at[id], (g_num_i || g_string_i) ? ", " : "")
	
	for (new i; i < g_num_i; i++) // actual ints, floats
	{
		static field_name[32]
		ArrayGetString(g_num_name, i, field_name, charsmax(field_name))
		
		len += formatex(query[len], charsmax(query) - len, "`%s` = %d%s", field_name, get_num(id, i), (i == g_num_i-1) ? "" : ", ")
	}
	
	if (g_string_i)
		len += formatex(query[len], charsmax(query) - len, ", ")
	
	for (new i; i < g_string_i; i++) // actual strings
	{
		static field_name[32], field_value[64]
		ArrayGetString(g_string_name, i, field_name, charsmax(field_name))
		get_string2(id, i, field_value, charsmax(field_value))
		
		len += formatex(query[len], charsmax(query) - len, "`%s` = ^"%s^"%s", field_name, field_value, (i == g_string_i-1) ? "" : ", ")
	}
	
	clear_nums(id)
	clear_strings(id)
	
	static data[2]
	data[0] = id
	
	SQL_ThreadQuery(g_sql_tuple, "_save_data", query, data, sizeof(data))
}

public _save_data(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	g_saving_data[id] = false
	
	client_print_color(id, 0, "^1[^4Bullet Login^1]^4 Logged out from previous session^1.")
	
	if (g_autolog_after_saving[id] == 2)
	{
		g_show_menu_after_logout[id] = true
		login_as_a_guest(id)
		g_autolog_after_saving[id] = 0
	}
	else if (g_autolog_after_saving[id] == 1)
	{
		login(id, false)
		g_autolog_after_saving[id] = 0
	}
}
