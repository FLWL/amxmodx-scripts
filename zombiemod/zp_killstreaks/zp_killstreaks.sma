#include <amxmodx>
#include <zombieplague>
#include <dhudmessage>

// Human Multikills
new const MULTIKILLS_H[][] =
{
	"DOUBLE KILL",
	"TRIPLE KILL",
	"QUADRA KILL",
	"PENTA KILL",
	"HEXA KILL",
	"HEPTA KILL",
	"OCTA KILL",
	"NONA KILL",
	"DECA KILL"
}
new const MULTIKILLS_H_OVER[] = "LEGENDARY KILL"

// Zombie Multikills
new const MULTIKILLS_Z[][] =
{
	"DOUBLE INFECT",
	"TRIPLE INFECT",
	"QUADRA INFECT",
	"PENTA INFECT",
	"HEXA INFECT",
	"HEPTA INFECT",
	"OCTA INFECT",
	"NONA INFECT",
	"DECA INFECT"
}
new const MULTIKILLS_Z_OVER[] = "LEGENDARY INFECT"

// Human Killstreaks
new const KILLSTREAKS_H[][] =
{
	"on a KILLING SPREE",
	"on a RAMPAGE",
	"UNSTOPPABLE",
	"DOMINATING",
	"GODLIKE",
	"LEGENDARY"
}
//new const KILLSTREAKS_H_OVER[] = "LEGENDARY"
new const KILLSTREAKS_H_KILLS[] =
{
	5,
	10,
	15,
	20,
	25,
	30
}

// Zombie Killstreaks
new const KILLSTREAKS_Z[][] =
{
	"BLOODTHRISTY",
	"MERCILESS",
	"RUTHLESS",
	"RELENTLESS",
	"BRUTAL",
	"NUCLEAR"
}
//new const KILLSTREAKS_Z_OVER[] = "NUCLEAR"
new const KILLSTREAKS_Z_KILLS[] =
{
	3,
	6,
	9,
	12,
	15,
	18
}

new g_killstreak[33]
new g_multikill[33]
new Float:g_killtime[33]

public plugin_init()
{
	register_plugin("[ZP] Killstreaks", "1.0", "FLWL")
	
	register_event("DeathMsg", "event_death", "a")
}

public event_death()
{
	// Variables
	static id, killer
	killer = read_data(1)
	id = read_data(2)
	
	// Reset victim's killstreak
	g_killstreak[id] = 0
	
	// Suicide does not count
	if (id == killer) return;
	
	// Invalid killer
	if (!is_user_connected(killer)) return;
	
	// Killstreaks
	g_killstreak[killer]++
	
	// Multikills
	if (get_gametime() - g_killtime[killer] > 0.5) g_multikill[killer] = 0 // too late
	g_multikill[killer]++
	g_killtime[killer] = get_gametime()
	
	// Double kill? Announce?
	if (g_multikill[killer] >= 2)
		announce_multikill(killer)
	
	// Killstreaks again
	if (zp_get_user_zombie(id))
	{
		// vars
		static streak
		streak = -1
		
		// get streak
		for (new i; i < sizeof(KILLSTREAKS_H); i++)
			if (g_killstreak[killer] >= KILLSTREAKS_H_KILLS[i])
				streak = i
		
		// streak?
		if (streak > -1)
			announce_killstreak_h(killer, streak)
	}
	else
	{
		// vars
		static streak
		streak = -1
		
		// get streak
		for (new i; i < sizeof(KILLSTREAKS_Z); i++)
			if (g_killstreak[killer] >= KILLSTREAKS_Z_KILLS[i])
				streak = i
		
		// streak?
		if (streak > -1)
			announce_killstreak_z(killer, streak)
	}
}

announce_multikill(id)
{
	// Get name
	static name[32]
	get_user_name(id, name, charsmax(name))
	
	// Display
	if (zp_get_user_zombie(id))
	{
		set_dhudmessage(229, 255, 204, -1.0, 0.03, 0, 0.0, 2.0, 0.1, 0.1)
		show_dhudmessage(0, "%s: %s!", name, (g_multikill[id]-2 > charsmax(MULTIKILLS_Z)) ? MULTIKILLS_Z[g_multikill[id]-2] : MULTIKILLS_Z_OVER)
	}
	else
	{
		set_dhudmessage(200, 200, 200, -1.0, 0.03, 0, 0.0, 2.0, 0.1, 0.1)
		show_dhudmessage(0, "%s: %s!", name, (g_multikill[id]-2 > charsmax(MULTIKILLS_H)) ? MULTIKILLS_H[g_multikill[id]-2] : MULTIKILLS_H_OVER)
	}
}

announce_killstreak_h(id, streak)
{
	// Get name
	static name[32]
	get_user_name(id, name, charsmax(name))
	
	// Message
	
	
	// Display
	set_dhudmessage(200, 200, 200, -1.0, 0.02, 0, 0.0, 2.0, 0.1, 0.1)
	show_dhudmessage(0, "%s is %s!", name, KILLSTREAKS_H[streak])
}

announce_killstreak_z(id, streak)
{
	// Get name
	static name[32]
	get_user_name(id, name, charsmax(name))
	
	// Display
	set_dhudmessage(229, 255, 204, -1.0, 0.02, 0, 0.0, 2.0, 0.1, 0.1)
	show_dhudmessage(0, "%s is %s!", name, KILLSTREAKS_Z[streak])
}

// bugfix: reset killstreak when turned into zombie
public zp_user_infected_post(id)
{
	g_killstreak[id] = 0
}






