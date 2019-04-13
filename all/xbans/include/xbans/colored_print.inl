#if defined _colored_print_included
    #endinput
#endif
#define _colored_print_included

colored_print(target, const message[], any:...)
{
	static buffer[192]
	
	// Send to everyone
	if (!target)
	{
		static player, argscount
		argscount = numargs()
		
		for (player = 1; player <= g_maxplayers; player++)
		{
			// Not connected
			if (!is_user_connected(player))
				continue;
			
			// Remember changed arguments
			static arg_index, changed_args[20], changedcount // [20] = max LANG_PLAYER occurencies	
			changedcount = 0
			
			// Replace LANG_PLAYER with player id
			for (arg_index = 2; arg_index < argscount; arg_index++)
			{
				if (getarg(arg_index) == LANG_PLAYER && arg_index + 1 < argscount)
				{
					// Check if next param string is a registered language translation
					static lang_key[64], arg_subindex
					arg_subindex = 0
					while ((lang_key[arg_subindex] = getarg(arg_index + 1, arg_subindex++))) { /* keep looping */ }
					if (GetLangTransKey(lang_key) != TransKey_Bad)
					{
						setarg(arg_index, 0, player)
						changed_args[changedcount++] = arg_index
						arg_index++ // skip next argument since we know it's a translation key
					}
				}
			}
			
			// Format message for player
			vformat(buffer, charsmax(buffer), message, 3)
			
			// Send it
			message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, player)
			write_byte(player)
			write_string(buffer)
			message_end()
			
			// Replace back player id's with LANG_PLAYER
			for (arg_index = 0; arg_index < changedcount; arg_index++)
				setarg(changed_args[arg_index], 0, LANG_PLAYER)
		}
	}
	// Send to specific target
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
