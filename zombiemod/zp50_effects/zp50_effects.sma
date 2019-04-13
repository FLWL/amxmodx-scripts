#include <amxmodx>
#include <fakemeta>
#include <engine>

const PEV_SPEC_MODE = pev_iuser1
const PEV_SPEC_TARGET = pev_iuser2

enum
{
	MODE_LOCKEDCHASECAM = 1,
	MODE_FREECHASECAM,
	MODE_FREELOOK,
	MODE_FIRSTPERSON,
	MODE_FREEOVERVIEW,
	MODE_CHASEOVERVIEW
}

new g_msgScreenShake
new g_maxplayers

public plugin_init()
{
	register_plugin("[ZP50] Effects", "1.0", "FLWL")
	
	g_msgScreenShake = get_user_msgid("ScreenShake")
	g_maxplayers = get_maxplayers()
}

public plugin_natives()
{
	register_library("zp50_effects")
	
	register_native("zp_effects_spray", "native_spray")
	register_native("zp_effects_earthquake", "native_earthquake")
}

public native_spray(plugin_id, num_params)
{
	static position[3], direction[3]
	get_array(1, position, sizeof(position))
	get_array(2, direction, sizeof(direction))
	
	message_begin(MSG_PVS, SVC_TEMPENTITY, position)
	write_byte(TE_SPRITE_SPRAY)
	write_coord(position[0])
	write_coord(position[1])
	write_coord(position[2])
	write_coord(direction[0])
	write_coord(direction[1])
	write_coord(direction[2])
	write_short(get_param(3)) // model index
	write_byte(get_param(4)) // count
	write_byte(get_param(5)) // speed
	write_byte(get_param(6)) // noise
	//write_byte(get_param(7)) // rendermode
	message_end()
}

public native_earthquake(plugin_id, num_params)
{
	static Float:originF[3], Float:amplitude, Float:frequency, Float:duration, Float:radius
	get_array_f(1, originF, sizeof(originF))
	amplitude = get_param_f(2)
	frequency = get_param_f(3)
	duration = get_param_f(4)
	radius = get_param_f(5)
	
	static fixedFrequency, fixedDuration, fixedAmplitude
	fixedFrequency = FixedUnsigned16(frequency, 1<<12)
	fixedDuration = FixedUnsigned16(duration, 1<<12)
	
	static Float:pOriginF[3], Float:distanceF, Float:localAmplitude, specTarget, onGround
	
	static id
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (!is_user_connected(id))
			continue;
		
		if (is_user_alive(id))
		{
			pev(id, pev_origin, pOriginF)
			onGround = (pev(id, pev_flags) & FL_ONGROUND)
		}
		else
		{
			// User isn't spectating in first person mode
			if (pev(id, PEV_SPEC_MODE) != MODE_FIRSTPERSON)
				continue;
			
			specTarget = pev(id, PEV_SPEC_TARGET)
			
			// User spectating dead player
			if (!is_user_alive(specTarget))
				continue;
			
			pev(specTarget, pev_origin, pOriginF)
			onGround = (pev(specTarget, pev_flags) & FL_ONGROUND)
		}
		
		distanceF = get_distance_f(originF, pOriginF)
		
		if (distanceF > radius)
			continue;
		
		localAmplitude = amplitude
		
		// Player is in air, decrease amplitude
		if (!onGround) amplitude *= 0.75
		
		fixedAmplitude = FixedUnsigned16(localAmplitude, 1<<12)
		
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, id)
		write_short(fixedAmplitude)
		write_short(fixedDuration)
		write_short(fixedFrequency)
		message_end()
	}
}

FixedUnsigned16(const Float:value, const scale)
{
    return clamp(floatround(value * scale), 0, 0xFFFF);
}
