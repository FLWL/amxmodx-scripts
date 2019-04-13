#include <amxmodx>
#include <engine>
#include <fakemeta>
#include <hamsandwich>
#include <fun>
#include <dhudmessage>
#include <xs>

//#include <orpheu>
//#include <orpheu_advanced>
//#include <orpheu_memory>

// Customization
new const SOUND_PREPARE[] = "racemod/prepare.wav"
new const SOUND_START[] = "racemod/start.wav"

// Tasks
enum (+= 2000)
{
	TASK_PREPARE,
	TASK_VEHICLE_STATS
}

// Offsets, constants
const PDATA_SAFE = 2
const OFFSET_ISDRIVING = 350
const VEHICLE_OWNER = EV_INT_iuser3
const OWNED_VEHICLE = EV_INT_iuser3
const GIB_ALWAYS = 2
const OFFSET_BUYZONE = 235
const OFFSET_LINUX = 5

// Client messages
new g_msgRoundTime//, g_msgShowTimer

// Cvars
new cvar_preptime

// Global vars
new g_preptime
new g_roundstarttime
new g_maxplayers
new g_msgSyncHud

#define VEHICLE_SPEED0_ACCELERATION 0.005000000000000000
#define VEHICLE_SPEED1_ACCELERATION 0.002142857142857143
#define VEHICLE_SPEED2_ACCELERATION 0.003333333333333334
#define VEHICLE_SPEED3_ACCELERATION 0.004166666666666667
#define VEHICLE_SPEED4_ACCELERATION 0.004000000000000000
#define VEHICLE_SPEED5_ACCELERATION 0.003800000000000000
#define VEHICLE_SPEED6_ACCELERATION 0.004500000000000000
#define VEHICLE_SPEED7_ACCELERATION 0.004250000000000000
#define VEHICLE_SPEED8_ACCELERATION 0.002666666666666667
#define VEHICLE_SPEED9_ACCELERATION 0.002285714285714286
#define VEHICLE_SPEED10_ACCELERATION 0.001875000000000000
#define VEHICLE_SPEED11_ACCELERATION 0.001444444444444444
#define VEHICLE_SPEED12_ACCELERATION 0.001200000000000000
#define VEHICLE_SPEED13_ACCELERATION 0.000916666666666666
#define VEHICLE_SPEED14_ACCELERATION 0.001444444444444444

//new Float:g_vecZero[3] = {0.0, 0.0, 0.0}

const m_length = 35
const m_width = 36
const m_height = 37
const m_speed = 38
const m_dir = 39
const m_acceleration = 49
const m_iTurnAngle = 53
const m_flSteeringWheelDecay = 54
const m_flAcceleratorDecay = 55
const m_flTurnStartTime = 56
const m_flLaunchTime = 57
const m_flLastNormalZ = 58
const m_flCanTurnNow = 59
const m_flUpdateSound = 60
const m_vFrontLeft = 61
const m_vFront = 64
const m_vFrontRight = 67
const m_vBackLeft = 70
const m_vBack = 73
const m_vBackRight = 76
const m_vSurfaceNormal = 79
const m_vVehicleDirection = 82

enum
{
	USE_OFF,
	USE_ON,
	USE_SET,
	USE_TOGGLE
}

enum
{
	THINK_NULL,
	THINK_NEXT,
}

public plugin_precache()
{
	precache_sound(SOUND_PREPARE)
	precache_sound(SOUND_START)
	
	// Countdown sounds
	static buffer[64]
	for (new i = 1; i <= 10; i++)
	{
		formatex(buffer, charsmax(buffer), "racemod/%d.wav", i)
		precache_sound(buffer)
	}
}

