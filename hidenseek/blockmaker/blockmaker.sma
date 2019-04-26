/*================================================================================
 [Plugin Customization]
=================================================================================*/

// Uncomment if you're using xRedirect
// #define XREDIRECT

// Comment if you want to save some CPU and are okay with teammates not being able to see their stealthed teammates
#define ADVANCED_STEALTH

// Uncomment if you want to get rid of non-admin players automatically during building
#define BUILD_MODE_KICK_UNWANTED

// All customization settings have been moved
// to external files to allow easier editing
new const BM_CUSTOMIZATION_FILE[] = "blockmaker.ini"

// Entity names used by the blockmaker
new const BLOCK_CLASSNAME[] = "bm_block"
new const TELEPORT_START_CLASSNAME[] = "bm_teleport_start"
new const TELEPORT_DEST_CLASSNAME[] = "bm_teleport_destination"

// Total frames in teleport sprites
const TELEPORT_START_FRAMES = 5
const TELEPORT_END_FRAMES = 3

const MAX_ENTITIES = 1500
const MAX_GROUPED_BLOCKS = 32

/*================================================================================
 Customization ends here! Yes, that's it. Editing anything beyond
 here is not officially supported. Proceed at your own risk...
=================================================================================*/

#include <amxmodx>
#include <amxmisc>
#include <fakemeta>
#include <hamsandwich>
#include <engine>
#include <cstrike>
#include <fun>

#include <dhudmessage>

#if defined XREDIRECT
	#include <xredirect>
#endif

/*================================================================================
 [Constants, Offsets, Macros]
=================================================================================*/

// Plugin Version
new const PLUGIN_VERSION[] = "2.20"

// Customization file sections
enum
{
	SECTION_NONE = 0,
	SECTION_ACCESS_FLAGS,
	SECTION_MODELS,
	SECTION_BLOCK_MODELS,
	SECTION_BLOCK_NAMES,
	SECTION_BLOCK_SIZE_NAMES,
	SECTION_BLOCK_DEFAULT_PROPS,
	SECTION_SPRITES,
	SECTION_SOUNDS
}

// Tasks
enum (+= 2000)
{
	#if defined XREDIRECT
		TASK_REDIRECT_BYPASS,
	#endif
	
	TASK_ICE,
	TASK_NOSLOWDOWN,
	TASK_HONEY,
	TASK_CAMOUFLAGE,
	TASK_BOOTS_OF_SPEED,
	TASK_STEALTH,
	TASK_INVINCIBILITY
}

// Access flags
enum
{
	ACCESS_BM = 0,
	ACCESS_DELETE_ALL,
	ACCESS_SAVE_ALL,
	ACCESS_BUILDING_MODE,
	ACCESS_VIP,
	ACCESS_RESPAWN_PLAYERS,
	ACCESS_GIVE_ACCESS,
	MAX_ACCESS_FLAGS
}

// Blocks
enum
{
	BLOCK_PLATFORM = 0,
	BLOCK_BHOP,
	BLOCK_DEATH,
	BLOCK_GLASS,
	BLOCK_BHOP_NOSLOWDOWN,
	BLOCK_HEAL,
	BLOCK_ICE,
	BLOCK_NO_FALL_DAMAGE,
	BLOCK_SPEED_BOOST,
	BLOCK_TRAMPOLINE,
	BLOCK_LOW_GRAVITY,
	BLOCK_HONEY,
	BLOCK_CT_BARRIER,
	BLOCK_T_BARRIER,
	BLOCK_VIP_ONLY,
	BLOCK_DAMAGE,
	BLOCK_GRENADE,
	BLOCK_WEAPON,
	BLOCK_CAMOUFLAGE,
	BLOCK_BLINDTRAP,
	BLOCK_BOOTS_OF_SPEED,
	BLOCK_STEALTH,
	BLOCK_MAGIC_CARPET,
	BLOCK_INVINCIBILITY,
	
	MAX_BLOCKS
}

new const CONFIG_BLOCK_NAME[MAX_BLOCKS][] =
{
	"PLATFORM",
	"BHOP",
	"DEATH",
	"GLASS",
	"BHOP NOSLOWDOWN",
	"HEAL",
	"ICE",
	"NO FALL DAMAGE",
	"SPEED BOOST",
	"TRAMPOLINE",
	"LOW GRAVITY",
	"HONEY",
	"CT BARRIER",
	"T BARRIER",
	"VIP ONLY",
	"DAMAGE",
	"GRENADE",
	"WEAPON",
	"CAMOUFLAGE",
	"BLIND TRAP",
	"BOOTS OF SPEED",
	"STEALTH",
	"MAGIC CARPET",
	"INVINCIBILITY"
}

// Block Sizes
enum
{
	BLOCK_SIZE_POLE,
	BLOCK_SIZE_SMALL,
	BLOCK_SIZE_NORMAL,
	BLOCK_SIZE_LARGE,
	BLOCK_SIZE_JUMBO,
	MAX_BLOCK_SIZES
}

// Teleports
enum
{
	TELEPORT_START = 0,
	TELEPORT_DESTINATION,
	MAX_TELEPORT_TYPES
}

enum
{
	X = 0,
	Y,
	Z
}

// Properties
enum
{
	PROP_ONTOPONLY = 0,
	PROP_NOFALLDAMAGE,
	
	PROP_TRANSPARENCY,
	PROP_COLOR,
	PROP_TRANSPARENCYGLOW,
	PROP_TRANSPARENCYACTIVE,
	
	PROP_MOVING_DIRECTION,
	PROP_MOVING_DISTANCE,
	PROP_MOVING_SPEED,
	PROP_MOVING_WAIT_BASE,
	PROP_MOVING_WAIT_TARGET,
	PROP_MOVING_BOUNCE,
	PROP_MOVING_GRAVITY,
	
	MAX_PROPS
}

new const PROP_KEY[MAX_PROPS][] =
{
	"prop_on_top_only",
	"prop_no_fall_damage",
	
	"prop_transparency",
	"prop_color",
	"prop_transparency_glow",
	"prop_transparency_active",
	
	"prop_moving_direction",
	"prop_moving_distance",
	"prop_moving_speed",
	"prop_moving_wait_base",
	"prop_moving_wait_target",
	"prop_moving_bounce",
	"prop_moving_gravity"
}

const MAX_SPECIAL_PROPS = 4
new const PROP_SPECIAL_KEY[MAX_BLOCKS][MAX_SPECIAL_PROPS][] =
{
	{ "", "", "", "" }, // 0 - Platform
	{ "sprop_delay_before_use", "sprop_delay_after_use", "", "" }, // 1 - Bhop
	{ "", "", "", "" }, // 2 - Death
	{ "", "", "", "" }, // 3 - Glass
	{ "sprop_delay_before_use", "sprop_delay_after_use", "", "" }, // 4 - Bhop (No Slow Down)
	{ "sprop_healing_amount", "sprop_healing_interval", "sprop_armor_amount", "" }, // 5 - Heal
	{ "sprop_friction", "", "", "" }, // 6 - Ice
	{ "", "", "", "" }, // 7 - No Fall Damage
	{ "sprop_forward_speed", "sprop_upward_speed", "sprop_direction", "" }, // 8 - Speed Boost
	{ "sprop_upward_speed", "", "", "" }, // 9 - Trampoline
	{ "sprop_gravity", "", "", "" }, // 10 - Low Gravity
	{ "sprop_speed", "", "", "" }, // 11 - Honey
	{ "sprop_delay_before_use", "sprop_delay_after_use", "", "" }, // 12 - CT Barrier
	{ "sprop_delay_before_use", "sprop_delay_after_use", "", "" }, // 13 - T Barrier
	{ "sprop_delay_before_use", "sprop_delay_after_use", "", "" }, // 14 - VIP Only
	{ "sprop_damage_amount", "sprop_damage_interval", "", "" }, // 15 - Damage
	{ "sprop_grenade", "sprop_amount", "", "" }, // 16 - Grenade
	{ "sprop_weapon", "sprop_ammo", "", "" }, // 17 - Weapon
	{ "sprop_duration", "sprop_delay", "", "" }, // 18 - Camouflage
	{ "sprop_duration", "sprop_color", "sprop_alpha", "sprop_delay" }, // 19 - Blind Trap
	{ "sprop_speed", "sprop_duration", "sprop_delay_after_use", "" }, // 20 - Boots of Speed
	{ "sprop_stealthiness", "sprop_duration", "sprop_delay_after_use", "" }, // 21 - Stealth
	{ "sprop_duration", "", "", "" }, // 22 - Magic Carpet
	{ "sprop_duration", "sprop_delay_after_use", "", "" } // 23 - Invincibility
}
new const PROP_SPECIAL_NAME[MAX_BLOCKS][MAX_SPECIAL_PROPS][] =
{
	{ "", "", "", "" }, // 0 - Platform
	{ "Delay before use", "Delay after use", "", "" }, // 1 - Bhop
	{ "", "", "", "" }, // 2 - Death
	{ "", "", "", "" }, // 3 - Glass
	{ "Delay before use", "Delay after use", "", "" }, // 4 - Bhop (No Slow Down)
	{ "Healing Amount", "Interval", "Armor Amount", "" }, // 5 - Heal
	{ "Friction", "", "", "" }, // 6 - Ice
	{ "", "", "", "" }, // 7 - No Fall Damage
	{ "Forward Speed", "Upward Speed", "Direction", "" }, // 8 - Speed Boost
	{ "Upward Speed", "", "", "" }, // 9 - Trampoline
	{ "Gravity", "", "", "" }, // 10 - Low Gravity
	{ "Speed", "", "", "" }, // 11 - Honey
	{ "Delay before use", "Delay after use", "", "" }, // 12 - CT Barrier
	{ "Delay before use", "Delay after use", "", "" }, // 13 - T Barrier
	{ "Delay before use", "Delay after use", "", "" }, // 14 - VIP Only
	{ "Damage Amount", "Damage Interval", "", "" }, // 15 - Damage
	{ "Grenade", "Amount", "", "" }, // 16 - Grenade
	{ "Weapon", "Ammo", "", "" }, // 17 - Weapon
	{ "Camouflage Duration", "Cooldown", "", "" }, // 18 - Camouflage
	{ "Duration", "Color", "Transparency", "Cooldown" }, // 19 - Blind Trap
	{ "Speed", "Duration", "Delay after use", "" }, // 20 - Boots of Speed
	{ "Stealthiness", "Duration", "Delay after use", "" }, // 21 - Stealth
	{ "Duration", "", "", "" }, // 22 - Magic Carpet
	{ "Duration", "Delay after use", "", "" } // 23 - Invincibility
}
new const Float:PROP_SPECIAL_DEFAULT_VALUE[MAX_BLOCKS][MAX_SPECIAL_PROPS] =
{
	{ -1.0, -1.0, -1.0, -1.0 }, // 0 - Platform
	{ 0.1, 0.75, -1.0, -1.0 }, // 1 - Bhop
	{ -1.0, -1.0, -1.0, -1.0 }, // 2 - Death
	{ -1.0, -1.0, -1.0, -1.0 }, // 3 - Glass
	{ 0.1, 0.75, -1.0, -1.0 }, // 4 - Bhop (No Slow Down)
	{ 1.0, 0.5, 1.0, -1.0 }, // 5 - Heal
	{ 0.15, -1.0, -1.0, -1.0 }, // 6 - Ice
	{ -1.0, -1.0, -1.0, -1.0 }, // 7 - No Fall Damage
	{ 1000.0, 200.0, 0.0, -1.0 }, // 8 - Speed Boost
	{ 500.0, -1.0, -1.0, -1.0 }, // 9 - Trampoline
	{ 0.25, -1.0, -1.0, -1.0 }, // 10 - Low Gravity
	{ 100.0, -1.0, -1.0, -1.0 }, // 11 - Honey
	{ 0.1, 1.0, -1.0, -1.0 }, // 12 - CT Barrier
	{ 0.1, 1.0, -1.0, -1.0 }, // 13 - T Barrier
	{ 0.1, 1.0, -1.0, -1.0 }, // 14 - VIP Only
	{ 5.0, 0.5, -1.0, -1.0 }, // 15 - Damage
	{ 0.0, 1.0, -1.0, -1.0 }, // 16 - Grenade
	{ 0.0, 1.0, -1.0, -1.0 }, // 17 - Weapon
	{ 10.0, 30.0, -1.0, -1.0 }, // 18 - Camouflage
	{ 1.0, 0.0, 255.0, 3.0 }, // 19 - Blind Trap
	{ 400.0, 6.0, 20.0, -1.0 }, // 20 - Boots of Speed
	{ 0.0, 6.0, 20.0, -1.0 }, // 21 - Stealth
	{ 5.0, -1.0, -1.0, -1.0 }, // 22 - Magic Carpet
	{ 5.0, 60.0, -1.0, -1.0 } // 23 - Invincibility
}
new const Float:PROP_SPECIAL_MIN_VALUE[MAX_BLOCKS][MAX_SPECIAL_PROPS] =
{
	{ -1.0, -1.0, -1.0, -1.0 }, // 0 - Platform
	{ 0.1, 0.1, -1.0, -1.0 }, // 1 - Bhop
	{ -1.0, -1.0, -1.0, -1.0 }, // 2 - Death
	{ -1.0, -1.0, -1.0, -1.0 }, // 3 - Glass
	{ 0.1, 0.1, -1.0, -1.0 }, // 4 - Bhop (No Slow Down)
	{ 1.0, 0.1, 0.0, -1.0 }, // 5 - Heal
	{ 0.0, -1.0, -1.0, -1.0 }, // 6 - Ice
	{ -1.0, -1.0, -1.0, -1.0 }, // 7 - No Fall Damage
	{ 10.0, 200.0, 0.0, -1.0 }, // 8 - Speed Boost
	{ 0.0, -1.0, -1.0, -1.0 }, // 9 - Trampoline
	{ 0.1, -1.0, -1.0, -1.0 }, // 10 - Low Gravity
	{ 50.0, -1.0, -1.0, -1.0 }, // 11 - Honey
	{ 0.1, 0.1, -1.0, -1.0 }, // 12 - CT Barrier
	{ 0.1, 0.1, -1.0, -1.0 }, // 13 - T Barrier
	{ 0.1, 0.1, -1.0, -1.0 }, // 14 - VIP Only
	{ 1.0, 0.1, -1.0, -1.0 }, // 15 - Damage
	{ 0.0, 1.0, -1.0, -1.0 }, // 16 - Grenade
	{ 0.0, 1.0, -1.0, -1.0 }, // 17 - Weapon
	{ 1.0, 0.0, -1.0, -1.0 }, // 18 - Camouflage
	{ 0.5, -1.0, 50.0, 1.0 }, // 19 - Blind Trap
	{ 260.0, 1.0, 0.0, -1.0 }, // 20 - Boots of Speed
	{ 0.0, 1.0, 0.0, -1.0 }, // 21 - Stealth
	{ 1.0, -1.0, -1.0, -1.0 }, // 22 - Magic Carpet
	{ 1.0, 0.0, -1.0, -1.0 } // 23 - Invincibility
}
new const Float:PROP_SPECIAL_MAX_VALUE[MAX_BLOCKS][MAX_SPECIAL_PROPS] =
{
	{ -1.0, -1.0, -1.0, -1.0 }, // 0 - Platform
	{ 10.0, 10.0, -1.0, -1.0 }, // 1 - Bhop
	{ -1.0, -1.0, -1.0, -1.0 }, // 2 - Death
	{ -1.0, -1.0, -1.0, -1.0 }, // 3 - Glass
	{ 10.0, 10.0, -1.0, -1.0 }, // 4 - Bhop (No Slow Down)
	{ 100.0, 60.0, 100.0, 60.0 }, // 5 - Heal
	{ 0.99, -1.0, -1.0, -1.0 }, // 6 - Ice
	{ -1.0, -1.0, -1.0, -1.0 }, // 7 - No Fall Damage
	{ 9999.0, 9999.0, 1.0, -1.0 }, // 8 - Speed Boost
	{ 9999.0, -1.0, -1.0, -1.0 }, // 9 - Trampoline
	{ 2.0, -1.0, -1.0, -1.0 }, // 10 - Low Gravity
	{ 230.0, -1.0, -1.0, -1.0 }, // 11 - Honey
	{ 10.0, 10.0, -1.0, -1.0 }, // 12 - CT Barrier
	{ 10.0, 10.0, -1.0, -1.0 }, // 13 - T Barrier
	{ 10.0, 10.0, -1.0, -1.0 }, // 14 - VIP Only
	{ 99.0, 60.0, -1.0, -1.0 }, // 15 - Damage
	{ 3.0, 60.0, -1.0, -1.0 }, // 16 - Grenade
	{ 24.0, 100.0, -1.0, -1.0 },  // 17 - Weapon
	{ 300.0, 300.0, -1.0, -1.0 },  // 18 - Camouflage
	{ 10.0, -1.0, 255.0, 60.0 },  // 19 - Blind Trap
	{ 800.0, 60.0, 300.0, -1.0 },  // 20 - Boots of Speed
	{ 255.0, 60.0, 300.0, -1.0 },  // 21 - Stealth
	{ 300.0, -1.0, -1.0, -1.0 },  // 22 - Magic Carpet
	{ 300.0, 300.0, -1.0, -1.0 }  // 23 - Invincibility
}

// Moving block stages
enum
{
	MOVING_STAGE_WAIT_BASE,
	MOVING_STAGE_TO_TARGET,
	MOVING_STAGE_WAIT_TARGET,
	MOVING_STAGE_TO_BASE
}

// Block think types
enum
{
	THINK_TYPE_NORMAL,
	THINK_TYPE_MOVING
}

// Hack to be able to use Ham_Player_ResetMaxSpeed (by joaquimandrade)
new Ham:Ham_Player_ResetMaxSpeed = Ham_Item_PreFrame

// CS Player PData Offsets (win32)
const PDATA_SAFE = 2
const OFFSET_CSTEAMS = 114
const OFFSET_CSMENUCODE = 205

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds

// Some constants
const UNIT_SECOND = (1<<12)
const FFADE_IN = 0x0000 // Just here so we don't pass 0 into the function

// CS Teams
enum
{
	FM_CS_TEAM_UNASSIGNED = 0,
	FM_CS_TEAM_T,
	FM_CS_TEAM_CT,
	FM_CS_TEAM_SPECTATOR
}

// Weapon Names
new const WEAPONNAMES[][] = { "", "P228 Compact", "", "Schmidt Scout", "HE-grenade", "XM1014 M4", "", "Ingram MAC-10", "Steyr AUG A1",
			"Frost Grenade", "Dual Elite Berettas", "FiveseveN", "UMP 45", "SG-550 Auto-Sniper", "IMI Galil", "Famas",
			"USP .45 ACP Tactical", "Glock 18C", "AWP Magnum Sniper", "MP5 Navy", "M249 Para Machinegun",
			"M3 Super 90", "M4A1 Carbine", "Schmidt TMP", "G3SG1 Auto-Sniper", "Flashbang", "Desert Eagle .50 AE",
			"SG-552 Commando", "AK-47 Kalashnikov", "", "ES P90" }

// Weapon entity names
new const WEAPONENTNAMES[][] = { "", "weapon_p228", "", "weapon_scout", "weapon_hegrenade", "weapon_xm1014", "weapon_c4", "weapon_mac10",
			"weapon_aug", "weapon_smokegrenade", "weapon_elite", "weapon_fiveseven", "weapon_ump45", "weapon_sg550",
			"weapon_galil", "weapon_famas", "weapon_usp", "weapon_glock18", "weapon_awp", "weapon_mp5navy", "weapon_m249",
			"weapon_m3", "weapon_m4a1", "weapon_tmp", "weapon_g3sg1", "weapon_flashbang", "weapon_deagle", "weapon_sg552",
			"weapon_ak47", "weapon_knife", "weapon_p90" }

// Weapon List
new const WEAPONLIST[] = { 0, CSW_GLOCK18, CSW_USP, CSW_P228, CSW_DEAGLE, CSW_FIVESEVEN, CSW_ELITE, CSW_M3, CSW_XM1014, CSW_TMP, CSW_MAC10,
			CSW_MP5NAVY, CSW_UMP45, CSW_P90, CSW_GALIL, CSW_FAMAS, CSW_AK47, CSW_SCOUT, CSW_M4A1, CSW_SG552, CSW_AUG, CSW_SG550, CSW_M249,
			CSW_G3SG1, CSW_AWP }

// Menu keys
const KEYSMENU = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_8|MENU_KEY_9|MENU_KEY_0

#define get_property(%1,%2) g_block_property[%1][%2]
#define set_property(%1,%2,%3) g_block_property[%1][%2] = %3
#define get_special_property(%1,%2) g_block_special_property[%1][%2]
#define set_special_property(%1,%2,%3) (g_block_special_property[%1][%2] = %3)

#define flag_get(%1,%2) (%1 & (1 << (%2 & 31)))
#define flag_set(%1,%2) %1 |= (1 << (%2 & 31))
#define flag_unset(%1,%2) %1 &= ~(1 << (%2 & 31))

#define MENU_PAGE_BLOCKS g_menu_data[id][0]
#define MENU_PAGE_SPECIAL_PROPS g_menu_data[id][1]
#define MENU_PAGE_LOAD g_menu_data[id][2]
#define MENU_PAGE_ACCESS g_menu_data[id][3]

/*================================================================================
 [Global Variables]
=================================================================================*/

// Customization vars
new g_access_flag[MAX_ACCESS_FLAGS]

new g_teleport_sprite[MAX_TELEPORT_TYPES][64]

new g_block_model[MAX_BLOCKS][MAX_BLOCK_SIZES][64]
new g_delayed_bhop_model[MAX_BLOCK_SIZES][64]

new g_block_name[MAX_BLOCKS][32]
new g_block_default_property[MAX_BLOCKS][16]
new g_block_size_name[MAX_BLOCK_SIZES][32]
new g_block_disabled[MAX_BLOCKS]

new g_sound_invincibility[64], g_sound_stealth[64], g_sound_boots_of_speed[64], g_sound_camouflage[64]

// Entity vars
new g_entity_creator[MAX_ENTITIES][32]
new g_entity_created[MAX_ENTITIES]
new g_entity_editor[MAX_ENTITIES][32]
new g_entity_edited[MAX_ENTITIES]
new g_block_property[MAX_ENTITIES][MAX_PROPS]
new Float:g_block_special_property[MAX_ENTITIES][MAX_SPECIAL_PROPS]
new g_used_block[MAX_ENTITIES]
new Float:g_block_next_use[MAX_ENTITIES][33]
new g_grouped_blocks[33][MAX_GROUPED_BLOCKS]

// Entity moving vars
new g_moving_stage[MAX_ENTITIES]
new Float:g_final_destination[MAX_ENTITIES][3]
new g_current_think_type[MAX_ENTITIES]
new g_buffered_think_type[MAX_ENTITIES]
new Float:g_buffered_nextthink[MAX_ENTITIES]

// General vars
new Array:g_builds
new g_menu_callback_enabled
new g_menu_callback_disabled

// Message IDs
new g_msgSayText, g_msgScreenFade

// Precache IDs
//new g_sprBeam

// Player vars
new g_teleport_start[33]
new g_block_type[33]
new g_block_size[33]
new g_option_snapping[33]
new g_option_snapping_gap[33]
new g_option_pushpull_speed[33]
new g_option_grid_size[33]
new Float:g_grab_length[33]
new Float:g_grab_offset[33][3]
new g_grabbed[33]
new g_no_fall_damage[33]
new g_low_gravity[33]
new Float:g_next_damage_time[33]
new Float:g_set_velocity[33][3]
new g_selected_block[33]
new g_selected_special_prop[33]
new g_menu_data[33][4]
new g_honey[33]
new g_ice[33]
new g_noslowdown[33]
new g_boots_of_speed[33]
new Float:g_boots_of_speed_end[33]
new g_camouflage[33]
new Float:g_camouflage_end[33]
new g_stealth[33]
new Float:g_stealth_end[33]
new g_magic_carpet[33]
new Float:g_magic_carpet_end[33]
new g_invincibility[33]
new Float:g_invincibility_end[33]
new g_viewmodel[33][64]
new g_camouflage_old_model[33][64]
new Float:g_last_hud_text[33]
new Float:g_last_hud_remaining_text[33]
new g_has_hud_text[33]
new g_grouped_block_count[33]
new g_grouped_block_color[33][3]
new g_auto_group_new_blocks[33]
new g_given_access[33]

// Game vars
new g_maxplayers
new g_savefile[64]
new g_mapname[32]
new g_savedir[64]
new g_HUDMsgSync
new g_buildmode
new g_current_build

// Cached player vars
new g_isconnected[33]
new g_isalive[33]
new g_playername[33][32]
#define is_user_valid_connected(%1) (1 <= %1 <= g_maxplayers && g_isconnected[%1])
#define is_user_valid_alive(%1) (1 <= %1 <= g_maxplayers && g_isalive[%1])

