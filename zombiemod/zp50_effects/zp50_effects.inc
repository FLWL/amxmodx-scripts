#if defined _zp50_effects_included
  #endinput
#endif
#define _zp50_effects_included

#if AMXX_VERSION_NUM >= 175
	#pragma reqlib zp50_effects
	#if !defined AMXMODX_NOAUTOLOAD
		#pragma loadlib zp50_effects
	#endif
#else
	#pragma library zp50_effects
#endif

native zp_effects_spray(const position[3], const direction[3], const modelindex, const count, const speed, const noise, const rendermode)
native zp_effects_earthquake(const Float:origin[3], const Float:amplitude, const Float:frequency, const Float:duration, const Float:radius)