public plugin_init()
{
	register_plugin("Racemod", "1.0", "FLWL")
	
	// Events
	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")
	register_logevent("event_round_end", 2, "1=Round_End")
	
	// Forwards
	//RegisterHam(Ham_Use, "func_vehicle", "fw_UseVehicle")
	//RegisterHam(Ham_Think, "func_vehicle", "fw_ThinkVehicle")
	//RegisterHam(Ham_OnControls, "func_vehicle", "fw_OnControlVehicle")
	register_forward(FM_PlayerPreThink, "fw_PlayerPreThink")
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled")
	register_forward(FM_CmdStart, "fw_CmdStart")
	RegisterHam(Ham_Spawn, "player", "fw_PlayerSpawn_Post", 1)
	
	register_touch("func_vehicle", "trigger_multiple", "fw_finish")
	register_touch("trigger_multiple", "func_vehicle", "fw_finish")
	
	// Message IDs
	g_msgRoundTime = get_user_msgid("RoundTime")
	//g_msgShowTimer = get_user_msgid("ShowTimer")
	
	// Messages
	register_message(g_msgRoundTime, "message_RoundTime")
	register_message(get_user_msgid("StatusIcon"), "message_StatusIcon")
	
	register_clcmd("test", "test")
	
	// Cvars
	cvar_preptime = register_cvar("racemod_preptime", "7")
	
	// Misc
	g_maxplayers = get_maxplayers()
	g_msgSyncHud = CreateHudSyncObj()
	
	// Manually start round
	set_task(0.5, "event_round_start")
	
	//OrpheuRegisterHook(OrpheuGetFunction("TerrainFollowing"), "Func_TerrainFollowing", OrpheuHookPre)
	//OrpheuRegisterHook(OrpheuGetFunction("CollisionDetection"), "Func_CollisionDetection", OrpheuHookPre)
	//OrpheuRegisterHook(OrpheuGetFunction("CheckTurning"), "Func_CheckTurning", OrpheuHookPre)
}
/*
public OrpheuHookReturn:Func_TerrainFollowing(ent)
{
	new Float:origin[3]
	entity_get_vector(ent, EV_VEC_origin, origin)
	new Float:vector[3]
	vector[2] = (get_pdata_float(ent, m_height, 4) + 48.0) * -1.0
	new Float:originvector[3]
	xs_vec_add(origin, vector, originvector)
	
	new tr = create_tr2()
	engfunc(EngFunc_TraceLine, origin, originvector, IGNORE_MONSTERS, ent, tr)
	
	new Float:fraction
	get_tr2(tr, TR_flFraction, fraction)
	
	if (fraction != 1.0)
	{
		new Float:vPlaneNormal[3]
		get_tr2(tr, TR_vecPlaneNormal, vPlaneNormal)
		
		set_pdata_vec(ent, m_vSurfaceNormal, vPlaneNormal)
	}
	else if (get_tr2(tr, TR_InWater))
	{
		set_pdata_vec(ent, m_vSurfaceNormal, Float:{0.0, 0.0, 1.0})
	}
	
	free_tr2(tr)
	
	return OrpheuSupercede;
}

public OrpheuHookReturn:Func_CheckTurning(ent)
{
	new tr = create_tr2();
	new Float:vecStart[3], Float:vecEnd[3]

	if (get_pdata_int(ent, m_iTurnAngle, 4) < 0)
	{
		if (entity_get_float(ent, EV_FL_speed) > 0.0)
		{
			get_pdata_vec(ent, m_vFrontLeft, vecStart)
			
			new Float:tempVec[3]
			global_get(glb_v_right, tempVec)
			xs_vec_mul_scalar(tempVec, 16.0, tempVec)
			xs_vec_sub(vecStart, tempVec, vecEnd)
		}
		else if (entity_get_float(ent, EV_FL_speed) < 0)
		{
			get_pdata_vec(ent, m_vBackLeft, vecStart)
			
			new Float:tempVec[3]
			global_get(glb_v_right, tempVec)
			xs_vec_mul_scalar(tempVec, 16.0, tempVec)
			xs_vec_add(vecStart, tempVec, vecEnd)
		}
		
		engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
		
		new Float:fraction
		get_tr2(tr, TR_flFraction, fraction)
		
		if (fraction != 1.0)
			set_pdata_int(ent, m_iTurnAngle, 1, 4)
	}
	else if (get_pdata_int(ent, m_iTurnAngle, 4) > 0)
	{
		if (entity_get_float(ent, EV_FL_speed) > 0)
		{
			get_pdata_vec(ent, m_vFrontRight, vecStart)
			
			new Float:tempVec[3]
			global_get(glb_v_right, tempVec)
			xs_vec_mul_scalar(tempVec, 16.0, tempVec)
			xs_vec_add(vecStart, tempVec, vecEnd)
		}
		else if (entity_get_float(ent, EV_FL_speed) < 0)
		{
			get_pdata_vec(ent, m_vBackRight, vecStart)
			
			new Float:tempVec[3]
			global_get(glb_v_right, tempVec)
			xs_vec_mul_scalar(tempVec, 16.0, tempVec)
			xs_vec_sub(vecStart, tempVec, vecEnd)
		}

		engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
		
		new Float:fraction
		get_tr2(tr, TR_flFraction, fraction)
		
		if (fraction != 1.0)
			set_pdata_int(ent, m_iTurnAngle, -1, 4)
	}
	
	free_tr2(tr)
	
	if (entity_get_float(ent, EV_FL_speed) <= 0.0)
		return OrpheuSupercede;
	
	new Float:speed;
	new turning = abs(get_pdata_int(ent, m_iTurnAngle, 4));

	if (turning > 4)
	{
		if (get_pdata_float(ent, m_flTurnStartTime, 4) != -1.0)
		{
			new Float:time = get_gametime() - get_pdata_float(ent, m_flTurnStartTime, 4);

			if (time >= 0)
				speed = get_pdata_float(ent, m_speed, 4) * 0.98;
			else if (time > 0.3)
				speed = get_pdata_float(ent, m_speed, 4) * 0.95;
			else if (time > 0.6)
				speed = get_pdata_float(ent, m_speed, 4) * 0.9;
			else if (time > 0.8)
				speed = get_pdata_float(ent, m_speed, 4) * 0.8;
			else if (time > 1)
				speed = get_pdata_float(ent, m_speed, 4) * 0.7;
			else if (time > 1.2)
				speed = get_pdata_float(ent, m_speed, 4) * 0.5;
			else
				speed = time;
		}
		else
		{
			set_pdata_float(ent, m_flTurnStartTime, get_gametime(), 4)
			speed = get_pdata_float(ent, m_speed, 4);
		}
	}
	else
	{
		set_pdata_float(ent, m_flTurnStartTime, -1.0, 4)

		if (turning > 2)
			speed = get_pdata_float(ent, m_speed, 4) * 0.9;
		else
			speed = get_pdata_float(ent, m_speed, 4);
	}

	if (speed < entity_get_float(ent, EV_FL_speed))
	{
		new Float:tempSpeed
		tempSpeed = entity_get_float(ent, EV_FL_speed)
		tempSpeed -= get_pdata_float(ent, m_speed, 4) * 0.1;
		entity_set_float(ent, EV_FL_speed, tempSpeed)
	}
	
	return OrpheuSupercede;
}

public OrpheuHookReturn:Func_CollisionDetection(ent)
{
	new tr = create_tr2();
	new Float:vecStart[3], Float:vecEnd[3];
	new Float:flDot;

	if (entity_get_float(ent, EV_FL_speed) < 0.0)
	{
		get_pdata_vec(ent, m_vBackLeft, vecStart)
		new Float:temp_vec[3]
		global_get(glb_v_forward, temp_vec)
		xs_vec_mul_scalar(temp_vec, 16.0, temp_vec)
		xs_vec_add(vecStart, temp_vec, vecEnd)
		
		engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
		
		new Float:fraction, Float:vecPlaneNormal[3], Float:vforward[3], Float:revPlaneNormal[3]
		get_tr2(tr, TR_flFraction, fraction)
		get_tr2(tr, TR_vecPlaneNormal, vecPlaneNormal)
		global_get(glb_v_forward, vforward)
		xs_vec_mul_scalar(vecPlaneNormal, -1.0, revPlaneNormal)
		
		if (fraction != 1.0)
		{
			flDot = xs_vec_dot(vforward, revPlaneNormal)
			if (flDot < 0.7 && vecPlaneNormal[2] < 0.1)
			{
				set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
				set_pdata_float(ent, m_vSurfaceNormal+2, 0.0)
				entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * 0.99)
			}
			else if (vecPlaneNormal[2] < 0.65 || get_tr2(tr, TR_StartSolid))
				entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * -1.0)
			else
				set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)

			new pHit = get_tr2(tr, TR_pHit)
			
			//if (pHit && pHit->Classify() == CLASS_VEHICLE)
			//	ALERT(at_console, "I hit another vehicle\n");
		}
		
		get_pdata_vec(ent, m_vBackRight, vecStart)
		xs_vec_add(vecStart, temp_vec, vecEnd)
		
		engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
		
		get_tr2(tr, TR_flFraction, fraction)
		
		if (fraction == 1.0)
		{
			get_pdata_vec(ent, m_vBack, vecStart)
			xs_vec_add(vecStart, temp_vec, vecEnd)
			engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
			
			get_tr2(tr, TR_flFraction, fraction)
			
			if (fraction == 1.0)
			{
				free_tr2(tr)
				return OrpheuSupercede;
			}
		}
		
		// Update revPlaneNormal
		get_tr2(tr, TR_vecPlaneNormal, vecPlaneNormal)
		xs_vec_mul_scalar(vecPlaneNormal, -1.0, revPlaneNormal)
		
		flDot = xs_vec_dot(vforward, revPlaneNormal)

		if (flDot >= 0.7)
		{
			if (vecPlaneNormal[2] < 0.65 || get_tr2(tr, TR_StartSolid) != 0)
				entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * -1.0)
			else
				set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
		}
		else if (vecPlaneNormal[2] < 0.1)
		{
			set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
			set_pdata_float(ent, m_vSurfaceNormal+2, 0.0)
			entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * 0.99)
		}
		else if (vecPlaneNormal[2] < 0.65 || get_tr2(tr, TR_StartSolid) != 0)
			entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * -1.0)
		else
			set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
	}
	else if (entity_get_float(ent, EV_FL_speed) > 0.0)
	{
		get_pdata_vec(ent, m_vFrontRight, vecStart)
		new Float:temp_vec[3], Float:vforward[3]
		global_get(glb_v_forward, vforward)
		xs_vec_mul_scalar(vforward, 16.0, temp_vec)
		xs_vec_sub(vecStart, temp_vec, vecEnd)
		
		engfunc(EngFunc_TraceLine, vecStart, vecEnd, DONT_IGNORE_MONSTERS, ent, tr)
		
		new Float:fraction
		get_tr2(tr, TR_flFraction, fraction)
		
		if (fraction == 1.0)
		{
			get_pdata_vec(ent, m_vFrontLeft, vecStart)
			xs_vec_sub(vecStart, temp_vec, vecEnd)
			
			engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
			
			get_tr2(tr, TR_flFraction, fraction)
			
			if (fraction == 1.0)
			{
				get_pdata_vec(ent, m_vFront, vecStart)
				xs_vec_sub(vecStart, temp_vec, vecEnd)
				
				engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
				
				get_tr2(tr, TR_flFraction, fraction)
				
				if (fraction == 1.0)
				{
					free_tr2(tr)
					return OrpheuSupercede;
				}
			}
		}
		
		new Float:vecPlaneNormal[3], Float:revPlaneNormal[3]
		get_tr2(tr, TR_vecPlaneNormal, vecPlaneNormal)
		xs_vec_mul_scalar(vecPlaneNormal, -1.0, revPlaneNormal)
		
		flDot = xs_vec_dot(vforward, revPlaneNormal)
		
		if (flDot <= -0.7)
		{
			if (vecPlaneNormal[2] < 0.65 || get_tr2(tr, TR_StartSolid) != 0)
				entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * -1.0)
			else
				set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
		}
		else if (vecPlaneNormal[2] < 0.1)
		{
			set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
			set_pdata_float(ent, m_vSurfaceNormal+2, 0.0)
			entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * 0.99)
		}
		else if (vecPlaneNormal[2] < 0.65 || get_tr2(tr, TR_StartSolid) != 0)
			entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * -1.0)
		else
			set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
	}
	
	return OrpheuSupercede;
}*/
/*
public fw_ThinkVehicle(ent)
{
	new think_type = pev(ent, pev_iuser4)
	
	//client_print(0, print_chat, "ThinkVehicle %d with type %d (pev_ltime: %f, pev_nextthink: %f, sub: %f", ent, think_type, entity_get_float(ent, EV_FL_ltime), entity_get_float(ent, EV_FL_nextthink), entity_get_float(ent, EV_FL_nextthink) - entity_get_float(ent, EV_FL_ltime))
	
	switch (think_type)
	{
		case THINK_NEXT: Next(ent);
	}
}

public fw_UseVehicle(ent, pActivator, pCaller, useType, Float:value)
{
	//client_print(0, print_chat, "Ham_Use(%d, %d, %d, %d, %f called)", ent, pActivator, pCaller, useType, value)
	
	new Float:delta = value
	
	if (useType != USE_SET)
	{
		if (!ShouldToggle(useType, (entity_get_float(ent, EV_FL_speed) != 0.0)))
			return HAM_SUPERCEDE;
		
		if (entity_get_float(ent, EV_FL_speed) == 0.0)
		{
			entity_set_float(ent, EV_FL_speed, get_pdata_float(ent, m_speed, 4) * get_pdata_float(ent, m_dir, 4))
			Next(ent)
		}
		else
		{
			entity_set_float(ent, EV_FL_speed, 0.0)
			entity_set_vector(ent, EV_VEC_velocity, g_vecZero)
			entity_set_vector(ent, EV_VEC_avelocity, g_vecZero)
			StopSound(ent)
			SetThink(ent, THINK_NULL)
		}
	}
	
	if (delta < 10)
	{
		if (delta < 0 && entity_get_float(ent, EV_FL_speed) > 145.0)
			StopSound(ent)
		
		new Float:flSpeedRatio = delta
		
		if (delta > 0)
		{
			flSpeedRatio = entity_get_float(ent, EV_FL_speed) / get_pdata_float(ent, m_speed, 4);
			
			if (entity_get_float(ent, EV_FL_speed) < 0.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0005 + flSpeedRatio + VEHICLE_SPEED0_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 10.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0006 + flSpeedRatio + VEHICLE_SPEED1_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 20.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0007 + flSpeedRatio + VEHICLE_SPEED2_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 30.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0007 + flSpeedRatio + VEHICLE_SPEED3_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 45.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0007 + flSpeedRatio + VEHICLE_SPEED4_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 60.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0008 + flSpeedRatio + VEHICLE_SPEED5_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 80.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0008 + flSpeedRatio + VEHICLE_SPEED6_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 100.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0009 + flSpeedRatio + VEHICLE_SPEED7_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 150.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0008 + flSpeedRatio + VEHICLE_SPEED8_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 225.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0007 + flSpeedRatio + VEHICLE_SPEED9_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 300.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0006 + flSpeedRatio + VEHICLE_SPEED10_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 400.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0005 + flSpeedRatio + VEHICLE_SPEED11_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 550.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0005 + flSpeedRatio + VEHICLE_SPEED12_ACCELERATION;
			else if (entity_get_float(ent, EV_FL_speed) < 800.0)
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0005 + flSpeedRatio + VEHICLE_SPEED13_ACCELERATION;
			else
				flSpeedRatio = get_pdata_float(ent, m_acceleration, 4) * 0.0005 + flSpeedRatio + VEHICLE_SPEED14_ACCELERATION;
		}
		else if (delta < 0)
		{
			flSpeedRatio = entity_get_float(ent, EV_FL_speed) / get_pdata_float(ent, m_speed, 4);
			
			if (flSpeedRatio > 0)
				flSpeedRatio -= 0.0125;
			else if (flSpeedRatio <= 0 && flSpeedRatio > -0.05)
				flSpeedRatio -= 0.0075;
			else if (flSpeedRatio <= 0.05 && flSpeedRatio > -0.1)
				flSpeedRatio -= 0.01;
			else if (flSpeedRatio <= 0.15 && flSpeedRatio > -0.15)
				flSpeedRatio -= 0.0125;
			else if (flSpeedRatio <= 0.15 && flSpeedRatio > -0.22)
				flSpeedRatio -= 0.01375;
			else if (flSpeedRatio <= 0.22 && flSpeedRatio > -0.3)
				flSpeedRatio -= - 0.0175;
			else if (flSpeedRatio <= 0.3)
				flSpeedRatio -= 0.0125;
		}
		
		if (flSpeedRatio > 1)
			flSpeedRatio = 1.0;
		else if (flSpeedRatio < -0.35)
			flSpeedRatio = -0.35;
		
		entity_set_float(ent, EV_FL_speed, get_pdata_float(ent, m_speed, 4) * flSpeedRatio)
		Next(ent);
		set_pdata_float(ent, m_flAcceleratorDecay, get_gametime() + 0.25, 4)
	}
	else
	{
		if (get_gametime() > get_pdata_float(ent, m_flCanTurnNow, 4))
		{
			if (delta == 20)
			{
				set_pdata_int(ent, m_iTurnAngle, get_pdata_int(ent, m_iTurnAngle, 4) + 1, 4)
				set_pdata_float(ent, m_flSteeringWheelDecay, get_gametime() + 0.075, 4)
				
				if (get_pdata_int(ent, m_iTurnAngle, 4) > 8)
					set_pdata_int(ent, m_iTurnAngle, 8, 4)
			}
			else if (delta == 30)
			{
				set_pdata_int(ent, m_iTurnAngle, get_pdata_int(ent, m_iTurnAngle, 4) - 1, 4)
				set_pdata_float(ent, m_flSteeringWheelDecay, get_gametime() + 0.075, 4)
				
				if (get_pdata_int(ent, m_iTurnAngle, 4) < -8)
					set_pdata_int(ent, m_iTurnAngle, -8, 4)
			}
			
			set_pdata_float(ent, m_flCanTurnNow, get_gametime() + 0.05, 4)
		}
	}
	
	return HAM_SUPERCEDE;
}

Next(ent)
{
	//client_print(0, print_chat, "Next(%d) called", ent)
	
	new Float:vGravityVector[3]
	new Float:angles[3]
	entity_get_vector(ent, EV_VEC_angles, angles)
	engfunc(EngFunc_MakeVectors, angles)
	entity_set_vector(ent, EV_VEC_angles, angles)
	
	new Float:fwd[3]
	global_get(glb_v_forward, fwd)
	xs_vec_mul_scalar(fwd, -1.0, fwd)
	xs_vec_mul_scalar(fwd, get_pdata_float(ent, m_length, 4) * 0.5, fwd)
	new Float:right[3]
	global_get(glb_v_right, right)
	xs_vec_mul_scalar(right, -1.0, right)
	xs_vec_mul_scalar(right, get_pdata_float(ent, m_width, 4) * 0.5, right)
	new Float:up[3]
	global_get(glb_v_up, up)
	xs_vec_mul_scalar(up, 16.0, up)
	
	new Float:origin[3]
	entity_get_vector(ent, EV_VEC_origin, origin)
	
	new Float:vFrontRight[3]
	vFrontRight = origin
	xs_vec_add(vFrontRight, fwd, vFrontRight)
	xs_vec_sub(vFrontRight, right, vFrontRight)
	xs_vec_add(vFrontRight, up, vFrontRight)
	set_pdata_vec(ent, m_vFrontRight, vFrontRight)
	new Float:vFrontLeft[3]
	vFrontLeft = origin
	xs_vec_add(vFrontLeft, fwd, vFrontLeft)
	xs_vec_add(vFrontLeft, right, vFrontLeft)
	xs_vec_add(vFrontLeft, up, vFrontLeft)
	set_pdata_vec(ent, m_vFrontLeft, vFrontLeft)
	new Float:vFront[3]
	vFront = origin
	xs_vec_add(vFront, fwd, vFront)
	xs_vec_add(vFront, up, vFront)
	set_pdata_vec(ent, m_vFront, vFront)
	new Float:vBackLeft[3]
	vBackLeft = origin
	xs_vec_sub(vBackLeft, fwd, vBackLeft)
	xs_vec_sub(vBackLeft, right, vBackLeft)
	xs_vec_add(vBackLeft, up, vBackLeft)
	set_pdata_vec(ent, m_vBackLeft, vBackLeft)
	new Float:vBackRight[3]
	vBackRight = origin
	xs_vec_sub(vBackRight, fwd, vBackRight)
	xs_vec_add(vBackRight, right, vBackRight)
	xs_vec_add(vBackRight, up, vBackRight)
	set_pdata_vec(ent, m_vBackRight, vBackRight)
	new Float:vBack[3]
	vBack = origin
	xs_vec_sub(vBack, fwd, vBack)
	xs_vec_add(vBack, up, vBack)
	set_pdata_vec(ent, m_vBack, vBack)
	set_pdata_vec(ent, m_vSurfaceNormal, g_vecZero)
	
	CheckTurning(ent)
	
	if (get_gametime() > get_pdata_float(ent, m_flSteeringWheelDecay, 4))
	{
		set_pdata_float(ent, m_flSteeringWheelDecay, get_gametime() + 0.1, 4)
		
		if (get_pdata_int(ent, m_iTurnAngle, 4) < 0)
			set_pdata_int(ent, m_iTurnAngle, get_pdata_int(ent, m_iTurnAngle, 4) + 1, 4)
		else if (get_pdata_int(ent, m_iTurnAngle, 4) > 0)
			set_pdata_int(ent, m_iTurnAngle, get_pdata_int(ent, m_iTurnAngle, 4) - 1, 4)
	}
	
	if (get_gametime() > get_pdata_float(ent, m_flAcceleratorDecay, 4))
	{
		if (entity_get_float(ent, EV_FL_speed) < 0.0)
		{
			entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) + 20.0)
			
			if (entity_get_float(ent, EV_FL_speed) > 0.0)
				entity_set_float(ent, EV_FL_speed, 0.0)
		}
		else if (entity_get_float(ent, EV_FL_speed) > 0.0)
		{
			entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) - 20.0)
			
			if (entity_get_float(ent, EV_FL_speed) < 0.0)
				entity_set_float(ent, EV_FL_speed, 0.0)
		}
	}

	if (entity_get_float(ent, EV_FL_speed) == 0.0)
	{
		set_pdata_int(ent, m_iTurnAngle, 0, 4)
		entity_set_vector(ent, EV_VEC_avelocity, g_vecZero)
		entity_set_vector(ent, EV_VEC_velocity, g_vecZero)
		SetThink(ent, THINK_NEXT);
		NextThink(ent, entity_get_float(ent, EV_FL_ltime) + 0.1, true);
		return;
	}
	
	TerrainFollowing(ent);
	//CollisionDetection(ent);
	
	new Float:vSurfaceNormal[3]
	get_pdata_vec(ent, m_vSurfaceNormal, vSurfaceNormal)

	if (vSurfaceNormal[0] == 0.0 && vSurfaceNormal[1] == 0.0 && vSurfaceNormal[2] == 0.0) // vehicle in air?
	{
		if (get_pdata_float(ent, m_flLaunchTime, 4) != -1.0)
		{
			vGravityVector = g_vecZero;
			vGravityVector[2] = (get_gametime() - get_pdata_float(ent, m_flLaunchTime, 4)) * -35.0;

			if (vGravityVector[2] < -400.0)
				vGravityVector[2] = -400.0;
		}
		else
		{
			set_pdata_float(ent, m_flLaunchTime, get_gametime(), 4)
			vGravityVector = g_vecZero;
			new Float:velocity[3]
			entity_get_vector(ent, EV_VEC_velocity, velocity)
			xs_vec_mul_scalar(velocity, 1.5, velocity)
			entity_set_vector(ent, EV_VEC_velocity, velocity)
		}
		
		new Float:vVehicleDirection[3]
		global_get(glb_v_forward, vVehicleDirection)
		xs_vec_mul_scalar(vVehicleDirection, -1.0, vVehicleDirection)
		set_pdata_vec(ent, m_vVehicleDirection, vVehicleDirection)
	}
	else
	{
		new Float:vVehicleDirection[3]
		new Float:v_forward[3]
		global_get(glb_v_forward, v_forward)
		xs_vec_cross(vSurfaceNormal, v_forward, vVehicleDirection)
		xs_vec_cross(vSurfaceNormal, vVehicleDirection, vVehicleDirection)
		set_pdata_vec(ent, m_vVehicleDirection, vVehicleDirection)
		
		vector_to_angle(vVehicleDirection, angles)
		angles[1] += 180.0;

		if (get_pdata_int(ent, m_iTurnAngle, 4) != 0)
			angles[1] += get_pdata_int(ent, m_iTurnAngle, 4);
		
		FixupAngles(angles);
		new Float:angles2[3]
		entity_get_vector(ent, EV_VEC_angles, angles2)
		FixupAngles(angles2);
		entity_set_vector(ent, EV_VEC_angles, angles2)
		
		new Float:vx = UTIL_AngleDistance(angles[0], angles2[0]);
		new Float:vy = UTIL_AngleDistance(angles[1], angles2[1]);

		if (vx > 10.0)
			vx = 10.0;
		else if (vx < -10.0)
			vx = -10.0;

		if (vy > 10.0)
			vy = 10.0;
		else if (vy < -10.0)
			vy = -10.0;
		
		new Float:avelocity[3]
		entity_get_vector(ent, EV_VEC_avelocity, avelocity)
		avelocity[1] = float(floatround(vy * 10.0));
		avelocity[0] = float(floatround(vx * 10.0));
		entity_set_vector(ent, EV_VEC_avelocity, avelocity)
		
		set_pdata_float(ent, m_flLaunchTime, -1.0, 4)
		set_pdata_float(ent, m_flLastNormalZ, vSurfaceNormal[2], 4)
	}

	new Float:vVehicleDirection[3]
	get_pdata_vec(ent, m_vVehicleDirection, vVehicleDirection)
	//vector_to_angle(vVehicleDirection, vVehicleDirection)
	//set_pdata_vec(ent, m_vVehicleDirection, vVehicleDirection)
	
	if (get_gametime() > get_pdata_float(ent, m_flUpdateSound, 4))
	{
		UpdateSound(ent);
		set_pdata_float(ent, m_flUpdateSound, get_gametime() + 1.0, 4)
	}
	
	if (vSurfaceNormal[0] == 0.0 && vSurfaceNormal[1] == 0.0 && vSurfaceNormal[2] == 0.0)
	{
		new Float:velocity[3]
		entity_get_vector(ent, EV_VEC_velocity, velocity)
		xs_vec_add(velocity, vGravityVector, velocity)
		entity_set_vector(ent, EV_VEC_velocity, velocity)
	}
	else
	{
		xs_vec_normalize(vVehicleDirection, vVehicleDirection)
		xs_vec_mul_scalar(vVehicleDirection, entity_get_float(ent, EV_FL_speed), vVehicleDirection)
		entity_set_vector(ent, EV_VEC_velocity, vVehicleDirection)
	}
	
	SetThink(ent, THINK_NEXT);
	NextThink(ent, entity_get_float(ent, EV_FL_ltime) + 0.1, true);
}

CheckTurning(ent)
{
	//client_print(0, print_chat, "CheckTurning(%d) called with m_iTurnAngle %d", ent, get_pdata_int(ent, m_iTurnAngle, 4))
	
	new tr = create_tr2();
	new Float:vecStart[3], Float:vecEnd[3]

	if (get_pdata_int(ent, m_iTurnAngle, 4) < 0)
	{
		if (entity_get_float(ent, EV_FL_speed) > 0.0)
		{
			get_pdata_vec(ent, m_vFrontLeft, vecStart)
			
			new Float:tempVec[3]
			global_get(glb_v_right, tempVec)
			xs_vec_mul_scalar(tempVec, 16.0, tempVec)
			xs_vec_sub(vecStart, tempVec, vecEnd)
		}
		else if (entity_get_float(ent, EV_FL_speed) < 0)
		{
			get_pdata_vec(ent, m_vBackLeft, vecStart)
			
			new Float:tempVec[3]
			global_get(glb_v_right, tempVec)
			xs_vec_mul_scalar(tempVec, 16.0, tempVec)
			xs_vec_add(vecStart, tempVec, vecEnd)
		}
		
		engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
		
		new Float:fraction
		get_tr2(tr, TR_flFraction, fraction)
		
		if (fraction != 1.0)
			set_pdata_int(ent, m_iTurnAngle, 1, 4)
	}
	else if (get_pdata_int(ent, m_iTurnAngle, 4) > 0)
	{
		if (entity_get_float(ent, EV_FL_speed) > 0)
		{
			get_pdata_vec(ent, m_vFrontRight, vecStart)
			
			new Float:tempVec[3]
			global_get(glb_v_right, tempVec)
			xs_vec_mul_scalar(tempVec, 16.0, tempVec)
			xs_vec_add(vecStart, tempVec, vecEnd)
		}
		else if (entity_get_float(ent, EV_FL_speed) < 0)
		{
			get_pdata_vec(ent, m_vBackRight, vecStart)
			
			new Float:tempVec[3]
			global_get(glb_v_right, tempVec)
			xs_vec_mul_scalar(tempVec, 16.0, tempVec)
			xs_vec_sub(vecStart, tempVec, vecEnd)
		}

		engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
		
		new Float:fraction
		get_tr2(tr, TR_flFraction, fraction)
		
		if (fraction != 1.0)
			set_pdata_int(ent, m_iTurnAngle, -1, 4)
	}
	
	free_tr2(tr)
	
	if (entity_get_float(ent, EV_FL_speed) <= 0.0)
		return;
	
	new Float:speed;
	new turning = abs(get_pdata_int(ent, m_iTurnAngle, 4));

	if (turning > 4)
	{
		if (get_pdata_float(ent, m_flTurnStartTime, 4) != -1.0)
		{
			new Float:time = get_gametime() - get_pdata_float(ent, m_flTurnStartTime, 4);

			if (time >= 0)
				speed = get_pdata_float(ent, m_speed, 4) * 0.98;
			else if (time > 0.3)
				speed = get_pdata_float(ent, m_speed, 4) * 0.95;
			else if (time > 0.6)
				speed = get_pdata_float(ent, m_speed, 4) * 0.9;
			else if (time > 0.8)
				speed = get_pdata_float(ent, m_speed, 4) * 0.8;
			else if (time > 1)
				speed = get_pdata_float(ent, m_speed, 4) * 0.7;
			else if (time > 1.2)
				speed = get_pdata_float(ent, m_speed, 4) * 0.5;
			else
				speed = time;
		}
		else
		{
			set_pdata_float(ent, m_flTurnStartTime, get_gametime(), 4)
			speed = get_pdata_float(ent, m_speed, 4);
		}
	}
	else
	{
		set_pdata_float(ent, m_flTurnStartTime, -1.0, 4)

		if (turning > 2)
			speed = get_pdata_float(ent, m_speed, 4) * 0.9;
		else
			speed = get_pdata_float(ent, m_speed, 4);
	}

	if (speed < entity_get_float(ent, EV_FL_speed))
	{
		new Float:tempSpeed
		tempSpeed = entity_get_float(ent, EV_FL_speed)
		tempSpeed -= get_pdata_float(ent, m_speed, 4) * 0.1;
		entity_set_float(ent, EV_FL_speed, tempSpeed)
	}
}

TerrainFollowing(ent)
{
	new Float:origin[3]
	entity_get_vector(ent, EV_VEC_origin, origin)
	new Float:vector[3]
	vector[2] = (get_pdata_float(ent, m_height, 4) + 48.0) * -1.0
	new Float:originvector[3]
	xs_vec_add(origin, vector, originvector)
	
	new tr = create_tr2()
	engfunc(EngFunc_TraceLine, origin, originvector, IGNORE_MONSTERS, ent, tr)
	
	new Float:fraction
	get_tr2(tr, TR_flFraction, fraction)
	
	if (fraction != 1.0)
	{
		new Float:vPlaneNormal[3]
		get_tr2(tr, TR_vecPlaneNormal, vPlaneNormal)
		
		set_pdata_vec(ent, m_vSurfaceNormal, vPlaneNormal)
	}
	else if (get_tr2(tr, TR_InWater))
	{
		set_pdata_vec(ent, m_vSurfaceNormal, Float:{0.0, 0.0, 1.0})
	}
	
	free_tr2(tr)
}

CollisionDetection(ent)
{
	new tr = create_tr2();
	new Float:vecStart[3], Float:vecEnd[3];
	new Float:flDot;

	if (entity_get_float(ent, EV_FL_speed) < 0.0)
	{
		get_pdata_vec(ent, m_vBackLeft, vecStart)
		new Float:temp_vec[3]
		global_get(glb_v_forward, temp_vec)
		xs_vec_mul_scalar(temp_vec, 16.0, temp_vec)
		xs_vec_add(vecStart, temp_vec, vecEnd)
		
		engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
		
		new Float:fraction, Float:vecPlaneNormal[3], Float:vforward[3], Float:revPlaneNormal[3]
		get_tr2(tr, TR_flFraction, fraction)
		get_tr2(tr, TR_vecPlaneNormal, vecPlaneNormal)
		global_get(glb_v_forward, vforward)
		xs_vec_mul_scalar(vecPlaneNormal, -1.0, revPlaneNormal)
		
		if (fraction != 1.0)
		{
			flDot = xs_vec_dot(vforward, revPlaneNormal)
			if (flDot < 0.7 && vecPlaneNormal[2] < 0.1)
			{
				set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
				set_pdata_float(ent, m_vSurfaceNormal+2, 0.0)
				entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * 0.99)
			}
			else if (vecPlaneNormal[2] < 0.65 || get_tr2(tr, TR_StartSolid))
				entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * -1.0)
			else
				set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)

			new pHit = get_tr2(tr, TR_pHit)
			
			//if (pHit && pHit->Classify() == CLASS_VEHICLE)
			//	ALERT(at_console, "I hit another vehicle\n");
		}
		
		get_pdata_vec(ent, m_vBackRight, vecStart)
		xs_vec_add(vecStart, temp_vec, vecEnd)
		
		engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
		
		get_tr2(tr, TR_flFraction, fraction)
		
		if (fraction == 1.0)
		{
			get_pdata_vec(ent, m_vBack, vecStart)
			xs_vec_add(vecStart, temp_vec, vecEnd)
			engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
			
			get_tr2(tr, TR_flFraction, fraction)
			
			if (fraction == 1.0)
			{
				free_tr2(tr)
				return;
			}
		}
		
		// Update revPlaneNormal
		get_tr2(tr, TR_vecPlaneNormal, vecPlaneNormal)
		xs_vec_mul_scalar(vecPlaneNormal, -1.0, revPlaneNormal)
		
		flDot = xs_vec_dot(vforward, revPlaneNormal)

		if (flDot >= 0.7)
		{
			if (vecPlaneNormal[2] < 0.65 || get_tr2(tr, TR_StartSolid) != 0)
				entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * -1.0)
			else
				set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
		}
		else if (vecPlaneNormal[2] < 0.1)
		{
			set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
			set_pdata_float(ent, m_vSurfaceNormal+2, 0.0)
			entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * 0.99)
		}
		else if (vecPlaneNormal[2] < 0.65 || get_tr2(tr, TR_StartSolid) != 0)
			entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * -1.0)
		else
			set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
	}
	else if (entity_get_float(ent, EV_FL_speed) > 0.0)
	{
		get_pdata_vec(ent, m_vFrontRight, vecStart)
		new Float:temp_vec[3], Float:vforward[3]
		global_get(glb_v_forward, vforward)
		xs_vec_mul_scalar(vforward, 16.0, temp_vec)
		xs_vec_sub(vecStart, temp_vec, vecEnd)
		
		engfunc(EngFunc_TraceLine, vecStart, vecEnd, DONT_IGNORE_MONSTERS, ent, tr)
		
		new Float:fraction
		get_tr2(tr, TR_flFraction, fraction)
		
		if (fraction == 1.0)
		{
			get_pdata_vec(ent, m_vFrontLeft, vecStart)
			xs_vec_sub(vecStart, temp_vec, vecEnd)
			
			engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
			
			get_tr2(tr, TR_flFraction, fraction)
			
			if (fraction == 1.0)
			{
				get_pdata_vec(ent, m_vFront, vecStart)
				xs_vec_sub(vecStart, temp_vec, vecEnd)
				
				engfunc(EngFunc_TraceLine, vecStart, vecEnd, IGNORE_MONSTERS, ent, tr)
				
				get_tr2(tr, TR_flFraction, fraction)
				
				if (fraction == 1.0)
				{
					free_tr2(tr)
					return;
				}
			}
		}
		
		new Float:vecPlaneNormal[3], Float:revPlaneNormal[3]
		get_tr2(tr, TR_vecPlaneNormal, vecPlaneNormal)
		xs_vec_mul_scalar(vecPlaneNormal, -1.0, revPlaneNormal)
		
		flDot = xs_vec_dot(vforward, revPlaneNormal)
		
		if (flDot <= -0.7)
		{
			if (vecPlaneNormal[2] < 0.65 || get_tr2(tr, TR_StartSolid) != 0)
				entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * -1.0)
			else
				set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
		}
		else if (vecPlaneNormal[2] < 0.1)
		{
			set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
			set_pdata_float(ent, m_vSurfaceNormal+2, 0.0)
			entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * 0.99)
		}
		else if (vecPlaneNormal[2] < 0.65 || get_tr2(tr, TR_StartSolid) != 0)
			entity_set_float(ent, EV_FL_speed, entity_get_float(ent, EV_FL_speed) * -1.0)
		else
			set_pdata_vec(ent, m_vSurfaceNormal, vecPlaneNormal)
	}
}

SetThink(ent, type)
{
	//client_print(0, print_chat, "SetThink(%d) called", type)
	
	set_pev(ent, pev_iuser4, type)
}

NextThink(ent, Float:thinkTime, bool:alwaysThink)
{
	if (alwaysThink)
		set_pev(ent, pev_flags, pev(ent, pev_flags) | FL_ALWAYSTHINK)
	else
		set_pev(ent, pev_flags, pev(ent, pev_flags) & ~FL_ALWAYSTHINK)

	set_pev(ent, pev_nextthink, thinkTime)
	
	//if (pev(ent, pev_flags) & FL_ALWAYSTHINK)
	//	client_print(0, print_chat, "Set %d nextthink for %f with FL_ALWAYSTHINK", ent, thinkTime)
	//else
	//	client_print(0, print_chat, "Set %d nextthink for %f without FL_ALWAYSTHINK", ent, thinkTime)
}

ShouldToggle(useType, bool:currentState)
{
	if (useType != USE_TOGGLE && useType != USE_SET)
	{
		if ((currentState && useType == USE_ON) || (!currentState && useType == USE_OFF))
			return 0;
	}
	
	return 1;
}

get_pdata_vec(ent, num, Float:vec[3], offset = 4)
{
	vec[0] = get_pdata_float(ent, num, offset)
	vec[1] = get_pdata_float(ent, num+1, offset)
	vec[2] = get_pdata_float(ent, num+2, offset)
}

set_pdata_vec(ent, num, Float:vec[3], offset = 4)
{
	set_pdata_float(ent, num, vec[0], offset)
	set_pdata_float(ent, num+1, vec[1], offset)
	set_pdata_float(ent, num+2, vec[2], offset)
}

Float:Fix(Float:angle2)
{
	new Float:angle = angle2
	
	while (angle < 0.0)
		angle += 360.0;
	while (angle > 360.0)
		angle -= 360.0;

	return angle;
}

FixupAngles(Float:v[3])
{
	v[0] = Fix(v[0]);
	v[1] = Fix(v[1]);
	v[2] = Fix(v[2]);
}

Float:UTIL_AngleDistance(Float:next, Float:cur)
{
	new Float:delta = next - cur;

	if (delta < -180.0)
		delta += 360.0;
	else if (delta > 180.0)
		delta -= 360.0;

	return delta;
}

UpdateSound(ent)
{
	//client_print(0, print_chat, "UpdateSound() called")
}

StopSound(ent)
{
	//client_print(0, print_chat, "StopSound() called")
}
*/
public fw_finish(ent, finish_ent)
{
	//client_print(0, print_chat, "somebody finished")
	
	static id
	id = entity_get_int(ent, VEHICLE_OWNER)
	
	//client_print(0, print_chat, "somebody finished %d", id)
	
	if (!is_user_alive(id))
		return;
	
	// finish entity?
	static target[32]
	entity_get_string(ent, EV_SZ_target, target, charsmax(target))
	
	//client_print(0, print_chat, target)
	
	if (!equal(target, "racemod_finish"))
		return;
	
	//client_print(0, print_chat, "somebody finished2")
	
}