/*================================================================================
 [Natives, Precache and Init]
=================================================================================*/

public plugin_precache()
{
	// Register earlier to show up in plugins list properly after plugin disable/error at loading
	register_plugin("Block Maker", PLUGIN_VERSION, "FLWL")
	
	// Initialize dynamically sized arrays
	g_builds = ArrayCreate(10, 1)
	
	// Load customization data
	load_customization_from_files()
	
	new i, j, models_precached_for_block
	
	// Precache block models
	for (i = 0; i < MAX_BLOCKS; i++)
	{
		models_precached_for_block = 0
		
		for (j = 0; j < MAX_BLOCK_SIZES; j++)
		{
			if (g_block_model[i][j][0] && file_exists(g_block_model[i][j]))
			{
				precache_model(g_block_model[i][j])
				models_precached_for_block++
			}
		}
		
		if (!models_precached_for_block)
			g_block_disabled[i] = true
	}
	
	// Precache special block models
	for (j = 0; j < MAX_BLOCK_SIZES; j++)
		if (g_delayed_bhop_model[j][0] && file_exists(g_delayed_bhop_model[j]))
			precache_model(g_delayed_bhop_model[j])
	
	// Teleport sprites
	for (i = 0; i < MAX_TELEPORT_TYPES; i++)
	{
		precache_model(g_teleport_sprite[i])
	}
	
	// Precache misc stuff
	precache_sound(g_sound_invincibility)
	precache_sound(g_sound_stealth)
	precache_sound(g_sound_boots_of_speed)
	precache_sound(g_sound_camouflage)
	//g_sprBeam = precache_model("sprites/laserbeam.spr")
}

public plugin_init()
{
	// Events
	register_event("HLTV", "event_RoundStart", "a", "1=0", "2=0")
	
	// Ham Forwards
	RegisterHam(Ham_Spawn, "player", "fw_SpawnPlayer_Post", 1)
	RegisterHam(Ham_Killed, "player", "fw_KilledPlayer")
	RegisterHam(Ham_Player_ResetMaxSpeed, "player", "fw_ResetMaxSpeed_Post", 1)
	for (new i = 1; i < sizeof WEAPONENTNAMES; i++) if (WEAPONENTNAMES[i][0])
	{
		RegisterHam(Ham_Weapon_PrimaryAttack, WEAPONENTNAMES[i], "fw_WeaponPrimaryAttack")
		RegisterHam(Ham_Weapon_SecondaryAttack, WEAPONENTNAMES[i], "fw_WeaponSecondaryAttack")
	}
	
	// FM Forwards
	register_forward(FM_ClientUserInfoChanged, "fw_ClientUserInfoChanged")
	register_forward(FM_CmdStart, "fw_CmdStart")
	#if defined ADVANCED_STEALTH
		register_forward(FM_AddToFullPack, "fw_AddToFullPack_Post", true)
	#endif
	
	// Engine Forwards
	register_think(BLOCK_CLASSNAME, "think_block")
	register_think(TELEPORT_START_CLASSNAME, "think_teleport_start")
	register_think(TELEPORT_DEST_CLASSNAME, "think_teleport_dest")
	register_touch("grenade", TELEPORT_START_CLASSNAME, "touch_grenade_teleport_start")
	register_touch(BLOCK_CLASSNAME, "*", "touch_block")
	
	// Client Commands
	register_clcmd("say /bm", "clcmd_saybm")
	register_clcmd("say_team /bm", "clcmd_saybm")
	register_clcmd("+grab", "clcmd_grab")
	register_clcmd("-grab", "clcmd_release")
	register_clcmd("+bmgrab", "clcmd_grab")
	register_clcmd("-bmgrab", "clcmd_release")
	register_clcmd("bm_snapping_gap", "clcmd_bmsnappinggap")
	register_clcmd("bm_pushpull_speed", "clcmd_bmpushpullspeed")
	register_clcmd("bm_grid_size", "clcmd_bmgridsize")
	register_clcmd("bm_prop_transparency", "clcmd_bmproptransparency")
	register_clcmd("bm_prop_color", "clcmd_bmpropcolor")
	register_clcmd("bm_prop_transparency_active", "clcmd_bmproptransparencyactive")
	register_clcmd("bm_prop_moving_distance", "clcmd_bmpropmovingdistance")
	register_clcmd("bm_prop_moving_speed", "clcmd_bmpropmovingspeed")
	register_clcmd("bm_prop_moving_wait_base", "clcmd_bmpropmovingwaitbase")
	register_clcmd("bm_prop_moving_wait_target", "clcmd_bmpropmovingwaittarget")
	register_clcmd("bm_prop_moving_bounce", "clcmd_bmpropmovingbounce")
	register_clcmd("bm_prop_moving_gravity", "clcmd_bmpropmovinggravity")
	register_clcmd("bm_prop_special", "clcmd_bmpropspecial")
	register_clcmd("chooseteam", "clcmd_changeteam")
	register_clcmd("jointeam", "clcmd_changeteam")
	register_clcmd("say /respawn", "clcmd_respawn")
	register_clcmd("say_team /respawn", "clcmd_respawn")
	register_clcmd("say /revive", "clcmd_respawn")
	register_clcmd("say_team /revive", "clcmd_respawn")
	
	// Admin commands
	register_concmd("bm_buildmode", "cmd_buildmode")
	register_concmd("bm_save", "cmd_save")
	register_concmd("bm_createbuild", "cmd_createbuild")
	register_concmd("bm_respawn", "cmd_respawn")
	register_concmd("bm_revive", "cmd_respawn")
	
	// Menus
	register_menu("Block Maker Menu", KEYSMENU, "menu_bm")
	register_menu("Block Menu", KEYSMENU, "menu_bm_block")
	//register_menu("Block Size Menu", KEYSMENU, "menu_bm_block_size")
	register_menu("Block Move Menu", KEYSMENU, "menu_bm_block_move")
	register_menu("Block Properties Menu", KEYSMENU, "menu_bm_block_props")
	register_menu("Block General Props Menu", KEYSMENU, "menu_bm_props_general")
	register_menu("Block Rendering Props Menu", KEYSMENU, "menu_bm_props_rendering")
	register_menu("Block Moving Props Menu", KEYSMENU, "menu_bm_props_moving")
	register_menu("Teleport Menu", KEYSMENU, "menu_bm_teleport")
	register_menu("Grouping Tool Menu", KEYSMENU, "menu_bm_grouping_tool")
	register_menu("Block Selection Menu", KEYSMENU, "menu_bm_block_selection")
	register_menu("Options Menu", KEYSMENU, "menu_bm_options")
	register_menu("Delete All Confirmation Menu", KEYSMENU, "menu_bm_delete_all")
	
	// Message IDs
	g_msgSayText = get_user_msgid("SayText")
	g_msgScreenFade = get_user_msgid("ScreenFade")
	
	// Registered messages
	//register_message(get_user_msgid("StatusValue"), "message_status_value")
	
	// Misc
	g_maxplayers = get_maxplayers()
	g_HUDMsgSync = CreateHudSyncObj()
	g_menu_callback_enabled = menu_makecallback("menu_callback_enabled")
	g_menu_callback_disabled = menu_makecallback("menu_callback_disabled")
}

public plugin_cfg()
{
	// Build block save path
	get_datadir(g_savedir, charsmax(g_savedir))
	add(g_savedir, charsmax(g_savedir), "/blockmaker")
	
	// Make directory if not exists
	if (!dir_exists(g_savedir)) mkdir(g_savedir)
	
	// Get map name
	get_mapname(g_mapname, charsmax(g_mapname))
	strtolower(g_mapname)
	
	// Load builds and blocks
	load_builds()
	load_blocks()
}

public plugin_end()
{
	// Save blocks if building mode is enabled
	if (g_buildmode)
		save_blocks()
}

/*================================================================================
 [Main Events]
=================================================================================*/

public event_RoundStart()
{
	arrayset(g_used_block, 0, MAX_ENTITIES)
}

/*================================================================================
 [Main Forwards]
=================================================================================*/

// Client is authorised by the server
public client_authorized(id)
{
	#if defined BUILD_MODE_KICK_UNWANTED
		if (g_buildmode && !can_build(id) && !is_user_admin(id))
			redirect_user(id, false)
	#endif
}

// Client joins the game
public client_putinserver(id)
{
	g_isconnected[id] = true
	
	// Cache player's name
	get_user_name(id, g_playername[id], charsmax(g_playername[]))
	
	// Initialize player vars
	reset_vars(id, 1)
}

// Client leaving
public fw_ClientDisconnect(id)
{
	// Player left, clear cached flags
	g_isconnected[id] = false
	g_isalive[id] = false
	
	clcmd_release(id)
	clear_group(id)
	if (g_teleport_start[id]) remove_entity(g_teleport_start[id])
}

// Ham Spawn Player Forward
public fw_SpawnPlayer_Post(id)
{
	if (!is_user_alive(id))
		return;
	
	g_isalive[id] = true
	
	static userflags
	userflags = get_user_flags(id)
	
	if (g_buildmode && ((userflags & g_access_flag[ACCESS_BM]) || (userflags & g_access_flag[ACCESS_VIP])))
		set_user_godmode(id, true)
	
	if (g_camouflage[id])
	{
		deaction_camouflage(TASK_CAMOUFLAGE+id)
		remove_task(TASK_CAMOUFLAGE+id)
	}
	
	if (g_boots_of_speed[id])
	{
		deaction_boots_of_speed(TASK_BOOTS_OF_SPEED+id)
		remove_task(TASK_BOOTS_OF_SPEED+id)
	}
	
	if (g_stealth[id])
	{
		deaction_stealth(TASK_STEALTH+id)
		remove_task(TASK_STEALTH+id)
	}
	
	if (g_invincibility[id])
	{
		deaction_invincibility(TASK_INVINCIBILITY+id)
		remove_task(TASK_INVINCIBILITY+id)
	}
	
	reset_vars(id)
}

// Ham Killed Player Forward
public fw_KilledPlayer(victim, attacker)
{
	// Player killed
	g_isalive[victim] = false
	
	g_set_velocity[victim][0] = 0.0
	g_set_velocity[victim][1] = 0.0
	g_set_velocity[victim][2] = 0.0
}

// Ham Reset MaxSpeed Post Forward
public fw_ResetMaxSpeed_Post(id)
{
	// Player not alive
	if (!g_isalive[id])
		return;
	
	if (g_honey[id])
	{
		entity_set_float(id, EV_FL_maxspeed, get_special_property(g_honey[id], 0))
		return;
	}
	if (g_boots_of_speed[id])
	{
		entity_set_float(id, EV_FL_maxspeed, get_special_property(g_boots_of_speed[id], 0))
		return;
	}
}

// Weapon Primary Attack Forward
public fw_WeaponPrimaryAttack(ent)
{
	if (!is_valid_ent(ent))
		return HAM_IGNORED;
	
	if (g_grabbed[entity_get_edict(ent, EV_ENT_owner)])
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Weapon Secondary Attack Forward
public fw_WeaponSecondaryAttack(ent)
{
	if (!is_valid_ent(ent))
		return HAM_IGNORED;
	
	if (g_grabbed[entity_get_edict(ent, EV_ENT_owner)])
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Forward Client User Info Changed
public fw_ClientUserInfoChanged(id)
{
	// Cache player's name
	get_user_name(id, g_playername[id], charsmax(g_playername[]))
}

// Forward Command Start
public fw_CmdStart(id, handle)
{
	if (!g_isconnected[id])
		return;
	
	static buttons, oldbuttons
	buttons = get_uc(handle, UC_Buttons)
	oldbuttons = entity_get_int(id, EV_INT_oldbuttons)
	
	if ((buttons & IN_USE) && !(oldbuttons & IN_USE))
	{
		static ent, body
		get_user_aiming(id, ent, body)
		
		if (is_valid_ent(ent))
		{
			static classname[32]
			entity_get_string(ent, EV_SZ_classname, classname, charsmax(classname))
			
			if (is_entity_block(ent, classname))
			{
				static block_type
				block_type = entity_get_int(ent, EV_INT_body)
				
				new len
				static message[512], strtime[32]
				format_time(strtime, charsmax(strtime), "%m-%d-%Y %H:%M:%S", g_entity_created[ent])
				len += formatex(message, charsmax(message), "Type: %s %s^nCreator: %s (%s)^n", g_block_size_name[get_block_size(ent)], g_block_name[block_type], g_entity_creator[ent], strtime)
				
				if (g_entity_edited[ent])
				{
					format_time(strtime, charsmax(strtime), "%m-%d-%Y %H:%M:%S", g_entity_edited[ent])
					len += formatex(message[len], charsmax(message) - len, "Editor: %s (%s)^n", g_entity_editor[ent], strtime)
				}
				
				static sprop_value[32]
				for (new i; i < MAX_SPECIAL_PROPS; i++)
				{
					if (PROP_SPECIAL_DEFAULT_VALUE[block_type][i] != -1.0)
					{
						get_formatted_sprop_value(ent, i, sprop_value, charsmax(sprop_value))
						len += formatex(message[len], charsmax(message) - len, "^n%s: %s", PROP_SPECIAL_NAME[block_type][i], sprop_value)
					}
				}
				
				ClearSyncHud(id, g_HUDMsgSync)
				set_hudmessage(0, 150, 0, 0.01, 0.18, 0, 0.0, 2.0, 0.25, 0.25)
				ShowSyncHudMsg(id, g_HUDMsgSync, message)
			}
			else if (is_entity_teleport(ent, classname))
			{
				new len
				static message[256], strtime[32]
				format_time(strtime, charsmax(strtime), "%m-%d-%Y %H:%M:%S", g_entity_created[ent])
				len += formatex(message, charsmax(message), "Type: Teleport %s^nCreator: %s (%s)^n", (classname[12] == 's') ? "Start" : "Destination", g_entity_creator[ent], strtime)
				
				if (g_entity_edited[ent])
				{
					format_time(strtime, charsmax(strtime), "%m-%d-%Y %H:%M:%S", g_entity_edited[ent])
					len += formatex(message[len], charsmax(message) - len, "Editor: %s (%s)^n", g_entity_editor[ent], strtime)
				}
				
				ClearSyncHud(id, g_HUDMsgSync)
				set_hudmessage(0, 150, 0, 0.01, 0.18, 0, 0.0, 2.0, 0.25, 0.25)
				ShowSyncHudMsg(id, g_HUDMsgSync, message)
			}
		}
	}
	
	static grabbed
	grabbed = g_grabbed[id]
	
	if (grabbed)
	{
		if ((buttons & IN_ATTACK) && !(buttons & IN_ATTACK2))
		{
			g_grab_length[id] += float(g_option_pushpull_speed[id])
			set_uc(handle, UC_Buttons, buttons &= ~IN_ATTACK)
			entity_set_int(id, EV_INT_oldbuttons, oldbuttons &= ~IN_ATTACK)
		}
		else if ((buttons & IN_ATTACK2) && !(buttons & IN_ATTACK) && g_grab_length[id] > 72.0)
		{
			g_grab_length[id] -= float(g_option_pushpull_speed[id])
			if (g_grab_length[id] < 72.0) g_grab_length[id] = 72.0
			set_uc(handle, UC_Buttons, buttons &= ~IN_ATTACK2)
			entity_set_int(id, EV_INT_oldbuttons, oldbuttons &= ~IN_ATTACK2)
		}
		
		if (g_grouped_block_count[id] > 1 && is_block_in_group(grabbed, id))
		{
			static block, Float:move_to[3], Float:block_offset[3], Float:block_origin[3]
			move_grabbed_entity(id, move_to, false)
			
			for (new i; i < MAX_GROUPED_BLOCKS; i++)
			{
				block = g_grouped_blocks[id][i]
				
				if (block == 0 || block == grabbed || !is_valid_ent(block) || !is_entity_block(block))
					continue;
				
				entity_get_vector(block, EV_VEC_vuser2, block_offset)
				block_origin[0] = move_to[0] - block_offset[0]
				block_origin[1] = move_to[1] - block_offset[1]
				block_origin[2] = move_to[2] - block_offset[2]
				
				move_entity(block, id, block_origin, false)
			}
		}
		else
			move_grabbed_entity(id)
	}
}

#if defined ADVANCED_STEALTH
	public fw_AddToFullPack_Post(es_handle, e, ent, host, hostflags, player, pset)
	{
		if (player && g_stealth[ent] && g_isalive[host] && host != ent)
		{
			if (cs_get_user_team(host) == cs_get_user_team(ent))
			{
				set_es(es_handle, ES_RenderMode, kRenderNormal)
				set_es(es_handle, ES_RenderAmt, 255)
			}
			else
			{
				set_es(es_handle, ES_RenderMode, kRenderTransColor)
				set_es(es_handle, ES_RenderAmt, floatround(get_special_property(g_stealth[ent], 0)))
			}
		}
	}
#endif

/*================================================================================
 [Client Commands]
=================================================================================*/

// Say "/bm"
public clcmd_saybm(id)
{
	show_menu_bm(id)
}

// Grab
public clcmd_grab(id)
{
	if (!can_build(id))
		return PLUGIN_HANDLED;
	
	if (is_valid_ent(g_grabbed[id]))
		return PLUGIN_HANDLED;
	
	static ent, body
	g_grab_length[id] = get_user_aiming(id, ent, body)
	
	if (!is_valid_ent(ent) || !is_entity_block(ent) && !is_entity_teleport(ent))
		return PLUGIN_HANDLED;
	
	static grabber, grouper
	grabber = entity_get_int(ent, EV_INT_iuser2)
	grouper = entity_get_int(ent, EV_INT_iuser1)
	
	if (grabber && grabber != id || (g_isconnected[grouper] && grouper != id && !access(id, g_access_flag[ACCESS_BUILDING_MODE])))
		return PLUGIN_HANDLED;
	
	entity_get_string(id, EV_SZ_viewmodel, g_viewmodel[id], charsmax(g_viewmodel[]))
	entity_set_string(id, EV_SZ_viewmodel, "")
	
	set_entity_grabbed(ent, id)
	
	if (g_grouped_block_count[id] > 1)
	{
		static block, Float:grabbed_origin[3], Float:block_origin[3], Float:block_offset[3]
		entity_get_vector(ent, EV_VEC_origin, grabbed_origin)
		
		for (new i; i < MAX_GROUPED_BLOCKS; i++)
		{
			block = g_grouped_blocks[id][i]
			
			if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
				continue;
			
			entity_get_vector(block, EV_VEC_origin, block_origin)
			block_offset[0] = grabbed_origin[0] - block_origin[0]
			block_offset[1] = grabbed_origin[1] - block_origin[1]
			block_offset[2] = grabbed_origin[2] - block_origin[2]
			entity_set_vector(block, EV_VEC_vuser2, block_offset)
			
			entity_set_int(block, EV_INT_iuser2, id)
			update_moving_path(block)
		}
	}
	
	return PLUGIN_HANDLED;
}

// Release
public clcmd_release(id)
{
	static grabbed
	grabbed = g_grabbed[id]
	
	if (!grabbed)
		return PLUGIN_HANDLED;
	
	entity_set_string(id, EV_SZ_viewmodel, g_viewmodel[id])
	g_grabbed[id] = 0
	
	if (!is_valid_ent(grabbed))
		return PLUGIN_HANDLED;
	
	if (is_entity_block(grabbed))
	{
		if (g_grouped_block_count[id] > 1 && is_block_in_group(grabbed, id))
		{
			static block
			
			for (new i; i < MAX_GROUPED_BLOCKS; i++)
			{
				block = g_grouped_blocks[id][i]
				
				if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
					continue;
				
				release_grabbed_block(id, block)
			}
		}
		else
			release_grabbed_block(id, grabbed)
	}
	else if (is_entity_teleport(grabbed))
	{
		entity_set_int(grabbed, EV_INT_iuser2, 0)
	}
	
	g_entity_editor[grabbed] = g_playername[id]
	g_entity_edited[grabbed] = get_systime()
	return PLUGIN_HANDLED;
}

release_grabbed_block(id, grabbed)
{
	if (is_block_stuck(grabbed) && delete_block(grabbed))
		client_printc(id, "^x04[BM]^x01 Block deleted because it was stuck!")
	else
	{
		entity_set_int(grabbed, EV_INT_iuser2, 0)
		
		if (entity_get_int(grabbed, EV_INT_body) == BLOCK_MAGIC_CARPET)
			deaction_magic_carpet(grabbed)
		else
			update_moving_path(grabbed)
	}
}

// Set Snapping Gap
public clcmd_bmsnappinggap(id)
{
	static msg[8]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	g_option_snapping_gap[id] = clamp(str_to_num(msg), 0, 300)
	show_menu_bm_options(id)
	
	return PLUGIN_HANDLED;
}

// Set Push/Pull Speed
public clcmd_bmpushpullspeed(id)
{
	static msg[8]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	g_option_pushpull_speed[id] = clamp(str_to_num(msg), 1, 50)
	show_menu_bm_options(id)
	
	return PLUGIN_HANDLED;
}

// Set Grid Size
public clcmd_bmgridsize(id)
{
	static msg[8]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	g_option_grid_size[id] = clamp(str_to_num(msg), 1, 300)
	show_menu_bm_block_move(id)
	return PLUGIN_HANDLED;
}

// Set Block's Transparency Property
public clcmd_bmproptransparency(id)
{
	if (!can_build(id) || !is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
		return PLUGIN_HANDLED;
	
	static msg[8]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	update_block_property(id, g_selected_block[id], PROP_TRANSPARENCY, clamp(str_to_num(msg), 0, 255), false, true)
	show_menu_bm_props_rendering(id)
	return PLUGIN_HANDLED;
}

// Set Block's Color Property
public clcmd_bmpropcolor(id)
{
	if (!can_build(id) || !is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
		return PLUGIN_HANDLED;
	
	static msg[32]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	new red[8], green[8], blue[8]
	parse(msg, red, charsmax(red), green, charsmax(green), blue, charsmax(blue))
	
	static rgb
	rgb = (clamp(str_to_num(red), 0, 255) << 16) | (clamp(str_to_num(green), 0, 255) << 8) | clamp(str_to_num(blue), 0, 255)
	
	static block
	block = g_selected_block[id]
	
	update_block_property(id, block, PROP_COLOR, rgb, false, true)
	show_menu_bm_props_rendering(id)
	return PLUGIN_HANDLED;
}

public clcmd_bmproptransparencyactive(id)
{
	if (!can_build(id) || !is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
		return PLUGIN_HANDLED;
	
	static msg[32]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	update_block_property(id, g_selected_block[id], PROP_TRANSPARENCYACTIVE, clamp(str_to_num(msg), 0, 255), false, true)
	show_menu_bm_props_rendering(id)
	return PLUGIN_HANDLED;
}

public clcmd_bmpropmovingdistance(id)
{
	if (!can_build(id) || !is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
		return PLUGIN_HANDLED;
	
	static msg[32]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	update_block_property(id, g_selected_block[id], PROP_MOVING_DISTANCE, clamp(str_to_num(msg), 0, 1000), true)
	show_menu_bm_props_moving(id)
	return PLUGIN_HANDLED;
}

public clcmd_bmpropmovingspeed(id)
{
	if (!can_build(id) || !is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
		return PLUGIN_HANDLED;
	
	static msg[32]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	update_block_property(id, g_selected_block[id], PROP_MOVING_SPEED, clamp(str_to_num(msg), 10, 1000), true)
	show_menu_bm_props_moving(id)
	return PLUGIN_HANDLED;
}

public clcmd_bmpropmovingwaitbase(id)
{
	if (!can_build(id) || !is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
		return PLUGIN_HANDLED;
	
	static msg[32]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	update_block_property(id, g_selected_block[id], PROP_MOVING_WAIT_BASE, clamp(floatround(str_to_float(msg)*10), 0, 600), true)
	show_menu_bm_props_moving(id)
	return PLUGIN_HANDLED;
}

public clcmd_bmpropmovingwaittarget(id)
{
	if (!can_build(id) || !is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
		return PLUGIN_HANDLED;
	
	static msg[32]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	update_block_property(id, g_selected_block[id], PROP_MOVING_WAIT_TARGET, clamp(floatround(str_to_float(msg)*10), 0, 600), true)
	show_menu_bm_props_moving(id)
	return PLUGIN_HANDLED;
}

public clcmd_bmpropmovingbounce(id)
{
	if (!can_build(id) || !is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
		return PLUGIN_HANDLED;
	
	static msg[32]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	update_block_property(id, g_selected_block[id], PROP_MOVING_BOUNCE, clamp(str_to_num(msg), 0, 9999), true)
	show_menu_bm_props_moving(id)
	return PLUGIN_HANDLED;
}

public clcmd_bmpropmovinggravity(id)
{
	if (!can_build(id) || !is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
		return PLUGIN_HANDLED;
	
	static msg[32]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	update_block_property(id, g_selected_block[id], PROP_MOVING_GRAVITY, clamp(str_to_num(msg), 0, 1000), true)
	show_menu_bm_props_moving(id)
	return PLUGIN_HANDLED;
}

public clcmd_bmpropspecial(id)
{
	if (!can_build(id) || !is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
		return PLUGIN_HANDLED;
	
	static msg[32]
	read_args(msg, charsmax(msg))
	remove_quotes(msg)
	
	static block_type, selected_prop
	block_type = entity_get_int(g_selected_block[id], EV_INT_body)
	selected_prop = g_selected_special_prop[id]
	
	if (block_type == BLOCK_BLINDTRAP && selected_prop == 1)
	{
		new red[8], green[8], blue[8]
		parse(msg, red, charsmax(red), green, charsmax(green), blue, charsmax(blue))
		
		static rgb
		rgb = (clamp(str_to_num(red), 0, 255) << 16) | (clamp(str_to_num(green), 0, 255) << 8) | clamp(str_to_num(blue), 0, 255)
		
		update_block_special_property(id, g_selected_block[id], selected_prop, float(rgb))
	}
	else
	{
		update_block_special_property(id, g_selected_block[id], selected_prop, fix_float(floatclamp(str_to_float(msg), PROP_SPECIAL_MIN_VALUE[block_type][selected_prop], PROP_SPECIAL_MAX_VALUE[block_type][selected_prop]), 0.01))
	}
	
	show_menu_bm_props_special(id)
	return PLUGIN_HANDLED;
}

// BlockMaker Menu
public clcmd_changeteam(id)
{
	// Unless it's a new player joining the game
	if (fm_cs_get_user_team(id) == FM_CS_TEAM_UNASSIGNED)
		return PLUGIN_CONTINUE;
	
	// Pressing 'M' (chooseteam) ingame should show the main menu instead
	show_menu_bm(id)
	return PLUGIN_HANDLED;
}

public clcmd_respawn(id)
{
	if (g_buildmode)
		ExecuteHamB(Ham_CS_RoundRespawn, id)
}

public cmd_buildmode(id, level, cid)
{
	// Check for access flag - Enable/Disable Building Mode
	if (!cmd_access(id, g_access_flag[ACCESS_BUILDING_MODE], cid, 1))
		return PLUGIN_HANDLED;
	
	// Toggle it
	toggle_buildmode()
	log_buildmode_toggle(id)
	return PLUGIN_HANDLED;
}

public cmd_save(id, level, cid)
{
	// Check for access flag - Save All
	if (!cmd_access(id, g_access_flag[ACCESS_SAVE_ALL], cid, 1))
		return PLUGIN_HANDLED;
	
	// Save 'em
	save_blocks(id)
	return PLUGIN_HANDLED;
}

public cmd_createbuild(id, level, cid)
{
	// Check for access flag - Save All
	if (!cmd_access(id, g_access_flag[ACCESS_SAVE_ALL], cid, 1))
		return PLUGIN_HANDLED;
	
	new build[8]
	read_argv(1, build, charsmax(build))
	strtolower(build)
	replace_all(build, charsmax(build), ".", "")
	if (!strlen(build)) return PLUGIN_HANDLED;
	
	new file[64]
	formatex(file, charsmax(file), "%s/%s.%s.bm", g_savedir, g_mapname, build)
	if (file_exists(file)) return PLUGIN_HANDLED;
	
	// Create file
	new fp = fopen(file, "wt")
	if (!fp) return PLUGIN_HANDLED;
	fclose(fp)
	
	// Load builds
	load_builds(id)
	
	client_printc(0, "^1[^4BM^1]^4 %s^1 created new build:^4 %s^1.", g_playername[id], build)
	return PLUGIN_HANDLED;
}

public cmd_respawn(id, level, cid)
{
	// Check for access flag - Respawn Player
	if (!cmd_access(id, g_access_flag[ACCESS_RESPAWN_PLAYERS], cid, 1))
		return PLUGIN_HANDLED;
	
	// Can only be used during build mode
	if (!g_buildmode)
		return PLUGIN_HANDLED;
	
	// Find the target
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	
	player = cmd_target(id, arg, CMDTARGET_ALLOW_SELF)
	if (!player) return PLUGIN_HANDLED;
	
	// Respawn
	ExecuteHamB(Ham_CS_RoundRespawn, player)
	
	// Notice everyone
	static name[32]
	get_user_name(player, name, charsmax(name))
	client_printc(0, "^1[^4BM^1]^4 %s^1 respawned^4 %s^1.", g_playername[id], name)
	
	return PLUGIN_HANDLED;
}

/*================================================================================
 [Registered Messages]
=================================================================================*/

public message_status_value()
{
	static team_relation, id
	team_relation = get_msg_arg_int(1)
	id = get_msg_arg_int(2)
	
	if (team_relation == 2)
	{
		if (g_stealth[id])
		{
			set_msg_arg_int(2, ARG_SHORT, 0)
		}
		else if (g_camouflage[id])
		{
			set_msg_arg_int(1, ARG_BYTE, 1)
		}
	}
}

/*================================================================================
 [Menus]
=================================================================================*/

// Block Maker Menu
show_menu_bm(id)
{
	static menu[250], len, canbuild, menukeys
	len = 0
	canbuild = can_build(id)
	menukeys = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_9|MENU_KEY_0
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\yBlock Maker v%s [Building Mode:%s\y]^n^n", PLUGIN_VERSION, (g_buildmode ? "\w Enabled" : "\r Disabled"))
	
	// 1. Block Menu
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Block Menu^n")
	
	// 2. Teleport Menu
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Teleport Menu^n")
	
	// 3. Grouping Tool
	len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Grouping Tool^n")
	
	// 4. Access Menu
	len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Access Menu^n^n")
	
	// 6. Noclip
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Noclip:%s^n", get_user_noclip(id) ? "\y On" : "\r Off")
		menukeys |= MENU_KEY_6
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d6. Noclip: Off^n")
	}
	
	// 7. Godmode
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r7.\w Godmode:%s^n", get_user_godmode(id) ? "\y On" : "\r Off")
		menukeys |= MENU_KEY_7
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d7. Godmode: Off^n")
	}
	
	// Spacers
	len += formatex(menu[len], charsmax(menu) - len, "^n")
	
	// 9. Options
	len += formatex(menu[len], charsmax(menu) - len, "\r9.\w Options")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w Exit")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Block Maker Menu")
}

// Block Menu
show_menu_bm_block(id)
{
	static menu[250], len, canbuild, menukeys, valid_block_selected
	len = 0
	canbuild = can_build(id)
	menukeys = MENU_KEY_1|MENU_KEY_2|MENU_KEY_7|MENU_KEY_9|MENU_KEY_0
	valid_block_selected = g_block_model[g_block_type[id]][g_block_size[id]][0]
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\yBlock Menu^n^n")
	
	// 1. Type
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Type:\y %s^n", g_block_name[g_block_type[id]])
	
	// 2. Size
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Size:%s %s^n", (valid_block_selected ? "\y" : "\d"), g_block_size_name[g_block_size[id]])
	
	// 3. Create
	if (canbuild && valid_block_selected)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Create^n")
		menukeys |= MENU_KEY_3
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d3. Create^n")
	}
	
	// 4. Delete
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Delete^n")
		menukeys |= MENU_KEY_4
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d4. Delete^n")
	}
	
	// 5. Rotate
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r5.\w Rotate^n")
		menukeys |= MENU_KEY_5
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d5. Rotate^n")
	}
	
	// 6. Convert
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Convert^n")
		menukeys |= MENU_KEY_6
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d6. Convert^n")
	}
	
	// 7. Set Properties
	len += formatex(menu[len], charsmax(menu) - len, "\r7.\w Set Properties^n")
	
	// 9. Move Menu
	len += formatex(menu[len], charsmax(menu) - len, "^n\r9.\w Move menu^n")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "\r0.\w Back")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Block Menu")
}

// Block Selection Menu
show_menu_bm_block_selection(id)
{
	static menu[128], buffer[1], menuid
	formatex(menu, charsmax(menu), "Block Selection\r")
	menuid = menu_create(menu, "menu_bm_block_selection")
	
	for (new i; i < MAX_BLOCKS; i++)
	{
		formatex(menu, charsmax(menu), "%s", g_block_name[i])
		buffer[0] = i
		
		menu_additem(menuid, menu, buffer, _, g_block_disabled[i] ? g_menu_callback_disabled : g_menu_callback_enabled)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "Previous")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "Next")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "Back")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// If remembered page is greater than number of pages, clamp down the value
	MENU_PAGE_BLOCKS = min(MENU_PAGE_BLOCKS, menu_pages(menuid) - 1)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	menu_display(id, menuid, MENU_PAGE_BLOCKS)
}

/*
// Block Size Menu
show_menu_bm_block_size(id)
{
	static menu[250], len, menukeys
	len = 0
	menukeys = MENU_KEY_0
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\yBlock Size Menu\w [Current:\y %s\w]^n^n", g_block_size_name[g_block_size[id]])
	
	// Sizes
	for (new i; i < MAX_BLOCK_SIZES; i++)
	{
		if (g_block_model[g_selected_block[id]][i][0])
		{
			len += formatex(menu[len], charsmax(menu) - len, "\r%d.\w %s%s^n", i+1, g_block_size_name[i], (g_block_size[id] == i ? "\y [selected]" : ""))
			menukeys |= MENU_KEY_1 + i
		}
		else
		{
			len += formatex(menu[len], charsmax(menu) - len, "\d%d. %s%s^n", i+1, g_block_size_name[i], (g_block_size[id] == i ? "\y [selected]" : ""))
		}
	}
	
	// 0. Back
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w Back")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Block Size Menu")
}
*/

// Block Move Menu
show_menu_bm_block_move(id)
{
	static menu[250], len, canbuild, menukeys
	len = 0
	canbuild = can_build(id)
	menukeys = MENU_KEY_1|MENU_KEY_0
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\yBlock Move Menu^n^n")
	
	// 1. Grid Size
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Grid Size:\y %d^n^n", g_option_grid_size[id])
	
	// 2. X++
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w X++^n")
		menukeys |= MENU_KEY_2
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d2. X++^n")
	}
	
	// 3. X--
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w X--^n")
		menukeys |= MENU_KEY_3
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d3. X--^n")
	}
	
	// 4. Y++
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Y++^n")
		menukeys |= MENU_KEY_4
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d4. Y++^n")
	}
	
	// 5. Y--
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r5.\w Y--^n")
		menukeys |= MENU_KEY_5
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d5. Y--^n")
	}
	
	// 6. Z++
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Z++^n")
		menukeys |= MENU_KEY_6
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d6. Z++^n")
	}
	
	// 7. Z--
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r7.\w Z--^n")
		menukeys |= MENU_KEY_7
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d7. Z--^n")
	}
	
	// 0. Back
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w Back")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Block Move Menu")
}

