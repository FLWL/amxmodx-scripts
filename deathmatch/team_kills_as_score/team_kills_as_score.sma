#include <amxmodx>

#define PLUGIN "Team Kills as Score"
#define VERSION "1.0"
#define AUTHOR "FLWL"

new g_tscore, g_ctscore

new g_msgTeamScore
new g_msgSayText

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	// Message IDs
	g_msgTeamScore = get_user_msgid("TeamScore")
	g_msgSayText = get_user_msgid("SayText")
	
	// Events
	register_event("DeathMsg", "event_DeathMsg", "ae")
	
	// Messages
	register_message(get_user_msgid("TeamScore"), "message_teamscore")
	
	// Notifications
	set_task(60.0, "notification", _, _, _, "b")
}

public event_DeathMsg()
{
	static attacker, victim, attackerteam, victimteam
	attacker = read_data(1)
	victim = read_data(2)
	attackerteam = get_user_team(attacker)
	victimteam = get_user_team(victim)
	
	if (attackerteam == 1 && victimteam == 2)
	{
		g_tscore++
		t_sendscore()
	}
	else if (attackerteam == 2 && victimteam == 1)
	{
		g_ctscore++
		ct_sendscore()
	}
}

public message_teamscore()
{
	static team[2]
	get_msg_arg_string(1, team, charsmax(team))
	
	switch (team[0])
	{
		// CT
		case 'C': set_msg_arg_int(2, get_msg_argtype(2), g_ctscore)
		// Terrorist
		case 'T': set_msg_arg_int(2, get_msg_argtype(2), g_tscore)
	}
}

public t_sendscore()
{
	message_begin(MSG_ALL, g_msgTeamScore, _, 0)
	write_string("TERRORIST")
	write_short(g_tscore)
	message_end()
}

public ct_sendscore()
{
	message_begin(MSG_ALL, g_msgTeamScore, _, 0)
	write_string("CT")
	write_short(g_ctscore)
	message_end()
}

public notification()
{
	if (g_tscore > g_ctscore)
		client_printc(0, "^1*^4 Terrorists team^1 is leading with^4 %d points^1!", g_tscore - g_ctscore)
	else if (g_tscore < g_ctscore)
		client_printc(0, "^1*^4 Counter-Terrorists team^1 is leading with^4 %d points^1!", g_ctscore - g_tscore)
	else
		client_printc(0, "^1*^4 Both teams^1 have the same number of^4 points^1!")
}

// Prints a colored message to target (use 0 for everyone), supports ML formatting.
// Note: I still need to make something like gungame's LANG_PLAYER_C to avoid unintended
// argument replacement when a function passes -1 (it will be considered a LANG_PLAYER)
stock client_printc(target, const message[], any:...)
{
	static buffer[190], i, argscount
	argscount = numargs()
	
	// Send to everyone
	if (!target)
	{
		static player
		for (player = 1; player <= get_maxplayers(); player++)
		{
			// Not connected
			if (!is_user_connected(player))
				continue;
			
			// Remember changed arguments
			static changed[5] // [5] = max LANG_PLAYER occurencies
			new changedcount
			
			// Replace LANG_PLAYER with player id
			for (i = 2; i < argscount; i++)
			{
				if (getarg(i) == LANG_PLAYER)
				{
					setarg(i, 0, player)
					changed[changedcount] = i
					changedcount++
				}
			}
			
			// Format message for player
			vformat(buffer, charsmax(buffer), message, 3)
			replace_all(buffer, charsmax(buffer), "\y", "^x01")
			replace_all(buffer, charsmax(buffer), "\g", "^x04")
			
			// Send it
			message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, player)
			write_byte(player)
			write_string(buffer)
			message_end()
			
			// Replace back player id's with LANG_PLAYER
			for (i = 0; i < changedcount; i++)
				setarg(changed[i], 0, LANG_PLAYER)
		}
	}
	// Send to special target
	else
	{
		// Format message for player
		vformat(buffer, charsmax(buffer), message, 3)
		
		// Send it
		message_begin(MSG_ONE, g_msgSayText, _, target)
		write_byte(target)
		write_string(buffer)
		message_end()
	}
}