public test(id)
{
	client_print(id, print_console, "Cur gametime: %f", get_gametime())
	
	new ent = entity_get_int(id, OWNED_VEHICLE)
	for (new i = 34; i <= 84; i++)
	{
		client_print(id, print_console, "pdata %d = %f", i, get_pdata_float(ent, i, 4))
	}
	
	//entity_set_vector(ent, EV_VEC_velocity, Float:{500.0, 0.0, 200.0})
	
	//set_pdata_vec(ent, m_vVehicleDirection, Float:{70.0, 286.0, 11.0})
}

public task_vehicle_stats()
{
	for (new id = 1; id <= g_maxplayers; id++)
	{
		if (!is_user_alive(id))
			continue;
		
		if (!is_user_driving(id))
			continue;
		
		static ent, speed, maxspeed
		ent = entity_get_int(id, OWNED_VEHICLE)
		speed = floatround(floatabs(entity_get_float(ent, EV_FL_speed)), floatround_floor)
		maxspeed = 600
		
		static bar[64]
		formatex(bar, charsmax(bar), "[ ")
		for (new i = 1; i <= 10; i++)
		{
			if (speed >= i*maxspeed/10) add(bar, charsmax(bar), "— ")
		}
		add(bar, charsmax(bar), "]")
		
		set_hudmessage(255, 255, 255, -1.0, 0.7, 0, 0.0, 0.2, 0.01, 0.0)
		ShowSyncHudMsg(id, g_msgSyncHud, "^n%s^n%d km/h", bar, speed)
	}
}