// Block Properties Menu
show_menu_bm_block_props(id)
{
	static menu[250], len, menukeys
	len = 0
	menukeys = MENU_KEY_0|MENU_KEY_1|MENU_KEY_2|MENU_KEY_4
	
	static ent, block_type, editing_group
	ent = g_selected_block[id]
	block_type = entity_get_int(ent, EV_INT_body)
	editing_group = g_grouped_block_count[id] && is_block_in_group(ent, id)
	
	// Title
	static properties_title[32]
	if (editing_group)
		formatex(properties_title, charsmax(properties_title), "Group of %d block%s", g_grouped_block_count[id], g_grouped_block_count[id] == 1 ? "" : "s")
	else
		formatex(properties_title, charsmax(properties_title), "#%d: %s %s", ent, g_block_size_name[get_block_size(ent)], g_block_name[block_type])
	
	len += formatex(menu[len], charsmax(menu) - len, "\yBlock Properties: %s^n^n", properties_title)
	
	// 1. General
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w General^n")
	
	// 2. Rendering
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Rendering^n")
	
	// 3. Special
	if (editing_group)
	{
		if (!group_contains_only_one_type(id, block_type))
			len += formatex(menu[len], charsmax(menu) - len, "\d3. Special [Group contains blocks of different types]^n")
		else if (!PROP_SPECIAL_KEY[block_type][0][0])
			len += formatex(menu[len], charsmax(menu) - len, "\d3. Special^n")
		else
		{
			len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Special^n")
			menukeys |= MENU_KEY_3
		}
	}
	else
	{
		if (PROP_SPECIAL_KEY[block_type][0][0])
		{
			len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Special^n")
			menukeys |= MENU_KEY_3
		}
		else
		{
			len += formatex(menu[len], charsmax(menu) - len, "\d3. Special^n")
		}
	}
	
	// 4. Movement
	len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Movement^n")
	
	// 0. Back
	len += formatex(menu[len], charsmax(menu) - len, "^n^n^n^n^n\r0.\w Back")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Block Properties Menu")
}

// Block General Properties Menu
show_menu_bm_props_general(id)
{
	static menu[250], len, canbuild, menukeys
	len = 0
	canbuild = can_build(id)
	menukeys = MENU_KEY_0
	
	static ent, block_type, editing_group
	ent = g_selected_block[id]
	block_type = entity_get_int(ent, EV_INT_body)
	editing_group = g_grouped_block_count[id] && is_block_in_group(ent, id)
	
	// Title
	static properties_title[32]
	if (editing_group)
		formatex(properties_title, charsmax(properties_title), "Group of %d block%s", g_grouped_block_count[id], g_grouped_block_count[id] == 1 ? "" : "s")
	else
		formatex(properties_title, charsmax(properties_title), "#%d: %s %s", ent, g_block_size_name[get_block_size(ent)], g_block_name[block_type])
	
	len += formatex(menu[len], charsmax(menu) - len, "\yGeneral Properties: %s^n^n", properties_title)
	
	// 1. On top only
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_ONTOPONLY))
			len += formatex(menu[len], charsmax(menu) - len, "\r1.\w On top only:\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r1.\w On top only:\y %s^n", (get_property(ent, PROP_ONTOPONLY) ? "On" : "Off"))
		
		menukeys |= MENU_KEY_1
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_ONTOPONLY))
			len += formatex(menu[len], charsmax(menu) - len, "\d1. On top only: <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d1. On top only: %s^n", (get_property(ent, PROP_ONTOPONLY) ? "On" : "Off"))
	}
	
	// 2. No fall damage
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_NOFALLDAMAGE))
			len += formatex(menu[len], charsmax(menu) - len, "\r2.\w No fall damage:\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r2.\w No fall damage:\y %s^n", (get_property(ent, PROP_NOFALLDAMAGE) ? "On" : "Off"))
		
		menukeys |= MENU_KEY_2
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_NOFALLDAMAGE))
			len += formatex(menu[len], charsmax(menu) - len, "\d2. No fall damage: <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d2. No fall damage: %s^n", (get_property(ent, PROP_NOFALLDAMAGE) ? "On" : "Off"))
	}
	
	// 0. Back
	len += formatex(menu[len], charsmax(menu) - len, "^n^n^n^n^n^n^n^n\r0.\w Back")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Block General Props Menu")
}

// Block Rendering Properties Menu
show_menu_bm_props_rendering(id)
{
	static menu[250], len, canbuild, menukeys
	len = 0
	canbuild = can_build(id)
	menukeys = MENU_KEY_0
	
	static ent, block_type, editing_group
	ent = g_selected_block[id]
	block_type = entity_get_int(ent, EV_INT_body)
	editing_group = g_grouped_block_count[id] && is_block_in_group(ent, id)
	
	// Title
	static properties_title[32]
	if (editing_group)
		formatex(properties_title, charsmax(properties_title), "Group of %d block%s", g_grouped_block_count[id], g_grouped_block_count[id] == 1 ? "" : "s")
	else
		formatex(properties_title, charsmax(properties_title), "#%d: %s %s", ent, g_block_size_name[get_block_size(ent)], g_block_name[block_type])
	
	len += formatex(menu[len], charsmax(menu) - len, "\yRendering Properties: %s^n^n", properties_title)
	
	// 1. Transparency
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_TRANSPARENCY))
			len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Transparency:\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Transparency:\y %d^n", get_property(ent, PROP_TRANSPARENCY))
		
		menukeys |= MENU_KEY_1
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_TRANSPARENCY))
			len += formatex(menu[len], charsmax(menu) - len, "\d1. Transparency: <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d1. Transparency: %d^n", get_property(ent, PROP_TRANSPARENCY))
	}
	
	static rgb, red, green, blue
	rgb = get_property(ent, PROP_COLOR)
	if (rgb)
	{
		red = rgb >> 16
		green = (rgb >> 8) & ~0xFF00
		blue = rgb & ~0xFFFF00
	}
	
	// 2. Glow
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_COLOR))
			len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Glow:\y <multiple values>^n")
		else if (rgb)
			len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Glow:\y %d %d %d^n", red, green, blue)
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Glow:\y Disabled^n")
		
		menukeys |= MENU_KEY_2
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_COLOR))
			len += formatex(menu[len], charsmax(menu) - len, "\d2. Glow: <multiple values>^n")
		else if (rgb)
			len += formatex(menu[len], charsmax(menu) - len, "\d2. Glow: %d %d %d^n", red, green, blue)
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d2. Glow: Disabled^n")
	}
	
	// 3. Glow transparency
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_TRANSPARENCYGLOW))
			len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Glow Transparency:\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Glow Transparency:\y %s^n", (get_property(ent, PROP_TRANSPARENCYGLOW) ? "On" : "Off"))
		
		menukeys |= MENU_KEY_3
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_TRANSPARENCYGLOW))
			len += formatex(menu[len], charsmax(menu) - len, "\d3. Glow Transparency: <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d3. Glow transparency: %s^n", (get_property(ent, PROP_TRANSPARENCYGLOW) ? "On" : "Off"))
	}
	
	// 4. Active transparency
	if (get_property(ent, PROP_TRANSPARENCYACTIVE) == -1)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d4. Active Transparency: N/A^n")
	}
	else if (!canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d4. Active Transparency: %d^n", get_property(ent, PROP_TRANSPARENCYACTIVE))
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_TRANSPARENCYACTIVE))
			len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Active Transparency:\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Active Transparency:\y %d^n", get_property(ent, PROP_TRANSPARENCYACTIVE))
		
		menukeys |= MENU_KEY_4
	}
	
	// 0. Back
	len += formatex(menu[len], charsmax(menu) - len, "^n^n^n^n^n^n\r0.\w Back")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Block Rendering Props Menu")
}

// Block Special Properties Menu
show_menu_bm_props_special(id)
{
	static ent, block_type, editing_group, canbuild
	ent = g_selected_block[id]
	block_type = entity_get_int(ent, EV_INT_body)
	canbuild = can_build(id)
	editing_group = g_grouped_block_count[id] && is_block_in_group(ent, id)
	
	if (editing_group && !group_contains_only_one_type(id, block_type))
	{
		show_menu_bm_block_props(id)
		return;
	}
	
	static menu[128], buffer[1], menuid, properties_title[32]
	if (editing_group)
		formatex(properties_title, charsmax(properties_title), "Group of %d block%s", g_grouped_block_count[id], g_grouped_block_count[id] == 1 ? "" : "s")
	else
		formatex(properties_title, charsmax(properties_title), "#%d: %s %s", ent, g_block_size_name[get_block_size(ent)], g_block_name[block_type])
	
	formatex(menu, charsmax(menu), "Special Properties: %s\r", properties_title)
	menuid = menu_create(menu, "menu_bm_props_special")
	
	static prop_value[32], callb
	for (new i; i < MAX_SPECIAL_PROPS; i++)
	{
		if (!PROP_SPECIAL_KEY[block_type][i][0])
			break;
		
		if (are_group_svalues_identical(id, ent, i))
		{
			get_formatted_sprop_value(ent, i, prop_value, charsmax(prop_value))
		}
		else
		{
			formatex(prop_value, charsmax(prop_value), "<multiple values>")
		}
		
		if (!canbuild)
		{
			formatex(menu, charsmax(menu), "%s: %s", PROP_SPECIAL_NAME[block_type][i], prop_value)
			callb = g_menu_callback_disabled
		}
		else
		{
			formatex(menu, charsmax(menu), "%s:\y %s", PROP_SPECIAL_NAME[block_type][i], prop_value)
			callb = g_menu_callback_enabled
		}
		
		buffer[0] = i
		menu_additem(menuid, menu, buffer, _, callb)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "Previous")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "Next")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "Back")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	menu_display(id, menuid)
}

get_formatted_sprop_value(ent, i, prop_value[], len)
{
	static block_type
	block_type = entity_get_int(ent, EV_INT_body)
	
	if (block_type == BLOCK_WEAPON && i == 0)
	{
		static prop
		prop = floatround(get_special_property(ent, i))
		
		switch (prop)
		{
			case 0: formatex(prop_value, len, "%s", "Random")
			default: formatex(prop_value, len, "%s", WEAPONNAMES[WEAPONLIST[prop]])
		}
	}
	else if (block_type == BLOCK_WEAPON && i == 1)
	{
		formatex(prop_value, len, "%d", floatround(get_special_property(ent, i)))
	}
	else if (block_type == BLOCK_GRENADE && i == 0)
	{
		switch (floatround(get_special_property(ent, i)))
		{
			case 0: formatex(prop_value, len, "%s", "Random")
			case 1: formatex(prop_value, len, "%s", "HE-Grenade")
			case 2: formatex(prop_value, len, "%s", "Flashbang")
			case 3: formatex(prop_value, len, "%s", "Frost Grenade")
		}
	}
	else if (block_type == BLOCK_GRENADE && i == 1)
	{
		formatex(prop_value, len, "%d", floatround(get_special_property(ent, i)))
	}
	else if (block_type == BLOCK_BLINDTRAP && i == 1)
	{
		static rgb
		rgb = floatround(get_special_property(ent, 1))
		
		static red, green, blue
		red = rgb >> 16
		green = (rgb >> 8) & ~0xFF00
		blue = rgb & ~0xFFFF00
		
		formatex(prop_value, len, "%d %d %d", red, green, blue)
	}
	else if (block_type == BLOCK_SPEED_BOOST && i == 2)
	{
		formatex(prop_value, len, "%s", get_special_property(ent, i) ? "Backwards" : "Forwards")
	}
	else if (block_type == BLOCK_TRAMPOLINE && i == 0)
	{
		static Float:upward_speed
		upward_speed = get_special_property(ent, 0)

		if (upward_speed < 200.0)
			formatex(prop_value, len, "Invert Existing")
		else
			formatex(prop_value, len, "%.2f", upward_speed)
	}
	else
	{
		formatex(prop_value, len, "%.2f", get_special_property(ent, i))
	}
}

