#include <amxmodx>
#include <amxmisc>

#define PLUGIN "Auto Restart"
#define VERSION "1.0"
#define AUTHOR "FLWL"

#define TASK_WARMUP 6539

new g_warmup = 25

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	set_task(1.0, "task_warmup", TASK_WARMUP, _, _, "b")
}

public task_warmup()
{
	g_warmup--
	
	if (g_warmup > 0)
	{
		client_print(0, print_center, "<<< Warmup: %d second%s >>>", g_warmup, g_warmup == 1 ? "" : "s")
	}
	else
	{
		set_cvar_num("sv_restart", 1)
		remove_task(TASK_WARMUP)
	}
}