// Start of preparation time
public event_round_start()
{
	// Reset all players' vars
	for (new id = 1; id <= g_maxplayers; id++)
	{
		if (!is_user_connected(id))
			continue;
		
		entity_set_int(id, OWNED_VEHICLE, 0)
	}
	
	// Reset all vehicles' owners
	new ent = -1
	while ((ent = find_ent_by_class(ent, "func_vehicle")))
	{
		entity_set_int(ent, VEHICLE_OWNER, 0)
		//entity_set_vector(ent, EV_VEC_angles, Float:{0.0, 0.0, 0.0})
	}
	
	g_preptime = get_pcvar_num(cvar_preptime)
	g_roundstarttime = get_systime()
	
	// Prepare sound
	client_cmd(0, "spk %s", SOUND_PREPARE)
	
	// Set task until prepare time end
	remove_task(TASK_PREPARE)
	set_task(1.0, "task_prepare", TASK_PREPARE, _, _, "b")
	update_timer(g_preptime+1)
	
	remove_task(TASK_VEHICLE_STATS)
	set_task(0.1, "task_vehicle_stats", TASK_VEHICLE_STATS, _, _, "b")
}

// All players have crashed
public event_round_end()
{
	remove_task(TASK_PREPARE)
}

// Preparation time
public task_prepare()
{
	g_preptime--;
	
	if (g_preptime > 0) // preptime counting
	{
		// hud
		set_dhudmessage(20, 255, 20, -1.0, 0.4, 0, 0.0, 1.0, 0.0, 0.1)
		show_dhudmessage(0, "%d", g_preptime)
		
		if (g_preptime <= 3) // sound
			client_cmd(0, "spk racemod/%d.wav", g_preptime)
	}
	else // round started
	{
		remove_task(TASK_PREPARE)
		g_preptime = false
		
		// Kill vehicles without owners
		new ent = -1
		while ((ent = find_ent_by_class(ent, "func_vehicle")))
		{
			if (!is_user_alive(entity_get_int(ent, VEHICLE_OWNER)))
			{
				// get entity origin
				static Float:originF[3]
				entity_get_vector(ent, EV_VEC_origin, originF)
				
				// move entity out of map
				entity_set_origin(ent, Float:{8192.0,8192.0,8192.0})
			}
		}
		
		// Start sound
		client_cmd(0, "spk %s", SOUND_START)
		
		// Msg
		set_dhudmessage(20, 255, 20, -1.0, 0.4, 0, 0.0, 1.0, 0.0, 0.1)
		show_dhudmessage(0, "PLAY !!!")
	}
}