// Block Moving Properties Menu
show_menu_bm_props_moving(id)
{
	static menu[512], len, canbuild, menukeys
	len = 0
	canbuild = can_build(id)
	menukeys = MENU_KEY_0
	
	static ent, block_type, editing_group
	ent = g_selected_block[id]
	block_type = entity_get_int(ent, EV_INT_body)
	editing_group = g_grouped_block_count[id] && is_block_in_group(ent, id)
	
	// Title
	static properties_title[32]
	if (editing_group)
		formatex(properties_title, charsmax(properties_title), "Group of %d block%s", g_grouped_block_count[id], g_grouped_block_count[id] == 1 ? "" : "s")
	else
		formatex(properties_title, charsmax(properties_title), "#%d: %s %s", ent, g_block_size_name[get_block_size(ent)], g_block_name[block_type])
	
	len += formatex(menu[len], charsmax(menu) - len, "\yMovement Properties: %s^n^n", properties_title)
	
	// 1. Direction
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_DIRECTION))
		{
			len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Direction:\y <multiple values>^n")
		}
		else
		{
			switch (get_property(ent, PROP_MOVING_DIRECTION))
			{
				case 0: len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Direction:\y X++^n")
				case 1: len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Direction:\y X--^n")
				case 2: len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Direction:\y Y++^n")
				case 3: len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Direction:\y Y--^n")
				case 4: len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Direction:\y Up^n")
				case 5: len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Direction:\y Down^n")
			}
		}
		
		menukeys |= MENU_KEY_1
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_DIRECTION))
		{
			len += formatex(menu[len], charsmax(menu) - len, "\d1. Direction: <multiple values>^n")
		}
		else
		{
			switch (get_property(ent, PROP_MOVING_DIRECTION))
			{
				case 0: len += formatex(menu[len], charsmax(menu) - len, "\d1. Direction:\y X++^n")
				case 1: len += formatex(menu[len], charsmax(menu) - len, "\d1. Direction:\y X--^n")
				case 2: len += formatex(menu[len], charsmax(menu) - len, "\d1. Direction:\y Y++^n")
				case 3: len += formatex(menu[len], charsmax(menu) - len, "\d1. Direction:\y Y--^n")
				case 4: len += formatex(menu[len], charsmax(menu) - len, "\d1. Direction:\y Up^n")
				case 5: len += formatex(menu[len], charsmax(menu) - len, "\d1. Direction:\y Down^n")
			}
		}
	}
	
	// 2. Distance
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_DISTANCE))
			len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Distance:\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Distance:\y %d units^n", get_property(ent, PROP_MOVING_DISTANCE))
		
		menukeys |= MENU_KEY_2
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_DISTANCE))
			len += formatex(menu[len], charsmax(menu) - len, "\d2. Distance: <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d2. Distance: %d units^n", get_property(ent, PROP_MOVING_DISTANCE))
	}
	
	// 3. Speed
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_SPEED))
			len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Speed:\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Speed:\y %d units/s^n", get_property(ent, PROP_MOVING_SPEED))
		
		menukeys |= MENU_KEY_3
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_SPEED))
			len += formatex(menu[len], charsmax(menu) - len, "\d3. Speed: <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d3. Speed: %d units/s^n", get_property(ent, PROP_MOVING_SPEED))
	}
	
	// 4. Wait Time (Base Position)
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_WAIT_BASE))
			len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Wait Time (Base Position):\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Wait Time (Base Position):\y %.1f seconds^n", float(get_property(ent, PROP_MOVING_WAIT_BASE)) / 10.0)
		
		menukeys |= MENU_KEY_4
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_WAIT_BASE))
			len += formatex(menu[len], charsmax(menu) - len, "\d4. Wait Time (Base Position): <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d4. Wait Time (Base Position): %.1f seconds^n", float(get_property(ent, PROP_MOVING_WAIT_BASE)) / 10.0)
	}
	
	// 5. Wait Time (Target Position)
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_WAIT_TARGET))
			len += formatex(menu[len], charsmax(menu) - len, "\r5.\w Wait Time (Target Position):\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r5.\w Wait Time (Target Position):\y %.1f seconds^n", float(get_property(ent, PROP_MOVING_WAIT_TARGET)) / 10.0)
		
		menukeys |= MENU_KEY_5
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_WAIT_TARGET))
			len += formatex(menu[len], charsmax(menu) - len, "\d5. Wait Time (Target Position): <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d5. Wait Time (Target Position): %.1f seconds^n", float(get_property(ent, PROP_MOVING_WAIT_TARGET)) / 10.0)
	}
	
	// 6. Bounce
	static formatted_bounce_velocity[32]
	if (get_property(ent, PROP_MOVING_BOUNCE))
		formatex(formatted_bounce_velocity, charsmax(formatted_bounce_velocity), "%d velocity", get_property(ent, PROP_MOVING_BOUNCE))
	else
		formatex(formatted_bounce_velocity, charsmax(formatted_bounce_velocity), "Off")
	
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_BOUNCE))
			len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Bounce:\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Bounce:\y %s^n", formatted_bounce_velocity)
		
		menukeys |= MENU_KEY_6
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_BOUNCE))
			len += formatex(menu[len], charsmax(menu) - len, "\d6. Bounce: <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d6. Bounce: %s^n", formatted_bounce_velocity)
	}
	
	// 7. Gravity
	if (canbuild)
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_GRAVITY))
			len += formatex(menu[len], charsmax(menu) - len, "\r7.\w Gravity:\y <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\r7.\w Gravity:\y %d%%^n", get_property(ent, PROP_MOVING_GRAVITY))
		
		menukeys |= MENU_KEY_7
	}
	else
	{
		if (editing_group && !are_group_values_identical(id, ent, PROP_MOVING_GRAVITY))
			len += formatex(menu[len], charsmax(menu) - len, "\d7.\w Gravity: <multiple values>^n")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d7.\w Gravity: %d%%^n", get_property(ent, PROP_MOVING_GRAVITY))
	}
	
	// 0. Back
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0.\w Back")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Block Moving Props Menu")
}

// Teleport Menu
show_menu_bm_teleport(id)
{
	static menu[250], len, canbuild, menukeys
	len = 0
	canbuild = can_build(id)
	menukeys = MENU_KEY_0
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\yTeleport Menu^n^n")
	
	// 1. Create
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Create:\y %s^n", g_teleport_start[id] ? "Destination" : "Start")
		menukeys |= MENU_KEY_1
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d1. Create: %s^n", g_teleport_start[id] ? "Destination" : "Start")
	}
	
	// 2. Delete
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Delete^n")
		menukeys |= MENU_KEY_2
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d2. Delete^n")
	}
	
	// 3. Swap
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Swap Start/Destination^n")
		menukeys |= MENU_KEY_3
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d3. Swap Start/Destination^n")
	}
	
	// Spacers
	len += formatex(menu[len], charsmax(menu) - len, "^n^n^n^n")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0.\w Back")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Teleport Menu")
}

// Teleport Menu
show_menu_bm_grouping_tool(id)
{
	static menu[250], len, canbuild, menukeys
	len = 0
	canbuild = can_build(id)
	menukeys = MENU_KEY_0|MENU_KEY_4
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\yGrouping Tool Menu^n^n")
	
	// 1. Add Block
	if (canbuild)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Add/Remove Block^n")
		menukeys |= MENU_KEY_1
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d1. Add/Remove Block^n")
	}
	
	// 2. Clear Group
	if (canbuild && g_grouped_block_count[id])
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Clear Group\y [%d block%s]^n^n", g_grouped_block_count[id], (g_grouped_block_count[id] == 1 ? "" : "s"))
		menukeys |= MENU_KEY_2
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d2. Clear Group [%d block%s]^n^n", g_grouped_block_count[id], (g_grouped_block_count[id] == 1 ? "" : "s"))
	}
	
	// 4. Auto-Group New Blocks
	len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Auto-Group New Blocks: %s^n", g_auto_group_new_blocks[id] ? "\yOn" : "\rOff")
	
	// Spacers
	len += formatex(menu[len], charsmax(menu) - len, "^n^n")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0.\w Back")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Grouping Tool Menu")
}

// Options Menu
show_menu_bm_options(id)
{
	static menu[250], len, userflags, menukeys
	len = 0
	userflags = get_user_flags(id)
	menukeys = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_0
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\yOptions Menu^n^n")
	
	// 1. Snapping
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Snapping:%s^n", g_option_snapping[id] ? "\y On" : "\r Off")
	
	// 2. Snapping gap
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Snapping gap:\y %d^n", g_option_snapping_gap[id])
	
	// 3. Push/Pull speed
	len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Push/Pull speed:\y %d^n", g_option_pushpull_speed[id])
	
	// 4. Toggle Building mode
	if (userflags & g_access_flag[ACCESS_BUILDING_MODE])
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Toggle Building Mode\y [Currently:%s\y]^n", (g_buildmode ? "\w Enabled" : "\r Disabled"))
		menukeys |= MENU_KEY_4
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d4. Toggle Building Mode^n")
	}
	
	// 5. Spacer
	len += formatex(menu[len], charsmax(menu) - len, "^n")
	
	// 6. Load blocks
	static build[10]
	ArrayGetString(g_builds, g_current_build, build, charsmax(build))
	
	if (userflags & g_access_flag[ACCESS_SAVE_ALL])
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Load\y [Currently:\d %s\w%s%s\y]^n", g_mapname, (build[0] ? "." : ""), build)
		menukeys |= MENU_KEY_6
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d6. Load [Currently: %s%s%s]^n", g_mapname, (build[0] ? "." : ""), build)
	}
	
	// 7. Save all blocks
	if (userflags & g_access_flag[ACCESS_SAVE_ALL])
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r7.\w Save map^n")
		menukeys |= MENU_KEY_7
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d7. Save map^n")
	}
	
	// Spacers
	len += formatex(menu[len], charsmax(menu) - len, "^n")
	
	// 9. Delete all blocks
	if (userflags & g_access_flag[ACCESS_DELETE_ALL])
	{
		len += formatex(menu[len], charsmax(menu) - len, "\r9.\w Delete all^n")
		menukeys |= MENU_KEY_9
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\d9. Delete all^n")
	}
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "\r0.\w Back")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Options Menu")
}

show_menu_bm_access(id)
{
	static menu[128], buffer[1], menuid, userflags, userflags2
	formatex(menu, charsmax(menu), "Access Menu\r")
	menuid = menu_create(menu, "menu_bm_access")
	userflags = get_user_flags(id)
	
	for (new i; i < g_maxplayers; i++)
	{
		if (!g_isconnected[i])
			continue;
		
		userflags2 = get_user_flags(i)
		
		if (userflags2 & g_access_flag[ACCESS_BM])
			formatex(menu, charsmax(menu), "\d%s [Yes]", g_playername[i])
		else if (userflags & g_access_flag[ACCESS_GIVE_ACCESS] && i != id)
			formatex(menu, charsmax(menu), "\w%s%s", g_playername[i], g_given_access[i] ? "\y [Temporary]" : "\d [No]")
		else
			formatex(menu, charsmax(menu), "\d%s%s", g_playername[i], g_given_access[i] ? " [Temporary]" : " [No]")
		
		buffer[0] = i
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "Previous")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "Next")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "Back")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// If remembered page is greater than number of pages, clamp down the value
	MENU_PAGE_ACCESS = min(MENU_PAGE_ACCESS, menu_pages(menuid) - 1)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	menu_display(id, menuid, MENU_PAGE_ACCESS)
}

show_menu_bm_delete_all(id)
{
	static menu[250], len, menukeys
	len = 0
	menukeys = MENU_KEY_1|MENU_KEY_2
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\yAre you sure you want to delete all blocks and teleports?^n^n")
	
	// 1. Yes
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Yes^n")
	
	// 2. No
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w No")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	show_menu(id, menukeys, menu, -1, "Delete All Confirmation Menu")
}

show_menu_bm_load(id)
{
	static menu[128], build[10], buffer[1], menuid
	formatex(menu, charsmax(menu), "Load\r")
	menuid = menu_create(menu, "menu_bm_load")
	
	for (new i; i < ArraySize(g_builds); i++)
	{
		ArrayGetString(g_builds, i, build, charsmax(build))
		
		formatex(menu, charsmax(menu), "\d%s\w%s%s", g_mapname, (build[0] ? "." : ""), build)
		buffer[0] = i
		
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "Previous")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "Next")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "Back")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// If remembered page is greater than number of pages, clamp down the value
	MENU_PAGE_LOAD = min(MENU_PAGE_LOAD, menu_pages(menuid) - 1)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	menu_display(id, menuid, MENU_PAGE_LOAD)
}

public menu_bm_load(id, menuid, item)
{
	// Player disconnected?
	if (!g_isconnected[id])
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Remember player's menu page
	static menudummy
	player_menu_info(id, menudummy, menudummy, MENU_PAGE_LOAD)
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_bm_options(id)
		return PLUGIN_HANDLED;
	}
	
	static buffer[1], dummy
	menu_item_getinfo(menuid, item, dummy, buffer, sizeof(buffer), _, _, dummy)
	
	// Save
	if (g_buildmode && buffer[0] != g_current_build)
		save_blocks(id)
	
	// Set new build
	set_current_build(buffer[0])
	
	// Load blocks
	load_blocks(id)
	
	menu_destroy(menuid)
	show_menu_bm_load(id)
	return PLUGIN_CONTINUE;
}
/*================================================================================
 [Menu Handlers]
=================================================================================*/

// Block Maker Menu
public menu_bm(id, key)
{
	switch (key)
	{
		case 0: // 1. Block Menu
		{
			show_menu_bm_block(id)
			return;
		}
		case 1: // 2. Teleport Menu
		{
			show_menu_bm_teleport(id)
			return;
		}
		case 2: // 3. Grouping Tool Menu
		{
			show_menu_bm_grouping_tool(id)
			return;
		}
		case 3: // 4. Access Menu
		{
			show_menu_bm_access(id)
			return;
		}
		case 5: // 6. Noclip
		{
			if (get_user_noclip(id))
				set_user_noclip(id, 0)
			else
				set_user_noclip(id, 1)
		}
		case 6: // 7. Godmode
		{
			if (get_user_godmode(id))
				set_user_godmode(id, 0)
			else
				set_user_godmode(id, 1)
		}
		case 8: // 9. Options
		{
			show_menu_bm_options(id)
			return;
		}
		case 9: return;
	}
	
	show_menu_bm(id)
}

// Block Menu
public menu_bm_block(id, key)
{
	switch (key)
	{
		case 0: // 1. Type
		{
			show_menu_bm_block_selection(id)
			return;
		}
		case 1: // 2. Size
		{
			if (g_block_size[id] < (MAX_BLOCK_SIZES - 1))
				g_block_size[id]++
			else
				g_block_size[id] = 0
		}
		case 2: // 3. Create
		{
			create_block_by_aim(id, g_block_type[id], g_block_size[id])
		}
		case 3: // 4. Delete
		{
			delete_block_by_aim(id)
		}
		case 4: // 5. Rotate
		{
			rotate_block_by_aim(id)
		}
		case 5: // 6. Convert
		{
			convert_block_by_aim(id, g_block_type[id], g_block_size[id])
		}
		case 6: // 7. Set Properties
		{
			static ent, body, selected
			get_user_aiming(id, ent, body)
			selected = g_selected_block[id]
			
			if (is_valid_ent(ent) && is_entity_block(ent))
			{
				g_selected_block[id] = ent
				show_menu_bm_block_props(id)
				return;
			}
			else if (selected && is_valid_ent(selected) && is_entity_block(selected))
			{
				show_menu_bm_block_props(id)
				return;
			}
			else
			{
				g_selected_block[id] = 0
			}
		}
		case 8: // 9. Move menu
		{
			show_menu_bm_block_move(id)
			return;
		}
		case 9:
		{
			show_menu_bm(id)
			return;
		}
	}
	
	show_menu_bm_block(id)
}

// Block Selection Menu
public menu_bm_block_selection(id, menuid, item)
{
	// Player disconnected?
	if (!g_isconnected[id])
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Remember player's menu page
	static menudummy
	player_menu_info(id, menudummy, menudummy, MENU_PAGE_BLOCKS)
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		
		show_menu_bm_block(id)
		
		return PLUGIN_HANDLED;
	}
	
	static buffer[1], dummy
	menu_item_getinfo(menuid, item, dummy, buffer, sizeof(buffer), _, _, dummy)
	
	g_block_type[id] = buffer[0]
	
	menu_destroy(menuid)
	show_menu_bm_block(id)
	return PLUGIN_CONTINUE;
}

/*
public menu_bm_block_size(id, key)
{
	if (key == 9) // Back?
	{
		show_menu_bm_block(id)
		return;
	}
	
	for (new i; i < MAX_BLOCK_SIZES; i++)
	{
		if (key == i)
		{
			g_block_size[id] = i;
			show_menu_bm_block(id)
			return;
		}
	}
}
*/

public menu_bm_block_move(id, key)
{
	switch (key)
	{
		case 0: // 1. Grid Size
		{
			client_cmd(id, "messagemode bm_grid_size")
			return;
		}
		case 9:
		{
			show_menu_bm_block(id)
			return;
		}
		default:
		{
			static ent, body
			get_user_aiming(id, ent, body)
			
			if (is_valid_ent(ent) && is_entity_block(ent))
			{
				if (g_grouped_block_count[id] && is_block_in_group(ent, id))
				{
					static block
					for (new i; i < MAX_GROUPED_BLOCKS; i++)
					{
						block = g_grouped_blocks[id][i]
						
						if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
							continue;
						
						nudge_block(id, block, key, float(g_option_grid_size[id]))
					}
				}
				else
					nudge_block(id, ent, key, float(g_option_grid_size[id]))
			}
		}
	}
	
	show_menu_bm_block_move(id)
}

