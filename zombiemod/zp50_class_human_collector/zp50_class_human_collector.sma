#include <amxmodx>
#include <fakemeta>
#include <cstrike>
#include <zp50_class_human>

// Event files
new const g_guns_events[][] =
{
	"events/awp.sc",
	"events/g3sg1.sc",
	"events/ak47.sc",
	"events/scout.sc",
	"events/m249.sc",
	"events/m4a1.sc",
	"events/sg552.sc",
	"events/aug.sc",
	"events/sg550.sc",
	"events/m3.sc",
	"events/xm1014.sc",
	"events/usp.sc",
	"events/mac10.sc",
	"events/ump45.sc",
	"events/fiveseven.sc",
	"events/p90.sc",
	"events/deagle.sc",
	"events/p228.sc",
	"events/glock18.sc",
	"events/mp5n.sc",
	"events/tmp.sc",
	"events/elite_left.sc",
	"events/elite_right.sc",
	"events/galil.sc",
	"events/famas.sc"
}

// Max BP ammo for weapons
new const MAXBPAMMO[] = { -1, 52, -1, 90, 1, 32, 1, 100, 90, 1, 120, 100, 100, 90, 90, 90, 100, 120,
			30, 120, 200, 32, 90, 120, 90, 2, 35, 90, 90, -1, 100 }

new g_fwPrecacheEvent

new g_class_id
new g_maxplayers
new g_guns_eventids_bitsum

public plugin_precache()
{
	register_plugin("[ZP50] Human Class: Collector", "1.0", "FLWL")
	g_class_id = zp_class_human_register("Collector Human", "Ability to get half of the fired bullets back", 100, 250.0, 1.0)
	
	g_fwPrecacheEvent = register_forward(FM_PrecacheEvent, "fw_PrecacheEvent_Post", 1)
}

public plugin_init()
{
	register_forward(FM_PlaybackEvent, "fw_PlaybackEvent")
	unregister_forward(FM_PrecacheEvent, g_fwPrecacheEvent)
	
	g_maxplayers = get_maxplayers()
}

public fw_PrecacheEvent_Post(type, const name[])
{
	for (new i; i < sizeof(g_guns_events); i++)
		if (equal(g_guns_events[i], name))
			g_guns_eventids_bitsum |= (1<<get_orig_retval())
}

public fw_PlaybackEvent(flags, id, eventid)
{
	if (!(g_guns_eventids_bitsum & (1<<eventid)) || !(1 <= id <= g_maxplayers) || zp_core_is_zombie(id))
		return;
	
	if (zp_class_human_get_current(id) == g_class_id && random_num(0, 1))
	{
		static wpn, ammo
		wpn = get_user_weapon(id)
		ammo = cs_get_user_bpammo(id, wpn)
		
		if (ammo < MAXBPAMMO[wpn])
			cs_set_user_bpammo(id, wpn, ammo + 1)
	}
}