// Player started controlling vehicle
public fw_OnControlVehicle(ent, id)
{
	if (!g_preptime)
		return HAM_IGNORED;
	
	new owner
	owner = entity_get_int(ent, VEHICLE_OWNER)
	
	if (owner == id)
		return HAM_IGNORED;
	
	if (is_user_connected(owner))
	{
		new name[32]
		get_user_name(owner, name, charsmax(name))
		ChatColor(id, "^1* This vehicle is already owned by^4 %s^1. Go find another one!", name)
		return HAM_SUPERCEDE;
	}
	
	new owned_vehicle
	owned_vehicle = entity_get_int(id, OWNED_VEHICLE)
	
	if (is_valid_vehicle(owned_vehicle) && owned_vehicle != ent)
	{
		ChatColor(id, "^1* You already have a vehicle.^4 Go back!")
		return HAM_SUPERCEDE;
	}
	
	entity_set_int(ent, VEHICLE_OWNER, id)
	entity_set_int(id, OWNED_VEHICLE, ent)
	
	ChatColor(id, "^1* This vehicle is now^4 yours^1!")
	return HAM_IGNORED;
}

// Forward Player PreThink
public fw_PlayerPreThink(id)
{
	if (g_preptime)
		return;
	
	if (!is_user_alive(id))
		return;
	
	static ent
	ent = entity_get_int(id, OWNED_VEHICLE)
	
	if (is_user_driving(id))
	{
		if (is_valid_vehicle(ent))
		{
			set_pdata_float(ent, 54, get_gametime() + 0.01)
		}
	}
	else // Escaped the car
	{
		ChatColor(id, "^1* You can't^4 leave from your vehicle^1 during the race!")
		
		if (is_valid_vehicle(ent))
		{
			// get entity origin
			static Float:originF[3]
			entity_get_vector(ent, EV_VEC_origin, originF)
			
			// move entity out of map
			entity_set_origin(ent, Float:{8192.0,8192.0,8192.0})
			
			// create explosion
			ExplosionCreate(originF, 150)
		}
		
		user_silentkill(id)
	}
}