public menu_bm_block_props(id, key)
{
	if (!is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
	{
		g_selected_block[id] = 0
		show_menu_bm_block(id)
		return;
	}
	
	switch (key)
	{
		case 0: // General
		{
			show_menu_bm_props_general(id)
			return;
		}
		case 1: // Rendering
		{
			show_menu_bm_props_rendering(id)
			return;
		}
		case 2: // Special
		{
			show_menu_bm_props_special(id)
			return;
		}
		case 3: // Movement
		{
			show_menu_bm_props_moving(id)
			return;
		}
		case 9:
		{
			show_menu_bm_block(id)
			return;
		}
	}
	
	show_menu_bm_block_props(id)
}

public menu_bm_props_general(id, key)
{
	if (!is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
	{
		g_selected_block[id] = 0
		show_menu_bm_block(id)
		return;
	}
	
	switch (key)
	{
		case 0:
		{
			update_block_property(id, g_selected_block[id], PROP_ONTOPONLY, !get_property(g_selected_block[id], PROP_ONTOPONLY))
		}
		case 1:
		{
			update_block_property(id, g_selected_block[id], PROP_NOFALLDAMAGE, !get_property(g_selected_block[id], PROP_NOFALLDAMAGE))
		}
		case 9:
		{
			show_menu_bm_block_props(id)
			return;
		}
	}
	
	show_menu_bm_props_general(id)
}

public menu_bm_props_rendering(id, key)
{
	if (!is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
	{
		g_selected_block[id] = 0
		show_menu_bm_block(id)
		return;
	}
	
	switch (key)
	{
		case 0:
		{
			client_cmd(id, "messagemode bm_prop_transparency")
			return;
		}
		case 1:
		{
			client_cmd(id, "messagemode bm_prop_color")
			return;
		}
		case 2:
		{
			update_block_property(id, g_selected_block[id], PROP_TRANSPARENCYGLOW, !get_property(g_selected_block[id], PROP_TRANSPARENCYGLOW), false, true)
		}
		case 3:
		{
			client_cmd(id, "messagemode bm_prop_transparency_active")
			return;
		}
		case 9:
		{
			show_menu_bm_block_props(id)
			return;
		}
	}
	
	show_menu_bm_props_rendering(id)
}

public menu_bm_props_moving(id, key)
{
	if (!is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
	{
		g_selected_block[id] = 0
		show_menu_bm_block(id)
		return;
	}
	
	switch (key)
	{
		case 0: // 1. Direction
		{
			static direction
			direction = get_property(g_selected_block[id], PROP_MOVING_DIRECTION)
			
			if (direction >= 5)
				direction = 0
			else
				direction++
			
			update_block_property(id, g_selected_block[id], PROP_MOVING_DIRECTION, direction, true)
		}
		case 1: // 2. Distance
		{
			client_cmd(id, "messagemode bm_prop_moving_distance")
			return;
		}
		case 2: // 3. Speed
		{
			client_cmd(id, "messagemode bm_prop_moving_speed")
			return;
		}
		case 3: // 4. Wait Time (Base Position)
		{
			client_cmd(id, "messagemode bm_prop_moving_wait_base")
			return;
		}
		case 4: // 5. Wait Time (Target Position)
		{
			client_cmd(id, "messagemode bm_prop_moving_wait_target")
			return;
		}
		case 5: // 6. Bounce
		{
			client_cmd(id, "messagemode bm_prop_moving_bounce")
			return;
		}
		case 6: // 7. Gravity
		{
			client_cmd(id, "messagemode bm_prop_moving_gravity")
			return;
		}
		case 9: // 0. Back
		{
			show_menu_bm_block_props(id)
			return;
		}
	}
	
	show_menu_bm_props_moving(id)
}

public menu_bm_props_special(id, menuid, item)
{
	// Player disconnected?
	if (!g_isconnected[id])
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	if (!is_valid_ent(g_selected_block[id]) || !is_entity_block(g_selected_block[id]))
	{
		g_selected_block[id] = 0
		show_menu_bm_block(id)
		return PLUGIN_HANDLED;
	}
	
	// Remember player's menu page
	static menudummy
	player_menu_info(id, menudummy, menudummy, MENU_PAGE_SPECIAL_PROPS)
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		
		show_menu_bm_block_props(id)
		return PLUGIN_HANDLED;
	}
	
	static buffer[1], dummy
	menu_item_getinfo(menuid, item, dummy, buffer, sizeof(buffer), _, _, dummy)
	
	static ent, block_type, prop, editing_group
	ent = g_selected_block[id]
	block_type = entity_get_int(ent, EV_INT_body)
	prop = buffer[0]
	editing_group = g_grouped_block_count[id] && is_block_in_group(ent, id)
	
	if (editing_group && !group_contains_only_one_type(id, block_type))
	{
		menu_destroy(menuid)
		show_menu_bm_block_props(id)
		return PLUGIN_HANDLED;
	}
	
	if (block_type == BLOCK_WEAPON && prop == 0)
	{
		static wpn
		wpn = floatround(get_special_property(ent, prop))
		
		if (wpn >= sizeof(WEAPONLIST)-1)
			wpn = 0
		else
			wpn++
		
		update_block_special_property(id, ent, prop, float(wpn), true)
		show_menu_bm_props_special(id)
	}
	else if (block_type == BLOCK_GRENADE && prop == 0)
	{
		static wpn
		wpn = floatround(get_special_property(ent, prop))
		
		if (wpn >= 3)
			wpn = 0
		else
			wpn++
		
		update_block_special_property(id, ent, prop, float(wpn), true)
		show_menu_bm_props_special(id)
	}
	else if (block_type == BLOCK_SPEED_BOOST && prop == 2)
	{
		static direction
		direction = floatround(get_special_property(ent, prop))
		direction = !direction
		
		update_block_special_property(id, ent, prop, float(direction))
		show_menu_bm_props_special(id)
	}
	else
	{
		g_selected_special_prop[id] = prop
		client_cmd(id, "messagemode bm_prop_special")
	}
	
	menu_destroy(menuid)
	return PLUGIN_CONTINUE;
}

// Teleport Menu
public menu_bm_teleport(id, key)
{
	switch (key)
	{
		case 0: // 1. Create
		{
			create_teleport_by_aim(id)
		}
		case 1: // 2. Delete
		{
			delete_teleport_by_aim(id)
		}
		case 2: // 3. Swap Start/Destination
		{
			swap_teleport_by_aim(id)
		}
		case 9:
		{
			show_menu_bm(id)
			return;
		}
	}
	
	show_menu_bm_teleport(id)
}

// Grouping Tool Menu
public menu_bm_grouping_tool(id, key)
{
	switch (key)
	{
		case 0: // 1. Add/Remove Block
		{
			toggle_group_by_aim(id)
		}
		case 1: // 2. Clear Group
		{
			clear_group(id)
		}
		case 3: // 4. Auto-Group New Blocks
		{
			g_auto_group_new_blocks[id] = !g_auto_group_new_blocks[id]
		}
		case 9:
		{
			show_menu_bm(id)
			return;
		}
	}
	
	show_menu_bm_grouping_tool(id)
}

// Options Menu
public menu_bm_options(id, key)
{
	switch (key)
	{
		case 0: // 1. Snapping
		{
			g_option_snapping[id] = !g_option_snapping[id]
		}
		case 1: // 2. Snapping gap
		{
			client_cmd(id, "messagemode bm_snapping_gap")
			return;
		}
		case 2: // 3. Push/Pull speed
		{
			client_cmd(id, "messagemode bm_pushpull_speed")
			return;
		}
		case 3: // 4. Toggle Building Mode
		{
			toggle_buildmode()
			log_buildmode_toggle(id)
		}
		case 5: // 6. Load
		{
			show_menu_bm_load(id)
			return;
		}
		case 6: // 7. Save
		{
			save_blocks(id)
		}
		case 8: // 9. Delete all
		{
			show_menu_bm_delete_all(id)
			return;
		}
		case 9:
		{
			show_menu_bm(id)
			return;
		}
	}
	
	show_menu_bm_options(id)
}

public menu_bm_delete_all(id, key)
{
	switch (key)
	{
		case 0:
		{
			delete_all(id, true)
		}
	}
	
	show_menu_bm_options(id)
}

public menu_bm_access(id, menuid, item)
{
	// Player disconnected?
	if (!is_user_connected(id))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_bm(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve target client
	static buffer[2], dummy, i
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	i = buffer[0]
	
	if (access(id, g_access_flag[ACCESS_GIVE_ACCESS]) && !access(i, g_access_flag[ACCESS_BM]) && i != id)
	{
		g_given_access[i] = !g_given_access[i]
		
		if (g_given_access[i])
			client_printc(0, "^x04[BM]^x01 ADMIN^x04 %s^x01: Give temporary BlockMaker access to^4 %s^1.", g_playername[id], g_playername[i])
		else
			client_printc(0, "^x04[BM]^x01 ADMIN^x04 %s^x01: Remove temporary BlockMaker access from^4 %s^1.", g_playername[id], g_playername[i])
	}
	
	// Destroy the menu
	menu_destroy(menuid)
	show_menu_bm(id)
	return PLUGIN_HANDLED;
}

public menu_callback_enabled() return ITEM_ENABLED;
public menu_callback_disabled() return ITEM_DISABLED;

/*================================================================================
 [Main Functions]
=================================================================================*/

public pfn_touch(ent, id)
{
	if (!is_user_valid_alive(id))
		return PLUGIN_CONTINUE;
	
	if (!is_valid_ent(ent))
		return PLUGIN_CONTINUE;
	
	static classname[32]
	entity_get_string(ent, EV_SZ_classname, classname, charsmax(classname))
	
	if (is_entity_block(ent, classname))
	{
		// Entity is being grabbed
		if (entity_get_int(ent, EV_INT_iuser2))
			return PLUGIN_CONTINUE;
		
		// Entity is not supposed to be touchable (SOLID_TRIGGER is for bouncing bhop blocks for example)
		if (entity_get_int(ent, EV_INT_solid) == SOLID_TRIGGER)
			return PLUGIN_CONTINUE;
		
		static property, stuck, onground, groundent
		property = get_property(ent, PROP_ONTOPONLY) ? true : false
		stuck = is_stuck(id)
		onground = (entity_get_int(id, EV_INT_flags) & FL_ONGROUND)
		groundent = entity_get_edict(id, EV_ENT_groundentity)
		
		if (!property || property && (((onground && groundent == ent) || stuck)))
		{
			static block_type
			block_type = entity_get_int(ent, EV_INT_body)
			
			g_no_fall_damage[id] = get_property(ent, PROP_NOFALLDAMAGE) ? true : false
			
			switch (block_type)
			{
				case BLOCK_BHOP: action_bhop(ent)
				case BLOCK_DEATH: action_death(id)
				case BLOCK_BHOP_NOSLOWDOWN: action_bhop_noslowdown(id, ent)
				case BLOCK_HEAL: action_heal(id, ent)
				case BLOCK_ICE: action_ice(id, ent)
				case BLOCK_SPEED_BOOST: action_speed_boost(id, ent)
				case BLOCK_TRAMPOLINE: action_trampoline(id, ent)
				case BLOCK_LOW_GRAVITY: action_low_gravity(id, ent)
				case BLOCK_HONEY: action_honey(id, ent)
				case BLOCK_CT_BARRIER: action_barrier(id, ent, stuck ? -1 : FM_CS_TEAM_CT)
				case BLOCK_T_BARRIER: action_barrier(id, ent, stuck ? -1 : FM_CS_TEAM_T)
				case BLOCK_VIP_ONLY: action_vip_only(id, ent)
				case BLOCK_DAMAGE: action_damage(id, ent)
				case BLOCK_GRENADE: action_grenade(id, ent)
				case BLOCK_WEAPON: action_weapon(id, ent)
				case BLOCK_CAMOUFLAGE: action_camouflage(id, ent)
				case BLOCK_BLINDTRAP: action_blindtrap(id, ent)
				case BLOCK_BOOTS_OF_SPEED: action_boots_of_speed(id, ent)
				case BLOCK_STEALTH: action_stealth(id, ent)
				case BLOCK_MAGIC_CARPET: action_magic_carpet(id, ent)
				case BLOCK_INVINCIBILITY: action_invincibility(id, ent)
			}
		}
	}
	else
	{
		if (classname[0] == TELEPORT_START_CLASSNAME[0] && classname[1] == TELEPORT_START_CLASSNAME[1] && classname[2] == TELEPORT_START_CLASSNAME[2] && classname[3] == TELEPORT_START_CLASSNAME[3])
		{
			if (classname[13] == TELEPORT_START_CLASSNAME[13])
			{
				action_teleport(id, ent)
			}
		}
	}
	
	return PLUGIN_CONTINUE;
}

public server_frame()
{
	static id
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (!g_isalive[id])
			continue;
		
		if (g_ice[id] || g_noslowdown[id])
		{
			entity_set_float(id, EV_FL_fuser2, 0.0)
		}
		
		// Stop the carpet if the user is no longer standing on it
		if (g_magic_carpet[id] && (!(entity_get_int(id, EV_INT_flags) & FL_ONGROUND) || entity_get_edict(id, EV_ENT_groundentity) != g_magic_carpet[id]))
		{
			static ent
			ent = g_magic_carpet[id]
			
			if (is_valid_ent(ent) && is_entity_block(ent))
			{
				entity_set_vector(ent, EV_VEC_velocity, Float:{0.0, 0.0, 0.0})
				entity_set_int(ent, EV_INT_weapons, 0) // Free up the magic carpet for others to use
			}
			
			g_magic_carpet[id] = 0
		}
		
		if (g_set_velocity[id][0] != 0.0 || g_set_velocity[id][1] != 0.0 || g_set_velocity[id][2] != 0.0)
		{
			entity_set_vector(id, EV_VEC_velocity, g_set_velocity[id])
			
			g_set_velocity[id][0] = 0.0
			g_set_velocity[id][1] = 0.0
			g_set_velocity[id][2] = 0.0
		}
	}
}

public client_PreThink(id)
{
	if (!g_isalive[id])
		return;
	
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime - g_last_hud_remaining_text[id] > 0.0)
	{
		if (g_boots_of_speed[id] || g_camouflage[id] || g_stealth[id] || g_magic_carpet[id] || g_invincibility[id])
		{
			static message[256], len
			len = formatex(message, charsmax(message), "Remaining:")
			
			if (g_boots_of_speed[id] && g_boots_of_speed_end[id] - gametime >= 0.0)
				len += formatex(message[len], charsmax(message) - len, "^nBoots of Speed: %.1fs", g_boots_of_speed_end[id] - gametime)
			
			if (g_camouflage[id] && g_camouflage_end[id] - gametime >= 0.0)
				len += formatex(message[len], charsmax(message) - len, "^nCamouflage: %.1fs", g_camouflage_end[id] - gametime)
			
			if (g_stealth[id] && g_stealth_end[id] - gametime >= 0.0)
				len += formatex(message[len], charsmax(message) - len, "^nStealth: %.1fs", g_stealth_end[id] - gametime)
			
			if (g_magic_carpet[id] && g_magic_carpet_end[id] - gametime >= 0.0)
				len += formatex(message[len], charsmax(message) - len, "^nMagic Carpet: %.1fs", g_magic_carpet_end[id] - gametime)
			//else
			//	g_magic_carpet[id] = 0 // If the magic carpet happens to be grabbed at the reset time, this variable will not be reset, do it here instead
			
			if (g_invincibility[id] && g_invincibility_end[id] - gametime >= 0.0)
				len += formatex(message[len], charsmax(message) - len, "^nInvincibility: %.1fs", g_invincibility_end[id] - gametime)
			
			set_hudmessage(128, 255, 0, -1.0, 0.7, 0, 0.1, 0.1, 0.1, 0.1)
			show_hudmessage(id, message)
			
			g_has_hud_text[id] = true
			g_last_hud_text[id] = gametime
		}
		else
		{
			g_has_hud_text[id] = false
		}
	}
}

public think_block(ent)
{
	if (!is_valid_ent(ent))
		return;
	
	static block_type, Float:gametime
	block_type = entity_get_int(ent, EV_INT_body)
	gametime = get_gametime()
	
	switch (g_current_think_type[ent])
	{
		case THINK_TYPE_NORMAL:
		{
			switch (block_type)
			{
				case BLOCK_MAGIC_CARPET:
				{
					deaction_magic_carpet(ent)
				}
				case BLOCK_BHOP, BLOCK_BHOP_NOSLOWDOWN:
				{
					if (entity_get_int(ent, EV_INT_solid) == SOLID_BBOX)
					{
						entity_set_int(ent, EV_INT_solid, SOLID_TRIGGER)
						reset_block_rendering(ent)
						
						set_block_nextthink(ent, THINK_TYPE_NORMAL, gametime + get_special_property(ent, 1))
					}
					else
					{
						entity_set_int(ent, EV_INT_solid, SOLID_BBOX)
						reset_block_rendering(ent)
						process_buffered_nextthink(ent)
					}
				}
				case BLOCK_CT_BARRIER, BLOCK_T_BARRIER, BLOCK_VIP_ONLY:
				{
					if (entity_get_int(ent, EV_INT_solid) == SOLID_BBOX)
					{
						entity_set_int(ent, EV_INT_solid, SOLID_TRIGGER)
						reset_block_rendering(ent)
						
						set_block_nextthink(ent, THINK_TYPE_NORMAL, gametime + get_special_property(ent, 1))
					}
					else
					{
						entity_set_int(ent, EV_INT_solid, SOLID_BBOX)
						reset_block_rendering(ent)
						process_buffered_nextthink(ent)
					}
				}
			}
		}
		case THINK_TYPE_MOVING:
		{
			if (is_moving_block(ent))
			{
				static Float:originF[3], Float:baseF[3], Float:targetF[3]
				entity_get_vector(ent, EV_VEC_origin, originF)
				entity_get_vector(ent, EV_VEC_vuser3, baseF)
				entity_get_vector(ent, EV_VEC_vuser4, targetF)
				
				switch (g_moving_stage[ent])
				{
					case MOVING_STAGE_WAIT_BASE:
					{
						entity_set_vector(ent, EV_VEC_velocity, Float:{0.0, 0.0, 0.0})
						g_moving_stage[ent] = MOVING_STAGE_TO_TARGET
						set_block_nextthink(ent, THINK_TYPE_MOVING, gametime + (float(get_property(ent, PROP_MOVING_WAIT_BASE)) / 10.0))
					}
					case MOVING_STAGE_TO_TARGET:
					{
						LinearMove(ent, targetF, float(get_property(ent, PROP_MOVING_SPEED)))
						g_moving_stage[ent] = get_property(ent, PROP_MOVING_WAIT_TARGET) ? MOVING_STAGE_WAIT_TARGET : MOVING_STAGE_TO_BASE
						process_buffered_nextthink(ent)
					}
					case MOVING_STAGE_WAIT_TARGET:
					{
						entity_set_vector(ent, EV_VEC_velocity, Float:{0.0, 0.0, 0.0})
						g_moving_stage[ent] = MOVING_STAGE_TO_BASE
						set_block_nextthink(ent, THINK_TYPE_MOVING, gametime + (float(get_property(ent, PROP_MOVING_WAIT_TARGET)) / 10.0))
					}
					case MOVING_STAGE_TO_BASE:
					{
						LinearMove(ent, baseF, float(get_property(ent, PROP_MOVING_SPEED)))
						g_moving_stage[ent] = get_property(ent, PROP_MOVING_WAIT_BASE) ? MOVING_STAGE_WAIT_BASE : MOVING_STAGE_TO_TARGET
						process_buffered_nextthink(ent)
					}
				}
			}
		}
	}
}

process_buffered_nextthink(ent)
{
	if (g_buffered_nextthink[ent] >= get_gametime() && entity_get_float(ent, EV_FL_nextthink) <= get_gametime())
	{
		g_current_think_type[ent] = g_buffered_think_type[ent]
		entity_set_float(ent, EV_FL_nextthink, g_buffered_nextthink[ent])
		
		g_buffered_nextthink[ent] = 0.0
	}
}

public think_teleport_start(ent)
{
	static Float:frame
	frame = entity_get_float(ent, EV_FL_frame) + 1.0
	
	if (frame > TELEPORT_START_FRAMES)
		entity_set_float(ent, EV_FL_frame, 0.0)
	else
		entity_set_float(ent, EV_FL_frame, frame)
	
	entity_set_float(ent, EV_FL_nextthink, get_gametime() + 0.1)
}

public think_teleport_dest(ent)
{
	static Float:frame
	frame = entity_get_float(ent, EV_FL_frame) + 1.0
	
	if (frame > TELEPORT_END_FRAMES)
		entity_set_float(ent, EV_FL_frame, 0.0)
	else
		entity_set_float(ent, EV_FL_frame, frame)
	
	if (g_buildmode)
	{
		static Float:originF[3]
		entity_get_vector(ent, EV_VEC_origin, originF)
		
		new ent_near
		static entinsphere
		entinsphere = -1
		
		while ((entinsphere = find_ent_in_sphere(entinsphere, originF, 64.0)))
		{
			static classname[32];
			entity_get_string(entinsphere, EV_SZ_classname, classname, charsmax(classname));
			
			if (is_user_valid_alive(entinsphere) || equal(classname, "grenade"))
			{
				ent_near = true;
				break;
			}
		}
		
		if (ent_near && !entity_get_int(ent, EV_INT_iuser2))
			entity_set_int(ent, EV_INT_solid, SOLID_NOT)
		else
			entity_set_int(ent, EV_INT_solid, SOLID_BBOX)
	}
	
	entity_set_float(ent, EV_FL_nextthink, get_gametime() + 0.1)
}

public touch_grenade_teleport_start(grenade_ent, teleport_start_ent)
{
	action_teleport(grenade_ent, teleport_start_ent) 
}

public touch_block(ent, other)
{
	if (!is_valid_ent(ent))
		return;
	
	if (get_property(ent, PROP_MOVING_BOUNCE) && (entity_get_int(ent, EV_INT_flags) & FL_ONGROUND) && !entity_get_int(ent, EV_INT_iuser2))
	{
		// a bouncing block is on the ground while not grabbed - bounce it up
		new Float:velocity[3]
		velocity[2] = float(get_property(ent, PROP_MOVING_BOUNCE))
		
		entity_set_vector(ent, EV_VEC_velocity, velocity)
	}
}

action_bhop(ent)
{
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime <= get_block_nextthink(ent, THINK_TYPE_NORMAL))
		return;
	
	// Make block not solid after 0.1 seconds
	set_block_nextthink(ent, THINK_TYPE_NORMAL, gametime + get_special_property(ent, 0))
}

action_bhop_noslowdown(id, ent)
{
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime <= get_block_nextthink(ent, THINK_TYPE_NORMAL))
		return;
	
	g_noslowdown[id] = true
	set_task(0.1, "deaction_bhop_noslowdown", TASK_NOSLOWDOWN+id)
	
	// Make block not solid after 0.1 seconds
	set_block_nextthink(ent, THINK_TYPE_NORMAL, gametime + get_special_property(ent, 0))
}
public deaction_bhop_noslowdown(id)
{
	id -= TASK_NOSLOWDOWN
	
	g_noslowdown[id] = 0
}

action_death(id)
{
	if (!get_user_godmode(id))
		fakedamage(id, "the block of death", 10000.0, DMG_GENERIC)
}

action_heal(id, ent)
{
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime < g_block_next_use[ent][id])
		return;
	
	static add_health, add_armor, amount
	add_health = floatround(get_special_property(ent, 0))
	add_armor = floatround(get_special_property(ent, 2))
	
	// Health
	if (add_health)
	{
		amount = get_user_health(id)
		
		if (amount < 100)
		{
			amount = min(amount + add_health, 100)
			set_user_health(id, amount)
		}
	}
	
	// Armor
	if (add_armor)
	{
		static CsArmorType:armor_type
		amount = cs_get_user_armor(id, armor_type)
		
		if (amount < 100)
		{
			amount = min(amount + add_armor, 100)
			cs_set_user_armor(id, amount, CS_ARMOR_VESTHELM)
		}
	}
	
	g_block_next_use[ent][id] = gametime + get_special_property(ent, 1)
}

action_ice(id, ent)
{
	if (g_ice[id] != ent)
	{
		entity_set_float(id, EV_FL_friction, get_special_property(ent, 0))
		g_ice[id] = ent
	}
	
	remove_task(TASK_ICE+id)
	set_task(0.1, "deaction_ice", TASK_ICE+id)
}
public deaction_ice(id)
{
	id -= TASK_ICE
	
	g_ice[id] = 0
	entity_set_float(id, EV_FL_friction, 1.0)
}

action_speed_boost(id, ent)
{
	velocity_by_aim(id, floatround(get_special_property(ent, 0)), g_set_velocity[id]) // forward speed
	
	// Reversed?
	if (get_special_property(ent, 2))
	{
		g_set_velocity[id][0] *= -1.0
		g_set_velocity[id][1] *= -1.0
	}
	
	g_set_velocity[id][2] = get_special_property(ent, 1) // upward speed
	
	ExecuteHamB(Ham_Player_Jump, id)
}

action_trampoline(id, ent)
{
	if (get_special_property(ent, 0) < 200.0)
	{
		static Float:current_velocity[3]
		entity_get_vector(id, EV_VEC_velocity, current_velocity)
		
		if (current_velocity[2] < -200.0)
		{
			// invert existing Z velocity
			g_set_velocity[id][0] = current_velocity[0]
			g_set_velocity[id][1] = current_velocity[1]
			g_set_velocity[id][2] = -current_velocity[2]
			ExecuteHamB(Ham_Player_Jump, id)
		}
	}
	else
	{
		// predefined upward speed
		entity_get_vector(id, EV_VEC_velocity, g_set_velocity[id])
		g_set_velocity[id][2] = get_special_property(ent, 0)
		ExecuteHamB(Ham_Player_Jump, id)
	}
}

action_low_gravity(id, ent)
{
	if (g_low_gravity[id] != ent)
	{
		set_user_gravity(id, get_special_property(ent, 0))
		g_low_gravity[id] = ent
	}
}

action_honey(id, ent)
{
	if (g_honey[id] != ent)
	{
		entity_set_float(id, EV_FL_maxspeed, get_special_property(ent, 0))
		g_honey[id] = ent
	}
	
	if (!task_exists(TASK_HONEY+id))
	{
		static Float:velocity[3]
		entity_get_vector(id, EV_VEC_velocity, velocity)
		
		velocity[0] *= 0.5
		velocity[1] *= 0.5
		velocity[2] *= 0.5
		
		entity_set_vector(id, EV_VEC_velocity, velocity)
	}
	
	remove_task(TASK_HONEY+id)
	set_task(0.1, "deaction_honey", TASK_HONEY+id)
}
public deaction_honey(id)
{
	id -= TASK_HONEY
	
	g_honey[id] = 0
	ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
}

action_barrier(id, ent, team)
{
	if (team != -1 && fm_cs_get_user_team(id) == team)
		return;
	
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime <= get_block_nextthink(ent, THINK_TYPE_NORMAL))
		return;
	
	// Make block not solid after 0.1 seconds
	set_block_nextthink(ent, THINK_TYPE_NORMAL, gametime + 0.1)
}

action_vip_only(id, ent)
{
	if (!(get_user_flags(id) & g_access_flag[ACCESS_VIP]))
		return;
	
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime <= get_block_nextthink(ent, THINK_TYPE_NORMAL))
		return;
	
	// Make block not solid after 0.1 seconds
	set_block_nextthink(ent, THINK_TYPE_NORMAL, gametime + 0.1)
}

action_damage(id, ent)
{
	if (get_user_godmode(id))
		return;
	
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime < g_block_next_use[ent][id])
		return;
	
	static armor
	armor = get_user_armor(id)
	if (armor > 0)
		set_user_armor(id, get_user_armor(id) - floatround(get_special_property(ent, 0)))
	else
		fakedamage(id, "the block of damage", get_special_property(ent, 0), DMG_GENERIC)
	
	g_block_next_use[ent][id] = gametime + get_special_property(ent, 1)
}

action_grenade(id, ent)
{
	if (flag_get(g_used_block[ent], id) || fm_cs_get_user_team(id) != FM_CS_TEAM_T)
		return;
	
	static wpn
	
	switch (floatround(get_special_property(ent, 0)))
	{
		case 0:
		{
			switch (random_num(1, 3))
			{
				case 1:
				{
					wpn = CSW_HEGRENADE;
				}
				case 2:
				{
					wpn = CSW_FLASHBANG;
				}
				case 3:
				{
					wpn = CSW_SMOKEGRENADE;
				}
			}
		}
		case 1: wpn = CSW_HEGRENADE;
		case 2: wpn = CSW_FLASHBANG;
		case 3: wpn = CSW_SMOKEGRENADE;
	}
	
	if (user_has_weapon(id, wpn))
		cs_set_user_bpammo(id, wpn, (cs_get_user_bpammo(id, wpn) + floatround(get_special_property(ent, 1))))
	else
	{
		give_item(id, WEAPONENTNAMES[wpn])
		cs_set_user_bpammo(id, wpn, floatround(get_special_property(ent, 1)))
	}
	
	// Switch to that grenade
	engclient_cmd(id, WEAPONENTNAMES[wpn])
	
	flag_set(g_used_block[ent], id)
}

action_weapon(id, ent)
{
	if (flag_get(g_used_block[ent], id) || fm_cs_get_user_team(id) != FM_CS_TEAM_T)
		return;
	
	static prop, wpn, ammo
	prop = floatround(get_special_property(ent, 0))
	ammo = floatround(get_special_property(ent, 1))
	
	if (prop)
		wpn = WEAPONLIST[prop]
	else
		wpn = WEAPONLIST[random_num(1, charsmax(WEAPONLIST))]
	
	if (user_has_weapon(id, wpn))
	{
		static ent
		ent = find_ent_by_owner(1, WEAPONENTNAMES[wpn], id)
		cs_set_weapon_ammo(ent, (cs_get_weapon_ammo(ent) + ammo))
	}
	else
	{
		cs_set_weapon_ammo(give_item(id, WEAPONENTNAMES[wpn]), ammo)
	}
	
	// Switch to that weapon
	engclient_cmd(id, WEAPONENTNAMES[wpn])
	
	flag_set(g_used_block[ent], id)
}

action_camouflage(id, ent)
{
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime < g_block_next_use[ent][id])
	{
		if (!g_has_hud_text[id] && gametime - g_last_hud_text[id] > 0.1 && gametime - g_last_hud_remaining_text[id] > 0.1)
		{
			set_hudmessage(255, 128, 0, -1.0, 0.7, 0, 0.1, 0.1, 0.1, 0.1)
			show_hudmessage(id, "Camouflage Next Use:^n%.1f seconds", g_block_next_use[ent][id] - gametime)
			g_last_hud_text[id] = gametime
		}
		
		return;
	}
	
	if (!g_camouflage[id])
	{
		static model[64]
		if (cs_get_user_team(id) == CS_TEAM_CT)
		{
			switch (random(4))
			{
				case 0: copy(model, charsmax(model), "arctic");
				case 1: copy(model, charsmax(model), "terror");
				case 2: copy(model, charsmax(model), "guerilla");
				case 3: copy(model, charsmax(model), "leet");
			}
		}
		else
		{
			switch (random(4))
			{
				case 0: copy(model, charsmax(model), "gign");
				case 1: copy(model, charsmax(model), "gsg9");
				case 2: copy(model, charsmax(model), "sas");
				case 3: copy(model, charsmax(model), "urban");
			}
		}
		
		cs_get_user_model(id, g_camouflage_old_model[id], charsmax(g_camouflage_old_model[]))
		cs_set_user_model(id, model)
	}
	
	// User gets camouflage
	emit_sound(id, CHAN_STATIC, g_sound_camouflage, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	remove_task(TASK_CAMOUFLAGE+id)
	set_task(get_special_property(ent, 0), "deaction_camouflage", TASK_CAMOUFLAGE+id)
	
	static Float:duration
	duration = get_special_property(ent, 0)
	
	g_camouflage[id] = ent
	g_camouflage_end[id] = gametime + duration
	g_block_next_use[ent][id] = gametime + duration + get_special_property(ent, 1)
}
public deaction_camouflage(id)
{
	id -= TASK_CAMOUFLAGE
	
	g_camouflage[id] = 0
	cs_set_user_model(id, g_camouflage_old_model[id])
}

action_blindtrap(id, ent)
{
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime < g_block_next_use[ent][id])
		return;
	
	static rgb, Float:duration
	rgb = floatround(get_special_property(ent, 1))
	duration = get_special_property(ent, 0)
	
	// Calculate real color
	static red, green, blue
	red = rgb >> 16
	green = (rgb >> 8) & ~0xFF00
	blue = rgb & ~0xFFFF00
	
	// Send ScreenFade message
	message_begin(MSG_ONE_UNRELIABLE, g_msgScreenFade, _, id)
	write_short(floatround(UNIT_SECOND * duration))
	write_short(floatround(UNIT_SECOND * duration * 0.75))
	write_short(FFADE_IN)
	write_byte(red)
	write_byte(green)
	write_byte(blue)
	write_byte(floatround(get_special_property(ent, 2)))
	message_end()
	
	// Sound
	client_cmd(id, "spk sound/weapons/flashbang-1.wav")
	
	g_block_next_use[ent][id] = gametime + get_special_property(ent, 3)
}

action_boots_of_speed(id, ent)
{
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime < g_block_next_use[ent][id])
	{
		if (!g_has_hud_text[id] && gametime - g_last_hud_text[id] > 0.1 && gametime - g_last_hud_remaining_text[id] > 0.1)
		{
			set_hudmessage(255, 128, 0, -1.0, 0.7, 0, 0.1, 0.1, 0.1, 0.1)
			show_hudmessage(id, "Boots of Speed Next Use:^n%.1f seconds", g_block_next_use[ent][id] - gametime)
			g_last_hud_text[id] = gametime
		}
		
		return;
	}
	
	if (g_boots_of_speed[id] != ent)
	{
		g_boots_of_speed[id] = ent
		ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
	}
	
	// User gets boots of speed
	emit_sound(id, CHAN_STATIC, g_sound_boots_of_speed, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	remove_task(TASK_BOOTS_OF_SPEED+id)
	set_task(get_special_property(ent, 1), "deaction_boots_of_speed", TASK_BOOTS_OF_SPEED+id)
	
	static Float:duration
	duration = get_special_property(ent, 1)
	
	g_boots_of_speed_end[id] = gametime + duration
	g_block_next_use[ent][id] = gametime + duration + get_special_property(ent, 2)
}
public deaction_boots_of_speed(id)
{
	id -= TASK_BOOTS_OF_SPEED
	
	g_boots_of_speed[id] = 0
	ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
}

