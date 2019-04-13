#include <amxmodx>

public plugin_init()
{
	register_plugin("[ZP] Day & Night", "1.0", "FLWL")
	
	set_task(5.0, "check_time")
	set_task(60.0, "check_time", _, _, _, "b")
}

public check_time()
{
	/* 00:00 - 05:59 - b
	 * 06:00 - 08:59 - c
	 * 09:00 - 11:59 - d
	 * 12:00 - 16:59 - e
	 * 17:00 - 19:59 - d
	 * 20:00 - 22:59 - c
	 * 23:00 - 23:59 - b
	 */
	
	new temp[64]
	get_time("%H", temp, charsmax(temp))
	
	new hours = str_to_num(temp)
	if (hours >= 0 && hours <= 5)
		server_cmd("zp_lighting b")
	else if (hours >= 6 && hours <= 8)
		server_cmd("zp_lighting c")
	else if (hours >= 9 && hours <= 11)
		server_cmd("zp_lighting d")
	else if (hours >= 12 && hours <= 16)
		server_cmd("zp_lighting e")
	else if (hours >= 17 && hours <= 19)
		server_cmd("zp_lighting d")
	else if (hours >= 20 && hours <= 22)
		server_cmd("zp_lighting c")
	else if (hours == 23)
		server_cmd("zp_lighting b")
	else
		server_cmd("zp_lighting e")
}