// Ham Player Killed Forward
public fw_PlayerKilled(victim, attacker, shouldgib)
{
	SetHamParamInteger(3, GIB_ALWAYS)
	return HAM_HANDLED;
}

// Forward CmdStart
public fw_CmdStart(id, uc)
{
	if (!is_user_alive(id))
		return;
	
	if (!is_user_driving(id))
		return;
	
	static buttons
	buttons = get_uc(uc, UC_Buttons)
	
	if (g_preptime)
	{
		if (buttons & IN_FORWARD || buttons & IN_BACK)
		{
			buttons &= ~IN_FORWARD
			buttons &= ~IN_BACK
			
			set_uc(uc, UC_Buttons, buttons)
		}
	}
	else
	{
		if (buttons & IN_JUMP)
		{
			static ent, Float:velocity[3]
			ent = entity_get_int(id, OWNED_VEHICLE)
			
			if (is_valid_vehicle(ent))
			{
				entity_get_vector(ent, EV_VEC_velocity, velocity)
				
				velocity[0] *= 0.95
				velocity[1] *= 0.95
				
				entity_set_vector(ent, EV_VEC_velocity, velocity)
				
				entity_set_float(ent, EV_FL_speed, 0.0)
				
				buttons &= ~IN_JUMP
				set_uc(uc, UC_Buttons, buttons)
			}
		}
	}
}