action_stealth(id, ent)
{
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime < g_block_next_use[ent][id])
	{
		if (!g_has_hud_text[id] && gametime - g_last_hud_text[id] > 0.1 && gametime - g_last_hud_remaining_text[id] > 0.1)
		{
			set_hudmessage(255, 128, 0, -1.0, 0.7, 0, 0.1, 0.1, 0.1, 0.1)
			show_hudmessage(id, "Stealth Next Use:^n%.1f seconds", g_block_next_use[ent][id] - gametime)
			g_last_hud_text[id] = gametime
		}
		
		return;
	}
	
	if (g_stealth[id] != ent)
	{
		g_stealth[id] = ent
		#if !defined ADVANCED_STEALTH
			reset_user_rendering(id)
		#endif
	}
	
	// User gets stealth
	emit_sound(id, CHAN_STATIC, g_sound_stealth, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	remove_task(TASK_STEALTH+id)
	set_task(get_special_property(ent, 1), "deaction_stealth", TASK_STEALTH+id)
	
	static Float:duration
	duration = get_special_property(ent, 1)
	
	g_stealth_end[id] = gametime + duration
	g_block_next_use[ent][id] = gametime + duration + get_special_property(ent, 2)
}
public deaction_stealth(id)
{
	id -= TASK_STEALTH
	
	g_stealth[id] = 0
	reset_user_rendering(id)
}

action_magic_carpet(id, ent)
{
	if (entity_get_int(ent, EV_INT_iuser2)) // Block is already grabbed
		return;
	
	static Float:duration, Float:gametime, owner
	duration = get_special_property(ent, 0)
	gametime = get_gametime()
	owner = entity_get_int(ent, EV_INT_weapons)
	
	if (owner != id && g_isalive[owner] && g_magic_carpet[owner] == ent)
	{
		if (!g_has_hud_text[id] && gametime - g_last_hud_text[id] > 0.1 && gametime - g_last_hud_remaining_text[id] > 0.1)
		{
			set_hudmessage(255, 128, 0, -1.0, 0.7, 0, 0.1, 0.1, 0.1, 0.1)
			show_hudmessage(id, "This Magic Carpet is already in use")
			g_last_hud_text[id] = gametime
		}
		
		return;
	}
	
	if (g_magic_carpet[id] != ent)
	{
		g_magic_carpet[id] = ent
		
		static Float:base_position[3], Float:current_position[3]
		entity_get_vector(ent, EV_VEC_vuser3, base_position)
		entity_get_vector(ent, EV_VEC_origin, current_position)
		
		if (base_position[0] == current_position[0] && base_position[1] == current_position[1] && base_position[2] == current_position[2] || get_block_nextthink(ent, THINK_TYPE_MOVING) >= gametime
			|| (get_property(ent, PROP_MOVING_BOUNCE) && base_position[0] == current_position[0] && base_position[1] == current_position[1]))
			g_magic_carpet_end[id] = gametime + duration
		else
			g_magic_carpet_end[id] = get_block_nextthink(ent, THINK_TYPE_NORMAL)
		
		entity_set_int(ent, EV_INT_weapons, id)
		entity_set_int(ent, EV_INT_movetype, MOVETYPE_FLY)
		set_block_nextthink(ent, THINK_TYPE_MOVING, -1.0)
		set_block_nextthink(ent, THINK_TYPE_NORMAL, g_magic_carpet_end[id])
	}
	
	static Float:player_velocity[3]
	entity_get_vector(id, EV_VEC_velocity, player_velocity)
	player_velocity[2] = 0.0
	entity_set_vector(ent, EV_VEC_velocity, player_velocity)
}
deaction_magic_carpet(ent)
{
	if (entity_get_int(ent, EV_INT_iuser2)) // Block is already grabbed
		return;
	
	static id
	id = entity_get_int(ent, EV_INT_weapons)
	
	g_magic_carpet[id] = 0
	entity_set_int(ent, EV_INT_weapons, 0)
	set_block_nextthink(ent, THINK_TYPE_NORMAL, -1.0)
	
	entity_set_vector(ent, EV_VEC_velocity, Float:{0.0, 0.0, 0.0})
	update_moving_path(ent)
}

