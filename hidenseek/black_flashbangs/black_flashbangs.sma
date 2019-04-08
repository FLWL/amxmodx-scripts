#include <amxmodx>

#define FFADE_IN 0x0000

public plugin_init()
{
	register_plugin("Black Flashbangs", "1.0", "FLWL")
	
	register_message(get_user_msgid("ScreenFade"), "msg_ScreenFade")
}

public msg_ScreenFade(msg_id, msg_dest, msg_entity)
{
	if (get_msg_arg_int(3) == FFADE_IN && get_msg_arg_int(4) == 255 && get_msg_arg_int(5) == 255 && get_msg_arg_int(6) == 255)
	{
		set_msg_arg_int(4, ARG_BYTE, 0)
		set_msg_arg_int(5, ARG_BYTE, 0)
		set_msg_arg_int(6, ARG_BYTE, 0)
	}
}