public fw_PlayerSpawn_Post(id)
{
	if (!is_user_alive(id))
		return;
	
	strip_user_weapons(id)
}




is_valid_vehicle(ent)
{
	if (!pev_valid(ent))
		return false;
	
	static classname[32]
	entity_get_string(ent, EV_SZ_classname, classname, charsmax(classname))
	
	if (!equal(classname, "func_vehicle"))
		return false;
	
	return true;
}

is_user_driving(id)
{
	if (pev_valid(id) != PDATA_SAFE)
		return false;
	
	return get_pdata_int(id, OFFSET_ISDRIVING);
}





public message_RoundTime(msg_id, msg_dest, msg_ent)
{
	if (!g_preptime)
		return;
	
	static remaining
	remaining = get_pcvar_num(cvar_preptime)-(get_systime()-g_roundstarttime)
	
	set_msg_arg_int(1, ARG_SHORT, remaining)
}

public message_StatusIcon(msg_id, msg_dest, msg_entity)
{
	new icon[8]
	get_msg_arg_string(2, icon, charsmax(icon))
	
	if (equal(icon, "buyzone") && pev_valid(msg_entity) == PDATA_SAFE)
	{
		set_pdata_int(msg_entity, OFFSET_BUYZONE, get_pdata_int(msg_entity, OFFSET_BUYZONE, OFFSET_LINUX) & ~(1<<0), OFFSET_LINUX)
		return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}
















// Update timer on all clients
stock update_timer(seconds)
{
	message_begin(MSG_BROADCAST, g_msgRoundTime)
	write_short(seconds)
	message_end()
}
























/**
 * Creates an explosion which the engine will do.
 * Note: Requieres Engine Module. Tested only on CS Steam.
 *
 * @param vecCenter                Position where the explosion should be created.
 * @param iMagnitude            Explosion size. This defines the explosion's max damage and sprite's size
 * @param iFlags                Explosion flags which you can find on hlsdk_const.inc
 * @param bDoDamage                Should do a radius damage?
 * @param bNoActivate        If this param is on true, the entity won't explode, and you must do it manually
 * @return                    Entity index on sucess, 0 on failure.
 */

stock ExplosionCreate(const Float:vecCenter[3], iMagnitude, iFlags = 0, bool:bDoDamage = false, bool:bNoActivate = false)
{
    // env_explosion entities are the ones
    // who creates explosions. So we are available
    // for using this one for creating explosions
    new iEnt = create_entity("env_explosion")
    
    if(!iEnt) // Invalid?
    return 0
    
    // The center of the explosion
    entity_set_origin(iEnt, vecCenter)
    
    // Key values must be only string, so we must
    // convert it from Int to String.
    new szMagnitude[8] // In explode.cpp the char size is 128 lol.
    formatex(szMagnitude, charsmax(szMagnitude), "%3d", iMagnitude) // Exactly as how the engine does it.
    DispatchKeyValue(iEnt, "iMagnitude", szMagnitude) // This will modify m_iMagnitude value.
    
    // In hlsdk_const.inc you can find env_explosion's spawn flags
    if(!bDoDamage) // If you don't want to create a damage sphere, so we must only add this flag.
        entity_set_int(iEnt, EV_INT_spawnflags, iFlags | SF_ENVEXPLOSION_NODAMAGE)
    else
        entity_set_int(iEnt, EV_INT_spawnflags, iFlags) // 3rd parameter flags.
    
    // Applying some pev values, and offset modifications
    DispatchSpawn(iEnt)
    
    if(!bNoActivate)
        force_use(iEnt, iEnt) // The engine doesn't care who used it. Btw, this actives the explosion.
    
    return iEnt
}

// Color Chat
stock ChatColor(const id, const input[], any:...)
{
	new count = 1, players[32]
	static msg[193]
	vformat(msg, 190, input, 3)
	
	if(id) {
		players[0] = id;
		} else {
		get_players(players, count, "ch")
	}
	
	static msgSayText
	if (!msgSayText) msgSayText = get_user_msgid("SayText")
	
	for(new i = 0; i < count; i++) {
		if(is_user_connected(players[i])) {
			message_begin(MSG_ONE_UNRELIABLE, msgSayText, _, players[i])
			write_byte(players[i])
			write_string(msg)
			message_end()
		}
	}
}