action_invincibility(id, ent)
{
	static Float:gametime
	gametime = get_gametime()
	
	if (gametime < g_block_next_use[ent][id])
	{
		if (!g_has_hud_text[id] && gametime - g_last_hud_text[id] > 0.1 && gametime - g_last_hud_remaining_text[id] > 0.1)
		{
			set_hudmessage(255, 128, 0, -1.0, 0.7, 0, 0.1, 0.1, 0.1, 0.1)
			show_hudmessage(id, "Invincibility Next Use:^n%.1f seconds", g_block_next_use[ent][id] - gametime)
			g_last_hud_text[id] = gametime
		}
		
		return;
	}
	
	if (g_invincibility[id] != ent)
	{
		g_invincibility[id] = ent
		reset_user_rendering(id)
		set_user_godmode(id, true)
	}
	
	// User gets invincibility
	emit_sound(id, CHAN_STATIC, g_sound_invincibility, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	static Float:duration
	duration = get_special_property(ent, 0)
	
	remove_task(TASK_INVINCIBILITY+id)
	set_task(duration, "deaction_invincibility", TASK_INVINCIBILITY+id)
	
	g_invincibility_end[id] = gametime + duration
	g_block_next_use[ent][id] = gametime + duration + get_special_property(ent, 1)
}
public deaction_invincibility(id)
{
	id -= TASK_INVINCIBILITY
	
	g_invincibility[id] = 0
	reset_user_rendering(id)
	set_user_godmode(id, false)
}

action_teleport(id, ent)
{
	static tele
	tele = entity_get_int(ent, EV_INT_iuser3)
	
	if (!is_valid_ent(tele))
		return;
	
	static Float:originF[3]
	entity_get_vector(tele, EV_VEC_origin, originF)
	entity_set_origin(id, originF)
	
	// Reset velocity if player
	//if (is_user_valid_alive(id))
	//	entity_set_vector(id, EV_VEC_velocity, Float:{0.0, 0.0, 0.0})
	
	// From JG blockmaker
	static Float:velocity[3]
	entity_get_vector(id, EV_VEC_velocity, velocity)
	velocity[2] = floatabs(velocity[2])
	
	g_set_velocity[id][0] = velocity[0]
	g_set_velocity[id][1] = velocity[1]
	g_set_velocity[id][2] = velocity[2]
}

reset_user_rendering(id)
{
	#if defined ADVANCED_STEALTH
		if (g_stealth[id])
		{
			set_user_rendering(id, kRenderFxNone, 0, 0, 0, kRenderTransColor, floatround(get_special_property(g_stealth[id], 0)))
		}
		else
		{
	#endif
			if (g_invincibility[id])
				set_user_rendering(id, kRenderFxGlowShell, 255, 255, 255, kRenderNormal, 16) // make the player glow white
			else
				set_user_rendering(id)
	#if defined ADVANCED_STEALTH
		}
	#endif
}

public client_PostThink(id)
{
	if (!g_isalive[id])
		return;
	
	if (g_no_fall_damage[id])
	{
		entity_set_int(id, EV_INT_watertype, -3)
		g_no_fall_damage[id] = false;
	}
	
	if (g_low_gravity[id] && (entity_get_int(id, EV_INT_flags) & FL_ONGROUND) && entity_get_int(entity_get_edict(id, EV_ENT_groundentity), EV_INT_body) != BLOCK_LOW_GRAVITY)
	{
		set_user_gravity(id, 1.0)
		g_low_gravity[id] = false
	}
}

toggle_buildmode()
{
	if (g_buildmode)
	{
		// Disable
		g_buildmode = false
		
		static ent
		for (ent = 1; ent <= g_maxplayers; ent++)
		{
			if (!g_isalive[ent])
				continue;
			
			clcmd_release(ent)
			if (g_grouped_block_count[ent]) clear_group(ent)
			
			set_user_noclip(ent, false)
			set_user_godmode(ent, false)
		}
		
		// Make all teleport destinations SOLID_NOT
		ent = -1
		while ((ent = find_ent_by_class(ent, TELEPORT_DEST_CLASSNAME)))
		{
			entity_set_int(ent, EV_INT_solid, SOLID_NOT)
		}
	}
	else
	{
		// Enable
		g_buildmode = true
		
		#if defined BUILD_MODE_KICK_UNWANTED
			// Get rid of unwanted players
			static id
			for (id = 1; id <= g_maxplayers; id++)
			{
				if (!is_user_connected(id) && !is_user_connecting(id))
					continue;
				
				if (!can_build(id))
					redirect_user(id, true)
			}
		#endif
	}
}

log_buildmode_toggle(id)
{
	// Log to file
	static logdata[256], name[32], authid[34], ip[16]
	get_user_name(id, name, charsmax(name))
	get_user_authid(id, authid, charsmax(authid))
	get_user_ip(id, ip, charsmax(ip), 1)
	formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %s Building Mode (Players: %d/%d)", name, authid, ip, name, (g_buildmode ? "Enable" : "Disable"), get_playersnum(), g_maxplayers)
	log_to_file("blockmaker.log", logdata)
	
	client_printc(0, "^x04[BM]^x01 ADMIN^x04 %s^x01: %s Building Mode", name, (g_buildmode ? "Enable" : "Disable"))
}

create_block_by_aim(id, block_type, block_size)
{
	// Get origin
	static origin[3], Float:originF[3]
	get_user_origin(id, origin, 3)
	IVecFVec(origin, originF)
	originF[2] += 4.0
	
	static ent
	ent = create_block(id, block_type, originF, block_size, Z)
	
	if (ent && g_auto_group_new_blocks[id])
		group_block(id, ent)
}

create_block(id, type, Float:originF[3], size, axis, props[MAX_PROPS] = { -1, ... }, Float:special_props[MAX_SPECIAL_PROPS] = { -1.0, ... })
{
	static ent
	ent = create_entity("info_target")
	
	if (!is_valid_ent(ent))
		return 0;
	
	entity_set_string(ent, EV_SZ_classname, BLOCK_CLASSNAME)
	entity_set_int(ent, EV_INT_solid, SOLID_BBOX)
	entity_set_int(ent, EV_INT_movetype, props[PROP_MOVING_BOUNCE] ? MOVETYPE_TOSS : MOVETYPE_NONE)
	
	static Float:size_min[3], Float:size_max[3], Float:angles[3]
	
	// Check if the size is valid
	if (!g_block_model[type][size][0])
	{
		if (id) client_printc(id, "^4* This size is not available for this particular type of block.")
		return 0;
	}
	
	switch (axis)
	{
		case X:
		{
			if (size == BLOCK_SIZE_POLE)
			{
				size_min[0] = -32.0
				size_min[1] = -4.0
				size_min[2] = -4.0
				
				size_max[0] = 32.0
				size_max[1] = 4.0
				size_max[2] = 4.0
			}
			else
			{
				size_min[0] = -4.0
				size_min[1] = -32.0
				size_min[2] = -32.0
				
				size_max[0] = 4.0
				size_max[1] = 32.0
				size_max[2] = 32.0
			}
			
			angles[0] = 90.0
			angles[1] = 0.0
			angles[2] = 0.0
		}
		case Y:
		{
			if (size == BLOCK_SIZE_POLE)
			{
				size_min[0] = -4.0
				size_min[1] = -32.0
				size_min[2] = -4.0
				
				size_max[0] = 4.0
				size_max[1] = 32.0
				size_max[2] = 4.0
			}
			else
			{
				size_min[0] = -32.0
				size_min[1] = -4.0
				size_min[2] = -32.0
				
				size_max[0] = 32.0
				size_max[1] = 4.0
				size_max[2] = 32.0
			}
			
			angles[0] = 90.0
			angles[1] = 0.0
			angles[2] = 90.0
		}
		case Z:
		{
			if (size == BLOCK_SIZE_POLE)
			{
				size_min[0] = -4.0
				size_min[1] = -4.0
				size_min[2] = -32.0
				
				size_max[0] = 4.0
				size_max[1] = 4.0
				size_max[2] = 32.0
			}
			else
			{
				size_min[0] = -32.0
				size_min[1] = -32.0
				size_min[2] = -4.0
				
				size_max[0] = 32.0
				size_max[1] = 32.0
				size_max[2] = 4.0
			}
			
			angles[0] = 0.0
			angles[1] = 0.0
			angles[2] = 0.0
		}
	}
	
	static Float:scale
	
	switch (size)
	{
		case BLOCK_SIZE_SMALL:
		{
			scale = 0.25
		}
		case BLOCK_SIZE_NORMAL:
		{
			scale = 1.0
		}
		case BLOCK_SIZE_LARGE:
		{
			scale = 2.0
		}
		case BLOCK_SIZE_JUMBO:
		{
			scale = 6.0
		}
	}
	
	static i
	if (size != BLOCK_SIZE_POLE) // Scale the block accordingly if it's not a pole
	{
		for (i = 0; i < 3; ++i)
		{
			if (size_min[i] != 4.0 && size_min[i] != -4.0)
				size_min[i] *= scale
			
			if (size_max[i] != 4.0 && size_max[i] != -4.0)
				size_max[i] *= scale
		}
	}
	
	// Bhop block model will be set later
	if (type != BLOCK_BHOP) entity_set_model(ent, g_block_model[type][size])
	
	entity_set_vector(ent, EV_VEC_angles, angles)
	entity_set_size(ent, size_min, size_max)
	entity_set_int(ent, EV_INT_body, type)
	
	if (id)
	{
		g_entity_creator[ent] = g_playername[id]
		g_entity_created[ent] = get_systime()
		if (g_option_snapping[id]) do_snapping(ent, id, originF)
	}
	
	entity_set_origin(ent, originF)
	entity_set_vector(ent, EV_VEC_vuser3, originF)
	
	for (i = 0; i < MAX_PROPS; i++)
	{
		set_property(ent, i, (props[i] == -1) ? g_block_default_property[type][i] : props[i])
	}
	for (i = 0; i < MAX_SPECIAL_PROPS; i++)
	{
		if (!PROP_SPECIAL_KEY[type][i][0])
			break;
		
		set_special_property(ent, i, (special_props[i] == -1.0) ? PROP_SPECIAL_DEFAULT_VALUE[type][i] : special_props[i])
	}
	for (i = 0; i <= g_maxplayers; i++) g_block_next_use[ent][i] = 0.0
	
	g_used_block[ent] = 0
	g_current_think_type[ent] = THINK_TYPE_NORMAL
	g_buffered_think_type[ent] = THINK_TYPE_NORMAL
	g_buffered_nextthink[ent] = 0.0
	
	if (type == BLOCK_BHOP) update_bhop_block_model(ent)
	reset_block_rendering(ent)
	update_moving_path(ent)
	
	return ent;
}

rotate_block_by_aim(id)
{
	static ent, body
	get_user_aiming(id, ent, body)
	
	if (!is_valid_ent(ent))
		return;
	
	if (!is_entity_block(ent))
		return;
	
	static grabber, grouper
	grabber = entity_get_int(ent, EV_INT_iuser2)
	grouper = entity_get_int(ent, EV_INT_iuser1)
	
	if (grabber && grabber != id || (g_isconnected[grouper] && grouper != id && !access(id, g_access_flag[ACCESS_BUILDING_MODE])))
		return;
	
	if (g_grouped_block_count[id] > 1 && is_block_in_group(ent, id))
	{
		static block
		
		for (new i; i < MAX_GROUPED_BLOCKS; i++)
		{
			block = g_grouped_blocks[id][i]
			
			if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
				continue;
			
			rotate_block(block)
		}
	}
	else
		rotate_block(ent)
}

rotate_block(ent)
{
	static Float:angles[3], Float:size_min[3], Float:size_max[3], Float:temp
	entity_get_vector(ent, EV_VEC_angles, angles)
	entity_get_vector(ent, EV_VEC_mins, size_min)
	entity_get_vector(ent, EV_VEC_maxs, size_max)
	
	if (angles[0] == 0.0 && angles[2] == 0.0)
	{
		angles[0] = 90.0
	}
	else if (angles[0] == 90.0 && angles[2] == 0.0)
	{
		angles[0] = 90.0
		angles[2] = 90.0
	}
	else
	{
		angles[0] = 0.0
		angles[1] = 0.0
		angles[2] = 0.0
	}
	
	temp = size_min[0]
	size_min[0] = size_min[2]
	size_min[2] = size_min[1]
	size_min[1] = temp
	
	temp = size_max[0]
	size_max[0] = size_max[2]
	size_max[2] = size_max[1]
	size_max[1] = temp
	
	entity_set_vector(ent, EV_VEC_angles, angles)
	entity_set_size(ent, size_min, size_max)
	
	return true;
}

set_entity_grabbed(ent, id)
{
	static aiming[3], Float:origin[3]
	get_user_origin(id, aiming, 3)
	entity_get_vector(ent, EV_VEC_origin, origin)
	
	g_grabbed[id] = ent
	g_grab_offset[id][0] = origin[0] - aiming[0]
	g_grab_offset[id][1] = origin[1] - aiming[1]
	g_grab_offset[id][2] = origin[2] - aiming[2]
	
	entity_set_int(ent, EV_INT_iuser2, id)
	update_moving_path(ent)
}

is_block_stuck(ent)
{
	static content, Float:origin[3], Float:point[3], Float:size_min[3], Float:size_max[3]
	entity_get_vector(ent, EV_VEC_origin, origin)
	entity_get_vector(ent, EV_VEC_mins, size_min)
	entity_get_vector(ent, EV_VEC_maxs, size_max)
	
	size_min[0] += 1.0
	size_min[1] += 1.0
	size_min[2] += 1.0
	size_max[0] -= 1.0
	size_max[1] -= 1.0
	size_max[2] -= 1.0
	
	for (new i; i < 14; i++)
	{
		point = origin
		
		switch (i)
		{
			case 0:
			{
				point[0] += size_max[0]
				point[1] += size_max[1]
				point[2] += size_max[2]
			}
			case 1:
			{
				point[0] += size_min[0]
				point[1] += size_max[1]
				point[2] += size_max[2]
			}
			case 2:
			{
				point[0] += size_max[0]
				point[1] += size_min[1]
				point[2] += size_max[2]
			}
			case 3:
			{
				point[0] += size_min[0]
				point[1] += size_min[1]
				point[2] += size_max[2]
			}
			case 4:
			{
				point[0] += size_max[0]
				point[1] += size_max[1]
				point[2] += size_min[2]
			}
			case 5:
			{
				point[0] += size_min[0]
				point[1] += size_max[1]
				point[2] += size_min[2]
			}
			case 6:
			{
				point[0] += size_max[0]
				point[1] += size_min[1]
				point[2] += size_min[2]
			}
			case 7:
			{
				point[0] += size_min[0]
				point[1] += size_min[1]
				point[2] += size_min[2]
			}
			case 8: point[0] += size_max[0]
			case 9: point[0] += size_min[0]
			case 10: point[1] += size_max[1]
			case 11: point[1] += size_min[1]
			case 12: point[2] += size_max[2]
			case 13: point[2] += size_min[2]
		}
		
		content = point_contents(point)
		if (!content || content == CONTENTS_EMPTY)
			return false;
	}
	
	return true;
}

move_grabbed_entity(id, Float:move_to[3] = {0.0, 0.0, 0.0}, snapping_override = -1)
{
	static aiming[3], look[3]
	static Float:float_aiming[3], Float:float_look[3], Float:direction[3], Float:length
	get_user_origin(id, aiming, 1)
	get_user_origin(id, look, 3)
	IVecFVec(aiming, float_aiming)
	IVecFVec(look, float_look)
	
	direction[0] = float_look[0] - float_aiming[0]
	direction[1] = float_look[1] - float_aiming[1]
	direction[2] = float_look[2] - float_aiming[2]
	length = get_distance_f(float_look, float_aiming)
	if (length == 0.0) length = 1.0
	
	move_to[0] = float(floatround((float_aiming[0] + direction[0] * g_grab_length[id] / length) + g_grab_offset[id][0]))
	move_to[1] = float(floatround((float_aiming[1] + direction[1] * g_grab_length[id] / length) + g_grab_offset[id][1]))
	move_to[2] = float(floatround((float_aiming[2] + direction[2] * g_grab_length[id] / length) + g_grab_offset[id][2]))
	move_to[2] = float(floatround(move_to[2]))
	
	move_entity(g_grabbed[id], id, move_to, (snapping_override == -1) ? g_option_snapping[id] : snapping_override)
}

move_entity(ent, id, Float:move_to[3], snap)
{
	if (snap)
		do_snapping(ent, id, move_to)
	
	entity_set_origin(ent, move_to)
	entity_set_vector(ent, EV_VEC_vuser3, move_to)
}

do_snapping(ent, id, Float:move_to[3])
{
	static Float:size_min[3], Float:size_max[3], Float:snapping_gap
	entity_get_vector(ent, EV_VEC_mins, size_min)
	entity_get_vector(ent, EV_VEC_maxs, size_max)
	snapping_gap = float(g_option_snapping_gap[id])
	
	static Float:snap_size, Float:old_dist, Float:dist, traceline, closest_trace, block_face, Float:trace_start[3], Float:trace_end[3], Float:v_return[3]
	snap_size = snapping_gap + 10.0
	old_dist = 9999.9
	closest_trace = 0
	
	for (new i; i < 6; i++)
	{
		trace_start = move_to
		
		switch (i)
		{
			case 0: trace_start[0] += size_min[0]
			case 1: trace_start[0] += size_max[0]
			case 2: trace_start[1] += size_min[1]
			case 3: trace_start[1] += size_max[1]
			case 4: trace_start[2] += size_min[2]
			case 5: trace_start[2] += size_max[2]
		}
		
		trace_end = trace_start
		
		switch (i)
		{
			case 0: trace_end[0] -= snap_size
			case 1: trace_end[0] += snap_size
			case 2: trace_end[1] -= snap_size
			case 3: trace_end[1] += snap_size
			case 4: trace_end[2] -= snap_size
			case 5: trace_end[2] += snap_size
		}
		
		traceline = trace_line(ent, trace_start, trace_end, v_return)
		
		if (is_valid_ent(traceline) && is_entity_block(traceline))
		{
			dist = get_distance_f(trace_start, v_return)
			if (dist < old_dist)
			{
				closest_trace = traceline
				old_dist = dist
				
				block_face = i
			}
		}
	}
	
	if (!is_valid_ent(closest_trace))
		return;
	
	static Float:trace_origin[3], Float:trace_size_min[3], Float:trace_size_max[3]
	entity_get_vector(closest_trace, EV_VEC_origin, trace_origin)
	entity_get_vector(closest_trace, EV_VEC_mins, trace_size_min)
	entity_get_vector(closest_trace, EV_VEC_maxs, trace_size_max)
	
	move_to = trace_origin
	
	switch (block_face)
	{
		case 0: move_to[0] += (trace_size_max[0] + size_max[0]) + snapping_gap
		case 1: move_to[0] += (trace_size_min[0] + size_min[0]) - snapping_gap
		case 2: move_to[1] += (trace_size_max[1] + size_max[1]) + snapping_gap
		case 3: move_to[1] += (trace_size_min[1] + size_min[1]) - snapping_gap
		case 4: move_to[2] += (trace_size_max[2] + size_max[2]) + snapping_gap
		case 5: move_to[2] += (trace_size_min[2] + size_min[2]) - snapping_gap
	}
}

reset_block_rendering(ent)
{
	static grouper
	grouper = entity_get_int(ent, EV_INT_iuser1)
	
	if (entity_get_int(ent, EV_INT_solid) == SOLID_TRIGGER)
	{
		set_rendering(ent, kRenderFxNone, 255, 255, 255, kRenderTransAlpha, get_property(ent, PROP_TRANSPARENCYACTIVE))
	}
	else if (g_isconnected[grouper]) // Is the block grouped?
	{
		set_rendering(ent, kRenderFxGlowShell, g_grouped_block_color[grouper][0], g_grouped_block_color[grouper][1], g_grouped_block_color[grouper][2], kRenderNormal, 128)
	}
	else
	{
		static rgb, red, green, blue
		rgb = get_property(ent, PROP_COLOR)
		if (rgb)
		{
			red = rgb >> 16
			green = (rgb >> 8) & ~0xFF00
			blue = rgb & ~0xFFFF00
			
			set_rendering(ent, kRenderFxGlowShell, red, green, blue, (get_property(ent, PROP_TRANSPARENCYGLOW) ? kRenderTransColor : kRenderNormal), get_property(ent, PROP_TRANSPARENCY))
		}
		else
		{
			set_rendering(ent, kRenderFxNone, 255, 255, 255, (get_property(ent, PROP_TRANSPARENCY) < 255 ? kRenderTransAlpha : kRenderNormal), get_property(ent, PROP_TRANSPARENCY))
		}
	}
}

update_moving_path(ent)
{
	// How far do we need to move?
	static Float:distance
	distance = float(get_property(ent, PROP_MOVING_DISTANCE))
	
	// Get a moving block's base position
	static Float:originF[3]
	entity_get_vector(ent, EV_VEC_vuser3, originF)
	
	// Reset the block to its base position
	entity_set_origin(ent, originF)
	
	// If bounce is set it overrides any normal movement
	if (get_property(ent, PROP_MOVING_BOUNCE))
	{
		if (entity_get_int(ent, EV_INT_iuser2))
		{
			// grabbed
			entity_set_int(ent, EV_INT_movetype, MOVETYPE_NONE)
			entity_set_vector(ent, EV_VEC_velocity, Float:{0.0, 0.0, 0.0})
		}
		else
		{
			entity_set_int(ent, EV_INT_movetype, MOVETYPE_TOSS)
			entity_set_vector(ent, EV_VEC_velocity, Float:{0.0, 0.0, -1.0})
			entity_set_float(ent, EV_FL_gravity, float(get_property(ent, PROP_MOVING_GRAVITY)) / 100.0)
			
			if (entity_get_int(ent, EV_INT_flags) & FL_ONGROUND)
				touch_block(ent, 0)
		}
		
		return;
	}
	
	if (distance <= 0.0 || get_property(ent, PROP_MOVING_SPEED) <= 0)
	{
		if (entity_get_int(ent, EV_INT_body) != BLOCK_MAGIC_CARPET) // Magic carpet weird velocity fix
			entity_set_int(ent, EV_INT_movetype, MOVETYPE_NONE)
		
		return;
	}
	else
		entity_set_int(ent, EV_INT_movetype, MOVETYPE_FLY)
	
	// If the distance is set and block is not grabbed
	if (distance && !entity_get_int(ent, EV_INT_iuser2))
	{
		// Recalculate target position
		switch (get_property(ent, PROP_MOVING_DIRECTION))
		{
			case 0: originF[0] += distance
			case 1: originF[0] -= distance
			case 2: originF[1] += distance
			case 3: originF[1] -= distance
			case 4: originF[2] += distance
			case 5: originF[2] -= distance
		}
		entity_set_vector(ent, EV_VEC_vuser4, originF)
		
		// Reset stage (we are moving from base -> target)
		g_moving_stage[ent] = MOVING_STAGE_TO_TARGET
		
		// Call think (start moving)
		set_block_nextthink(ent, THINK_TYPE_MOVING, get_gametime())
	}
	else
	{
		// Cancel think
		set_block_nextthink(ent, THINK_TYPE_MOVING, -1.0)
		
		// Reset velocity
		entity_set_vector(ent, EV_VEC_velocity, Float:{0.0, 0.0, 0.0})
	}
}

Float:get_block_nextthink(ent, think_type)
{
	if (g_current_think_type[ent] == think_type)
		return entity_get_float(ent, EV_FL_nextthink);
	
	if (g_buffered_think_type[ent] == think_type)
		return g_buffered_nextthink[ent];
	
	return 0.0;
}

set_block_nextthink(ent, think_type, Float:nextthink)
{
	process_buffered_nextthink(ent)
	
	static Float:cur_nextthink, Float:gametime
	cur_nextthink = entity_get_float(ent, EV_FL_nextthink)
	gametime = get_gametime()
	
	if (nextthink < gametime) // We are trying to stop the thinking
	{
		// If the think type we need to stop is in the buffer, just remove it
		if (g_buffered_think_type[ent] == think_type)
			g_buffered_nextthink[ent] = 0.0
		
		// If it is the current type, we also need to check the buffer
		if (g_current_think_type[ent] == think_type)
		{
			if (g_buffered_nextthink[ent] >= gametime) // There is an another think in the buffer that needs executing
				process_buffered_nextthink(ent)
			else // Nothing in the buffer
				entity_set_float(ent, EV_FL_nextthink, 0.0)
		}
	}
	else if (cur_nextthink <= gametime) // No future think exists, just set the new think directly
	{
		g_current_think_type[ent] = think_type
		entity_set_float(ent, EV_FL_nextthink, nextthink)
	}
	else
	{
		// There is a think in the future with g_current_think_type[ent]
		// Now check whether the existing think is before or after the new think we want to apply
		
		if (nextthink > cur_nextthink) // Our new think is after the already existing think, just move our new think into the buffer to be executed after the existing think
		{
			if (g_current_think_type[ent] == think_type) // the same think type is already active, overwrite it
			{
				entity_set_float(ent, EV_FL_nextthink, nextthink)
			}
			else // just insert new think with different type into buffer
			{
				g_buffered_nextthink[ent] = nextthink
				g_buffered_think_type[ent] = think_type
			}
		}
		else // Our new think is before the already existing think, move the existing think to buffer and set our new think directly
		{
			if (g_current_think_type[ent] != think_type) // if it is not the same type of think then buffer the previous one
			{
				g_buffered_nextthink[ent] = cur_nextthink
				g_buffered_think_type[ent] = g_current_think_type[ent]
			}
			
			g_current_think_type[ent] = think_type
			entity_set_float(ent, EV_FL_nextthink, nextthink)
		}
	}
}

is_moving_block(ent)
{
	return get_property(ent, PROP_MOVING_DISTANCE) > 0 && get_property(ent, PROP_MOVING_SPEED) > 0 && !get_property(ent, PROP_MOVING_BOUNCE);
}

convert_block_by_aim(id, type, size)
{
	static ent, body
	get_user_aiming(id, ent, body)
	
	if (!is_valid_ent(ent))
		return;
	
	if (!is_entity_block(ent))
		return;
	
	static grabber, grouper
	grabber = entity_get_int(ent, EV_INT_iuser2)
	grouper = entity_get_int(ent, EV_INT_iuser1)
	
	if (grabber || (g_isconnected[grouper] && grouper != id && !access(id, g_access_flag[ACCESS_BUILDING_MODE])))
		return;
	
	if (g_grouped_block_count[id] > 1 && is_block_in_group(ent, id))
	{
		static block
		
		for (new i; i < MAX_GROUPED_BLOCKS; i++)
		{
			block = g_grouped_blocks[id][i]
			
			if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
				continue;
			
			ungroup_block(block)
			block = convert_block(id, block, type, size)
			group_block(id, block)
		}
	}
	else
		convert_block(id, ent, type, size)
}

convert_block(id, ent, type, size)
{
	static axis, Float:originF[3], Float:size_max[3]
	entity_get_vector(ent, EV_VEC_origin, originF)
	entity_get_vector(ent, EV_VEC_maxs, size_max)
	
	for (new i; i < 3; i++)
	{
		if (size_max[i] == 4.0)
		{
			axis = i
			break;
		}
	}
	
	static i
	new props[MAX_PROPS] = { -1, ... }, Float:special_props[MAX_SPECIAL_PROPS] = { -1.0, ... }
	for (i = 0; i < MAX_PROPS; i++)
	{
		props[i] = get_property(ent, i)
	}
	if (entity_get_int(ent, EV_INT_body) == type)
	{
		for (i = 0; i < MAX_SPECIAL_PROPS; i++)
		{
			special_props[i] = get_special_property(ent, i)
		}
	}
	
	delete_block(ent)
	return create_block(id, type, originF, size, axis, props, special_props)
}

create_teleport_by_aim(id)
{
	static origin[3], Float:originF[3]
	get_user_origin(id, origin, 3)
	IVecFVec(origin, originF)
	originF[2] += 36.0
	
	create_teleport(id, originF)
}

create_teleport(id, Float:originF[3])
{
	static ent
	ent = create_entity("info_target")
	
	if (!is_valid_ent(ent))
		return 0;
	
	if (g_teleport_start[id])
	{
		entity_set_string(ent, EV_SZ_classname, TELEPORT_DEST_CLASSNAME)
		entity_set_int(ent, EV_INT_solid, (g_buildmode ? SOLID_BBOX : SOLID_NOT))
		entity_set_int(ent, EV_INT_movetype, MOVETYPE_NONE)
		entity_set_model(ent, g_teleport_sprite[TELEPORT_DESTINATION])
		entity_set_size(ent, Float:{-32.0, -32.0, -32.0}, Float:{32.0, 32.0, 32.0})
		entity_set_origin(ent, originF)
		
		entity_set_int(ent, EV_INT_rendermode, 5)
		entity_set_float(ent, EV_FL_renderamt, 255.0)
		
		entity_set_int(ent, EV_INT_iuser3, g_teleport_start[id])
		entity_set_int(g_teleport_start[id], EV_INT_iuser3, ent)
		
		g_entity_creator[ent] = g_playername[id]
		g_entity_created[ent] = get_systime()
		
		g_teleport_start[id] = 0
	}
	else
	{
		entity_set_string(ent, EV_SZ_classname, TELEPORT_START_CLASSNAME)
		entity_set_int(ent, EV_INT_solid, SOLID_BBOX)
		entity_set_int(ent, EV_INT_movetype, MOVETYPE_NONE)
		entity_set_model(ent, g_teleport_sprite[TELEPORT_START])
		entity_set_size(ent, Float:{-32.0, -32.0, -32.0}, Float:{32.0, 32.0, 32.0})
		entity_set_origin(ent, originF)
		
		entity_set_int(ent, EV_INT_rendermode, 5)
		entity_set_float(ent, EV_FL_renderamt, 255.0)
		
		g_entity_creator[ent] = g_playername[id]
		g_entity_created[ent] = get_systime()
		
		g_teleport_start[id] = ent
	}
	
	entity_set_float(ent, EV_FL_nextthink, get_gametime() + 0.1)
	
	return ent;
}

delete_teleport_by_aim(id)
{
	static ent, body
	get_user_aiming(id, ent, body)
	
	if (delete_teleport(id, ent))
		client_printc(id, "^x04[BM]^x01 Teleport deleted.")
}

delete_teleport(id, ent)
{
	if (!is_entity_teleport(ent))
		return false;
	
	static tele
	tele = entity_get_int(ent, EV_INT_iuser3)
	
	if (g_teleport_start[id] == ent || g_teleport_start[id] == tele)
		g_teleport_start[id] = 0
	
	remove_entity(ent)
	if (is_valid_ent(tele)) remove_entity(tele)
	
	return true;
}

swap_teleport_by_aim(id)
{
	static ent, body
	get_user_aiming(id, ent, body)
	
	if (swap_teleport(id, ent))
		client_printc(id, "^x04[BM]^x01 Teleports swapped.")
}

swap_teleport(id, ent)
{
	static tele
	tele = entity_get_int(ent, EV_INT_iuser3)
	
	if (!is_entity_teleport(ent) || !is_entity_teleport(tele))
		return false;
	
	static Float:originF_ent[3], Float:originF_tele[3], classname[32]
	entity_get_vector(ent, EV_VEC_origin, originF_ent)
	entity_get_vector(tele, EV_VEC_origin, originF_tele)
	entity_get_string(ent, EV_SZ_classname, classname, charsmax(classname))
	
	delete_teleport(id, ent)
	
	if (equal(classname, TELEPORT_START_CLASSNAME))
	{
		create_teleport(id, originF_tele)
		create_teleport(id, originF_ent)
	}
	else
	{
		create_teleport(id, originF_ent);
		create_teleport(id, originF_tele);
	}
	
	return true;
}

is_entity_teleport(ent, classname[32] = "")
{
	if (!classname[0])
		entity_get_string(ent, EV_SZ_classname, classname, charsmax(classname))
	
	if (classname[0] == 'b' && classname[1] == 'm' && classname[2] == '_' && classname[3] == 't')
		return true;
	
	return false;
}

toggle_group_by_aim(id)
{
	if (!can_build(id))
		return;
	
	static ent, body
	get_user_aiming(id, ent, body)
	
	if (!is_valid_ent(ent))
		return;
	
	if (!is_entity_block(ent))
		return;
	
	static grabber, grouper
	grabber = entity_get_int(ent, EV_INT_iuser2)
	grouper = entity_get_int(ent, EV_INT_iuser1)
	
	if (g_isconnected[grabber] && grabber != id && !access(id, ACCESS_BUILDING_MODE))
		client_printc(id, "^4[BM]^1 This block is already grabbed by^4 %s^1.", g_playername[grabber])
	else if (g_isconnected[grouper] && grouper != id && !access(id, ACCESS_BUILDING_MODE))
		client_printc(id, "^4[BM]^1 This block is already grouped by^4 %s^1.", g_playername[grabber])
	else if (grouper == id)
		ungroup_block(ent)
	else if (g_isconnected[grouper])
	{
		ungroup_block(ent)
		group_block(id, ent)
	}
	else
		group_block(id, ent)
}

clear_group(id)
{
	static ent, blocks_ungrouped
	blocks_ungrouped = 0
	for (new i; i < MAX_GROUPED_BLOCKS; i++)
	{
		if (!is_valid_ent(g_grouped_blocks[id][i]))
			continue;
		
		ent = g_grouped_blocks[id][i]
		if (is_block_stuck(ent))
			delete_block(ent)
		else
			ungroup_block(ent)
		
		blocks_ungrouped++
	}
	
	if (g_isconnected[id])
		client_printc(id, "^x04[BM]^1 Ungrouped^4 %d^1 block%s.", blocks_ungrouped, (blocks_ungrouped == 1 ? "" : "s"))
}

group_block(id, ent)
{
	if (g_grouped_block_count[id] == MAX_GROUPED_BLOCKS)
	{
		client_printc(0, "^4[BM]^1 Unable to group any more blocks:^4 maximum amount of grouped blocks reached^1.")
		return;
	}
	
	g_grouped_block_count[id]++
	for (new i; i < MAX_GROUPED_BLOCKS; i++)
	{
		if (!is_valid_ent(g_grouped_blocks[id][i]))
		{
			g_grouped_blocks[id][i] = ent
			break;
		}
	}
	
	entity_set_int(ent, EV_INT_iuser1, id)
	reset_block_rendering(ent)
}

ungroup_block(ent)
{
	static id
	id = entity_get_int(ent, EV_INT_iuser1)
	
	if (g_isconnected[id])
	{
		for (new i; i < MAX_GROUPED_BLOCKS; i++)
		{
			if (g_grouped_blocks[id][i] == ent)
			{
				g_grouped_blocks[id][i] = 0
				break;
			}
		}
		
		g_grouped_block_count[id]--
	}
	
	entity_set_int(ent, EV_INT_iuser1, 0)
	reset_block_rendering(ent)
}

is_block_in_group(ent, id)
{
	return (entity_get_int(ent, EV_INT_iuser1) == id);
}

group_contains_only_one_type(id, block_type)
{
	static block
	for (new i; i < MAX_GROUPED_BLOCKS; i++)
	{
		block = g_grouped_blocks[id][i]
		
		if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
			continue;
		
		if (entity_get_int(block, EV_INT_body) != block_type)
			return false;
	}
	
	return true;
}

are_group_values_identical(id, ent, prop)
{
	static value_to_match, block
	value_to_match = get_property(ent, prop)
	
	for (new i; i < MAX_GROUPED_BLOCKS; i++)
	{
		block = g_grouped_blocks[id][i]
		
		if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
			continue;
		
		if (get_property(block, prop) != value_to_match)
			return false;
	}
	
	return true;
}

are_group_svalues_identical(id, ent, prop)
{
	static Float:value_to_match, block
	value_to_match = get_special_property(ent, prop)
	
	for (new i; i < MAX_GROUPED_BLOCKS; i++)
	{
		block = g_grouped_blocks[id][i]
		
		if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
			continue;
		
		if (get_special_property(block, prop) != value_to_match)
			return false;
	}
	
	return true;
}

update_block_property(id, ent, property, value, update_movement = false, update_rendering = false)
{
	if (g_grouped_block_count[id] && is_block_in_group(ent, id))
	{
		static block
		for (new i; i < MAX_GROUPED_BLOCKS; i++)
		{
			block = g_grouped_blocks[id][i]
			
			if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
				continue;
			
			set_property(block, property, value)
			if (update_movement) update_moving_path(block)
			if (update_rendering) reset_block_rendering(block)
			
			g_entity_editor[block] = g_playername[id]
			g_entity_edited[block] = get_systime()
		}
	}
	else
	{
		set_property(ent, property, value)
		if (update_movement) update_moving_path(ent)
		if (update_rendering) reset_block_rendering(ent)
		
		g_entity_editor[ent] = g_playername[id]
		g_entity_edited[ent] = get_systime()
	}
}

update_block_special_property(id, ent, property, Float:value, reset_use = false)
{
	if (g_grouped_block_count[id] && is_block_in_group(ent, id))
	{
		static block
		for (new i; i < MAX_GROUPED_BLOCKS; i++)
		{
			block = g_grouped_blocks[id][i]
			
			if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
				continue;
			
			set_special_property(block, property, value)
			if (entity_get_int(ent, EV_INT_body) == BLOCK_BHOP) update_bhop_block_model(ent)
			if (reset_use) g_used_block[block] = 0
			
			g_entity_editor[block] = g_playername[id]
			g_entity_edited[block] = get_systime()
		}
	}
	else
	{
		set_special_property(ent, property, value)
		if (entity_get_int(ent, EV_INT_body) == BLOCK_BHOP) update_bhop_block_model(ent)
		if (reset_use) g_used_block[ent] = 0
		
		g_entity_editor[ent] = g_playername[id]
		g_entity_edited[ent] = get_systime()
	}
}

update_bhop_block_model(ent)
{
	static size
	size = get_block_size(ent)
	
	static Float:mins[3], Float:maxs[3]
	entity_get_vector(ent, EV_VEC_mins, mins)
	entity_get_vector(ent, EV_VEC_maxs, maxs)
	
	// Special model for bhop block?
	if (g_delayed_bhop_model[size][0] && ((floatabs(get_special_property(ent, 0) - PROP_SPECIAL_DEFAULT_VALUE[BLOCK_BHOP][0]) >= 0.01) || (floatabs(get_special_property(ent, 1) - PROP_SPECIAL_DEFAULT_VALUE[BLOCK_BHOP][1]) >= 0.01)))
		entity_set_model(ent, g_delayed_bhop_model[size])
	else
		entity_set_model(ent, g_block_model[BLOCK_BHOP][size])
	
	entity_set_size(ent, mins, maxs)
}

nudge_block(id, ent, direction, Float:amount)
{
	static Float:originF[3]
	entity_get_vector(ent, EV_VEC_origin, originF)
	
	switch (direction)
	{
		case 1: originF[0] += amount
		case 2: originF[0] -= amount
		case 3: originF[1] += amount
		case 4: originF[1] -= amount
		case 5: originF[2] += amount
		case 6: originF[2] -= amount
	}
	
	move_entity(ent, id, originF, false)
	
	if (is_block_stuck(ent) && delete_block(ent))
	{
		client_printc(id, "^x04[BM]^x01 Block deleted because it was stuck!")
	}
	else
	{
		g_entity_editor[ent] = g_playername[id]
		g_entity_edited[ent] = get_systime()
	}
}

#if defined BUILD_MODE_KICK_UNWANTED
	redirect_user(id, notify = false)
	{
	#if defined XREDIRECT
		redirect(id, -1, true)
		set_task(1.0, "task_redirect_bypass", TASK_REDIRECT_BYPASS+id)
	#else
		kick_player(id)
	#endif
		
		// Notice other players?
		if (notify)
		{
			static nickname[32]
			get_user_name(id, nickname, charsmax(nickname))
			
			client_printc(0, "^x04[BM] %s^1 has been redirected due to^4 building mode^1.", nickname)
		}
	}

	kick_player(id)
	{
		server_cmd("kick #%d ^"Sorry, you cannot be in the server while building mode is enabled.^"", get_user_userid(id))
	}
#endif

#if defined XREDIRECT
	// Someone managed to ignore the redirect command, kick them
	public task_redirect_bypass(id)
	{
		id -= TASK_REDIRECT_BYPASS
		kick_player(id)
	}
#endif

can_build(id)
{
	static userflags
	userflags = get_user_flags(id)
	
	return (g_buildmode && (userflags & g_access_flag[ACCESS_BM] || g_given_access[id]) || !g_buildmode && (userflags & g_access_flag[ACCESS_BUILDING_MODE]));
}

/*================================================================================
 [Other Functions and Tasks]
=================================================================================*/

load_customization_from_files()
{
	// Build customization file path
	new path[64]
	get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, BM_CUSTOMIZATION_FILE)
	
	// File not present
	if (!file_exists(path))
	{
		new error[100]
		formatex(error, charsmax(error), "Cannot load customization file %s!", path)
		set_fail_state(error)
		return;
	}
	
	// Set up some vars to hold parsing info
	new linedata[1024], key[64], value[960], section, valuenum
	
	// Open customization file for reading
	new file = fopen(path, "rt")
	
	while (file && !feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		
		// Blank line or comment
		if (!linedata[0] || linedata[0] == ';' || linedata[0] == '/' || linedata[1] == '/') continue;
		
		// New section starting
		if (linedata[0] == '[')
		{
			section++
			continue;
		}
		
		// Get key and value(s)
		strtok(linedata, key, charsmax(key), value, charsmax(value), '=')
		valuenum = 0
		
		// Trim spaces
		trim(key)
		trim(value)
		
		switch (section)
		{
			case SECTION_ACCESS_FLAGS:
			{
				if (equal(key, "BM"))
					g_access_flag[ACCESS_BM] = read_flags(value)
				else if (equal(key, "DELETE ALL"))
					g_access_flag[ACCESS_DELETE_ALL] = read_flags(value)
				else if (equal(key, "SAVE ALL"))
					g_access_flag[ACCESS_SAVE_ALL] = read_flags(value)
				else if (equal(key, "BUILDING MODE"))
					g_access_flag[ACCESS_BUILDING_MODE] = read_flags(value)
				else if (equal(key, "VIP"))
					g_access_flag[ACCESS_VIP] = read_flags(value)
				else if (equal(key, "RESPAWN PLAYERS"))
					g_access_flag[ACCESS_RESPAWN_PLAYERS] = read_flags(value)
				else if (equal(key, "GIVE ACCESS"))
					g_access_flag[ACCESS_GIVE_ACCESS] = read_flags(value)
			}
			case SECTION_MODELS:
			{
				
			}
			case SECTION_BLOCK_MODELS:
			{
				if (equal(key, "DELAYED BHOP"))
				{
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						valuenum++
						
						// No model for this block size
						if (equal(key, "_"))
							continue;
						
						g_delayed_bhop_model[valuenum-1] = key
					}
				}
				else
				{
					for (new i; i < MAX_BLOCKS; i++)
					{
						if (equal(key, CONFIG_BLOCK_NAME[i]))
						{
							while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
							{
								// Trim spaces
								trim(key)
								trim(value)
								valuenum++
								
								// No model for this block size
								if (equal(key, "_"))
									continue;
								
								g_block_model[i][valuenum-1] = key
							}
							
							break;
						}
					}
				}
			}
			case SECTION_BLOCK_NAMES:
			{
				for (new i; i < MAX_BLOCKS; i++)
				{
					if (equal(key, CONFIG_BLOCK_NAME[i]))
					{
						copy(g_block_name[i], charsmax(g_block_name[]), value)
						break;
					}
				}
			}
			case SECTION_BLOCK_SIZE_NAMES:
			{
				if (equal(key, "POLE"))
					copy(g_block_size_name[BLOCK_SIZE_POLE], charsmax(g_block_size_name[]), value)
				else if (equal(key, "SMALL"))
					copy(g_block_size_name[BLOCK_SIZE_SMALL], charsmax(g_block_size_name[]), value)
				else if (equal(key, "NORMAL"))
					copy(g_block_size_name[BLOCK_SIZE_NORMAL], charsmax(g_block_size_name[]), value)
				else if (equal(key, "LARGE"))
					copy(g_block_size_name[BLOCK_SIZE_LARGE], charsmax(g_block_size_name[]), value)
				else if (equal(key, "JUMBO"))
					copy(g_block_size_name[BLOCK_SIZE_JUMBO], charsmax(g_block_size_name[]), value)
			}
			case SECTION_BLOCK_DEFAULT_PROPS:
			{
				for (new i; i < MAX_BLOCKS; i++)
				{
					if (equal(key, CONFIG_BLOCK_NAME[i]))
					{
						while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
						{
							// Trim spaces
							trim(key)
							trim(value)
							
							g_block_default_property[i][valuenum] = str_to_num(key)
							valuenum++
						}
						
						break;
					}
				}
			}
			case SECTION_SPRITES:
			{
				if (equal(key, "TELEPORT START"))
					copy(g_teleport_sprite[TELEPORT_START], charsmax(g_teleport_sprite[]), value)
				else if (equal(key, "TELEPORT DESTINATION"))
					copy(g_teleport_sprite[TELEPORT_DESTINATION], charsmax(g_teleport_sprite[]), value)
			}
			case SECTION_SOUNDS:
			{
				if (equal(key, "INVINCIBILITY"))
					copy(g_sound_invincibility, charsmax(g_sound_invincibility), value)
				else if (equal(key, "STEALTH"))
					copy(g_sound_stealth, charsmax(g_sound_stealth), value)
				else if (equal(key, "BOOTS OF SPEED"))
					copy(g_sound_boots_of_speed, charsmax(g_sound_boots_of_speed), value)
				else if (equal(key, "CAMOUFLAGE"))
					copy(g_sound_camouflage, charsmax(g_sound_camouflage), value)
			}
		}
	}
	if (file) fclose(file)
}

