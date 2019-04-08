#include <amxmodx>
#include <fakemeta>

public plugin_init()
{
	register_plugin("Block Kill Command", "1.0", "FLWL")
	
	register_forward(FM_ClientKill, "fw_ClientKill")
}

public fw_ClientKill(id)
{
	if (!is_user_alive(id))
		return FMRES_IGNORED;
	
	return FMRES_SUPERCEDE;
}
