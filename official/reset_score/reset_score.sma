#include <amxmodx>
#include <cstrike>
#include <fun>

new g_msgSayText

public plugin_init()
{
	register_plugin("Reset Score", "1.0", "FLWL")
	
	g_msgSayText = get_user_msgid("SayText")
	
	register_clcmd("say /resetscore", "clcmd_sayresetscore")
	register_clcmd("say /rs", "clcmd_sayresetscore")
}

public clcmd_sayresetscore(id)
{
	client_printcolor(id, "!y[!gReset!y] Your score is reset. Old score:!g %i-%i!y.", get_user_frags(id), cs_get_user_deaths(id))
	
	reset_player_score(id)
}

stock reset_player_score(id)
{
	cs_set_user_deaths(id, 0)
	set_user_frags(id, 0)
	cs_set_user_deaths(id, 0)
	set_user_frags(id, 0)
}

stock client_printcolor(const id, const input[], any:...)
{
	new count = 1, players[32]
	static msg[191]
	vformat(msg, 190, input, 3)
	
	replace_all(msg, 190, "!g", "^4") // Green Color
	replace_all(msg, 190, "!y", "^1") // Default Color
	replace_all(msg, 190, "!t", "^3") // Team Color
	
	if (id) players[0] = id; else get_players(players, count, "ch") 
	{
		for ( new i = 0; i < count; i++ )
		{
			if ( is_user_connected(players[i]) )
			{
				message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, players[i])
				write_byte(players[i]);
				write_string(msg);
				message_end();
			}
		}
	}
}