save_blocks(id = 0)
{
	new ent, block_type, data[1024], i
	new Float:origin[3], Float:angles[3]
	new block_count, tele_count
	new len, file = fopen(g_savefile, "wt")
	
	// Header
	len = formatex(data, charsmax(data), "^"blockmaker^"^n")
	len += formatex(data[len], charsmax(data) - len, "{^n")
	len += formatex(data[len], charsmax(data) - len, "^t^"version^" ^"%s^"^n", PLUGIN_VERSION)
	len += formatex(data[len], charsmax(data) - len, "}^n")
	fputs(file, data)
	
	ent = -1
	while ((ent = find_ent_by_class(ent, BLOCK_CLASSNAME)))
	{
		// Get data
		block_type = entity_get_int(ent, EV_INT_body)
		entity_get_vector(ent, EV_VEC_vuser3, origin)
		entity_get_vector(ent, EV_VEC_angles, angles)
		
		len = formatex(data, charsmax(data), "^"block^"^n")
		len += formatex(data[len], charsmax(data) - len, "{^n")
		len += formatex(data[len], charsmax(data) - len, "^t^"type^" ^"%d^"^n", block_type)
		len += formatex(data[len], charsmax(data) - len, "^t^"size^" ^"%d^"^n", get_block_size(ent))
		len += formatex(data[len], charsmax(data) - len, "^t^"origin_x^" ^"%f^"^n", origin[0])
		len += formatex(data[len], charsmax(data) - len, "^t^"origin_y^" ^"%f^"^n", origin[1])
		len += formatex(data[len], charsmax(data) - len, "^t^"origin_z^" ^"%f^"^n", origin[2])
		len += formatex(data[len], charsmax(data) - len, "^t^"angles_x^" ^"%f^"^n", angles[0])
		len += formatex(data[len], charsmax(data) - len, "^t^"angles_y^" ^"%f^"^n", angles[1])
		len += formatex(data[len], charsmax(data) - len, "^t^"angles_z^" ^"%f^"^n", angles[2])
		len += formatex(data[len], charsmax(data) - len, "^t^"creator^" ^"%s^"^n", g_entity_creator[ent])
		len += formatex(data[len], charsmax(data) - len, "^t^"created^" ^"%d^"^n", g_entity_created[ent])
		len += formatex(data[len], charsmax(data) - len, "^t^"editor^" ^"%s^"^n", g_entity_editor[ent])
		len += formatex(data[len], charsmax(data) - len, "^t^"edited^" ^"%d^"^n", g_entity_edited[ent])
		for (i = 0; i < MAX_PROPS; i++)
		{
			len += formatex(data[len], charsmax(data) - len, "^t^"%s^" ^"%d^"^n", PROP_KEY[i], get_property(ent, i))
		}
		for (i = 0; i < MAX_SPECIAL_PROPS; i++)
		{
			if (!PROP_SPECIAL_KEY[block_type][i][0])
				break;
			
			len += formatex(data[len], charsmax(data) - len, "^t^"%s^" ^"%f^"^n", PROP_SPECIAL_KEY[block_type][i], g_block_special_property[ent][i])
		}
		len += formatex(data[len], charsmax(data) - len, "}^n")
		
		fputs(file, data)
		
		block_count++
	}
	
	new tele, Float:tele_start[3], Float:tele_end[3]
	ent = -1
	while ((ent = find_ent_by_class(ent, TELEPORT_DEST_CLASSNAME)))
	{
		tele = entity_get_int(ent, EV_INT_iuser3)
		
		if (!is_entity_teleport(tele))
			continue;
		
		entity_get_vector(tele, EV_VEC_origin, tele_start)
		entity_get_vector(ent, EV_VEC_origin, tele_end)
		
		len = formatex(data, charsmax(data), "^"teleport^"^n")
		len += formatex(data[len], charsmax(data) - len, "{^n")
		len += formatex(data[len], charsmax(data) - len, "^t^"start_origin_x^" ^"%f^"^n", tele_start[0])
		len += formatex(data[len], charsmax(data) - len, "^t^"start_origin_y^" ^"%f^"^n", tele_start[1])
		len += formatex(data[len], charsmax(data) - len, "^t^"start_origin_z^" ^"%f^"^n", tele_start[2])
		len += formatex(data[len], charsmax(data) - len, "^t^"end_origin_x^" ^"%f^"^n", tele_end[0])
		len += formatex(data[len], charsmax(data) - len, "^t^"end_origin_y^" ^"%f^"^n", tele_end[1])
		len += formatex(data[len], charsmax(data) - len, "^t^"end_origin_z^" ^"%f^"^n", tele_end[2])
		len += formatex(data[len], charsmax(data) - len, "^t^"creator^" ^"%s^"^n", g_entity_creator[ent])
		len += formatex(data[len], charsmax(data) - len, "^t^"created^" ^"%d^"^n", g_entity_created[ent])
		len += formatex(data[len], charsmax(data) - len, "^t^"editor^" ^"%s^"^n", g_entity_editor[ent])
		len += formatex(data[len], charsmax(data) - len, "^t^"edited^" ^"%d^"^n", g_entity_edited[ent])
		len += formatex(data[len], charsmax(data) - len, "}^n")
		
		fputs(file, data)
		
		tele_count++
	}
	
	if (file) fclose(file)
	
	if (id)
	{
		new build[10]
		ArrayGetString(g_builds, g_current_build, build, charsmax(build))
		
		client_printc(0, "^x04[BM] %s^x01 saved^x04 %d^x01 block%s and^x04 %d^x01 teleport%s. Total entities in map:^x04 %d^x01. Build:^4 %s^1.", g_playername[id], block_count, (block_count == 1) ? "" : "s", tele_count, (tele_count == 1) ? "" : "s", entity_count(), (build[0] ? build : "Default"))
	}
}

load_blocks(id = 0)
{
	if (!file_exists(g_savefile))
	{
		if (is_user_valid_connected(id))
			client_printc(id, "^x04[BM]^x01 Save file for this map not found!")
		
		return;
	}
	
	if (is_user_valid_connected(id))
		delete_all(id)
	
	new file = fopen(g_savefile, "rt")
	
	// Set up some vars to hold parsing info
	new linedata[1024], var[32], value[64], what, creator[32], created, editor[32], edited, props[MAX_PROPS] = { -1, ... },
				Float:special_props[MAX_SPECIAL_PROPS] = { -1.0, ... }
	new block_type, block_size, axis, Float:origin[3], Float:angles[3]
	new block_count, tele_count, ent, i
	new Float:savefile_version, compat_block_size_shift = 1
	
	while (file && !feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines and tabs with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		replace(linedata, charsmax(linedata), "^t", "")
		
		// Blank line or comment
		if (!linedata[0] || linedata[0] == ';') continue;
		
		if (equal(linedata, "^"block^""))
		{
			what = 1 // Block
			continue;
		}
		else if (equal(linedata, "^"teleport^""))
		{
			what = 2 // Teleport
			continue;
		}
		else if (equal(linedata, "^"blockmaker^""))
		{
			what = 3; // File header
			continue;
		}
		else if (equal(linedata, "{"))
		{
			continue; // Section started
		}
		else if (equal(linedata, "}")) // Section ended
		{
			// Create entity
			switch (what)
			{
				case 1: // Block
				{
					if (angles[0] == 90.0 && angles[1] == 0.0 && angles[2] == 0.0)
						axis = X;
					else if (angles[0] == 90.0 && angles[1] == 0.0 && angles[2] == 90.0)
						axis = Y;
					else
						axis = Z;
					
					if (block_type == BLOCK_BHOP) special_props[1] = 0.75
					
					ent = create_block(0, block_type, origin, block_size, axis, props, special_props)
					if (ent)
					{
						g_entity_creator[ent] = creator
						g_entity_created[ent] = created
						g_entity_editor[ent] = editor
						g_entity_edited[ent] = edited
						
						block_count++
					}
					
					// Reset vars
					for (i = 0; i < MAX_PROPS; i++) props[i] = -1
					for (i = 0; i < MAX_SPECIAL_PROPS; i++) special_props[i] = -1.0
				}
				case 2: // Teleport
				{
					ent = create_teleport(0, origin)
					
					if (ent)
					{
						g_entity_creator[ent] = creator
						g_entity_created[ent] = created
						g_entity_editor[ent] = editor
						g_entity_edited[ent] = edited
						tele_count++
					}
					
					ent = create_teleport(0, angles)
					
					if (ent)
					{
						g_entity_creator[ent] = creator
						g_entity_created[ent] = created
						g_entity_editor[ent] = editor
						g_entity_edited[ent] = edited
						tele_count++
					}
				}
				case 3: // File header
				{
					if (savefile_version >= 2.2)
					{
						// Versions earlier than 2.2 didn't have pole sized blocks
						// Thus we don't have to shift block sizes by +1 to match the block size table used in the newer versions
						compat_block_size_shift = 0;
					}
				}
			}
			
			what = 0
			continue;
		}
		// Else it should be variable...
		
		// Parse data
		parse(linedata, var, charsmax(var), value, charsmax(value))
		
		// Error?
		if (!var[0] || !value[0]) continue;
		
		// General
		if (equal(var, "creator"))
		{
			copy(creator, charsmax(creator), value)
			continue;
		}
		else if (equal(var, "created"))
		{
			created = str_to_num(value)
			continue;
		}
		else if (equal(var, "editor"))
		{
			copy(editor, charsmax(editor), value)
			continue;
		}
		else if (equal(var, "edited"))
		{
			edited = str_to_num(value)
			continue;
		}
		
		if (what == 1) // Block
		{
			if (equal(var, "type"))
			{
				block_type = str_to_num(value)
				continue;
			}
			else if (equal(var, "size"))
			{
				block_size = str_to_num(value) + compat_block_size_shift
				continue;
			}
			else if (equal(var, "origin_x"))
			{
				origin[0] = str_to_float(value)
				continue;
			}
			else if (equal(var, "origin_y"))
			{
				origin[1] = str_to_float(value)
				continue;
			}
			else if (equal(var, "origin_z"))
			{
				origin[2] = str_to_float(value)
				continue;
			}
			else if (equal(var, "angles_x"))
			{
				angles[0] = str_to_float(value)
				continue;
			}
			else if (equal(var, "angles_y"))
			{
				angles[1] = str_to_float(value)
				continue;
			}
			else if (equal(var, "angles_z"))
			{
				angles[2] = str_to_float(value)
				continue;
			}
			else
			{
				for (i = 0; i < MAX_PROPS; i++)
				{
					if (equal(var, PROP_KEY[i]))
					{
						props[i] = str_to_num(value)
						break;
					}
				}
				for (i = 0; i < MAX_SPECIAL_PROPS; i++)
				{
					if (equal(var, PROP_SPECIAL_KEY[block_type][i]))
					{
						special_props[i] = str_to_float(value)
						break;
					}
				}
			}
		}
		else if (what == 2) // Teleport
		{
			if (equal(var, "start_origin_x"))
			{
				origin[0] = str_to_float(value)
				continue;
			}
			else if (equal(var, "start_origin_y"))
			{
				origin[1] = str_to_float(value)
				continue;
			}
			else if (equal(var, "start_origin_z"))
			{
				origin[2] = str_to_float(value)
				continue;
			}
			else if (equal(var, "end_origin_x"))
			{
				angles[0] = str_to_float(value)
				continue;
			}
			else if (equal(var, "end_origin_y"))
			{
				angles[1] = str_to_float(value)
				continue;
			}
			else if (equal(var, "end_origin_z"))
			{
				angles[2] = str_to_float(value)
				continue;
			}
		}
		else if (what == 3) // File header
		{
			if (equal(var, "version"))
			{
				savefile_version = str_to_float(value)
				continue;
			}
		}
		
		/*
		block_type = str_to_num(type)
		block_size = str_to_num(size)
		origin[0] =	str_to_float(origin_x)
		origin[1] =	str_to_float(origin_y)
		origin[2] =	str_to_float(origin_z)
		angles[0] =	str_to_float(angle_x)
		angles[1] =	str_to_float(angle_y)
		angles[2] =	str_to_float(angle_z)
		
		if (type[0] == '*')
		{
			ent = create_teleport(0, origin)
			
			if (ent)
			{
				g_entity_creator[ent] = creator
				g_entity_created[ent] = str_to_num(created)
				tele_count++
			}
			
			ent = create_teleport(0, angles)
			
			if (ent)
			{
				g_entity_creator[ent] = creator
				g_entity_created[ent] = str_to_num(created)
				tele_count++
			}
		}
		else
		{
			if (angles[0] == 90.0 && angles[1] == 0.0 && angles[2] == 0.0)
				axis = X;
			else if (angles[0] == 90.0 && angles[1] == 0.0 && angles[2] == 90.0)
				axis = Y;
			else
				axis = Z;
			
			ent = create_block(0, block_type, origin, block_size, axis)
			if (ent)
			{
				g_entity_creator[ent] = creator
				g_entity_created[ent] = str_to_num(created)
				block_count++
			}
		}*/
	}
	if (file) fclose(file)
	
	if (id)
	{
		new build[10]
		ArrayGetString(g_builds, g_current_build, build, charsmax(build))
		
		client_printc(0, "^x04[BM] %s^x01 loaded^x04 %d^x01 block%s. Total entities in map:^x04 %d^x01. Build:^4 %s^1.", g_playername[id], block_count, (block_count == 1) ? "" : "s", entity_count(), (build[0] ? build : "Default"))
	}
}

load_builds(id = 0)
{
	new dir = open_dir(g_savedir, "", 0)
	if (!dir) return;
	
	ArrayClear(g_builds)
	ArrayPushString(g_builds, "")
	
	new filename[64], len, map[33], build[10]
	
	while (next_file(dir, filename, charsmax(filename)))
	{
		// Get filename length
		len = strlen(filename)
		
		// Skip if not valid
		if (filename[0] == '.' || !equal(filename[len - 3], ".bm"))
			continue;
		
		// Remove file extension
		copy(filename[len - 3], charsmax(filename), "")
		
		// Parse file
		strtok(filename, map, charsmax(map), build, charsmax(build), '.')
		
		// Skip if not current map
		if (!equal(g_mapname, map))
			continue;
		
		// No build specified, assume it's default
		if (!build[0])
			continue;
		
		// Add build to the array
		ArrayPushString(g_builds, build)
	}
	
	close_dir(dir)
	
	// Random build
	if (!id) set_current_build(random(ArraySize(g_builds)))
}

set_current_build(build)
{
	// Set build
	g_current_build = build
	
	// Format file path
	static build[10]
	ArrayGetString(g_builds, g_current_build, build, charsmax(build))
	formatex(g_savefile, charsmax(g_savefile), "%s/%s%s%s.bm", g_savedir, g_mapname, (build[0] ? "." : ""), build)
}

delete_all(id = 0, notify = false)
{
	static ent
	new block_count, tele_count
	
	ent = -1
	while ((ent = find_ent_by_class(ent, BLOCK_CLASSNAME)))
	{
		if (!is_valid_ent(ent))
			continue;
		
		if (delete_block(ent))
			block_count++
	}
	
	ent = -1
	while ((ent = find_ent_by_class(ent, TELEPORT_START_CLASSNAME)))
	{
		if (!is_valid_ent(ent))
			continue;
		
		if (delete_teleport(id, ent))
			tele_count++
	}
	
	if (notify && id)
	{
		client_printc(0, "^x04[BM] %s^x01 deleted^x04 %d^x01 block%s^x01 and^x04 %d^x01 teleport%s from the map!", g_playername[id], block_count, (block_count == 1) ? "" : "s", tele_count, (tele_count == 1) ? "" : "s")
	}
}

delete_block_by_aim(id)
{
	static ent, body
	get_user_aiming(id, ent, body)
	
	if (!is_valid_ent(ent))
		return;
	
	if (!is_entity_block(ent))
		return;
	
	static grabber, grouper
	grabber = entity_get_int(ent, EV_INT_iuser2)
	grouper = entity_get_int(ent, EV_INT_iuser1)
	
	if (grabber || (g_isconnected[grouper] && grouper != id && !access(id, g_access_flag[ACCESS_BUILDING_MODE])))
		return;
	
	if (g_grouped_block_count[id] > 1 && is_block_in_group(ent, id))
	{
		static block
		
		for (new i; i < MAX_GROUPED_BLOCKS; i++)
		{
			block = g_grouped_blocks[id][i]
			
			if (block == 0 || !is_valid_ent(block) || !is_entity_block(block))
				continue;
			
			delete_block(block)
		}
	}
	else
		delete_block(ent)
}

delete_block(ent)
{
	if (entity_get_int(ent, EV_INT_iuser1))
		ungroup_block(ent)
	
	remove_entity(ent)
	return true;
}

is_entity_block(ent, classname[32] = "")
{
	if (!classname[0])
		entity_get_string(ent, EV_SZ_classname, classname, charsmax(classname))
	
	if (!equal(classname, BLOCK_CLASSNAME))
		return false;
	
	return true;
}

reset_vars(id, resetall = 0)
{
	g_no_fall_damage[id] = false
	g_low_gravity[id] = 0
	g_next_damage_time[id] = 0.0
	g_honey[id] = 0
	g_ice[id] = 0
	g_boots_of_speed[id] = 0
	g_boots_of_speed_end[id] = 0.0
	g_camouflage[id] = 0
	g_camouflage_end[id] = 0.0
	g_stealth[id] = 0
	g_stealth_end[id] = 0.0
	g_magic_carpet[id] = 0
	g_magic_carpet_end[id] = 0.0
	g_invincibility[id] = 0
	g_invincibility_end[id] = 0.0
	g_last_hud_text[id] = 0.0
	g_last_hud_remaining_text[id] = 0.0
	g_has_hud_text[id] = false
	
	remove_task(TASK_HONEY+id)
	remove_task(TASK_ICE+id)
	remove_task(TASK_NOSLOWDOWN+id)
	remove_task(TASK_BOOTS_OF_SPEED+id)
	remove_task(TASK_CAMOUFLAGE+id)
	
	if (resetall)
	{
		g_block_type[id] = BLOCK_PLATFORM
		g_block_size[id] = BLOCK_SIZE_NORMAL
		g_option_snapping[id] = 1
		g_option_snapping_gap[id] = 0
		g_option_pushpull_speed[id] = 4
		g_option_grid_size[id] = 1
		g_teleport_start[id] = 0
		g_selected_block[id] = 0
		g_grabbed[id] = 0
		g_auto_group_new_blocks[id] = false
		g_given_access[id] = false
		
		// Generate random color for grouping blocks
		static color_to_max
		color_to_max = random(3)
		g_grouped_block_color[id][color_to_max] = 255 // Set at least one color field to maximum, otherwise there'd be a chance for a transparent color
		
		// Then randomly fill the 2 other color fields
		for (new i; i < 3; i++)
			if (i != color_to_max)
				g_grouped_block_color[id][i] = random(128)
	}
}

get_block_size(ent)
{
	static Float:max_sizes[3], Float:max_size
	entity_get_vector(ent, EV_VEC_maxs, max_sizes)
	max_size = max_sizes[0] + max_sizes[1] + max_sizes[2]
	
	if (max_size > 300.0)
		return BLOCK_SIZE_JUMBO;
	else if (max_size > 128.0)
		return BLOCK_SIZE_LARGE;
	else if (max_size > 64.0)
		return BLOCK_SIZE_NORMAL;
	else if (max_size > 36.0)
		return BLOCK_SIZE_POLE;
	
	return BLOCK_SIZE_SMALL;
}

/*================================================================================
 [Stocks]
=================================================================================*/

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
		for (player = 1; player <= g_maxplayers; player++)
		{
			// Not connected
			if (!g_isconnected[player])
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
		/*
		// Not needed since you should set the ML argument
		// to the player's id for a targeted print message
		
		// Replace LANG_PLAYER with player id
		for (i = 2; i < argscount; i++)
		{
			if (getarg(i) == LANG_PLAYER)
				setarg(i, 0, target)
		}
		*/
		
		// Format message for player
		vformat(buffer, charsmax(buffer), message, 3)
		
		// Send it
		message_begin(MSG_ONE, g_msgSayText, _, target)
		write_byte(target)
		write_string(buffer)
		message_end()
	}
}

// Get User Team
stock fm_cs_get_user_team(id)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return FM_CS_TEAM_UNASSIGNED;
	
	return get_pdata_int(id, OFFSET_CSTEAMS, OFFSET_LINUX);
}

/*
stock intersects(ent1, ent2)
{
	static Float:minsa[3], Float:maxsa[3]
	entity_get_vector(ent1, EV_VEC_absmin, minsa)
	entity_get_vector(ent1, EV_VEC_absmax, maxsa)
	static Float:minsb[3], Float:maxsb[3]
	entity_get_vector(ent2, EV_VEC_absmin, minsb)
	entity_get_vector(ent2, EV_VEC_absmin, maxsb)
	
	if (minsb[0] > maxsa[0] ||
		minsb[1] > maxsa[1] ||
		minsb[2] > maxsa[2] ||
		maxsb[0] < minsa[0] ||
		maxsb[1] < minsa[1] ||
		maxsb[2] < minsa[2])
		return false;
	
	return true;
}
*/

stock is_stuck(id)
{
	static Float:originF[3], hull
	entity_get_vector(id, EV_VEC_origin, originF)
	hull = (entity_get_int(id, EV_INT_flags) & FL_DUCKING) ? HULL_HEAD : HULL_HUMAN
	
	static tr
	engfunc(EngFunc_TraceHull, originF, originF, 0, hull, id, tr)
	
	if (!get_tr2(tr, TR_StartSolid) || !get_tr2(tr, TR_AllSolid))
		return false;
	
	return true;
}

stock Float:fix_float(const Float:number, const Float:placeToFix)
{
    return (float(floatround(number / placeToFix)) * placeToFix);
}

// calculate pev->velocity and pev->nextthink to reach vecDest from
// pev->origin traveling at flSpeed
stock LinearMove(ent, Float:vecDest[3], Float:flSpeed)
{
	g_final_destination[ent][0] = vecDest[0]
	g_final_destination[ent][1] = vecDest[1]
	g_final_destination[ent][2] = vecDest[2]
	
	// Get entity's origin
	static Float:originF[3]
	entity_get_vector(ent, EV_VEC_origin, originF)
	
	// Already there?
	if (vecDest[0] == originF[0] && vecDest[1] == originF[1] && vecDest[2] == originF[2])
	{
		LinearMoveDone(ent);
		return;
	}
	
	// set destdelta to the vector needed to move
	static Float:vecDestDelta[3]
	vecDestDelta[0] = vecDest[0] - originF[0]
	vecDestDelta[1] = vecDest[1] - originF[1]
	vecDestDelta[2] = vecDest[2] - originF[2]
	
	// divide vector length by speed to get time to reach dest
	static Float:flTravelTime
	flTravelTime = floatdiv(GetVectorLength(vecDestDelta), flSpeed)
	
	// scale the destdelta vector by the time spent traveling to get velocity
	static Float:velocity[3]
	velocity[0] = floatdiv(vecDestDelta[0], flTravelTime)
	velocity[1] = floatdiv(vecDestDelta[1], flTravelTime)
	velocity[2] = floatdiv(vecDestDelta[2], flTravelTime)
	entity_set_vector(ent, EV_VEC_velocity, velocity)
	
	// set nextthink to trigger a call to LinearMoveDone when dest is reached
	set_block_nextthink(ent, THINK_TYPE_MOVING, (get_gametime() + flTravelTime))
	
	
	//client_print(0, print_chat, "--------")
	//client_print(0, print_chat, "flTravelTime = %f    ; Z = %f", flTravelTime, originF[2])
	
	//server_print("--------")
	//server_print("flTravelTime = %f    ; Z = %f", flTravelTime, originF[2])
	
}

stock Float:GetVectorLength(Float:vector[3])
{
	return floatsqroot(vector[0]*vector[0] + vector[1]*vector[1] + vector[2]*vector[2])
}

stock Float:LinearMoveDone(ent)
{
	entity_set_origin(ent, g_final_destination[ent])
	entity_set_vector(ent, EV_VEC_velocity, Float:{0.0, 0.0, 0.0})
	//entity_set_float(ent, EV_FL_nextthink, -1.0)
}
