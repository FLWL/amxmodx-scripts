/*================================================================================
	
		*****************************************************
		************** [Zombie Plague Mod 4.3] **************
		*****************************************************
	
	----------------------
	-*- Licensing Info -*-
	----------------------
	
	Zombie Plague Mod
	Copyright (C) 2008-2009 by MeRcyLeZZ
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
	In addition, as a special exception, the author gives permission to
	link the code of this program with the Half-Life Game Engine ("HL
	Engine") and Modified Game Libraries ("MODs") developed by Valve,
	L.L.C ("Valve"). You must obey the GNU General Public License in all
	respects for all of the code used other than the HL Engine and MODs
	from Valve. If you modify this file, you may extend this exception
	to your version of the file, but you are not obligated to do so. If
	you do not wish to do so, delete this exception statement from your
	version.
	
	-------------------
	-*- Description -*-
	-------------------
	
	Zombie Plague is a Counter-Strike server side modification, developed as
	an AMX Mod X plugin, which completely revamps the gameplay, turning the
	game into an intense "Humans vs Zombies" survival experience.
	
	Even though it's strongly based on the classic zombie infection mods, it
	takes the concept to a new level by introducing:
	
	* New Gameplay Modes: Nemesis, Survivor, Multi Infection, Swarm, Plague
	* Zombie Classes System: allows addding unlimited custom zombie classes
	* Ammo Packs: awarded to skilled players, can be exchanged for goods
	* Extra Items System: allows adding unlimited custom items to buy
	* Custom Grenades: Napalms, Frost Nades, Flares, and Infection Bombs
	* Deathmatch Mode: where zombies or humans can continually respawn
	* Admin Menus: to easily perform the included console commands
	* Special Effects: from the HL Engine, such as dynamic lighting and fog
	
	There is plenty of customization as well, which enables you to create
	several different styles of gameplay. You can:
	
	* Set zombies and humans' health, speed, models, rewards, and more
	* Toggle unlimited ammo and adjustable knockback for weapons
	* Separately enable and customize the new gameplay modes to your liking
	* Change overall map lighting (lightnings available for the dark settings)
	* Set different colors and sizes for flashlight and nightvision
	* Toggle leap (long jumping) and pain shock free (no damage slowdowns)
	* Toggle various infection effects, such as sparks and screen shakes
	* Enable random spawning (CSDM-spawn friendly)
	* Replace sounds or add some background themes
	* And many more...
	
	-------------
	-*- Media -*-
	-------------
	
	* Gameplay Video 1: http://www.youtube.com/watch?v=HFUyF7-_uzw
	* Gameplay Video 2: http://www.youtube.com/watch?v=XByif6Mti-w
	
	--------------------
	-*- Requirements -*-
	--------------------
	
	* Mods: Counter-Strike 1.6 or Condition-Zero
	* AMXX: Version 1.8.0 or later
	
	--------------------
	-*- Installation -*-
	--------------------
	
	Extract the contents from the .zip file to your server's mod directory
	("cstrike" or "czero"). Make sure to keep folder structure.
	
	-----------------------
	-*- Official Forums -*-
	-----------------------
	
	For the official Zombie Plague forums visit:
	http://forums.alliedmods.net/forumdisplay.php?f=126
	
	There you can:
	
	* Get the latest releases and early betas
	* Discuss new features and suggestions
	* Share sub-plugins (expansions) for the mod
	* Find the support and help you need
	* Report any bugs you might find
	* And all that sort of stuff...
	
	-------------------------------
	-*- CVARS and Customization -*-
	-------------------------------
	
	For a complete and in-depth cvar list, look at the zombieplague.cfg file
	located in the amxmodx\configs directory.
	
	Additionally, you can change player models, sounds, weather effects,
	and some other stuff from the configuration file zombieplague.ini.
	
	As for editing attributes of zombie classes or custom extra items, you'll
	find a zp_zombieclasses.ini and zp_extraitems.ini. These files will be
	automatically updated as you install new custom classes or items with
	new entries for you to edit conveniently.
	
	---------------
	-*- History -*-
	---------------
	
	This project started back on late 2007, when the free infection mods
	around were quite buggy and I wanted to make one on my own. With little
	to no experience at AMXX scripting, I had to start from the very scratch.
	
	Not after spending over a week looking at many plugins (mainly Zombie
	Swarm) and scarce tutorials, I somehow managed to have all the basic
	stuff working quite well (even though the code was a real mess). The
	following months were spent polishing things up and trying to fulfill
	new original ideas, most of them quite worth the hard work.
	
	In the meantime, I got the chance to try the plugin out on a 32 man
	server. This meant a huge progress on development, and after lots of
	testing and bug fixing, the mod turned out to be more than the simple
	infection plugin I had originally planned it to be.
	
	The project has come a long way since, and I'm glad to say I'm finally
	making it freely available. All I'm asking in return is to keep my
	name in the plugin.
	
	-Enjoy!
	
	----------------------
	-*- Infection Mode -*-
	----------------------
	
	On every round players start out as humans, equip themselves with a few
	weapons and grenades, and head to the closest cover they find, knowing
	that one of them is infected with the T-Virus, and will suddenly turn
	into a vicious brain eating creature.
	
	Only little time after, the battle for survival begins. The first zombie
	has to infect as many humans as possible to cluster a numerous zombie
	horde and take over the world.
	
	Maps are set in the dark by default. Humans must use flashlights to light
	their way and spot any enemies. Zombies, on the other hand, have night
	vision but can only attack melee.
	
	--------------------------
	-*- New Gameplay Modes -*-
	--------------------------
	
	* Nemesis:
	   The first zombie may turn into a Nemesis, a powerful fast-moving
	   beast. His goal is to kill every human while sustaining the gunfire.
	
	* Survivor:
	   Everyone became a zombie except him. The survivor gets a machinegun
	   with unlimited ammo and has to stop the never-ending army of undead.
	
	* Multiple Infection:
	   The round starts with many humans infected, so the remaining players
	   will have to act quickly in order to control the situation.
	
	* Swarm Mode:
	   Half of the players turn into zombies, the rest become immune and
	   cannot be infected. It's a battle to death.
	
	* Plague Mode: [bonus]
	   A full armed Survivor and his soldiers are to face Nemesis and
	   his zombie minions. The future of the world is in their hands.
	
	--------------------
	-*- In-Game Menu -*-
	--------------------
	
	Players can access the mod menu by typing "zpmenu" on chat, or by
	pressing the M ("chooseteam") key. The menu allows players to choose
	their zombie class, buy extra items, get unstuck, or see the ingame
	help. Admins will find an additional option to easily perform all
	console commands.
	
	----------------------
	-*- Admin Commands -*-
	----------------------
	
	The following console commands are available:
	
	* zp_zombie <target> - Turn someone into a Zombie
	* zp_human <target> - Turn someone back to Human
	* zp_nemesis <target> - Turn someone into a Nemesis
	* zp_survivor <target> - Turn someone into a Survivor
	* zp_respawn <target> - Respawn someone
	* zp_swarm - Start Swarm Mode (*)
	* zp_multi - Start Multi Infection (*)
	* zp_plague - Start Plague Mode (*)
	
	(*) - These commands can only be used at round start, that is, when the
	T-Virus notice is shown on screen. 
	
	------------------
	-*- Plugin API -*-
	------------------
	
	From version 3.6, some natives and forwards have been added to ease the
	development of sub-plugins, though you may also find them useful to work
	out compatibility issues with existing plugins.
	
	Look for the zombieplague.inc file in your amxmodx\scripting\include
	folder for the full documented list.
	
	----------------------
	-*- Zombie Classes -*-
	----------------------
	
	From version 4.0 it is possible to create and add an unlimited number of
	zombie classes to the main mod. They can be made as separate plugins,
	by using the provided zombie class API, and easily distributed.
	
	By default, five zombie classes are included:
	
	* Classic Zombie: well balanced zombie for beginners.
	* Raptor Zombie: fast moving zombie, but also the weakest.
	* Poison Zombie: light weighed zombie, jumps higher.
	* Big Zombie: slow but strong zombie, with lots of hit points.
	* Leech Zombie: regains additional health when infecting.
	
	-------------------
	-*- Extra Items -*-
	-------------------
	
	From version 4.0 it is possible to add an unlimited number of items
	which can be purchased through the Extra Items menu. All you need
	to do is use the provided item registration natives on your custom
	plugins. You can set the name, the cost in ammo packs, and the team
	the extra item should be available for.
	
	By default there is a number of items already included, listed here:
	
	* Night Vision: makes you able to see in the dark for a single round [Human]
	* T-Virus Antidote: makes you turn back to your human form [Zombie]
	* Zombie Madness: you develop a powerful shield for a short time [Zombie]
	* Infection Bomb: infects anyone within its explosion radius [Zombie]
	
	You are also able to choose some weapons to act as extra items, and change
	ammo packs costs in the customization file (zombieplague.ini).
	
	---------------
	-*- Credits -*-
	---------------
	
	* AMXX Dev Team: for all the hard work which made this possible
	* Imperio LNJ Community: for providing the first server where I
	   could really test the plugin and for everyone's support
	* Mini_Midget: for his Zombie Swarm plugin which I used for reference
	   on earliest stages of development
	* Avalanche: for the random spawning code I got from GunGame and the
	   original Frostnades concept that I ported in here
	* cheap_suit: for some modelchange and knockback codes that I got from
	   Biohazard
	* Simon Logic/ConnorMcLeod: for the Pain Shock Free feature
	* KRoT@L: for some code from Follow the Wounded, used to make the zombie
	   bleeding feature
	* VEN: for Fakemeta Utilities and some useful stocks
	* RaaPuar and Goltark: for the custom grenade models
	* Orangutanz: for finding the precached modelindex offset
	* ML Translations: DKs/nunoabc/DarkMarcos (bp), JahMan/KWo (pl), DA (de),
	   Zombie Lurker (ls), DoPe^ (da), k1nny (fr), NeWbiE' (cz), skymoon (tc),
	   SUPER MATRIX/Shidla/zDemon/4eRT (ru), zsy314 (cn), lOlIl/Seehank (sk),
	   Bridgestone (sv), crazyeffect.net/Mave/Wesley (nl), hleV/aaarnas (lt),
	   darkbad945 (bg), decongamco (vn), beckham9224 (mn), TehGeorge (gr),
	   shadoww_ro/tuty/georgik57/EastSider (ro)
	* Beta testers: for all the feedback, bug reports, and suggestions which
	   constantly help improve this mod further
	* And to all zombie-mod supporters out there!
	
	-----------------
	-*- Changelog -*-
	-----------------
	
	* v1.0: (Dec 2007)
	   - First Release: most of the basic stuff done.
	   - Added: random spawning, HP display on hud, lighting setting,
	      simple buy menu, custom nightvision, admin commands, Nemesis
	      and Survivor modes, glow and leap settings for them.
	
	* v2.2: (Jan 2008)
	   - Added: zombie classes, ammo packs system, buying ammo for weapons,
	      custom flashlight, admin skins setting, zombieplague.cfg file
	   - Upgraded: weapons menu improved, flashlight and nightvision colors
	      now customizable, HamSandwich module used to handle damage.
	   - Fixed various bugs.
	
	* v3.0: (Mar 2008)
	   - Added: door removal setting, unstuck feature, human cvars, armor
	      cvar for zombies, weapon knockback, zombie bleeding, flares,
	      extra items (weapons, antidote, infection bomb), pain shock
	      free setting, Multiple Infection and Swarm modes.
	   - Upgraded: dumped Engine, Fun and Cstrike modules, code optimized,
	      new model change method, new gfx effects for zombie infections.
	   - Fixed a bunch of gameplay bugs.
	
	* v3.5: (May 2008)
	   - Added: deathmatch setting with spawn protection, unlimited ammo
	      setting, fire and frost grenades, additional customization cvars,
	      new extra items, help menu.
	   - Upgraded: better objectives removal method, dropped weapons now
	      keep their bpammo, code optimized a lot.
	   - Fixed: no more game commencing bug when last zombie/human leaves,
	      no more hegrenade infection bug, reduced svc_bad errors, and
	      many more.
	
	* v3.6: (Jun 2008)
	   - Added: a few natives and forwards for sub-plugins support,
	      zombie classes can now have their own models, additional
	      knockback customization, bot support, various CVARs.
	   - Upgraded: extra items now supporting grenades and pistols, changed
	      bomb removal method, players can join on survivor/swarm rounds,
	      extended lightnings support to other dark settings.
	   - Fixed: a bunch of minor bugs, and a server crash with CZ bots.
	
	* v4.0: (Aug 2008)
	   - Added: new gameplay mode (Plague Mode), option to remember weapon
	      selection, command to enable/disable the plugin, more CVARs.
	   - Upgraded: redid all the menus, extra items and zombie classes now
	      support external additions, survivor can now have its own model,
	      upgraded model changing method.
	   - Fixed: some bugs with bots, win sounds not being precached.
	
	* v4.1: (Oct 2008)
	   - Added: more CVARs, more customization, more natives, custom
	      leap system, admin zombie models support, and more.
	   - Upgraded: custom grenades compatible with Nade Modes, ambience
	      sounds specific game mode support, optimized bandwidth usage
	      for temp ents, admin commands logged with IP and SteamID.
	   - Fixed: lots of bugs (some minor, some not)
	
	* v4.2: (Feb 2009)
	   - Added various CVARs for customization, improved prevention of
	      svc_bad in some cases, optimized ammo handling code.
	   - Fixed server crash with 'msg 35 has not been sent yet' error,
	      fixed client overflow issues with ambience sounds, resolved
	      many gameplay bugs.
	
	* v4.3: (Apr 2009)
	   - Customization settings can now be edited through external files,
	      added support for global and multiple random zombie models,
	      added even more CVARs for tweaking stuff, extended admin commands'
	      functionality, greatly extended API capabilities, implemented a
	      more efficient Pain Shock Free code, reworked some menus.
	   - Fixed pretty much all reported bugs to the date.
	
=================================================================================*/

/*================================================================================
 [Plugin Customization]
=================================================================================*/

// All customization settings have been moved
// to external files to allow easier editing
new const ZP_CUSTOMIZATION_FILE[] = "zombieplague.ini"
new const ZP_EXTRAITEMS_FILE[] = "zp_extraitems.ini"

// Limiters for stuff not worth making dynamic arrays out of (increase if needed)
const MAX_CSDM_SPAWNS = 128
const MAX_STATS_SAVED = 64

// HUD msg colors
const HUD_ZOMBIES_RED = 200
const HUD_ZOMBIES_GREEN = 250
const HUD_ZOMBIES_BLUE = 0
const HUD_HUMANS_RED = 30
const HUD_HUMANS_GREEN = 144
const HUD_HUMANS_BLUE = 255

/*================================================================================
 Customization ends here! Yes, that's it. Editing anything beyond
 here is not officially supported. Proceed at your own risk...
=================================================================================*/

#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <fakemeta>
#include <hamsandwich>
#include <engine>
#include <fun>
#include <xs>
#include <sqlx>
#include <time>

#include <dhudmessage>

#pragma dynamic 131072

/*================================================================================
 [Constants, Offsets, Macros]
=================================================================================*/

// Plugin Version
new const PLUGIN_VERSION[] = "4.3 Fix5a"

// Customization file sections
enum
{
	SECTION_NONE = 0,
	SECTION_ACCESS_FLAGS,
	SECTION_PLAYER_MODELS,
	SECTION_WEAPON_MODELS,
	SECTION_GRENADE_SPRITES,
	SECTION_SOUNDS,
	SECTION_AMBIENCE_SOUNDS,
	SECTION_HARD_CODED_ITEMS_COSTS,
	SECTION_WEATHER_EFFECTS,
	SECTION_SKY,
	SECTION_ZOMBIE_DECALS,
	SECTION_KNOCKBACK,
	SECTION_OBJECTIVE_ENTS,
	SECTION_SVC_BAD
}

// Access flags
enum
{
	ACCESS_ENABLE_MOD = 0,
	ACCESS_ADMIN_MENU,
	ACCESS_MODE_INFECTION,
	ACCESS_MODE_NEMESIS,
	ACCESS_MODE_SURVIVOR,
	ACCESS_MODE_SWARM,
	ACCESS_MODE_MULTI,
	ACCESS_MODE_PLAGUE,
	ACCESS_MODE_ARMAGEDDON,
	ACCESS_MODE_VIP,
	ACCESS_MAKE_ZOMBIE,
	ACCESS_MAKE_HUMAN,
	ACCESS_MAKE_NEMESIS,
	ACCESS_MAKE_SURVIVOR,
	ACCESS_RESPAWN_PLAYERS,
	ACCESS_ADMIN_MODELS,
	MAX_ACCESS_FLAGS
}

// Task offsets
enum (+= 100)
{
	TASK_MODEL = 2000,
	TASK_TEAM,
	TASK_SPAWN,
	TASK_BLOOD,
	TASK_AURA,
	TASK_BURN,
	TASK_FREEZE,
	TASK_FLASH,
	TASK_CHARGE,
	TASK_SHOWHUD,
	TASK_MAKEZOMBIE,
	TASK_WELCOMEMSG,
	TASK_AMBIENCESOUNDS,
	TASK_JOINSPAWN,
	TASK_MINUTENEMESIS
}

// IDs inside tasks
#define ID_MODEL (taskid - TASK_MODEL)
#define ID_TEAM (taskid - TASK_TEAM)
#define ID_SPAWN (taskid - TASK_SPAWN)
#define ID_BLOOD (taskid - TASK_BLOOD)
#define ID_AURA (taskid - TASK_AURA)
#define ID_BURN (taskid - TASK_BURN)
#define ID_FREEZE (taskid - TASK_FREEZE)
#define ID_FLASH (taskid - TASK_FLASH)
#define ID_CHARGE (taskid - TASK_CHARGE)
#define ID_SHOWHUD (taskid - TASK_SHOWHUD)

// BP Ammo Refill task
#define REFILL_WEAPONID args[0]

// For player list menu handlers
#define PL_ACTION g_menu_data[id][0]

// For remembering menu pages
#define MENU_PAGE_ZCLASS g_menu_data[id][5]
#define MENU_PAGE_EXTRAS g_menu_data[id][6]
#define MENU_PAGE_PLAYERS g_menu_data[id][7]
#define MENU_PAGE_HCLASS g_menu_data[id][8]
#define MENU_PAGE_UPGRADE g_menu_data[id][9]

// Menu selections
const MENU_KEY_AUTOSELECT = 7
const MENU_KEY_BACK = 7
const MENU_KEY_NEXT = 8
const MENU_KEY_EXIT = 9

// Hard coded extra items
enum
{
	EXTRA_NVISION = 0,
	EXTRA_ANTIDOTE,
	EXTRA_MADNESS,
	EXTRA_INFBOMB,
	EXTRA_NAPALMGRENADE,
	EXTRA_FROSTGRENADE,
	EXTRA_FLARE,
	EXTRA_HEGRENADE,
	EXTRA_MOLOTOV,
	EXTRA_CUTTER,
	EXTRA_FORCEFIELD,
	EXTRA_KBBOMB,
	EXTRAS_CUSTOM_STARTID
}

// Game modes
enum
{
	MODE_NONE = 0,
	MODE_INFECTION,
	MODE_NEMESIS,
	MODE_SURVIVOR,
	MODE_SWARM,
	MODE_MULTI,
	MODE_PLAGUE,
	MODE_ARMAGEDDON,
	MODE_VIP
}

// ZP Teams
const ZP_TEAM_NO_ONE = 0
const ZP_TEAM_ANY = 0
const ZP_TEAM_ZOMBIE = (1<<0)
const ZP_TEAM_HUMAN = (1<<1)
const ZP_TEAM_NEMESIS = (1<<2)
const ZP_TEAM_SURVIVOR = (1<<3)
new const ZP_TEAM_NAMES[][] = { "ZOMBIE , HUMAN", "ZOMBIE", "HUMAN", "ZOMBIE , HUMAN", "NEMESIS",
			"ZOMBIE , NEMESIS", "HUMAN , NEMESIS", "ZOMBIE , HUMAN , NEMESIS",
			"SURVIVOR", "ZOMBIE , SURVIVOR", "HUMAN , SURVIVOR", "ZOMBIE , HUMAN , SURVIVOR",
			"NEMESIS , SURVIVOR", "ZOMBIE , NEMESIS , SURVIVOR", "HUMAN, NEMESIS, SURVIVOR",
			"ZOMBIE , HUMAN , NEMESIS , SURVIVOR" }

// Zombie classes
const ZCLASS_NONE = -1

// Human classes
const HCLASS_NONE = -1

// HUD messages
const Float:HUD_EVENT_X = -1.0
const Float:HUD_EVENT_Y = 0.17
const Float:HUD_INFECT_X = 0.05
const Float:HUD_INFECT_Y = 0.45
const Float:HUD_SPECT_X = 0.6
const Float:HUD_SPECT_Y = 0.6
const Float:HUD_STATS_X = 0.02
const Float:HUD_STATS_Y = 0.92

// Hack to be able to use Ham_Player_ResetMaxSpeed (by joaquimandrade)
new Ham:Ham_Player_ResetMaxSpeed = Ham_Item_PreFrame

// CS Player PData Offsets (win32)
const PDATA_SAFE = 2
const OFFSET_PAINSHOCK = 108 // ConnorMcLeod
const OFFSET_CSTEAMS = 114
const OFFSET_CSMONEY = 115
const OFFSET_CSMENUCODE = 205
const OFFSET_FLASHLIGHT_BATTERY = 244
const OFFSET_CSDEATHS = 444
const OFFSET_MODELINDEX = 491 // Orangutanz

// CS Player CBase Offsets (win32)
const OFFSET_ACTIVE_ITEM = 373

// CS Weapon CBase Offsets (win32)
const OFFSET_WEAPONOWNER = 41

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds
const OFFSET_LINUX_WEAPONS = 4 // weapon offsets are only 4 steps higher on Linux

// CS Teams
enum
{
	FM_CS_TEAM_UNASSIGNED = 0,
	FM_CS_TEAM_T,
	FM_CS_TEAM_CT,
	FM_CS_TEAM_SPECTATOR
}
new const CS_TEAM_NAMES[][] = { "UNASSIGNED", "TERRORIST", "CT", "SPECTATOR" }

// Some constants
const HIDE_MONEY = (1<<5)
const HIDE_CROSS = (1<<6)
const UNIT_SECOND = (1<<12)
const DMG_HEGRENADE = (1<<24)
const IMPULSE_FLASHLIGHT = 100
const USE_USING = 2
const USE_STOPPED = 0
const STEPTIME_SILENT = 999
const BREAK_GLASS = 0x01
const FFADE_IN = 0x0000
const FFADE_STAYOUT = 0x0004
const PEV_SPEC_TARGET = pev_iuser2

// Max BP ammo for weapons
new const MAXBPAMMO[] = { -1, 52, -1, 90, 1, 32, 1, 100, 90, 1, 120, 100, 100, 90, 90, 90, 100, 120,
			30, 120, 200, 32, 90, 120, 90, 2, 35, 90, 90, -1, 100 }

/*
// Max Clip for weapons
new const MAXCLIP[] = { -1, 13, -1, 10, -1, 7, -1, 30, 30, -1, 30, 20, 25, 30, 35, 25, 12, 20,
			10, 30, 100, 8, 30, 30, 20, -1, 7, 30, 30, -1, 50 } */

// Amount of ammo to give when buying additional clips for weapons
new const BUYAMMO[] = { -1, 13, -1, 30, -1, 8, -1, 12, 30, -1, 30, 50, 12, 30, 30, 30, 12, 30,
			10, 30, 30, 8, 30, 30, 30, -1, 7, 30, 30, -1, 50 }

// Ammo IDs for weapons
new const AMMOID[] = { -1, 9, -1, 2, 12, 5, 14, 6, 4, 13, 10, 7, 6, 4, 4, 4, 6, 10,
			1, 10, 3, 5, 4, 10, 2, 11, 8, 4, 2, -1, 7 }

// Ammo Type Names for weapons
new const AMMOTYPE[][] = { "", "357sig", "", "762nato", "", "buckshot", "", "45acp", "556nato", "", "9mm", "57mm", "45acp",
			"556nato", "556nato", "556nato", "45acp", "9mm", "338magnum", "9mm", "556natobox", "buckshot",
			"556nato", "9mm", "762nato", "", "50ae", "556nato", "762nato", "", "57mm" }

// Weapon IDs for ammo types
new const AMMOWEAPON[] = { 0, CSW_AWP, CSW_SCOUT, CSW_M249, CSW_AUG, CSW_XM1014, CSW_MAC10, CSW_FIVESEVEN, CSW_DEAGLE,
			CSW_P228, CSW_ELITE, CSW_FLASHBANG, CSW_HEGRENADE, CSW_SMOKEGRENADE, CSW_C4 }

// Weapon entity names
new const WEAPONENTNAMES[][] = { "", "weapon_p228", "", "weapon_scout", "weapon_hegrenade", "weapon_xm1014", "weapon_c4", "weapon_mac10",
			"weapon_aug", "weapon_smokegrenade", "weapon_elite", "weapon_fiveseven", "weapon_ump45", "weapon_sg550",
			"weapon_galil", "weapon_famas", "weapon_usp", "weapon_glock18", "weapon_awp", "weapon_mp5navy", "weapon_m249",
			"weapon_m3", "weapon_m4a1", "weapon_tmp", "weapon_g3sg1", "weapon_flashbang", "weapon_deagle", "weapon_sg552",
			"weapon_ak47", "weapon_knife", "weapon_p90" }

// CS sounds
new const sound_flashlight[] = "items/flashlight1.wav"
new const sound_buyammo[] = "items/9mmclip1.wav"
new const sound_armorhit[] = "player/bhit_helmet-1.wav"

// Explosion radius for custom grenades
const Float:NADE_EXPLOSION_RADIUS = 200.0
const Float:NADE_EXPLOSION_DAMAGE = 1000.0
const Float:MOLOTOV_EXPLOSION_RADIUS = 100.0
const Float:NADE_KNOCKBACK_POWER = 800.0

// HACK: pev_ field used to store additional ammo on weapons
const PEV_ADDITIONAL_AMMO = pev_iuser1

// HACK: pev_ field used to store custom nade types and their values
const PEV_NADE_TYPE = pev_flTimeStepSound
const NADE_TYPE_INFECTION = 1111
const NADE_TYPE_NAPALM = 2222
const NADE_TYPE_FROST = 3333
const NADE_TYPE_FLARE = 4444
const NADE_TYPE_HE = 5555
const NADE_TYPE_CUTTER = 6666
const NADE_TYPE_MOLOTOV = 7777
const NADE_TYPE_FORCEFIELD = 8888
const NADE_TYPE_KBBOMB = 9999
const PEV_FLARE_COLOR = pev_punchangle
const PEV_NADE_DURATION = pev_flSwimTime

// Weapon bitsums
const PRIMARY_WEAPONS_BIT_SUM = (1<<CSW_SCOUT)|(1<<CSW_XM1014)|(1<<CSW_MAC10)|(1<<CSW_AUG)|(1<<CSW_UMP45)|(1<<CSW_SG550)|(1<<CSW_GALIL)|(1<<CSW_FAMAS)|(1<<CSW_AWP)|(1<<CSW_MP5NAVY)|(1<<CSW_M249)|(1<<CSW_M3)|(1<<CSW_M4A1)|(1<<CSW_TMP)|(1<<CSW_G3SG1)|(1<<CSW_SG552)|(1<<CSW_AK47)|(1<<CSW_P90)
const SECONDARY_WEAPONS_BIT_SUM = (1<<CSW_P228)|(1<<CSW_ELITE)|(1<<CSW_FIVESEVEN)|(1<<CSW_USP)|(1<<CSW_GLOCK18)|(1<<CSW_DEAGLE)

// Allowed weapons for zombies (added grenades/bomb for sub-plugin support, since they shouldn't be getting them anyway)
const ZOMBIE_ALLOWED_WEAPONS_BITSUM = (1<<CSW_KNIFE)|(1<<CSW_HEGRENADE)|(1<<CSW_FLASHBANG)|(1<<CSW_SMOKEGRENADE)|(1<<CSW_C4)

// Classnames for separate model entities
new const MODEL_ENT_CLASSNAME[] = "player_model"
new const WEAPON_ENT_CLASSNAME[] = "weapon_model"

// Menu keys
const KEYSMENU = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_8|MENU_KEY_9|MENU_KEY_0

// Scoreboard attribs
enum
{
	SCOREATTRIB_ARG_PLAYERID = 1,
	SCOREATTRIB_ARG_FLAGS
}
enum (<<= 1)
{
	SCOREATTRIB_FLAG_NONE = 0,
	SCOREATTRIB_FLAG_DEAD,
	SCOREATTRIB_FLAG_BOMB,
	SCOREATTRIB_FLAG_VIP
}

// Ambience Sounds
enum
{
	AMBIENCE_SOUNDS_INFECTION = 0,
	AMBIENCE_SOUNDS_NEMESIS,
	AMBIENCE_SOUNDS_SURVIVOR,
	AMBIENCE_SOUNDS_SWARM,
	AMBIENCE_SOUNDS_PLAGUE,
	AMBIENCE_SOUNDS_ARMAGEDDON,
	AMBIENCE_SOUNDS_VIP,
	MAX_AMBIENCE_SOUNDS
}

// Admin menu actions
enum
{
	ACTION_ZOMBIEFY_HUMANIZE = 0,
	ACTION_MAKE_NEMESIS,
	ACTION_MAKE_SURVIVOR,
	ACTION_RESPAWN_PLAYER,
	ACTION_MODE_SWARM,
	ACTION_MODE_MULTI,
	ACTION_MODE_PLAGUE,
	ACTION_MODE_ARMAGEDDON,
	ACTION_MODE_VIP
}

// Custom forward return values
const ZP_PLUGIN_HANDLED = 97

// Equipment: Primary Weapons
enum
{
	PRIMARY_AK47 = 0,
	PRIMARY_M4A1,
	PRIMARY_SPAS12,
	PRIMARY_TRG42,
	PRIMARY_DEATHMACHINE,
	MAX_PRIMARY_WEAPONS
}
new const PRIMARY_NAME[][] =
{
	"AK-47 Grenadier",
	"M4A1",
	"Franchi SPAS-12",
	"Sako TRG",
	"Death Machine"
}
new const PRIMARY_LVL[] =
{
	1,
	1,
	1,
	1,
	35
}

// Equipment: Secondary Weapons
enum
{
	SECONDARY_ELDIABLO = 0,
	SECONDARY_G18,
	SECONDARY_DUALINFINITY,
	MAX_SECONDARY_WEAPONS
}
new const SECONDARY_NAME[][] =
{
	"El Diablo",
	"G18",
	"Dual Infinity"
}
new const SECONDARY_LVL[] =
{
	1,
	1,
	1
}

// Equipment: Offensive Grenades
enum
{
	OFFENSIVENADE_NAPALM = 0,
	OFFENSIVENADE_HE,
	OFFENSIVENADE_MOLOTOV,
	OFFENSIVENADE_CUTTER,
	MAX_OFFENSIVE_NADES
}
new const OFFENSIVENADE_NAME[][] =
{
	"Napalm Grenade",
	"HE-Grenade",
	"Molotov Cocktail",
	"Laser Cutter"
}
new const OFFENSIVENADE_LVL[] =
{
	1,
	2,
	6,
	8
}

// Equipment: Defensive Grenades
enum
{
	DEFENSIVENADE_FROST = 0,
	DEFENSIVENADE_FORCEFIELD,
	MAX_DEFENSIVE_NADES
}
new const DEFENSIVENADE_NAME[][] =
{
	"Frost Grenade",
	"Force Field Grenade"
}
new const DEFENSIVENADE_LVL[] =
{
	1,
	45
}

// Equipment: Utility Grenades
enum
{
	UTILITYNADE_FLARE = 0,
	MAX_UTILITY_NADES
}
new const UTILITYNADE_NAME[][] =
{
	"Flare"
}
new const UTILITYNADE_LVL[] =
{
	1
}

// Equipment: Ammo
enum
{
	AMMO_NORMAL = 0,
	AMMO_FROSTBITE,
	AMMO_INCENDIARY,
	AMMO_SILVER,
	AMMO_POISON,
	MAX_AMMO
}
new const AMMO_NAME[][] =
{
	"Standard",
	"Frostbite",
	"Incendiary",
	"Silver",
	"Poison",
	"Electric"
}
new const AMMO_LVL[] =
{
	1,
	30,
	50,
	60,
	65,
	75
}

// Ammunition stacks
const AMMOSTACKS_FROSTBITE = 30
const AMMOSTACKS_INCENDIARY = 15
const AMMOSTACKS_POISON = 10

// Hardcoded upgrades
new const UPGRADE_HUMAN_FLAT_HP[] = "100"
new const UPGRADE_HUMAN_SCALING_HP[] = "200"
new const UPGRADE_ZOMBIE_PERCENT_HP[] = "300"
new const UPGRADE_ZOMBIE_PROTECTOR[] = "400"
new const UPGRADE_HUMAN_EXECUTIONER[] = "500"
new const UPGRADE_HUMAN_BLOODY_BLADE[] = "600"
new const UPGRADE_ZOMBIE_DEADLY_CLAWS[] = "700"
new const UPGRADE_HUMAN_FLAT_ARMOR[] = "101"
new const UPGRADE_HUMAN_SCALING_ARMOR[] = "201"
new const UPGRADE_HUMAN_XTR_COND[] = "800"
new const UPGRADE_HUMAN_PLASMA_CUTTER[] = "900"
new const UPGRADE_ZOMBIE_EXTENDED_CLAWS[] = "701"

// XP scaling
const XP_MODIFIER = 50
const MAX_LEVEL = 100

#define chance(%1) (%1 > random(100)) // %1 = probability

/*================================================================================
 [Global Variables]
=================================================================================*/

// Player vars
new g_zombie[33] // is zombie
new g_nemesis[33] // is nemesis
new g_survivor[33] // is survivor
new g_vip[33] // is vip
new g_firstzombie[33] // is first zombie
new g_lastzombie[33] // is last zombie
new g_lasthuman[33] // is last human
new Float:g_frozen_gravity[33] // store previous gravity when frozen
new g_nodamage[33] // has spawn protection/zombie madness
new g_respawn_as_zombie[33] // should respawn as zombie
new g_nvision[33] // has night vision
new g_nvisionenabled[33] // has night vision turned on
new g_zombieclass[33] // zombie class
new g_zombieclassnext[33] // zombie class for next infection
new g_humanclass[33] // human class
new g_humanclassnext[33] // human class for next spawn
new g_flashlight[33] // has custom flashlight turned on
new g_flashbattery[33] = { 100, ... } // custom flashlight battery
new g_canbuy[33] // is allowed to buy a new weapon through the menu
new g_ammopacks[33] // ammo pack count
new Float:g_lastleaptime[33] // time leap was last used
new Float:g_lastflashtime[33] // time flashlight was last toggled
new g_playermodel[33][32] // current model's short name [player][model]
new g_menu_data[33][10] // data for some menu handlers
new g_ent_playermodel[33] // player model entity
new g_ent_weaponmodel[33] // weapon model entity
new g_burning_duration[33] // burning task duration
new g_freezing_duration[33] // freeze task duration
new g_grenade_slot1[33] // grenade type in slot 1
new g_grenade_slot2[33] // grenade type in slot 2
new g_grenade_slot3[33] // grenade type in slot 3
new g_auth[33][34] // used to load players' stats
new g_putinserver[33] // for calculating playtime
new g_knife[33] // knife
new g_ammo[33] // ammo type
new g_level[33] // player's level
new g_xpneeded[33] // xp needed for next level
new g_viewing_upgrade[33] // player viewing upgrade x
new Trie:g_upgrades[33] // each players' owned upgrades
new g_ammostacks_frostbite[33] // stacks of frostbite applied
new g_ammostacks_incendiary[33] // stacks of incendiary applied
new g_ammostacks_poison[33] // stacks of poison applied

// Player database vars
new g_db_id[33] // player's ID in database
new g_db_primary[33] // player's selected primary weapon
new g_db_secondary[33] // player's selected secondary weapon
new g_db_knife[33] // player's selected knife
new g_db_offensivegrenade[33] // player's selected offensive grenade
new g_db_defensivegrenade[33] // player's selected defensive grenade
new g_db_tacticalgrenade[33] // player's selected tactical grenade
new g_db_special[33] // player's selected special weapon
new g_db_ammo[33] // player's selected ammo type
new g_db_xp[33] // player's XP
new g_db_zombieskilled[33] // amount of zombies killed
new g_db_humansinfected[33] // amount of humans infected
new g_db_roundswon[33] // amount of rounds won

// General database vars
new Handle:g_sql_tuple

// Game vars
new g_pluginenabled // ZP enabled
new g_newround // new round starting
new g_endround // round ended
new g_nemround // nemesis round
new g_survround // survivor round
new g_swarmround // swarm round
new g_plagueround // plague round
new g_vipround // plague round
new g_armageddonround // armageddon round
new g_modestarted // mode fully started
new g_lastmode // last played mode
new g_scorezombies, g_scorehumans, g_gamecommencing // team scores
new g_spawnCount, g_spawnCount2 // available spawn points counter
new Float:g_spawns[MAX_CSDM_SPAWNS][3], Float:g_spawns2[MAX_CSDM_SPAWNS][3] // spawn points data
new Float:g_models_targettime // for adding delays between Model Change messages
new Float:g_teams_targettime // for adding delays between Team Change messages
new g_MsgSync, g_MsgSync2 // message sync objects
new g_trailSpr, g_exploSpr, g_flameSpr, g_smokeSpr, g_glassSpr, g_bloodSpr // sprites
new g_modname[32] // for formatting the mod name
new g_freezetime // whether CS's freeze time is on
new g_maxplayers // max players counter
new g_czero // whether we are running on a CZ server
new g_hamczbots // whether ham forwards are registered for CZ bots
new g_fwSpawn, g_fwPrecacheSound // spawn and precache sound forward handles
new g_infbombcounter, g_antidotecounter, g_madnesscounter // to limit buying some items
new g_arrays_created // to prevent stuff from being registered before initializing arrays
new g_lastplayerleaving // flag for whenever a player leaves and another takes his place
new g_switchingteam // flag for whenever a player's team change emessage is sent
new g_buyzone_ent // custom buyzone entity

new cache_smoke, cache_nade

// Message IDs vars
new g_msgScoreInfo, g_msgNVGToggle, g_msgScoreAttrib, g_msgAmmoPickup, g_msgScreenFade,
g_msgDeathMsg, g_msgSetFOV, g_msgFlashlight, g_msgFlashBat, g_msgTeamInfo, g_msgDamage,
g_msgHideWeapon, g_msgCrosshair, g_msgSayText, g_msgScreenShake, g_msgBattery
/*, g_msgWeaponList */

// Some forward handlers
new g_fwRoundStart, g_fwRoundEnd, g_fwUserInfected_pre, g_fwUserInfected_post,
g_fwUserHumanized_pre, g_fwUserHumanized_post, g_fwUserInfect_attempt,
g_fwUserHumanize_attempt, g_fwExtraItemSelected, g_fwUserUnfrozen,
g_fwUserLastZombie, g_fwUserLastHuman, g_fwDummyResult, g_fwGiveSpecial

new g_fwReplaceWeaponModels, g_fwZombieClassAvailable, g_fwHumanClassAvailable

// Extra Items vars
new Array:g_extraitem_name // caption
new Array:g_extraitem_cost // cost
new Array:g_extraitem_team // team
new g_extraitem_i // loaded extra items counter

// For extra items file parsing
new Array:g_extraitem2_realname, Array:g_extraitem2_name, Array:g_extraitem2_cost,
Array:g_extraitem2_team, Array:g_extraitem_new

// Zombie Classes vars
new Array:g_zclass_name // caption
new Array:g_zclass_info // description
new Array:g_zclass_modelsstart // start position in models array
new Array:g_zclass_modelsend // end position in models array
new Array:g_zclass_playermodel // player models array
new Array:g_zclass_modelindex // model indices array
new Array:g_zclass_clawmodel // claw model
new Array:g_zclass_hp // health
new Array:g_zclass_spd // speed
new Array:g_zclass_grav // gravity
new Array:g_zclass_kb // knockback
new Array:g_zclass_lvl // level needed
new Array:g_zclass_armor // armor
new Array:g_zclass_slashdmg // slash delay
new Array:g_zclass_stabdmg // stab delay
new g_zclass_i // loaded zombie classes counter

// Human Classes vars
new Array:g_hclass_name // caption
new Array:g_hclass_info // description
new Array:g_hclass_modelsstart // start position in models array
new Array:g_hclass_modelsend // end position in models array
new Array:g_hclass_playermodel // player models array
new Array:g_hclass_modelindex // model indices array
new Array:g_hclass_hp // health
new Array:g_hclass_spd // speed
new Array:g_hclass_grav // gravity
new Array:g_hclass_lvl // level needed
new Array:g_hclass_ap // armor
new Array:g_hclass_aprgn // armor regeneration
new g_hclass_i // loaded zombie classes counter

// Equipment Knifes vars
new Array:g_knife_name // caption
new Array:g_knife_vmodel // view model
new Array:g_knife_pmodel // player model
new Array:g_knife_lvl // level needed
new Array:g_knife_slash // slash distance
new Array:g_knife_stab // stab distance
new g_knife_i // loaded knifes counter

// Equipment Special vars
new Array:g_special_name // caption
new Array:g_special_lvl // level needed
new g_special_i // loaded knifes counter

// Upgrade Menu vars
new Array:g_upgrade_name // caption
new Array:g_upgrade_desc // description
new Array:g_upgrade_cost // cost
new Array:g_upgrade_lvl // level needed
new Array:g_upgrade_team // team
new Array:g_upgrade_id // unique identifier
new Array:g_upgrade_avail // unique identifier
new g_upgrade_i

// Customization vars
new g_access_flag[MAX_ACCESS_FLAGS], Array:model_nemesis, Array:model_survivor,
Array:model_admin_zombie, Array:model_vip, Array:g_modelindex_vip,
Array:g_modelindex_nemesis, Array:g_modelindex_survivor,
Array:g_modelindex_admin_zombie, model_vknife_human[64],
model_vknife_nemesis[64], model_grenade_infect[64],
model_grenade_fire[64], model_grenade_frost[64], model_grenade_flare[64],
model_vknife_admin_human[64], model_vknife_admin_zombie[64],
sprite_grenade_trail[64], sprite_grenade_ring[64], sprite_grenade_fire[64],
sprite_grenade_smoke[64], sprite_grenade_glass[64], Array:sound_win_zombies,
Array:sound_win_humans, Array:sound_win_no_one, Array:sound_win_zombies_ismp3,
Array:sound_win_humans_ismp3, Array:sound_win_no_one_ismp3, Array:zombie_infect,
Array:zombie_idle, Array:zombie_pain, Array:nemesis_pain, Array:zombie_die, Array:zombie_fall,
Array:zombie_miss_wall, Array:zombie_hit_normal, Array:zombie_hit_stab, g_ambience_rain,
Array:zombie_idle_last, Array:zombie_madness, Array:sound_nemesis, Array:sound_survivor,
Array:sound_swarm, Array:sound_multi, Array:sound_plague, Array:sound_vip, Array:sound_armageddon, Array:grenade_infect,
Array:grenade_infect_player, Array:grenade_fire, Array:grenade_fire_player,
Array:grenade_frost, Array:grenade_frost_player, Array:grenade_frost_break,
Array:grenade_flare, Array:sound_antidote, g_ambience_sounds[MAX_AMBIENCE_SOUNDS],
Array:sound_ambience1, Array:sound_ambience2, Array:sound_ambience3, Array:sound_ambience4,
Array:sound_ambience5, Array:sound_ambience1_duration, Array:sound_ambience2_duration,
Array:sound_ambience3_duration, Array:sound_ambience4_duration,
Array:sound_ambience5_duration, Array:sound_ambience1_ismp3, Array:sound_ambience2_ismp3,
Array:sound_ambience3_ismp3, Array:sound_ambience4_ismp3, Array:sound_ambience5_ismp3,
Array:sound_ambience6, Array:sound_ambience6_duration, Array:sound_ambience6_ismp3,
Array:sound_ambience7, Array:sound_ambience7_duration, Array:sound_ambience7_ismp3,
g_extra_costs2[EXTRAS_CUSTOM_STARTID],
g_ambience_snow, g_ambience_fog, g_fog_density[10], g_fog_color[12], g_sky_enable,
Array:g_sky_names, Array:zombie_decals, Array:g_objective_ents,
Float:g_modelchange_delay, g_set_modelindex_offset, g_handle_models_on_separate_ent,
Float:kb_weapon_power[31] = { -1.0, ... }, Array:zombie_miss_slash, g_force_consistency,
Array:sound_loading, Array:sound_levelup, Array:sound_none

// CVAR pointers
new cvar_lighting, cvar_zombiefov, cvar_plague, cvar_plaguechance, cvar_zombiefirsthp,
cvar_removemoney, cvar_zombiebonushp, cvar_nemhp, cvar_nem, cvar_surv,
cvar_nemchance, cvar_deathmatch, cvar_nemglow, cvar_hitzones,
cvar_nemgravity, cvar_flashsize,
cvar_survpainfree, cvar_nempainfree, cvar_nemspd, cvar_survchance,
cvar_survhp, cvar_survspd, cvar_swarmchance, cvar_flashdrain,
cvar_zombiebleeding, cvar_removedoors, cvar_customflash, cvar_randspawn, cvar_multi,
cvar_multichance, cvar_infammo, cvar_swarm, cvar_toggle,
cvar_knockbackpower, cvar_freezeduration, cvar_triggered, cvar_flashcharge,
cvar_firegrenades, cvar_frostgrenades, cvar_survgravity, cvar_logcommands, cvar_survglow,
cvar_spawnprotection, cvar_flareduration, cvar_zclasses,
cvar_extraitems, cvar_showactivity, cvar_humanlasthp, cvar_nemignorefrags, cvar_warmup,
cvar_flashdist, cvar_flarecolor, cvar_survignorefrags, cvar_fireduration, cvar_firedamage,
cvar_flaregrenades, cvar_knockbackducking, cvar_knockbackdamage, cvar_knockbackzvel,
cvar_multiratio, cvar_flaresize, cvar_spawndelay, cvar_extraantidote, cvar_extramadness,
cvar_extranvision, cvar_preventconsecutive, cvar_botquota,
cvar_zombiepainfree, cvar_fireslowdown, cvar_survbasehp, cvar_survaura,
cvar_nemaura, cvar_extrainfbomb, cvar_knockback,
cvar_fragsinfect, cvar_fragskill, cvar_humanarmor, cvar_zombiesilent, cvar_removedropped,
cvar_plagueratio, cvar_blocksuicide, cvar_knockbackdist, cvar_nemdamage, cvar_leapzombies,
cvar_leapzombiesforce, cvar_leapzombiesheight, cvar_leapzombiescooldown, cvar_leapnemesis,
cvar_leapnemesisforce, cvar_leapnemesisheight, cvar_leapnemesiscooldown, cvar_leapsurvivor,
cvar_leapsurvivorforce, cvar_leapsurvivorheight, cvar_nemminplayers, cvar_survminplayers,
cvar_respawnonsuicide, cvar_respawnafterlast, cvar_leapsurvivorcooldown,
cvar_swarmminplayers, cvar_multiminplayers, cvar_plagueminplayers,
cvar_adminmodelszombie, cvar_nembasehp, cvar_blockpushables, cvar_respawnworldspawnkill,
cvar_madnessduration, cvar_plaguenemnum, cvar_plaguenemhpmulti, cvar_plaguesurvhpmulti,
cvar_survweapon, cvar_plaguesurvnum, cvar_infectionscreenfade, cvar_infectionscreenshake,
cvar_infectionsparkle, cvar_infectiontracers, cvar_infectionparticles, cvar_infbomblimit,
cvar_allowrespawnsurv, cvar_flashshowall, cvar_allowrespawninfection, cvar_allowrespawnnem,
cvar_allowrespawnswarm, cvar_allowrespawnplague, cvar_survinfammo, cvar_nemknockback,
cvar_flashcolor[3],
cvar_hudicons, cvar_respawnzomb, cvar_respawnhum, cvar_respawnnem, cvar_respawnsurv,
cvar_startammopacks, cvar_antidotelimit, cvar_madnesslimit,
cvar_adminknifemodelszombie, cvar_keephealthondisconnect,
cvar_huddisplay, cvar_freezedamage, cvar_vip, cvar_vipchance, cvar_vipratio, cvar_vipminplayers,
cvar_lightingzombies, cvar_forcefieldtime, cvar_armageddon, cvar_armageddonchance

// Cached stuff for players
new g_isconnected[33] // whether player is connected
new g_isalive[33] // whether player is alive
new g_isbot[33] // whether player is a bot
new g_currentweapon[33] // player's current weapon id
new g_playername[33][32] // player's name
new Float:g_zombie_spd[33] // zombie class speed
new Float:g_zombie_knockback[33] // zombie class knockback
new g_zombie_classname[33][32] // zombie class name
new Float:g_human_spd[33] // zombie class speed
new g_human_classname[33][32] // zombie class name
#define is_user_valid_connected(%1) (1 <= %1 <= g_maxplayers && g_isconnected[%1])
#define is_user_valid_alive(%1) (1 <= %1 <= g_maxplayers && g_isalive[%1])
#define is_user_valid(%1) (1 <= %1 <= g_maxplayers)

// Cached CVARs
new g_cached_customflash, g_cached_zombiesilent, g_cached_leapzombies, g_cached_leapnemesis,
g_cached_leapsurvivor, Float:g_cached_leapzombiescooldown, Float:g_cached_leapnemesiscooldown,
Float:g_cached_leapsurvivorcooldown, g_cached_lighting[2], g_cached_lightingzombies[2]

/*================================================================================
 [Natives, Precache and Init]
=================================================================================*/

public plugin_natives()
{
	// Player specific natives
	register_native("zp_get_user_zombie", "native_get_user_zombie", 1)
	register_native("zp_get_user_nemesis", "native_get_user_nemesis", 1)
	register_native("zp_get_user_survivor", "native_get_user_survivor", 1)
	register_native("zp_get_user_first_zombie", "native_get_user_first_zombie", 1)
	register_native("zp_get_user_last_zombie", "native_get_user_last_zombie", 1)
	register_native("zp_get_user_last_human", "native_get_user_last_human", 1)
	register_native("zp_get_user_zombie_class", "native_get_user_zombie_class", 1)
	register_native("zp_get_user_next_class", "native_get_user_next_class", 1)
	register_native("zp_set_user_zombie_class", "native_set_user_zombie_class", 1)
	register_native("zp_get_user_ammo_packs", "native_get_user_ammo_packs", 1)
	register_native("zp_set_user_ammo_packs", "native_set_user_ammo_packs", 1)
	register_native("zp_get_zombie_maxhealth", "native_get_zombie_maxhealth", 1)
	register_native("zp_get_user_batteries", "native_get_user_batteries", 1)
	register_native("zp_set_user_batteries", "native_set_user_batteries", 1)
	register_native("zp_get_user_nightvision", "native_get_user_nightvision", 1)
	register_native("zp_set_user_nightvision", "native_set_user_nightvision", 1)
	register_native("zp_infect_user", "native_infect_user", 1)
	register_native("zp_disinfect_user", "native_disinfect_user", 1)
	register_native("zp_make_user_nemesis", "native_make_user_nemesis", 1)
	register_native("zp_make_user_survivor", "native_make_user_survivor", 1)
	register_native("zp_respawn_user", "native_respawn_user", 1)
	register_native("zp_force_buy_extra_item", "native_force_buy_extra_item", 1)
	register_native("zp_override_user_model", "native_override_user_model", 1)
	
	// Round natives
	register_native("zp_has_round_started", "native_has_round_started", 1)
	register_native("zp_is_nemesis_round", "native_is_nemesis_round", 1)
	register_native("zp_is_survivor_round", "native_is_survivor_round", 1)
	register_native("zp_is_swarm_round", "native_is_swarm_round", 1)
	register_native("zp_is_plague_round", "native_is_plague_round", 1)
	register_native("zp_get_zombie_count", "native_get_zombie_count", 1)
	register_native("zp_get_human_count", "native_get_human_count", 1)
	register_native("zp_get_nemesis_count", "native_get_nemesis_count", 1)
	register_native("zp_get_survivor_count", "native_get_survivor_count", 1)
	
	// External additions natives
	register_native("zp_register_extra_item", "native_register_extra_item", 1)
	register_native("zp_register_zombie_class", "native_register_zombie_class", 1)
	register_native("zp_get_extra_item_id", "native_get_extra_item_id", 1)
	register_native("zp_get_zombie_class_id", "native_get_zombie_class_id", 1)
	register_native("zp_get_zombie_class_info", "native_get_zombie_class_info", 1)
	
	register_native("zp_register_human_class", "native_register_human_class", 1)
	register_native("zp_get_user_human_class", "native_get_user_human_class", 1)
	register_native("zp_register_knife", "native_register_knife", 1)
	register_native("zp_register_special", "native_register_special", 1)
	register_native("zp_get_user_knife", "native_get_user_knife", 1)
	register_native("zp_register_upgrade", "native_register_upgrade", 1)
	register_native("zp_user_has_upgrade", "native_user_has_upgrade", 1)
	
	register_native("zp_takedamage", "native_takedamage", 1)
	register_native("zp_get_user_frozen", "native_get_user_frozen", 1)
	
	register_native("zp_calculate_zhealth", "native_calculate_zhealth", 1)
	
	register_native("zp_add_xp", "native_add_xp", 1)
}

public plugin_precache()
{
	// Register earlier to show up in plugins list properly after plugin disable/error at loading
	register_plugin("Zombie Plague XP", PLUGIN_VERSION, "MeRcyLeZZ / FLWL")
	
	// To switch plugin on/off
	register_concmd("zp_toggle", "cmd_toggle", _, "<1/0> - Enable/Disable Zombie Plague (will restart the current map)", 0)
	cvar_toggle = register_cvar("zp_on", "1")
	
	// Plugin disabled?
	if (!get_pcvar_num(cvar_toggle)) return;
	g_pluginenabled = true
	
	new i
	
	// Initialize a few dynamically sized arrays (alright, maybe more than just a few...)
	model_nemesis = ArrayCreate(32, 1)
	model_survivor = ArrayCreate(32, 1)
	model_vip = ArrayCreate(32, 1)
	model_admin_zombie = ArrayCreate(32, 1)
	g_modelindex_nemesis = ArrayCreate(1, 1)
	g_modelindex_survivor = ArrayCreate(1, 1)
	g_modelindex_vip = ArrayCreate(1, 1)
	g_modelindex_admin_zombie = ArrayCreate(1, 1)
	sound_win_zombies = ArrayCreate(64, 1)
	sound_win_zombies_ismp3 = ArrayCreate(1, 1)
	sound_win_humans = ArrayCreate(64, 1)
	sound_win_humans_ismp3 = ArrayCreate(1, 1)
	sound_win_no_one = ArrayCreate(64, 1)
	sound_win_no_one_ismp3 = ArrayCreate(1, 1)
	zombie_infect = ArrayCreate(64, 1)
	zombie_pain = ArrayCreate(64, 1)
	nemesis_pain = ArrayCreate(64, 1)
	zombie_die = ArrayCreate(64, 1)
	zombie_fall = ArrayCreate(64, 1)
	zombie_miss_slash = ArrayCreate(64, 1)
	zombie_miss_wall = ArrayCreate(64, 1)
	zombie_hit_normal = ArrayCreate(64, 1)
	zombie_hit_stab = ArrayCreate(64, 1)
	zombie_idle = ArrayCreate(64, 1)
	zombie_idle_last = ArrayCreate(64, 1)
	zombie_madness = ArrayCreate(64, 1)
	sound_none = ArrayCreate(64, 1)
	sound_nemesis = ArrayCreate(64, 1)
	sound_survivor = ArrayCreate(64, 1)
	sound_swarm = ArrayCreate(64, 1)
	sound_multi = ArrayCreate(64, 1)
	sound_plague = ArrayCreate(64, 1)
	sound_vip = ArrayCreate(64, 1)
	sound_armageddon = ArrayCreate(64, 1)
	grenade_infect = ArrayCreate(64, 1)
	grenade_infect_player = ArrayCreate(64, 1)
	grenade_fire = ArrayCreate(64, 1)
	grenade_fire_player = ArrayCreate(64, 1)
	grenade_frost = ArrayCreate(64, 1)
	grenade_frost_player = ArrayCreate(64, 1)
	grenade_frost_break = ArrayCreate(64, 1)
	grenade_flare = ArrayCreate(64, 1)
	sound_antidote = ArrayCreate(64, 1)
	sound_loading = ArrayCreate(64, 1)
	sound_levelup = ArrayCreate(64, 1)
	sound_ambience1 = ArrayCreate(64, 1)
	sound_ambience2 = ArrayCreate(64, 1)
	sound_ambience3 = ArrayCreate(64, 1)
	sound_ambience4 = ArrayCreate(64, 1)
	sound_ambience5 = ArrayCreate(64, 1)
	sound_ambience6 = ArrayCreate(64, 1)
	sound_ambience7 = ArrayCreate(64, 1)
	sound_ambience1_duration = ArrayCreate(1, 1)
	sound_ambience2_duration = ArrayCreate(1, 1)
	sound_ambience3_duration = ArrayCreate(1, 1)
	sound_ambience4_duration = ArrayCreate(1, 1)
	sound_ambience5_duration = ArrayCreate(1, 1)
	sound_ambience6_duration = ArrayCreate(1, 1)
	sound_ambience7_duration = ArrayCreate(1, 1)
	sound_ambience1_ismp3 = ArrayCreate(1, 1)
	sound_ambience2_ismp3 = ArrayCreate(1, 1)
	sound_ambience3_ismp3 = ArrayCreate(1, 1)
	sound_ambience4_ismp3 = ArrayCreate(1, 1)
	sound_ambience5_ismp3 = ArrayCreate(1, 1)
	sound_ambience6_ismp3 = ArrayCreate(1, 1)
	sound_ambience7_ismp3 = ArrayCreate(1, 1)
	g_sky_names = ArrayCreate(32, 1)
	zombie_decals = ArrayCreate(1, 1)
	g_objective_ents = ArrayCreate(32, 1)
	// Extra items
	g_extraitem_name = ArrayCreate(32, 1)
	g_extraitem_cost = ArrayCreate(1, 1)
	g_extraitem_team = ArrayCreate(1, 1)
	g_extraitem2_realname = ArrayCreate(32, 1)
	g_extraitem2_name = ArrayCreate(32, 1)
	g_extraitem2_cost = ArrayCreate(1, 1)
	g_extraitem2_team = ArrayCreate(1, 1)
	g_extraitem_new = ArrayCreate(1, 1)
	// Zombie classes
	g_zclass_name = ArrayCreate(32, 1)
	g_zclass_info = ArrayCreate(64, 1)
	g_zclass_modelsstart = ArrayCreate(1, 1)
	g_zclass_modelsend = ArrayCreate(1, 1)
	g_zclass_playermodel = ArrayCreate(32, 1)
	g_zclass_modelindex = ArrayCreate(1, 1)
	g_zclass_clawmodel = ArrayCreate(64, 1)
	g_zclass_hp = ArrayCreate(1, 1)
	g_zclass_spd = ArrayCreate(1, 1)
	g_zclass_grav = ArrayCreate(1, 1)
	g_zclass_kb = ArrayCreate(1, 1)
	g_zclass_lvl = ArrayCreate(1, 1)
	g_zclass_armor = ArrayCreate(1, 1)
	g_zclass_slashdmg = ArrayCreate(1, 1)
	g_zclass_stabdmg = ArrayCreate(1, 1)
	// Human classes
	g_hclass_name = ArrayCreate(32, 1)
	g_hclass_info = ArrayCreate(64, 1)
	g_hclass_modelsstart = ArrayCreate(1, 1)
	g_hclass_modelsend = ArrayCreate(1, 1)
	g_hclass_playermodel = ArrayCreate(32, 1)
	g_hclass_modelindex = ArrayCreate(1, 1)
	g_hclass_hp = ArrayCreate(1, 1)
	g_hclass_spd = ArrayCreate(1, 1)
	g_hclass_grav = ArrayCreate(1, 1)
	g_hclass_lvl = ArrayCreate(1, 1)
	g_hclass_ap = ArrayCreate(1, 1)
	g_hclass_aprgn = ArrayCreate(1, 1)
	// Equipment: Knife
	g_knife_name = ArrayCreate(32, 1)
	g_knife_vmodel = ArrayCreate(64, 1)
	g_knife_pmodel = ArrayCreate(64, 1)
	g_knife_lvl = ArrayCreate(1, 1)
	g_knife_slash = ArrayCreate(1, 1)
	g_knife_stab = ArrayCreate(1, 1)
	// Equipment: Special
	g_special_name = ArrayCreate(32, 1)
	g_special_lvl = ArrayCreate(1, 1)
	// Upgrades
	g_upgrade_name = ArrayCreate(32, 1)
	g_upgrade_desc = ArrayCreate(128, 1)
	g_upgrade_cost = ArrayCreate(1, 1)
	g_upgrade_lvl = ArrayCreate(1, 1)
	g_upgrade_team = ArrayCreate(16, 1)
	g_upgrade_id = ArrayCreate(11, 1)
	g_upgrade_avail = ArrayCreate(1, 1)
	for (i = 0; i < 33; i++) g_upgrades[i] = TrieCreate()
	
	// Allow registering stuff now
	g_arrays_created = true
	
	// Load customization data
	load_customization_from_files()
	
	new buffer[100]
	
	// Load up the hard coded extra items
	native_register_extra_item2("NightVision", g_extra_costs2[EXTRA_NVISION], ZP_TEAM_HUMAN)
	native_register_extra_item2("T-Virus Antidote", g_extra_costs2[EXTRA_ANTIDOTE], ZP_TEAM_ZOMBIE)
	native_register_extra_item2("Zombie Madness", g_extra_costs2[EXTRA_MADNESS], ZP_TEAM_ZOMBIE)
	native_register_extra_item2("Infection Bomb", g_extra_costs2[EXTRA_INFBOMB], ZP_TEAM_ZOMBIE)
	native_register_extra_item2("Napalm Grenade", g_extra_costs2[EXTRA_NAPALMGRENADE], ZP_TEAM_HUMAN)
	native_register_extra_item2("Frost Grenade", g_extra_costs2[EXTRA_FROSTGRENADE], ZP_TEAM_HUMAN)
	native_register_extra_item2("Flare", g_extra_costs2[EXTRA_FLARE], ZP_TEAM_HUMAN)
	native_register_extra_item2("HE Grenade", g_extra_costs2[EXTRA_HEGRENADE], ZP_TEAM_HUMAN)
	native_register_extra_item2("Molotov Cocktail", g_extra_costs2[EXTRA_MOLOTOV], ZP_TEAM_HUMAN)
	native_register_extra_item2("Laser Cutter", g_extra_costs2[EXTRA_CUTTER], ZP_TEAM_HUMAN)
	native_register_extra_item2("Force Field Grenade", g_extra_costs2[EXTRA_FORCEFIELD], ZP_TEAM_HUMAN)
	native_register_extra_item2("Knockback Bomb", g_extra_costs2[EXTRA_KBBOMB], ZP_TEAM_ZOMBIE)
	
	// Load up default knife
	ArrayPushString(g_knife_name, "Seal Knife")
	ArrayPushString(g_knife_vmodel, "models/v_knife.mdl")
	ArrayPushString(g_knife_pmodel, "models/p_knife.mdl")
	ArrayPushCell(g_knife_lvl, 1)
	ArrayPushCell(g_knife_slash, 48.0)
	ArrayPushCell(g_knife_stab, 32.0)
	g_knife_i++
	
	// Load up default special: defusal kit
	ArrayPushString(g_special_name, "Defusal Kit")
	ArrayPushCell(g_special_lvl, 1)
	g_special_i++
	
	// Human Flat HP
	ArrayPushString(g_upgrade_name, "Flat HP")
	ArrayPushString(g_upgrade_desc, "+10 health")
	ArrayPushCell(g_upgrade_cost, 80)
	ArrayPushCell(g_upgrade_lvl, 1)
	ArrayPushString(g_upgrade_team, "Human")
	ArrayPushString(g_upgrade_id, UPGRADE_HUMAN_FLAT_HP)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Human Scaling HP
	ArrayPushString(g_upgrade_name, "Scaling HP")
	ArrayPushString(g_upgrade_desc, "+0.5 health per level")
	ArrayPushCell(g_upgrade_cost, 90)
	ArrayPushCell(g_upgrade_lvl, 1)
	ArrayPushString(g_upgrade_team, "Human")
	ArrayPushString(g_upgrade_id, UPGRADE_HUMAN_SCALING_HP)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Zombie Percent HP
	ArrayPushString(g_upgrade_name, "Percent HP")
	ArrayPushString(g_upgrade_desc, "Maximum health increased by 20%")
	ArrayPushCell(g_upgrade_cost, 150)
	ArrayPushCell(g_upgrade_lvl, 1)
	ArrayPushString(g_upgrade_team, "Zombie")
	ArrayPushString(g_upgrade_id, UPGRADE_ZOMBIE_PERCENT_HP)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Zombie Protector
	ArrayPushString(g_upgrade_name, "Protector")
	ArrayPushString(g_upgrade_desc, "Reduces incoming damage by 10% while below 50% health.")
	ArrayPushCell(g_upgrade_cost, 100)
	ArrayPushCell(g_upgrade_lvl, 5)
	ArrayPushString(g_upgrade_team, "Zombie")
	ArrayPushString(g_upgrade_id, UPGRADE_ZOMBIE_PROTECTOR)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Human Executioner
	ArrayPushString(g_upgrade_name, "Executioner")
	ArrayPushString(g_upgrade_desc, "Increases damage dealt by 10% to zombies below 40% health.")
	ArrayPushCell(g_upgrade_cost, 160)
	ArrayPushCell(g_upgrade_lvl, 5)
	ArrayPushString(g_upgrade_team, "Human")
	ArrayPushString(g_upgrade_id, UPGRADE_HUMAN_EXECUTIONER)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Human Bloody Blade
	ArrayPushString(g_upgrade_name, "Bloody Blade")
	ArrayPushString(g_upgrade_desc, "Increases melee damage by 20%.")
	ArrayPushCell(g_upgrade_cost, 75)
	ArrayPushCell(g_upgrade_lvl, 10)
	ArrayPushString(g_upgrade_team, "Human")
	ArrayPushString(g_upgrade_id, UPGRADE_HUMAN_BLOODY_BLADE)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Zombie Deadly Claws
	ArrayPushString(g_upgrade_name, "Deadly Claws")
	ArrayPushString(g_upgrade_desc, "Increases melee damage to humans by 20%.")
	ArrayPushCell(g_upgrade_cost, 75)
	ArrayPushCell(g_upgrade_lvl, 10)
	ArrayPushString(g_upgrade_team, "Zombie")
	ArrayPushString(g_upgrade_id, UPGRADE_ZOMBIE_DEADLY_CLAWS)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Human Flat Armor
	ArrayPushString(g_upgrade_name, "Flat Armor")
	ArrayPushString(g_upgrade_desc, "+10 armor")
	ArrayPushCell(g_upgrade_cost, 160)
	ArrayPushCell(g_upgrade_lvl, 20)
	ArrayPushString(g_upgrade_team, "Human")
	ArrayPushString(g_upgrade_id, UPGRADE_HUMAN_FLAT_ARMOR)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Human Scaling Armor
	ArrayPushString(g_upgrade_name, "Scaling Armor")
	ArrayPushString(g_upgrade_desc, "+0.5 armor per level")
	ArrayPushCell(g_upgrade_cost, 190)
	ArrayPushCell(g_upgrade_lvl, 20)
	ArrayPushString(g_upgrade_team, "Human")
	ArrayPushString(g_upgrade_id, UPGRADE_HUMAN_SCALING_ARMOR)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Extreme Conditioning
	ArrayPushString(g_upgrade_name, "Extreme Conditioning")
	ArrayPushString(g_upgrade_desc, "Movement speed increased by 3%.")
	ArrayPushCell(g_upgrade_cost, 145)
	ArrayPushCell(g_upgrade_lvl, 22)
	ArrayPushString(g_upgrade_team, "Human")
	ArrayPushString(g_upgrade_id, UPGRADE_HUMAN_XTR_COND)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Plasma Cutter
	ArrayPushString(g_upgrade_name, "Plasma Cutter")
	ArrayPushString(g_upgrade_desc, "Increases Laser Cutter's damage by 50% and freezing chance by 5%.")
	ArrayPushCell(g_upgrade_cost, 200)
	ArrayPushCell(g_upgrade_lvl, 39)
	ArrayPushString(g_upgrade_team, "Human")
	ArrayPushString(g_upgrade_id, UPGRADE_HUMAN_PLASMA_CUTTER)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	// Extended Claws
	ArrayPushString(g_upgrade_name, "Extended Claws")
	ArrayPushString(g_upgrade_desc, "Increases claws' attack range by 5 units.")
	ArrayPushCell(g_upgrade_cost, 200)
	ArrayPushCell(g_upgrade_lvl, 15)
	ArrayPushString(g_upgrade_team, "Zombie")
	ArrayPushString(g_upgrade_id, UPGRADE_ZOMBIE_EXTENDED_CLAWS)
	ArrayPushCell(g_upgrade_avail, 0)
	g_upgrade_i++
	
	for (i = 0; i < ArraySize(model_nemesis); i++)
	{
		ArrayGetString(model_nemesis, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_nemesis, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
		// Precache modelT.mdl files too
		copy(buffer[strlen(buffer)-4], charsmax(buffer) - (strlen(buffer)-4), "T.mdl")
		if (file_exists(buffer)) engfunc(EngFunc_PrecacheModel, buffer)
	}
	for (i = 0; i < ArraySize(model_survivor); i++)
	{
		ArrayGetString(model_survivor, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_survivor, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
		// Precache modelT.mdl files too
		copy(buffer[strlen(buffer)-4], charsmax(buffer) - (strlen(buffer)-4), "T.mdl")
		if (file_exists(buffer)) engfunc(EngFunc_PrecacheModel, buffer)
	}
	for (i = 0; i < ArraySize(model_vip); i++)
	{
		ArrayGetString(model_vip, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_vip, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
		// Precache modelT.mdl files too
		copy(buffer[strlen(buffer)-4], charsmax(buffer) - (strlen(buffer)-4), "T.mdl")
		if (file_exists(buffer)) engfunc(EngFunc_PrecacheModel, buffer)
	}
	for (i = 0; i < ArraySize(model_admin_zombie); i++)
	{
		ArrayGetString(model_admin_zombie, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_admin_zombie, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
		// Precache modelT.mdl files too
		copy(buffer[strlen(buffer)-4], charsmax(buffer) - (strlen(buffer)-4), "T.mdl")
		if (file_exists(buffer)) engfunc(EngFunc_PrecacheModel, buffer)
	}
	
	// Custom weapon models
	engfunc(EngFunc_PrecacheModel, model_vknife_human)
	engfunc(EngFunc_PrecacheModel, model_vknife_nemesis)
	engfunc(EngFunc_PrecacheModel, model_grenade_infect)
	engfunc(EngFunc_PrecacheModel, model_grenade_fire)
	engfunc(EngFunc_PrecacheModel, model_grenade_frost)
	engfunc(EngFunc_PrecacheModel, model_grenade_flare)
	engfunc(EngFunc_PrecacheModel, model_vknife_admin_human)
	engfunc(EngFunc_PrecacheModel, model_vknife_admin_zombie)
	
	// Custom sprites
	g_trailSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_trail)
	g_exploSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_ring)
	g_flameSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_fire)
	g_smokeSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_smoke)
	g_glassSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_glass)
	g_bloodSpr = engfunc(EngFunc_PrecacheModel, "sprites/blood.spr")
	
	// Custom sounds
	for (i = 0; i < ArraySize(sound_win_zombies); i++)
	{
		ArrayGetString(sound_win_zombies, i, buffer, charsmax(buffer))
		if (ArrayGetCell(sound_win_zombies_ismp3, i))
		{
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else
		{
			engfunc(EngFunc_PrecacheSound, buffer)
		}
	}
	for (i = 0; i < ArraySize(sound_win_humans); i++)
	{
		ArrayGetString(sound_win_humans, i, buffer, charsmax(buffer))
		if (ArrayGetCell(sound_win_humans_ismp3, i))
		{
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else
		{
			engfunc(EngFunc_PrecacheSound, buffer)
		}
	}
	for (i = 0; i < ArraySize(sound_win_no_one); i++)
	{
		ArrayGetString(sound_win_no_one, i, buffer, charsmax(buffer))
		if (ArrayGetCell(sound_win_no_one_ismp3, i))
		{
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else
		{
			engfunc(EngFunc_PrecacheSound, buffer)
		}
	}
	for (i = 0; i < ArraySize(zombie_infect); i++)
	{
		ArrayGetString(zombie_infect, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_pain); i++)
	{
		ArrayGetString(zombie_pain, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(nemesis_pain); i++)
	{
		ArrayGetString(nemesis_pain, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_die); i++)
	{
		ArrayGetString(zombie_die, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_fall); i++)
	{
		ArrayGetString(zombie_fall, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_miss_slash); i++)
	{
		ArrayGetString(zombie_miss_slash, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_miss_wall); i++)
	{
		ArrayGetString(zombie_miss_wall, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_hit_normal); i++)
	{
		ArrayGetString(zombie_hit_normal, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_hit_stab); i++)
	{
		ArrayGetString(zombie_hit_stab, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_idle); i++)
	{
		ArrayGetString(zombie_idle, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_idle_last); i++)
	{
		ArrayGetString(zombie_idle_last, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_madness); i++)
	{
		ArrayGetString(zombie_madness, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_none); i++)
	{
		ArrayGetString(sound_none, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_nemesis); i++)
	{
		ArrayGetString(sound_nemesis, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_survivor); i++)
	{
		ArrayGetString(sound_survivor, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_swarm); i++)
	{
		ArrayGetString(sound_swarm, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_multi); i++)
	{
		ArrayGetString(sound_multi, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_plague); i++)
	{
		ArrayGetString(sound_plague, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_vip); i++)
	{
		ArrayGetString(sound_vip, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_infect); i++)
	{
		ArrayGetString(grenade_infect, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_infect_player); i++)
	{
		ArrayGetString(grenade_infect_player, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_fire); i++)
	{
		ArrayGetString(grenade_fire, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_fire_player); i++)
	{
		ArrayGetString(grenade_fire_player, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_frost); i++)
	{
		ArrayGetString(grenade_frost, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_frost_player); i++)
	{
		ArrayGetString(grenade_frost_player, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_frost_break); i++)
	{
		ArrayGetString(grenade_frost_break, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_flare); i++)
	{
		ArrayGetString(grenade_flare, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_antidote); i++)
	{
		ArrayGetString(sound_antidote, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_loading); i++)
	{
		ArrayGetString(sound_loading, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_levelup); i++)
	{
		ArrayGetString(sound_levelup, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	
	// Ambience Sounds
	if (g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION])
	{
		for (i = 0; i < ArraySize(sound_ambience1); i++)
		{
			ArrayGetString(sound_ambience1, i, buffer, charsmax(buffer))
			
			if (ArrayGetCell(sound_ambience1_ismp3, i))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS])
	{
		for (i = 0; i < ArraySize(sound_ambience2); i++)
		{
			ArrayGetString(sound_ambience2, i, buffer, charsmax(buffer))
			
			if (ArrayGetCell(sound_ambience2_ismp3, i))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR])
	{
		for (i = 0; i < ArraySize(sound_ambience3); i++)
		{
			ArrayGetString(sound_ambience3, i, buffer, charsmax(buffer))
			
			if (ArrayGetCell(sound_ambience3_ismp3, i))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_SWARM])
	{
		for (i = 0; i < ArraySize(sound_ambience4); i++)
		{
			ArrayGetString(sound_ambience4, i, buffer, charsmax(buffer))
			
			if (ArrayGetCell(sound_ambience4_ismp3, i))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE])
	{
		for (i = 0; i < ArraySize(sound_ambience5); i++)
		{
			ArrayGetString(sound_ambience5, i, buffer, charsmax(buffer))
			
			if (ArrayGetCell(sound_ambience5_ismp3, i))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_ARMAGEDDON])
	{
		for (i = 0; i < ArraySize(sound_ambience7); i++)
		{
			ArrayGetString(sound_ambience7, i, buffer, charsmax(buffer))
			
			if (ArrayGetCell(sound_ambience7_ismp3, i))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_VIP])
	{
		for (i = 0; i < ArraySize(sound_ambience6); i++)
		{
			ArrayGetString(sound_ambience6, i, buffer, charsmax(buffer))
			
			if (ArrayGetCell(sound_ambience6_ismp3, i))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	
	// CS sounds (just in case)
	engfunc(EngFunc_PrecacheSound, sound_flashlight)
	engfunc(EngFunc_PrecacheSound, sound_buyammo)
	engfunc(EngFunc_PrecacheSound, sound_armorhit)
	
	cache_smoke  = precache_model("sprites/steam1.spr")
	cache_nade = precache_model("sprites/smokepuff.spr")
	
	// Molotov cocktail
	precache_model("models/fzm/v_molotov.mdl")
	precache_model("models/fzm/p_molotov.mdl")
	precache_model("models/fzm/w_molotov.mdl")
	
	/*
	// HUD icons
	precache_generic("sprites/weapon_fzmflare.txt")
	precache_generic("sprites/weapon_fzmmolotov.txt")
	*/
	
	// Laser Cutter
	precache_model("models/fzm/w_cutter.mdl")
	precache_sound("ambience/alien_minddrill.wav")
	
	// Force Field Grenade
	precache_model("models/zombie_plague/v_auragren.mdl")
	precache_model("models/zombie_plague/w_aura.mdl")
	precache_model("models/zombie_plague/aura8.mdl")
	
	new ent
	
	// Fake Hostage (to force round ending)
	ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "hostage_entity"))
	if (pev_valid(ent))
	{
		engfunc(EngFunc_SetOrigin, ent, Float:{8192.0,8192.0,8192.0})
		dllfunc(DLLFunc_Spawn, ent)
	}
	
	// Weather/ambience effects
	if (g_ambience_fog)
	{
		ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_fog"))
		if (pev_valid(ent))
		{
			fm_set_kvd(ent, "density", g_fog_density, "env_fog")
			fm_set_kvd(ent, "rendercolor", g_fog_color, "env_fog")
		}
	}
	if (g_ambience_rain) engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_rain"))
	if (g_ambience_snow) engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_snow"))
	
	// Custom buyzone for all players
	g_buyzone_ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "func_buyzone"))
	if (pev_valid(g_buyzone_ent))
	{
		dllfunc(DLLFunc_Spawn, g_buyzone_ent)
		set_pev(g_buyzone_ent, pev_solid, SOLID_NOT)
	}
	
	// Prevent some entities from spawning
	g_fwSpawn = register_forward(FM_Spawn, "fw_Spawn")
	
	// Prevent hostage sounds from being precached
	g_fwPrecacheSound = register_forward(FM_PrecacheSound, "fw_PrecacheSound")
}

public plugin_init()
{
	// Plugin disabled?
	if (!g_pluginenabled) return;
	
	// No zombie or classes?
	if (!g_zclass_i) set_fail_state("No zombie classes loaded!")
	if (!g_hclass_i) set_fail_state("No human classes loaded!")
	
	// Language files
	register_dictionary("zombie_plague.txt")
	register_dictionary("time.txt")
	
	// Events
	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")
	register_logevent("logevent_round_start",2, "1=Round_Start")
	register_logevent("logevent_round_end", 2, "1=Round_End")
	register_event("AmmoX", "event_ammo_x", "be")
	if (g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION] || g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS] || g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR] || g_ambience_sounds[AMBIENCE_SOUNDS_SWARM] || g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE] || g_ambience_sounds[AMBIENCE_SOUNDS_ARMAGEDDON] || g_ambience_sounds[AMBIENCE_SOUNDS_VIP])
		register_event("30", "event_intermission", "a")
	
	// HAM Forwards
	RegisterHam(Ham_Spawn, "player", "fw_PlayerSpawn_Post", 1)
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled")
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled_Post", 1)
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage_Post", 1)
	RegisterHam(Ham_TraceAttack, "player", "fw_TraceAttack")
	RegisterHam(Ham_Player_ResetMaxSpeed, "player", "fw_ResetMaxSpeed_Post", 1)
	RegisterHam(Ham_Use, "func_tank", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tankmortar", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tankrocket", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tanklaser", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tank", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_tankmortar", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_tankrocket", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_tanklaser", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_pushable", "fw_UsePushable")
	RegisterHam(Ham_Touch, "weaponbox", "fw_TouchWeapon")
	RegisterHam(Ham_Touch, "armoury_entity", "fw_TouchWeapon")
	RegisterHam(Ham_Touch, "weapon_shield", "fw_TouchWeapon")
	RegisterHam(Ham_AddPlayerItem, "player", "fw_AddPlayerItem")
	for (new i = 1; i < sizeof WEAPONENTNAMES; i++) if (WEAPONENTNAMES[i][0]) RegisterHam(Ham_Item_Deploy, WEAPONENTNAMES[i], "fw_Item_Deploy_Post", 1)
	RegisterHam(Ham_BloodColor, "player", "fw_PlayerBloodColor")
	/*RegisterHam(Ham_Item_AddToPlayer, "weapon_smokegrenade", "fw_AddSmokeGrenadeToPlayer")
	RegisterHam(Ham_Item_AddToPlayer, "weapon_hegrenade", "fw_AddHEGrenadeToPlayer")*/
	RegisterHam(Ham_TakeDamage, "func_breakable", "fw_TakeDamage_Breakable")
	
	// FM Forwards
	register_forward(FM_ClientDisconnect, "fw_ClientDisconnect")
	register_forward(FM_ClientDisconnect, "fw_ClientDisconnect_Post", 1)
	register_forward(FM_ClientKill, "fw_ClientKill")
	register_forward(FM_EmitSound, "fw_EmitSound")
	if (!g_handle_models_on_separate_ent) register_forward(FM_SetClientKeyValue, "fw_SetClientKeyValue")
	register_forward(FM_ClientUserInfoChanged, "fw_ClientUserInfoChanged")
	register_forward(FM_SetModel, "fw_SetModel")
	RegisterHam(Ham_Think, "grenade", "fw_ThinkGrenade")
	register_forward(FM_CmdStart, "fw_CmdStart")
	register_forward(FM_PlayerPreThink, "fw_PlayerPreThink")
	register_forward(FM_TraceLine, "fw_TraceLine")
	register_forward(FM_TraceHull, "fw_TraceHull")
	unregister_forward(FM_Spawn, g_fwSpawn)
	unregister_forward(FM_PrecacheSound, g_fwPrecacheSound)
	
	// Engine forwards
	register_touch("grenade", "*", "fw_GrenadeTouch")
	register_touch("zp_forcefield", "player", "fw_ForceFieldTouch")
	
	// Client commands
	register_clcmd("say zpmenu", "clcmd_saymenu")
	register_clcmd("say /zpmenu", "clcmd_saymenu")
	register_clcmd("say unstuck", "clcmd_sayunstuck")
	register_clcmd("say /unstuck", "clcmd_sayunstuck")
	register_clcmd("nightvision", "clcmd_nightvision")
	register_clcmd("drop", "clcmd_drop")
	register_clcmd("buyammo1", "clcmd_buyammo")
	register_clcmd("buyammo2", "clcmd_buyammo")
	register_clcmd("chooseteam", "clcmd_changeteam")
	register_clcmd("jointeam", "clcmd_changeteam")
	
	/*
	// Custom HUD icons
	register_clcmd("weapon_fzmflare", "fw_SelectFlare")
	register_clcmd("weapon_fzmmolotov", "fw_SelectMolotov")
	*/
	
	// Menus
	register_menu("Game Menu", KEYSMENU, "menu_game")
	register_menu("Equipment Menu", KEYSMENU, "menu_equipment")
	register_menu("Upgrade Details Menu", MENU_KEY_1|MENU_KEY_0, "menu_upgrade_details")
	register_menu("Admin Menu", KEYSMENU, "menu_admin")
	
	// CS Buy Menus (to prevent zombies/survivor from buying)
	register_menucmd(register_menuid("#Buy", 1), 511, "menu_cs_buy")
	register_menucmd(register_menuid("BuyPistol", 1), 511, "menu_cs_buy")
	register_menucmd(register_menuid("BuyShotgun", 1), 511, "menu_cs_buy")
	register_menucmd(register_menuid("BuySub", 1), 511, "menu_cs_buy")
	register_menucmd(register_menuid("BuyRifle", 1), 511, "menu_cs_buy")
	register_menucmd(register_menuid("BuyMachine", 1), 511, "menu_cs_buy")
	register_menucmd(register_menuid("BuyItem", 1), 511, "menu_cs_buy")
	register_menucmd(-28, 511, "menu_cs_buy")
	register_menucmd(-29, 511, "menu_cs_buy")
	register_menucmd(-30, 511, "menu_cs_buy")
	register_menucmd(-32, 511, "menu_cs_buy")
	register_menucmd(-31, 511, "menu_cs_buy")
	register_menucmd(-33, 511, "menu_cs_buy")
	register_menucmd(-34, 511, "menu_cs_buy")
	
	// Admin commands
	register_concmd("zp_zombie", "cmd_zombie", _, "<target> - Turn someone into a Zombie", 0)
	register_concmd("zp_human", "cmd_human", _, "<target> - Turn someone back to Human", 0)
	register_concmd("zp_nemesis", "cmd_nemesis", _, "<target> - Turn someone into a Nemesis", 0)
	register_concmd("zp_survivor", "cmd_survivor", _, "<target> - Turn someone into a Survivor", 0)
	register_concmd("zp_respawn", "cmd_respawn", _, "<target> - Respawn someone", 0)
	register_concmd("zp_swarm", "cmd_swarm", _, " - Start Swarm Mode", 0)
	register_concmd("zp_multi", "cmd_multi", _, " - Start Multi Infection", 0)
	register_concmd("zp_plague", "cmd_plague", _, " - Start Plague Mode", 0)
	register_concmd("zp_armageddon", "cmd_armageddon", _, " - Start Armageddon Mode", 0)
	register_concmd("zp_vip", "cmd_vip", _, " - Start VIP Mode", 0)
	
	// Message IDs
	g_msgScoreInfo = get_user_msgid("ScoreInfo")
	g_msgTeamInfo = get_user_msgid("TeamInfo")
	g_msgDeathMsg = get_user_msgid("DeathMsg")
	g_msgScoreAttrib = get_user_msgid("ScoreAttrib")
	g_msgSetFOV = get_user_msgid("SetFOV")
	g_msgScreenFade = get_user_msgid("ScreenFade")
	g_msgScreenShake = get_user_msgid("ScreenShake")
	g_msgNVGToggle = get_user_msgid("NVGToggle")
	g_msgFlashlight = get_user_msgid("Flashlight")
	g_msgFlashBat = get_user_msgid("FlashBat")
	g_msgAmmoPickup = get_user_msgid("AmmoPickup")
	g_msgDamage = get_user_msgid("Damage")
	g_msgHideWeapon = get_user_msgid("HideWeapon")
	g_msgCrosshair = get_user_msgid("Crosshair")
	g_msgSayText = get_user_msgid("SayText")
	g_msgBattery = get_user_msgid("Battery")
	//g_msgWeaponList = get_user_msgid("WeaponList")
	
	// Message hooks
	register_message(get_user_msgid("Money"), "message_money")
	register_message(get_user_msgid("Health"), "message_health")
	register_message(g_msgBattery, "message_battery")
	register_message(g_msgFlashBat, "message_flashbat")
	register_message(g_msgScreenFade, "message_screenfade")
	register_message(g_msgNVGToggle, "message_nvgtoggle")
	if (g_handle_models_on_separate_ent) register_message(get_user_msgid("ClCorpse"), "message_clcorpse")
	register_message(get_user_msgid("WeapPickup"), "message_weappickup")
	register_message(g_msgAmmoPickup, "message_ammopickup")
	register_message(get_user_msgid("Scenario"), "message_scenario")
	register_message(get_user_msgid("HostagePos"), "message_hostagepos")
	register_message(get_user_msgid("TextMsg"), "message_textmsg")
	register_message(get_user_msgid("SendAudio"), "message_sendaudio")
	register_message(get_user_msgid("TeamScore"), "message_teamscore")
	register_message(g_msgTeamInfo, "message_teaminfo")
	register_message(g_msgDamage, "message_damage")
	register_message(g_msgScoreAttrib, "message_score_attrib")
	
	// CVARS - General Purpose
	cvar_warmup = register_cvar("zp_delay", "10")
	cvar_lighting = register_cvar("zp_lighting", "a")
	cvar_lightingzombies = register_cvar("zp_lighting_zombies", "a")
	cvar_triggered = register_cvar("zp_triggered_lights", "1")
	cvar_removedoors = register_cvar("zp_remove_doors", "0")
	cvar_blockpushables = register_cvar("zp_blockuse_pushables", "1")
	cvar_blocksuicide = register_cvar("zp_block_suicide", "1")
	cvar_randspawn = register_cvar("zp_random_spawn", "1")
	cvar_respawnworldspawnkill = register_cvar("zp_respawn_on_worldspawn_kill", "1")
	cvar_removedropped = register_cvar("zp_remove_dropped", "0")
	cvar_removemoney = register_cvar("zp_remove_money", "1")
	cvar_adminmodelszombie = register_cvar("zp_admin_models_zombie", "1")
	cvar_adminknifemodelszombie = register_cvar("zp_admin_knife_models_zombie", "0")
	cvar_zclasses = register_cvar("zp_zombie_classes", "1")
	cvar_startammopacks = register_cvar("zp_starting_ammo_packs", "5")
	cvar_preventconsecutive = register_cvar("zp_prevent_consecutive_modes", "1")
	cvar_keephealthondisconnect = register_cvar("zp_keep_health_on_disconnect", "1")
	cvar_huddisplay = register_cvar("zp_hud_display", "1")
	
	// CVARS - Deathmatch
	cvar_deathmatch = register_cvar("zp_deathmatch", "0")
	cvar_spawndelay = register_cvar("zp_spawn_delay", "5")
	cvar_spawnprotection = register_cvar("zp_spawn_protection", "5")
	cvar_respawnonsuicide = register_cvar("zp_respawn_on_suicide", "0")
	cvar_respawnafterlast = register_cvar("zp_respawn_after_last_human", "1")
	cvar_allowrespawninfection = register_cvar("zp_infection_allow_respawn", "1")
	cvar_allowrespawnnem = register_cvar("zp_nem_allow_respawn", "0")
	cvar_allowrespawnsurv = register_cvar("zp_surv_allow_respawn", "0")
	cvar_allowrespawnswarm = register_cvar("zp_swarm_allow_respawn", "0")
	cvar_allowrespawnplague = register_cvar("zp_plague_allow_respawn", "0")
	cvar_respawnzomb = register_cvar("zp_respawn_zombies", "1")
	cvar_respawnhum = register_cvar("zp_respawn_humans", "1")
	cvar_respawnnem = register_cvar("zp_respawn_nemesis", "1")
	cvar_respawnsurv = register_cvar("zp_respawn_survivors", "1")
	
	// CVARS - Extra Items
	cvar_extraitems = register_cvar("zp_extra_items", "1")
	cvar_extranvision = register_cvar("zp_extra_nvision", "1")
	cvar_extraantidote = register_cvar("zp_extra_antidote", "1")
	cvar_antidotelimit = register_cvar("zp_extra_antidote_limit", "999")
	cvar_extramadness = register_cvar("zp_extra_madness", "1")
	cvar_madnesslimit = register_cvar("zp_extra_madness_limit", "999")
	cvar_madnessduration = register_cvar("zp_extra_madness_duration", "5.0")
	cvar_extrainfbomb = register_cvar("zp_extra_infbomb", "1")
	cvar_infbomblimit = register_cvar("zp_extra_infbomb_limit", "999")
	
	// CVARS - Flashlight and Nightvision
	cvar_customflash = register_cvar("zp_flash_custom", "0")
	cvar_flashsize = register_cvar("zp_flash_size", "10")
	cvar_flashdrain = register_cvar("zp_flash_drain", "1")
	cvar_flashcharge = register_cvar("zp_flash_charge", "5")
	cvar_flashdist = register_cvar("zp_flash_distance", "1000")
	cvar_flashcolor[0] = register_cvar("zp_flash_color_R", "100")
	cvar_flashcolor[1] = register_cvar("zp_flash_color_G", "100")
	cvar_flashcolor[2] = register_cvar("zp_flash_color_B", "100")
	cvar_flashshowall = register_cvar("zp_flash_show_all", "1")
	
	// CVARS - Knockback
	cvar_knockback = register_cvar("zp_knockback", "0")
	cvar_knockbackdamage = register_cvar("zp_knockback_damage", "1")
	cvar_knockbackpower = register_cvar("zp_knockback_power", "1")
	cvar_knockbackzvel = register_cvar("zp_knockback_zvel", "0")
	cvar_knockbackducking = register_cvar("zp_knockback_ducking", "0.25")
	cvar_knockbackdist = register_cvar("zp_knockback_distance", "500")
	cvar_nemknockback = register_cvar("zp_knockback_nemesis", "0.25")
	
	// CVARS - Leap
	cvar_leapzombies = register_cvar("zp_leap_zombies", "0")
	cvar_leapzombiesforce = register_cvar("zp_leap_zombies_force", "500")
	cvar_leapzombiesheight = register_cvar("zp_leap_zombies_height", "300")
	cvar_leapzombiescooldown = register_cvar("zp_leap_zombies_cooldown", "5.0")
	cvar_leapnemesis = register_cvar("zp_leap_nemesis", "1")
	cvar_leapnemesisforce = register_cvar("zp_leap_nemesis_force", "500")
	cvar_leapnemesisheight = register_cvar("zp_leap_nemesis_height", "300")
	cvar_leapnemesiscooldown = register_cvar("zp_leap_nemesis_cooldown", "5.0")
	cvar_leapsurvivor = register_cvar("zp_leap_survivor", "0")
	cvar_leapsurvivorforce = register_cvar("zp_leap_survivor_force", "500")
	cvar_leapsurvivorheight = register_cvar("zp_leap_survivor_height", "300")
	cvar_leapsurvivorcooldown = register_cvar("zp_leap_survivor_cooldown", "5.0")
	
	// CVARS - Humans
	cvar_humanlasthp = register_cvar("zp_human_last_extrahp", "0")
	cvar_humanarmor = register_cvar("zp_human_armor_protect", "1")
	cvar_infammo = register_cvar("zp_human_unlimited_ammo", "0")
	cvar_fragskill = register_cvar("zp_human_frags_for_kill", "1")
	
	// CVARS - Custom Grenades
	cvar_firegrenades = register_cvar("zp_fire_grenades", "1")
	cvar_fireduration = register_cvar("zp_fire_duration", "10")
	cvar_firedamage = register_cvar("zp_fire_damage", "8")
	cvar_fireslowdown = register_cvar("zp_fire_slowdown", "0.5")
	cvar_frostgrenades = register_cvar("zp_frost_grenades", "1")
	cvar_freezeduration = register_cvar("zp_frost_duration", "4")
	cvar_freezedamage = register_cvar("zp_frost_damage", "3")
	cvar_flaregrenades = register_cvar("zp_flare_grenades","1")
	cvar_flareduration = register_cvar("zp_flare_duration", "60")
	cvar_flaresize = register_cvar("zp_flare_size", "25")
	cvar_flarecolor = register_cvar("zp_flare_color", "0")
	cvar_forcefieldtime = register_cvar("zp_force_field_time", "10.0")
	
	// CVARS - Zombies
	cvar_zombiefirsthp = register_cvar("zp_zombie_first_hp", "2.0")
	cvar_hitzones = register_cvar("zp_zombie_hitzones", "0")
	cvar_zombiebonushp = register_cvar("zp_zombie_infect_health", "100")
	cvar_zombiefov = register_cvar("zp_zombie_fov", "110")
	cvar_zombiesilent = register_cvar("zp_zombie_silent", "1")
	cvar_zombiepainfree = register_cvar("zp_zombie_painfree", "2")
	cvar_zombiebleeding = register_cvar("zp_zombie_bleeding", "1")
	cvar_fragsinfect = register_cvar("zp_zombie_frags_for_infect", "1")
	
	// CVARS - Special Effects
	cvar_infectionscreenfade = register_cvar("zp_infection_screenfade", "1")
	cvar_infectionscreenshake = register_cvar("zp_infection_screenshake", "1")
	cvar_infectionsparkle = register_cvar("zp_infection_sparkle", "1")
	cvar_infectiontracers = register_cvar("zp_infection_tracers", "1")
	cvar_infectionparticles = register_cvar("zp_infection_particles", "1")
	cvar_hudicons = register_cvar("zp_hud_icons", "1")
	
	// CVARS - Nemesis
	cvar_nem = register_cvar("zp_nem_enabled", "1")
	cvar_nemchance = register_cvar("zp_nem_chance", "20")
	cvar_nemminplayers = register_cvar("zp_nem_min_players", "0")
	cvar_nemhp = register_cvar("zp_nem_health", "0")
	cvar_nembasehp = register_cvar("zp_nem_base_health", "0")
	cvar_nemspd = register_cvar("zp_nem_speed", "250")
	cvar_nemgravity = register_cvar("zp_nem_gravity", "0.5")
	cvar_nemdamage = register_cvar("zp_nem_damage", "200")
	cvar_nemglow = register_cvar("zp_nem_glow", "1")
	cvar_nemaura = register_cvar("zp_nem_aura", "1")	
	cvar_nempainfree = register_cvar("zp_nem_painfree", "0")
	cvar_nemignorefrags = register_cvar("zp_nem_ignore_frags", "1")
	
	// CVARS - Survivor
	cvar_surv = register_cvar("zp_surv_enabled", "1")
	cvar_survchance = register_cvar("zp_surv_chance", "20")
	cvar_survminplayers = register_cvar("zp_surv_min_players", "0")
	cvar_survhp = register_cvar("zp_surv_health", "0")
	cvar_survbasehp = register_cvar("zp_surv_base_health", "0")
	cvar_survspd = register_cvar("zp_surv_speed", "230")
	cvar_survgravity = register_cvar("zp_surv_gravity", "1.25")
	cvar_survglow = register_cvar("zp_surv_glow", "1")
	cvar_survaura = register_cvar("zp_surv_aura", "1")
	cvar_survpainfree = register_cvar("zp_surv_painfree", "1")
	cvar_survignorefrags = register_cvar("zp_surv_ignore_frags", "1")
	cvar_survweapon = register_cvar("zp_surv_weapon", "weapon_m249")
	cvar_survinfammo = register_cvar("zp_surv_unlimited_ammo", "2")
	
	// CVARS - Swarm Mode
	cvar_swarm = register_cvar("zp_swarm_enabled", "1")
	cvar_swarmchance = register_cvar("zp_swarm_chance", "20")
	cvar_swarmminplayers = register_cvar("zp_swarm_min_players", "0")
	
	// CVARS - Multi Infection
	cvar_multi = register_cvar("zp_multi_enabled", "1")
	cvar_multichance = register_cvar("zp_multi_chance", "20")
	cvar_multiminplayers = register_cvar("zp_multi_min_players", "0")
	cvar_multiratio = register_cvar("zp_multi_ratio", "0.15")
	
	// CVARS - Plague Mode
	cvar_plague = register_cvar("zp_plague_enabled", "1")
	cvar_plaguechance = register_cvar("zp_plague_chance", "30")
	cvar_plagueminplayers = register_cvar("zp_plague_min_players", "0")
	cvar_plagueratio = register_cvar("zp_plague_ratio", "0.5")
	cvar_plaguenemnum = register_cvar("zp_plague_nem_number", "1")
	cvar_plaguenemhpmulti = register_cvar("zp_plague_nem_hp_multi", "0.5")
	cvar_plaguesurvnum = register_cvar("zp_plague_surv_number", "1")
	cvar_plaguesurvhpmulti = register_cvar("zp_plague_surv_hp_multi", "0.5")
	
	// CVARS - Armageddon Mode
	cvar_armageddon = register_cvar("zp_armageddon_enabled", "1")
	cvar_armageddonchance = register_cvar("zp_armageddon_chance", "20")
	
	// CVARS - VIP Mode
	cvar_vip = register_cvar("zp_vip_enabled", "1")
	cvar_vipchance = register_cvar("zp_vip_chance", "20")
	cvar_vipminplayers = register_cvar("zp_vip_min_players", "0")
	cvar_vipratio = register_cvar("zp_vip_ratio", "0.15")
	
	// CVARS - Others
	cvar_logcommands = register_cvar("zp_logcommands", "1")
	cvar_showactivity = get_cvar_pointer("amx_show_activity")
	cvar_botquota = get_cvar_pointer("bot_quota")
	register_cvar("zp_version", PLUGIN_VERSION, FCVAR_SERVER|FCVAR_SPONLY)
	set_cvar_string("zp_version", PLUGIN_VERSION)
	
	// Custom Forwards
	g_fwRoundStart = CreateMultiForward("zp_round_started", ET_IGNORE, FP_CELL, FP_CELL)
	g_fwRoundEnd = CreateMultiForward("zp_round_ended", ET_IGNORE, FP_CELL)
	g_fwUserInfected_pre = CreateMultiForward("zp_user_infected_pre", ET_IGNORE, FP_CELL, FP_CELL, FP_CELL)
	g_fwUserInfected_post = CreateMultiForward("zp_user_infected_post", ET_IGNORE, FP_CELL, FP_CELL, FP_CELL)
	g_fwUserHumanized_pre = CreateMultiForward("zp_user_humanized_pre", ET_IGNORE, FP_CELL, FP_CELL)
	g_fwUserHumanized_post = CreateMultiForward("zp_user_humanized_post", ET_IGNORE, FP_CELL, FP_CELL)
	g_fwUserInfect_attempt = CreateMultiForward("zp_user_infect_attempt", ET_CONTINUE, FP_CELL, FP_CELL, FP_CELL)
	g_fwUserHumanize_attempt = CreateMultiForward("zp_user_humanize_attempt", ET_CONTINUE, FP_CELL, FP_CELL)
	g_fwExtraItemSelected = CreateMultiForward("zp_extra_item_selected", ET_CONTINUE, FP_CELL, FP_CELL)
	g_fwUserUnfrozen = CreateMultiForward("zp_user_unfrozen", ET_IGNORE, FP_CELL)
	g_fwUserLastZombie = CreateMultiForward("zp_user_last_zombie", ET_IGNORE, FP_CELL)
	g_fwUserLastHuman = CreateMultiForward("zp_user_last_human", ET_IGNORE, FP_CELL)
	g_fwGiveSpecial = CreateMultiForward("zp_give_special", ET_IGNORE, FP_CELL, FP_CELL)
	
	g_fwReplaceWeaponModels = CreateMultiForward("zp_replace_weapon_models", ET_IGNORE, FP_CELL, FP_CELL)
	g_fwZombieClassAvailable = CreateMultiForward("zp_zombie_class_available", ET_IGNORE, FP_CELL, FP_CELL, FP_STRING, FP_CELL)
	g_fwHumanClassAvailable = CreateMultiForward("zp_human_class_available", ET_IGNORE, FP_CELL, FP_CELL, FP_STRING, FP_CELL)
	
	// Collect random spawn points
	load_spawns()
	
	// Set a random skybox?
	if (g_sky_enable)
	{
		new sky[32]
		ArrayGetString(g_sky_names, random_num(0, ArraySize(g_sky_names) - 1), sky, charsmax(sky))
		set_cvar_string("sv_skyname", sky)
	}
	
	// Disable sky lighting so it doesn't mess with our custom lighting
	set_cvar_num("sv_skycolor_r", 0)
	set_cvar_num("sv_skycolor_g", 0)
	set_cvar_num("sv_skycolor_b", 0)
	
	// Create the HUD Sync Objects
	g_MsgSync = CreateHudSyncObj()
	g_MsgSync2 = CreateHudSyncObj()
	
	// Format mod name
	formatex(g_modname, charsmax(g_modname), "Zombie Plague %s", PLUGIN_VERSION)
	
	// Get Max Players
	g_maxplayers = get_maxplayers()
	
	// Check if it's a CZ server
	new mymod[6]
	get_modname(mymod, charsmax(mymod))
	if (equal(mymod, "czero")) g_czero = 1
	
	// Initialize SQL tuple
	register_srvcmd("zp_sqlinit", "sql_init")
	server_cmd("zp_sqlinit")
}

public plugin_cfg()
{
	// Plugin disabled?
	if (!g_pluginenabled) return;
	
	// Get configs dir
	new cfgdir[32]
	get_configsdir(cfgdir, charsmax(cfgdir))
	
	// Execute config file (zombieplague.cfg)
	server_cmd("exec %s/zombieplague.cfg", cfgdir)
	server_exec()
	
	// Set initial lighting
	static lighting[2]
	get_pcvar_string(cvar_lighting, lighting, charsmax(lighting))
	strtolower(lighting)
	engfunc(EngFunc_LightStyle, lighting)
	
	// Prevent any more stuff from registering
	g_arrays_created = false
	
	// Save customization data
	save_customization()
	
	// Lighting task
	set_task(5.0, "lighting_effects", _, _, _, "b")
	
	// Cache CVARs after configs are loaded / call roundstart manually
	set_task(0.5, "cache_cvars")
	set_task(0.5, "event_round_start")
	set_task(0.5, "logevent_round_start")
	
	// Save data task
	set_task(60.0, "task_save_data", _, _, _, "b")
}

/*================================================================================
 [Main Events]
=================================================================================*/

// Event Round Start
public event_round_start()
{
	// Remove doors/lights?
	set_task(0.1, "remove_stuff")
	
	remove_entity_name("grenade")
	remove_entity_name("zp_forcefield")
	
	// New round starting
	g_newround = true
	g_endround = false
	g_survround = false
	g_nemround = false
	g_swarmround = false
	g_plagueround = false
	g_vipround = false
	g_armageddonround = false
	g_modestarted = false
	
	// Reset bought infection bombs counter
	g_infbombcounter = 0
	g_antidotecounter = 0
	g_madnesscounter = 0
	
	// Freezetime begins
	g_freezetime = true
	
	// Show welcome message and T-Virus notice
	remove_task(TASK_WELCOMEMSG)
	set_task(2.0, "welcome_msg", TASK_WELCOMEMSG)
	
	// Set a new "Make Zombie Task"
	remove_task(TASK_MAKEZOMBIE)
	set_task(2.0 + get_pcvar_float(cvar_warmup), "make_zombie_task", TASK_MAKEZOMBIE)
}

// Log Event Round Start
public logevent_round_start()
{
	// Freezetime ends
	g_freezetime = false
}

// Log Event Round End
public logevent_round_end()
{
	// Prevent this from getting called twice when restarting (bugfix)
	static Float:lastendtime, Float:current_time
	current_time = get_gametime()
	if (current_time - lastendtime < 0.5) return;
	lastendtime = current_time
	
	// Round ended
	g_endround = true
	g_modestarted = false
	
	// Stop old tasks (if any)
	remove_task(TASK_WELCOMEMSG)
	remove_task(TASK_MAKEZOMBIE)
	remove_task(TASK_MINUTENEMESIS)
	
	// Stop ambience sounds
	if ((g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS] && g_nemround) || (g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR] && g_survround) || (g_ambience_sounds[AMBIENCE_SOUNDS_SWARM] && g_swarmround) || (g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE] && g_plagueround)
	|| (g_ambience_sounds[AMBIENCE_SOUNDS_ARMAGEDDON] && g_vipround) || (g_ambience_sounds[AMBIENCE_SOUNDS_VIP] && g_vipround) || (g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION] && !g_nemround && !g_survround && !g_swarmround && !g_plagueround && !g_armageddonround && !g_vipround))
	{
		remove_task(TASK_AMBIENCESOUNDS)
		ambience_sound_stop()
	}
	
	// Show HUD notice, play win sound, update team scores...
	static sound[64]
	if (!fnGetZombies())
	{
		// Human team wins
		set_dhudmessage(30, 144, 255, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0)
		show_dhudmessage(0, "%L", LANG_PLAYER, "WIN_HUMAN")
		
		// Play win sound and increase score, unless game commencing
		ArrayGetString(sound_win_humans, random_num(0, ArraySize(sound_win_humans) - 1), sound, charsmax(sound))
		PlayGlobalSound(sound)
		if (!g_gamecommencing) g_scorehumans++
		
		// Round end forward
		ExecuteForward(g_fwRoundEnd, g_fwDummyResult, ZP_TEAM_HUMAN);
		
		// Reward humans
		for (new id = 1; id <= g_maxplayers; id++)
			if (g_isconnected[id] && !g_zombie[id] && fm_cs_get_user_team(id) == FM_CS_TEAM_CT)
				g_db_roundswon[id]++
	}
	else if (!fnGetHumans())
	{
		// Zombie team wins
		set_dhudmessage(200, 0, 0, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0)
		show_dhudmessage(0, "%L", LANG_PLAYER, "WIN_ZOMBIE")
		
		// Play win sound and increase score, unless game commencing
		ArrayGetString(sound_win_zombies, random_num(0, ArraySize(sound_win_zombies) - 1), sound, charsmax(sound))
		PlayGlobalSound(sound)
		if (!g_gamecommencing) g_scorezombies++
		
		// Round end forward
		ExecuteForward(g_fwRoundEnd, g_fwDummyResult, ZP_TEAM_ZOMBIE);
		
		// Reward humans
		for (new id = 1; id <= g_maxplayers; id++)
			if (g_isconnected[id] && g_zombie[id])
				g_db_roundswon[id]++
	}
	else
	{
		// No one wins
		set_dhudmessage(0, 200, 0, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0)
		show_dhudmessage(0, "%L", LANG_PLAYER, "WIN_NO_ONE")
		
		// Play win sound
		ArrayGetString(sound_win_no_one, random_num(0, ArraySize(sound_win_no_one) - 1), sound, charsmax(sound))
		PlayGlobalSound(sound)
		
		// Round end forward
		ExecuteForward(g_fwRoundEnd, g_fwDummyResult, ZP_TEAM_NO_ONE);
	}
	
	// Game commencing triggers round end
	g_gamecommencing = false
	
	// Balance the teams
	balance_teams()
}

// Event Map Ended
public event_intermission()
{
	// Remove ambience sounds task
	remove_task(TASK_AMBIENCESOUNDS)
}

// BP Ammo update
public event_ammo_x(id)
{
	// Humans only
	if (g_zombie[id])
		return;
	
	// Get ammo type
	static type
	type = read_data(1)
	
	// Unknown ammo type
	if (type >= sizeof AMMOWEAPON)
		return;
	
	// Get weapon's id
	static weapon
	weapon = AMMOWEAPON[type]
	
	// Primary and secondary only
	if (MAXBPAMMO[weapon] <= 2)
		return;
	
	// Get ammo amount
	static amount
	amount = read_data(2)
	
	// Unlimited BP Ammo?
	if (g_survivor[id] ? get_pcvar_num(cvar_survinfammo) : get_pcvar_num(cvar_infammo))
	{
		if (amount < MAXBPAMMO[weapon])
		{
			// The BP Ammo refill code causes the engine to send a message, but we
			// can't have that in this forward or we risk getting some recursion bugs.
			// For more info see: https://bugs.alliedmods.net/show_bug.cgi?id=3664
			static args[1]
			args[0] = weapon
			set_task(0.1, "refill_bpammo", id, args, sizeof args)
		}
	}
	// Bots automatically buy ammo when needed
	else if (g_isbot[id] && amount <= BUYAMMO[weapon])
	{
		// Task needed for the same reason as above
		set_task(0.1, "clcmd_buyammo", id)
	}
}

/*================================================================================
 [Main Forwards]
=================================================================================*/

// Entity Spawn Forward
public fw_Spawn(entity)
{
	// Invalid entity
	if (!pev_valid(entity)) return FMRES_IGNORED;
	
	// Get classname
	new classname[32], objective[32], size = ArraySize(g_objective_ents)
	pev(entity, pev_classname, classname, charsmax(classname))
	
	// Check whether it needs to be removed
	for (new i = 0; i < size; i++)
	{
		ArrayGetString(g_objective_ents, i, objective, charsmax(objective))
		
		if (equal(classname, objective))
		{
			engfunc(EngFunc_RemoveEntity, entity)
			return FMRES_SUPERCEDE;
		}
	}
	
	return FMRES_IGNORED;
}

// Sound Precache Forward
public fw_PrecacheSound(const sound[])
{
	// Block all those unneeeded hostage sounds
	if (equal(sound, "hostage", 7))
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}

// Ham Player Spawn Post Forward
public fw_PlayerSpawn_Post(id)
{
	// Not alive or didn't join a team yet
	if (!is_user_alive(id) || !fm_cs_get_user_team(id))
		return;
	
	// Player spawned
	g_isalive[id] = true
	
	// Remove previous tasks
	remove_task(id+TASK_SPAWN)
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	remove_task(id+TASK_FREEZE)
	remove_task(id+TASK_CHARGE)
	remove_task(id+TASK_FLASH)
	
	// Remove nightvision (bugfix)
	set_user_gnvision(id, 0)
	g_nvision[id] = false
	g_nvisionenabled[id] = false
	
	// Spawn at a random location?
	if (get_pcvar_num(cvar_randspawn)) do_random_spawn(id)
	
	// Hide money?
	if (get_pcvar_num(cvar_removemoney))
		set_task(0.4, "task_hide_money", id+TASK_SPAWN)
	
	// Respawn player if he dies because of a worldspawn kill?
	if (get_pcvar_num(cvar_respawnworldspawnkill))
		set_task(2.0, "respawn_player_check_task", id+TASK_SPAWN)
	
	// Spawn as zombie?
	if (g_respawn_as_zombie[id] && !g_newround)
	{
		reset_vars(id, 0) // reset player vars
		zombieme(id, 0, 0, 0, 0) // make him zombie right away
		return;
	}
	
	// Reset player vars
	reset_vars(id, 0)
	
	// Set selected human class
	g_humanclass[id] = g_humanclassnext[id]
	// If no class selected yet, use the first (default) one
	if (g_humanclass[id] == HCLASS_NONE) g_humanclass[id] = 0
	
	// Set new knife
	g_knife[id] = g_db_knife[id]
	
	// Set new ammo
	g_ammo[id] = g_db_ammo[id]
	
	// Cache speed and name for player's class
	g_human_spd[id] = calculate_maxspeed(id)
	ArrayGetString(g_hclass_name, g_humanclass[id], g_human_classname[id], charsmax(g_human_classname[]))
	
	// Set health and gravity
	set_pev(id, pev_health, calculate_hhealth(id))
	set_pev(id, pev_gravity, Float:ArrayGetCell(g_hclass_grav, g_humanclass[id]))
	
	// Set human maxspeed
	ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
	
	// Set armor
	static hclass_ap
	hclass_ap = floatround(calculate_harmor(id))
	
	if (hclass_ap > 0)
		cs_set_user_armor(id, hclass_ap, CS_ARMOR_VESTHELM)
	
	// Give Equipment
	give_equipment(id)
	
	// Switch to CT if spawning mid-round
	if (!g_newround && fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
	{
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
		fm_user_team_update(id)
	}
	
	// Custom models stuff
	static currentmodel[32], tempmodel[32], already_has_model, i, iRand
	already_has_model = false
	
	if (g_handle_models_on_separate_ent)
	{
		iRand = random_num(ArrayGetCell(g_hclass_modelsstart, g_humanclass[id]), ArrayGetCell(g_hclass_modelsend, g_humanclass[id]) - 1)
		ArrayGetString(g_hclass_playermodel, iRand, g_playermodel[id], charsmax(g_playermodel[]))
		if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_hclass_modelindex, iRand))
		
		// Set model on player model entity
		fm_set_playermodel_ent(id)
		
		// Remove glow on player model entity
		fm_set_rendering(g_ent_playermodel[id])
	}
	else
	{
		// Get current model for comparing it with the current one
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		for (i = ArrayGetCell(g_hclass_modelsstart, g_humanclass[id]); i < ArrayGetCell(g_hclass_modelsend, g_humanclass[id]); i++)
		{
			ArrayGetString(g_hclass_playermodel, i, tempmodel, charsmax(tempmodel))
			if (equal(currentmodel, tempmodel)) already_has_model = true
		}
		
		if (!already_has_model)
		{
			iRand = random_num(ArrayGetCell(g_hclass_modelsstart, g_humanclass[id]), ArrayGetCell(g_hclass_modelsend, g_humanclass[id]) - 1)
			ArrayGetString(g_hclass_playermodel, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_hclass_modelindex, iRand))
		}
	
		// Need to change the model?
		if (!already_has_model)
		{
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if (g_newround)
				set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else
				fm_user_model_update(id+TASK_MODEL)
		}
		
		// Remove glow
		fm_set_rendering(id)
	}
	
	// Bots stuff
	if (g_isbot[id])
	{
		// Turn off NVG for bots
		cs_set_user_nvg(id, 0)
		
		// Automatically buy extra items/weapons after first zombie is chosen
		if (get_pcvar_num(cvar_extraitems))
		{
			if (g_newround) set_task(10.0 + get_pcvar_float(cvar_warmup), "bot_buy_extras", id+TASK_SPAWN)
			else set_task(10.0, "bot_buy_extras", id+TASK_SPAWN)
		}
	}
	
	// Enable spawn protection for humans spawning mid-round
	if (!g_newround && get_pcvar_float(cvar_spawnprotection) > 0.0)
	{
		// Do not take damage
		g_nodamage[id] = true
		
		// Make temporarily invisible
		set_pev(id, pev_effects, pev(id, pev_effects) | EF_NODRAW)
		
		// Set task to remove it
		set_task(get_pcvar_float(cvar_spawnprotection), "remove_spawn_protection", id+TASK_SPAWN)
	}
	
	// Turn off his flashlight (prevents double flashlight bug/exploit)
	turn_off_flashlight(id)
	
	// Set the flashlight charge task to update battery status
	if (g_cached_customflash)
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b")
	
	// Replace weapon models (bugfix)
	static weapon_ent
	weapon_ent = fm_cs_get_current_weapon_ent(id)
	if (pev_valid(weapon_ent)) replace_weapon_models(id, cs_get_weapon_id(weapon_ent))
	
	// Last Zombie Check
	fnCheckLastZombie()
}

// Ham Player Killed Forward
public fw_PlayerKilled(victim, attacker, shouldgib)
{
	// Player killed
	g_isalive[victim] = false
	// Disable nodamage mode after we die to prevent spectator nightvision using zombie madness colors bug
	g_nodamage[victim] = false
	
	// Enable dead players nightvision
	set_task(0.1, "spec_nvision", victim)
	
	// Turn off custom flashlight when killed
	if (g_cached_customflash)
	{
		// Turn it off
		g_flashlight[victim] = false
		g_flashbattery[victim] = 100
		
		// Remove previous tasks
		remove_task(victim+TASK_CHARGE)
		remove_task(victim+TASK_FLASH)
	}
	
	// Stop bleeding/burning/aura when killed
	if (g_zombie[victim])
	{
		remove_task(victim+TASK_BLOOD)
		remove_task(victim+TASK_AURA)
		remove_task(victim+TASK_BURN)
		remove_task(victim+TASK_FREEZE)
	}
	
	// Nemesis explodes!
	if (g_nemesis[victim])
		SetHamParamInteger(3, 2)
	
	// Determine whether the player killed himself
	static selfkill
	selfkill = (victim == attacker || !is_user_valid_connected(attacker)) ? true : false
	
	// Killed by a non-player entity or self killed
	if (selfkill) return;
	
	// Ignore Nemesis/Survivor Frags?
	if ((g_nemesis[attacker] && get_pcvar_num(cvar_nemignorefrags)) || (g_survivor[attacker] && get_pcvar_num(cvar_survignorefrags)))
		RemoveFrags(attacker, victim)
	
	// Human killed zombie
	if (!g_zombie[attacker])
	{
		// add up the extra frags for kill
		if (get_pcvar_num(cvar_fragskill) > 1)
			UpdateFrags(attacker, victim, get_pcvar_num(cvar_fragskill) - 1, 0, 0)
		
		// Add to total counter
		g_db_zombieskilled[attacker]++
	}
	
	// Zombie killed human
	if (g_zombie[attacker])
	{
		// add up the extra frags for kill
		if (get_pcvar_num(cvar_fragsinfect) > 1)
			UpdateFrags(attacker, victim, get_pcvar_num(cvar_fragsinfect) - 1, 0, 0)
		
		// Add to total counter
		g_db_humansinfected[attacker]++
	}
}

// Ham Player Killed Post Forward
public fw_PlayerKilled_Post(victim, attacker, shouldgib)
{
	// Last Zombie Check
	fnCheckLastZombie()
	
	// Check last VIP
	if (g_vipround && fnGetAliveVIPs() == 0)
	{
		for (new i = 1; i <= g_maxplayers; i++)
		{
			if (g_isalive[i] && !g_zombie[i])
			{
				set_pev(i, pev_frags, pev(i, pev_frags)+1.0)
				user_silentkill(i)
			}
		}
		
		client_print(0, print_center, "All VIPs have been assassinated!")
	}
	
	// Determine whether the player killed himself
	static selfkill
	selfkill = (victim == attacker || !is_user_valid_connected(attacker)) ? true : false
	
	// Respawn if deathmatch is enabled
	if (get_pcvar_num(cvar_deathmatch))
	{
		// Respawn on suicide?
		if (selfkill && !get_pcvar_num(cvar_respawnonsuicide))
			return;
		
		// Respawn if human/zombie/nemesis/survivor?
		if ((g_zombie[victim] && !g_nemesis[victim] && !get_pcvar_num(cvar_respawnzomb)) || (!g_zombie[victim] && !g_survivor[victim] && !get_pcvar_num(cvar_respawnhum)) || (g_nemesis[victim] && !get_pcvar_num(cvar_respawnnem)) || (g_survivor[victim] && !get_pcvar_num(cvar_respawnsurv)))
			return;
		
		// Set the respawn task
		set_task(get_pcvar_float(cvar_spawndelay), "respawn_player_task", victim+TASK_SPAWN)
	}
}

// Fakemeta TraceLine Forward
public fw_TraceLine(Float:vector_start[3], Float:vector_end[3], ignored_monster, id, handle)
{
	if (!is_user_alive(id))
		return FMRES_IGNORED;
	
	if (get_user_weapon(id) != CSW_KNIFE)
		return FMRES_IGNORED;
	
	static Float:slash_range, Float:stab_range
	if (g_zombie[id])
	{
		slash_range = 48.0
		stab_range = 32.0
		
		// Extended Claws upgrade?
		if (has_upgrade(id, UPGRADE_ZOMBIE_EXTENDED_CLAWS))
		{
			slash_range += 5.0
			stab_range += 5.0
		}
	}
	else
	{
		slash_range = Float:ArrayGetCell(g_knife_slash, g_knife[id])
		stab_range = Float:ArrayGetCell(g_knife_stab, g_knife[id])
	}
	
	static button
	button = pev(id, pev_button)
	
	if (button & IN_ATTACK) // slash
	{
		pev(id, pev_v_angle, vector_end)
		angle_vector(vector_end, ANGLEVECTOR_FORWARD, vector_end)
		xs_vec_mul_scalar(vector_end, slash_range, vector_end)
		xs_vec_add(vector_start, vector_end, vector_end)
		engfunc(EngFunc_TraceLine, vector_start, vector_end, ignored_monster, id, handle)
		return FMRES_SUPERCEDE;
	}
	else if (button & IN_ATTACK2) // stab
	{
		pev(id, pev_v_angle, vector_end)
		angle_vector(vector_end, ANGLEVECTOR_FORWARD, vector_end)
		xs_vec_mul_scalar(vector_end, stab_range, vector_end)
		xs_vec_add(vector_start, vector_end, vector_end)
		engfunc(EngFunc_TraceLine, vector_start, vector_end, ignored_monster, id, handle)
		return FMRES_SUPERCEDE;
	}
	
	return FMRES_IGNORED;
}

// Fakemeta TraceHull Forward
public fw_TraceHull(Float:vector_start[3], Float:vector_end[3], ignored_monster, hull, id, handle)
{
	if (!is_user_alive(id))
		return FMRES_IGNORED;
	
	if (get_user_weapon(id) != CSW_KNIFE)
		return FMRES_IGNORED;
	
	static Float:slash_range, Float:stab_range
	if (g_zombie[id])
	{
		slash_range = 48.0
		stab_range = 32.0
		
		// Extended Claws upgrade?
		if (has_upgrade(id, UPGRADE_ZOMBIE_EXTENDED_CLAWS))
		{
			slash_range += 5.0
			stab_range += 5.0
		}
	}
	else
	{
		slash_range = Float:ArrayGetCell(g_knife_slash, g_knife[id])
		stab_range = Float:ArrayGetCell(g_knife_stab, g_knife[id])
	}
	
	static button
	button = pev(id, pev_button)
	
	if (button & IN_ATTACK) // slash
	{
		pev(id, pev_v_angle, vector_end)
		angle_vector(vector_end, ANGLEVECTOR_FORWARD, vector_end)
		xs_vec_mul_scalar(vector_end, slash_range, vector_end)
		xs_vec_add(vector_start, vector_end, vector_end)
		engfunc(EngFunc_TraceHull, vector_start, vector_end, ignored_monster, hull, id, handle)
		return FMRES_SUPERCEDE;
	}
	else if (button & IN_ATTACK2) // stab
	{
		pev(id, pev_v_angle, vector_end)
		angle_vector(vector_end, ANGLEVECTOR_FORWARD, vector_end)
		xs_vec_mul_scalar(vector_end, stab_range, vector_end)
		xs_vec_add(vector_start, vector_end, vector_end)
		engfunc(EngFunc_TraceHull, vector_start, vector_end, ignored_monster, hull, id, handle)
		return FMRES_SUPERCEDE;
	}
	
	return FMRES_IGNORED;
}

// Ham Take Damage Forward
public fw_TakeDamage(victim, inflictor, attacker, Float:damage, damage_type)
{
	// Non-player damage or self damage
	if (victim == attacker || !is_user_valid_connected(attacker))
		return HAM_IGNORED;
	
	// New round starting or round ended
	if (g_newround || g_endround)
		return HAM_SUPERCEDE;
	
	// Victim shouldn't take damage or victim is frozen
	if (g_nodamage[victim] || g_freezing_duration[victim])
		return HAM_SUPERCEDE;
	
	// Prevent friendly fire
	if (g_zombie[attacker] == g_zombie[victim])
		return HAM_SUPERCEDE;
	
	// Attacker is human...
	if (!g_zombie[attacker])
	{
		if (g_survivor[attacker])
			return HAM_IGNORED;
		
		static weapon
		weapon = get_user_weapon(attacker)
		
		// Ammo types
		if (weapon != CSW_KNIFE)
		{
			switch (g_ammo[attacker])
			{
				case AMMO_FROSTBITE: damage += (weapon == CSW_M3 ? 15.0 : 3.0);
				case AMMO_INCENDIARY: damage += (weapon == CSW_M3 ? 40.0 : 8.0);
				case AMMO_POISON: damage += (weapon == CSW_M3 ? 70.0 : 14.0);
			}
			
			// Ammunition effects
			ammo_effect(victim, attacker, weapon)
		}
		
		// Variables
		static Float:victimHP, Float:percentModifier
		pev(victim, pev_health, victimHP)
		percentModifier = Float:ArrayGetCell(g_zclass_armor, g_zombieclass[victim])
		
		switch (weapon)
		{
			case CSW_KNIFE: // Knife
			{
				static stab
				stab = pev(attacker, pev_button) & IN_ATTACK2
				
				switch (g_knife[attacker])
				{
					case 0: // Seal Knife
					{
						damage = stab ? 150.0 : 50.0
					}
					case 1: // Executioner's Axe
					{
						if (stab)
						{
							// Damage based on percentage of missing health
							static Float:missing_health
							missing_health = calculate_zhealth(victim, false) - pev(victim, pev_health)
							
							damage = missing_health*0.25
							
							if (damage < 100.0) damage = 100.0
						}
						else
						{
							damage = 200.0
						}
					}
					case 2: // Sledgehammer
					{
						if (stab)
						{
							damage = calculate_zhealth(victim)*0.15
						}
						else
						{
							damage = 200.0
						}
					}
					case 3: // Dragon Glaive
					{
						if (stab)
						{
							damage = 250.0
						}
						else
						{
							damage = 300.0
						}
					}
				}
			}
			case CSW_M249: // Death Machine
			{
				percentModifier += 0.2 // increase by 20%
			}
			case CSW_M3: // SPAS-12
			{
				//percentModifier -= 0.4 // increase by 20%
				
				if (g_humanclass[attacker] == 3) // survivalist class
					percentModifier += 0.1
			}
			case CSW_AWP: // Sako TRG
			{
				percentModifier += 0.2 // increase by 20%
			}
			case CSW_DEAGLE: // El Diablo
			{
				percentModifier += 0.3 // increase by 30%
			}
			case CSW_GLOCK18: // G18
			{
				percentModifier -= 0.4 // decrease by 40%
			}
			case CSW_ELITE: // Dual Infinity
			{
				percentModifier += 0.2 // decrease by 40%
			}
		}
		
		// Executioner upgrade?
		if (victimHP < float(ArrayGetCell(g_zclass_hp, g_zombieclass[victim]))*0.4 && has_upgrade(attacker, UPGRADE_HUMAN_EXECUTIONER))
			percentModifier += 0.1 // increase by 10%
		
		// Bloody Blade upgrade?
		if (weapon == CSW_KNIFE && has_upgrade(attacker, UPGRADE_HUMAN_BLOODY_BLADE))
			percentModifier += 0.2 // increase by 20%
		
		// Zombie classes
		switch (g_zombieclass[victim])
		{
			case 0: // Skeleton
			{
				// double the damage if attacker is using silver bullets
				if (g_ammo[attacker] == AMMO_SILVER)
					percentModifier *= 2.0
			}
			case 1: // Boomer
			{
				// half the damage if it exceeds 300
				if (damage > 300.0)
					percentModifier /= 2.0
			}
			case 3: // Venom Guard
			{
				if (damage > 250.0) percentModifier /= 2.0 // half
			}
		}
		// Protector upgrade?
		if (victimHP < float(ArrayGetCell(g_zclass_hp, g_zombieclass[victim]))*0.5 && has_upgrade(victim, UPGRADE_ZOMBIE_PROTECTOR))
			percentModifier -= 0.1 // decrease by 10%
		
		// Finished percentage modification
		damage *= percentModifier
		
		// No damage?
		if (damage <= 0.0)
			return HAM_SUPERCEDE;
		
		// Finally set the damage
		SetHamParamFloat(4, damage)
		return HAM_IGNORED;
	}
	
	// Attacker is zombie...
	
	// Prevent infection/damage by HE grenade (bugfix)
	if (damage_type & DMG_HEGRENADE)
		return HAM_SUPERCEDE;
	
	// Nemesis?
	if (g_nemesis[attacker])
	{
		// Ignore nemesis damage override if damage comes from a 3rd party entity
		// (to prevent this from affecting a sub-plugin's rockets e.g.)
		if (inflictor == attacker)
		{
			// Set nemesis damage
			SetHamParamFloat(4, get_pcvar_float(cvar_nemdamage))
		}
		
		return HAM_IGNORED;
	}
	
	// Not an infection round
	if (g_survround || g_nemround || g_swarmround || g_plagueround || g_armageddonround)
		return HAM_IGNORED; // human is killed
	
	// Does human armor need to be reduced before infecting?
	if (get_pcvar_num(cvar_humanarmor))
	{
		// Variables
		static Float:percentModifier
		percentModifier = Float:ArrayGetCell(pev(attacker, pev_button) & IN_ATTACK2 ? g_zclass_stabdmg : g_zclass_slashdmg, g_zombieclass[attacker])
		
		// Bloody Blade upgrade?
		if (get_user_weapon(attacker) == CSW_KNIFE && has_upgrade(attacker, UPGRADE_ZOMBIE_DEADLY_CLAWS))
			percentModifier += 0.2 // increase by 20%
		
		// Set damage
		damage *= percentModifier
		
		// No damage?
		if (damage <= 0.0)
			return HAM_SUPERCEDE;
		
		// Get victim armor
		static Float:armor
		pev(victim, pev_armorvalue, armor)
		
		// If he has some, block the infection and reduce armor instead
		if (armor > 0.0)
		{
			emit_sound(victim, CHAN_BODY, sound_armorhit, 1.0, ATTN_NORM, 0, PITCH_NORM)
			if (armor - damage > 0.0)
				set_pev(victim, pev_armorvalue, armor - damage)
			else
				cs_set_user_armor(victim, 0, CS_ARMOR_NONE)
			return HAM_SUPERCEDE;
		}
	}
	
	// Last human?
	if (fnGetHumans() == 1)
		return HAM_IGNORED;
	
	// Infection allowed
	zombieme(victim, attacker, 0, 0, 1) // turn into zombie
	
	// unstable code
	if (g_vipround && fnGetAliveVIPs() == 0)
	{
		for (new i = 1; i <= g_maxplayers; i++)
		{
			if (g_isalive[i] && !g_zombie[i])
			{
				user_silentkill(i)
			}
		}
		
		client_print(0, print_center, "All VIPs have been assassinated!")
	}
	return HAM_SUPERCEDE;
}

// Ham Take Damage Post Forward
public fw_TakeDamage_Post(victim, inflictor, attacker, Float:damage)
{
	// Show damage?
	if (is_user_valid_alive(attacker) && access(attacker, ADMIN_LEVEL_H))
	{
		client_print(attacker, print_center, "%s - DMG: %d - HP: %d", g_playername[victim], floatround(damage), get_user_health(victim))
	}
	
	// --- Check if victim should be Pain Shock Free ---
	
	// Check if proper CVARs are enabled
	if (g_zombie[victim])
	{
		if (g_nemesis[victim])
		{
			if (!get_pcvar_num(cvar_nempainfree)) return;
		}
		else
		{
			switch (get_pcvar_num(cvar_zombiepainfree))
			{
				case 0: return;
				case 2: if (!g_lastzombie[victim]) return;
				case 3: if (!g_firstzombie[victim]) return;
			}
		}
	}
	else
	{
		if (g_survivor[victim])
		{
			if (!get_pcvar_num(cvar_survpainfree)) return;
		}
		else return;
	}
	
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(victim) != PDATA_SAFE)
		return;
	
	// Set pain shock free offset
	set_pdata_float(victim, OFFSET_PAINSHOCK, 1.0, OFFSET_LINUX)
}


ammo_effect(id, attacker, weapon)
{
	// calculate stacks to be added
	static add_stacks
	switch (weapon)
	{
		case CSW_M3: add_stacks = 5;
		default: add_stacks = 1;
	}
	
	// add the stacks, check if over the limit, apply effect
	switch (g_ammo[attacker])
	{
		case AMMO_NORMAL: return;
		case AMMO_FROSTBITE:
		{
			// add the stacks
			g_ammostacks_frostbite[id] += add_stacks
			
			// apply the effect?
			if (g_ammostacks_frostbite[id] >= AMMOSTACKS_FROSTBITE)
			{
				// reset stack counter
				g_ammostacks_frostbite[id] = 0
				
				// effect
				freeze_player(id, attacker, Float:{0.0, 0.0, 0.0}, 5.0, false)
			}
		}
		case AMMO_INCENDIARY:
		{
			// add the stacks
			g_ammostacks_incendiary[id] += add_stacks
			
			// apply the effect?
			if (g_ammostacks_incendiary[id] >= AMMOSTACKS_INCENDIARY)
			{
				// reset stack counter
				g_ammostacks_incendiary[id] = 0
				
				// effect, Set fire duration
				g_burning_duration[id] += 5
				
				// Our task params
				static params[1]
				params[0] = attacker
				
				// Set burning task on victim
				set_task(0.2, "burning_flame", id+TASK_BURN, params, sizeof(params), "b")
			}
		}
		case AMMO_POISON:
		{
			// add the stacks
			g_ammostacks_poison[id] += add_stacks
			
			// apply the effect?
			if (g_ammostacks_poison[id] >= AMMOSTACKS_POISON)
			{
				// reset stack counter
				g_ammostacks_poison[id] = 0
				
				// effect
				TakeDamage(id, attacker, "poison", 70.0, DMG_POISON)
			}
		}
	}
}

// Ham Trace Attack Forward
public fw_TraceAttack(victim, attacker, Float:damage, Float:direction[3], tracehandle, damage_type)
{
	// Non-player damage or self damage
	if (victim == attacker || !is_user_valid_connected(attacker))
		return HAM_IGNORED;
	
	// New round starting or round ended
	if (g_newround || g_endround)
		return HAM_SUPERCEDE;
	
	// Victim shouldn't take damage or victim is frozen
	if (g_nodamage[victim] || g_freezing_duration[victim])
		return HAM_SUPERCEDE;
	
	// Prevent friendly fire
	if (g_zombie[attacker] == g_zombie[victim])
		return HAM_SUPERCEDE;
	
	// Victim isn't a zombie or not bullet damage, nothing else to do here
	if (!g_zombie[victim] || !(damage_type & DMG_BULLET))
		return HAM_IGNORED;
	
	// If zombie hitzones are enabled, check whether we hit an allowed one
	if (get_pcvar_num(cvar_hitzones) && !g_nemesis[victim] && !(get_pcvar_num(cvar_hitzones) & (1<<get_tr2(tracehandle, TR_iHitgroup))))
		return HAM_SUPERCEDE;
	
	// Knockback disabled, nothing else to do here
	if (!get_pcvar_num(cvar_knockback))
		return HAM_IGNORED;
	
	// Nemesis knockback disabled, nothing else to do here
	if (g_nemesis[victim] && get_pcvar_float(cvar_nemknockback) == 0.0)
		return HAM_IGNORED;
	
	// Get whether the victim is in a crouch state
	static ducking
	ducking = pev(victim, pev_flags) & (FL_DUCKING | FL_ONGROUND) == (FL_DUCKING | FL_ONGROUND)
	
	// Zombie knockback when ducking disabled
	if (ducking && get_pcvar_float(cvar_knockbackducking) == 0.0)
		return HAM_IGNORED;
	
	// Get distance between players
	static origin1[3], origin2[3]
	get_user_origin(victim, origin1)
	get_user_origin(attacker, origin2)
	
	// Max distance exceeded
	if (get_distance(origin1, origin2) > get_pcvar_num(cvar_knockbackdist))
		return HAM_IGNORED;
	
	// Get victim's velocity
	static Float:velocity[3]
	pev(victim, pev_velocity, velocity)
	
	// Use damage on knockback calculation
	if (get_pcvar_num(cvar_knockbackdamage))
		xs_vec_mul_scalar(direction, damage, direction)
	
	// Use weapon power on knockback calculation
	if (get_pcvar_num(cvar_knockbackpower) && kb_weapon_power[g_currentweapon[attacker]] > 0.0)
		xs_vec_mul_scalar(direction, kb_weapon_power[g_currentweapon[attacker]], direction)
	
	// Apply ducking knockback multiplier
	if (ducking)
		xs_vec_mul_scalar(direction, get_pcvar_float(cvar_knockbackducking), direction)
	
	// Apply zombie class/nemesis knockback multiplier
	if (g_nemesis[victim])
		xs_vec_mul_scalar(direction, get_pcvar_float(cvar_nemknockback), direction)
	else
		xs_vec_mul_scalar(direction, g_zombie_knockback[victim], direction)
	
	// Add up the new vector
	xs_vec_add(velocity, direction, direction)
	
	// Should knockback also affect vertical velocity?
	if (!get_pcvar_num(cvar_knockbackzvel))
		direction[2] = velocity[2]
	
	// Set the knockback'd victim's velocity
	set_pev(victim, pev_velocity, direction)
	
	return HAM_IGNORED;
}

// Ham Reset MaxSpeed Post Forward
public fw_ResetMaxSpeed_Post(id)
{
	// Freezetime active or player not alive
	if (g_freezetime || !g_isalive[id])
		return;
	
	set_player_maxspeed(id)
}

// Ham Use Stationary Gun Forward
public fw_UseStationary(entity, caller, activator, use_type)
{
	// Prevent zombies from using stationary guns
	if (use_type == USE_USING && is_user_valid_connected(caller) && g_zombie[caller])
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Ham Use Stationary Gun Post Forward
public fw_UseStationary_Post(entity, caller, activator, use_type)
{
	// Someone stopped using a stationary gun
	if (use_type == USE_STOPPED && is_user_valid_connected(caller))
		replace_weapon_models(caller, g_currentweapon[caller]) // replace weapon models (bugfix)
}

// Ham Use Pushable Forward
public fw_UsePushable()
{
	// Prevent speed bug with pushables?
	if (get_pcvar_num(cvar_blockpushables))
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Ham Weapon Touch Forward
public fw_TouchWeapon(weapon, id)
{
	// Not a player
	if (!is_user_valid_connected(id))
		return HAM_IGNORED;
	
	// Dont pickup weapons if zombie or survivor (+PODBot MM fix)
	if (g_zombie[id] || g_vip[id] || (g_survivor[id] && !g_isbot[id]))
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Ham Weapon Pickup Forward
public fw_AddPlayerItem(id, weapon_ent)
{
	// HACK: Retrieve our custom extra ammo from the weapon
	static extra_ammo
	extra_ammo = pev(weapon_ent, PEV_ADDITIONAL_AMMO)
	
	// If present
	if (extra_ammo)
	{
		// Get weapon's id
		static weaponid
		weaponid = cs_get_weapon_id(weapon_ent)
		
		// Add to player's bpammo
		ExecuteHamB(Ham_GiveAmmo, id, extra_ammo, AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
		set_pev(weapon_ent, PEV_ADDITIONAL_AMMO, 0)
	}
}

// Ham Weapon Deploy Forward
public fw_Item_Deploy_Post(weapon_ent)
{
	// Get weapon's owner
	static owner
	owner = fm_cs_get_weapon_ent_owner(weapon_ent)
	
	// Valid owner?
	if (!pev_valid(owner))
		return;
	
	// Get weapon's id
	static weaponid
	weaponid = cs_get_weapon_id(weapon_ent)
	
	// Store current weapon's id for reference
	g_currentweapon[owner] = weaponid
	
	// Replace weapon models with custom ones
	replace_weapon_models(owner, weaponid)
	
	// Zombie not holding an allowed weapon for some reason
	if (g_zombie[owner] && !((1<<weaponid) & ZOMBIE_ALLOWED_WEAPONS_BITSUM))
	{
		// Switch to knife
		g_currentweapon[owner] = CSW_KNIFE
		engclient_cmd(owner, "weapon_knife")
	}
}

// Player's blood color
public fw_PlayerBloodColor(id)
{
	if (!is_user_alive(id))
		return HAM_IGNORED;
	
	if (g_survivor[id])
	{
		SetHamReturnInteger(208)
		return HAM_SUPERCEDE;
	}
	else if (g_zombie[id])
	{
		// silver bullets deal double damage to skeletons, set whitish blood
		if (g_zombieclass[id] == 0 && g_ammo[get_user_attacker(id)] == AMMO_SILVER)
		{
			SetHamReturnInteger(12)
			return HAM_SUPERCEDE;
		}
	}
	
	return HAM_IGNORED;
}

/*
// HE grenade is added to player
public fw_AddHEGrenadeToPlayer(ent, id)
{
	switch (g_grenade_slot1[id])
	{
		case NADE_TYPE_MOLOTOV:
		{
			message_begin(MSG_ONE, g_msgWeaponList, _, id)
			write_string("weapon_fzmmolotov");    // WeaponName
			write_byte(12);                   // PrimaryAmmoID
			write_byte(1);                   // PrimaryAmmoMaxAmount
			write_byte(-1);                   // SecondaryAmmoID
			write_byte(-1);                   // SecondaryAmmoMaxAmount
			write_byte(3);                    // SlotID (0...N)    <== Changed here (was 2)
			write_byte(1);                    // NumberInSlot (1...N)
			write_byte(CSW_HEGRENADE);            // WeaponID
			write_byte(24);                    // Flags
			message_end()
		}
	}
}
// Aliases
public fw_SelectMolotov(id) engclient_cmd(id, "weapon_hegrenade")

// Smoke grenade is added to player
public fw_AddSmokeGrenadeToPlayer(ent, id)
{
	switch (g_grenade_slot3[id])
	{
		case NADE_TYPE_FLARE:
		{
			message_begin(MSG_ONE, g_msgWeaponList, _, id)
			write_string("weapon_fzmflare");    // WeaponName
			write_byte(13);                   // PrimaryAmmoID
			write_byte(1);                   // PrimaryAmmoMaxAmount
			write_byte(-1);                   // SecondaryAmmoID
			write_byte(-1);                   // SecondaryAmmoMaxAmount
			write_byte(3);                    // SlotID (0...N)    <== Changed here (was 2)
			write_byte(3);                    // NumberInSlot (1...N)
			write_byte(CSW_SMOKEGRENADE);            // WeaponID
			write_byte(24);                    // Flags
			message_end()
		}
	}
}
// Aliases
public fw_SelectFlare(id) engclient_cmd(id, "weapon_smokegrenade")
*/

// Nemesis breakable damage fix
public fw_TakeDamage_Breakable(ent, inflictor, attacker)
{
	if (!is_user_valid_connected(attacker))
		return HAM_IGNORED;
	
	// Nemesis?
	if (g_nemesis[attacker])
	{
		// Ignore nemesis damage override if damage comes from a 3rd party entity
		// (to prevent this from affecting a sub-plugin's rockets e.g.)
		if (inflictor == attacker)
		{
			// Set nemesis damage
			SetHamParamFloat(4, get_pcvar_float(cvar_nemdamage))
		}
		
		return HAM_IGNORED;
	}
	
	return HAM_IGNORED;
}

// WeaponMod bugfix
// forward wpn_gi_reset_weapon(id)
public wpn_gi_reset_weapon(id)
{
	// Replace knife model
	replace_weapon_models(id, CSW_KNIFE)
}

// Client connects to the server
public client_connect(id)
{
	// Play loading sound
	static sound[64]
	ArrayGetString(sound_loading, random_num(0, ArraySize(sound_loading) - 1), sound, charsmax(sound))
	PlaySound(id, sound)
}

// Client joins the game
public client_putinserver(id)
{
	// Plugin disabled?
	if (!g_pluginenabled) return;
	
	// Player joined
	g_isconnected[id] = true
	
	// Stop loading sound
	StopSound(id)
	
	// Cache player's name
	get_user_name(id, g_playername[id], charsmax(g_playername[]))
	
	// Initialize player vars
	reset_vars(id, 1)
	
	// Set some tasks for humans only
	if (!is_user_bot(id))
	{
		// Set the custom HUD display task if enabled
		if (get_pcvar_num(cvar_huddisplay))
			set_task(1.0, "ShowHUD", id+TASK_SHOWHUD, _, _, "b")
		
		// Disable minmodels for clients to see zombies properly
		set_task(5.0, "disable_minmodels", id)
		
		// Get user auth
		get_user_authid(id, g_auth[id], charsmax(g_auth[]))
		if (g_auth[id][7] != ':') get_user_ip(id, g_auth[id], charsmax(g_auth[]), 1)
		
		// Playtime
		g_putinserver[id] = get_systime()
		
		// Load data
		load_data(id)
	}
	else
	{
		// Set bot flag
		g_isbot[id] = true
		
		// CZ bots seem to use a different "classtype" for player entities
		// (or something like that) which needs to be hooked separately
		if (!g_hamczbots && cvar_botquota)
		{
			// Set a task to let the private data initialize
			set_task(0.1, "register_ham_czbots", id)
		}
	}
}

// Client leaving
public fw_ClientDisconnect(id)
{
	// Check that we still have both humans and zombies to keep the round going
	if (g_isalive[id]) check_round(id)
	
	// Remove previous tasks
	remove_task(id+TASK_TEAM)
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_FLASH)
	remove_task(id+TASK_CHARGE)
	remove_task(id+TASK_SPAWN)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	remove_task(id+TASK_FREEZE)
	remove_task(id+TASK_SHOWHUD)
	
	if (g_handle_models_on_separate_ent)
	{
		// Remove custom model entities
		fm_remove_model_ents(id)
	}
	
	// Player left, clear cached flags
	g_isconnected[id] = false
	g_isbot[id] = false
	g_isalive[id] = false
}

// Client left
public fw_ClientDisconnect_Post()
{
	// Last Zombie Check
	fnCheckLastZombie()
}

// Client disconnected
public client_disconnect(id)
{
	// Save data
	if (g_db_id[id] != -1) save_data(id)
}

// Client Kill Forward
public fw_ClientKill()
{
	// Prevent players from killing themselves?
	if (get_pcvar_num(cvar_blocksuicide))
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}

// Emit Sound Forward
public fw_EmitSound(id, channel, const sample[], Float:volume, Float:attn, flags, pitch)
{
	// Block all those unneeeded hostage sounds
	if (sample[0] == 'h' && sample[1] == 'o' && sample[2] == 's' && sample[3] == 't' && sample[4] == 'a' && sample[5] == 'g' && sample[6] == 'e')
		return FMRES_SUPERCEDE;
	
	// Replace these next sounds for zombies only
	if (!is_user_valid_connected(id) || !g_zombie[id])
		return FMRES_IGNORED;
	
	static sound[64]
	
	// Zombie being hit
	if (sample[7] == 'b' && sample[8] == 'h' && sample[9] == 'i' && sample[10] == 't')
	{
		if (g_nemesis[id])
		{
			ArrayGetString(nemesis_pain, random_num(0, ArraySize(nemesis_pain) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
		}
		else
		{
			ArrayGetString(zombie_pain, random_num(0, ArraySize(zombie_pain) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
		}
		return FMRES_SUPERCEDE;
	}
	
	// Zombie attacks with knife
	if (sample[8] == 'k' && sample[9] == 'n' && sample[10] == 'i')
	{
		if (sample[14] == 's' && sample[15] == 'l' && sample[16] == 'a') // slash
		{
			ArrayGetString(zombie_miss_slash, random_num(0, ArraySize(zombie_miss_slash) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
			return FMRES_SUPERCEDE;
		}
		if (sample[14] == 'h' && sample[15] == 'i' && sample[16] == 't') // hit
		{
			if (sample[17] == 'w') // wall
			{
				ArrayGetString(zombie_miss_wall, random_num(0, ArraySize(zombie_miss_wall) - 1), sound, charsmax(sound))
				emit_sound(id, channel, sound, volume, attn, flags, pitch)
				return FMRES_SUPERCEDE;
			}
			else
			{
				ArrayGetString(zombie_hit_normal, random_num(0, ArraySize(zombie_hit_normal) - 1), sound, charsmax(sound))
				emit_sound(id, channel, sound, volume, attn, flags, pitch)
				return FMRES_SUPERCEDE;
			}
		}
		if (sample[14] == 's' && sample[15] == 't' && sample[16] == 'a') // stab
		{
			ArrayGetString(zombie_hit_stab, random_num(0, ArraySize(zombie_hit_stab) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
			return FMRES_SUPERCEDE;
		}
	}
	
	// Zombie dies
	if (sample[7] == 'd' && ((sample[8] == 'i' && sample[9] == 'e') || (sample[8] == 'e' && sample[9] == 'a')))
	{
		ArrayGetString(zombie_die, random_num(0, ArraySize(zombie_die) - 1), sound, charsmax(sound))
		emit_sound(id, channel, sound, volume, attn, flags, pitch)
		return FMRES_SUPERCEDE;
	}
	
	// Zombie falls off
	if (sample[10] == 'f' && sample[11] == 'a' && sample[12] == 'l' && sample[13] == 'l')
	{
		ArrayGetString(zombie_fall, random_num(0, ArraySize(zombie_fall) - 1), sound, charsmax(sound))
		emit_sound(id, channel, sound, volume, attn, flags, pitch)
		return FMRES_SUPERCEDE;
	}
	
	return FMRES_IGNORED;
}

// Forward Set ClientKey Value -prevent CS from changing player models-
public fw_SetClientKeyValue(id, const infobuffer[], const key[])
{
	// Block CS model changes
	if (key[0] == 'm' && key[1] == 'o' && key[2] == 'd' && key[3] == 'e' && key[4] == 'l')
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}

// Forward Client User Info Changed -prevent players from changing models-
public fw_ClientUserInfoChanged(id)
{
	// Cache player's name
	get_user_name(id, g_playername[id], charsmax(g_playername[]))
	
	if (!g_handle_models_on_separate_ent)
	{
		// Get current model
		static currentmodel[32]
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// If they're different, set model again
		if (!equal(currentmodel, g_playermodel[id]) && !task_exists(id+TASK_MODEL))
			fm_cs_set_user_model(id+TASK_MODEL)
	}
}

// Forward Set Model
public fw_SetModel(entity, const model[])
{
	// We don't care
	if (strlen(model) < 8)
		return FMRES_IGNORED;
	
	// Get entity's classname
	static classname[10]
	pev(entity, pev_classname, classname, charsmax(classname))
	
	// Remove weapons?
	if (get_pcvar_float(cvar_removedropped) > 0.0)
	{
		// Get entity's classname
		static classname[10]
		pev(entity, pev_classname, classname, charsmax(classname))
		
		// Check if it's a weapon box
		if (equal(classname, "weaponbox"))
		{
			// They get automatically removed when thinking
			set_pev(entity, pev_nextthink, get_gametime() + get_pcvar_float(cvar_removedropped))
			return FMRES_IGNORED;
		}
	}
	
	// Narrow down our matches a bit
	if (model[7] != 'w' || model[8] != '_')
		return FMRES_IGNORED;
	
	// Get damage time of grenade
	static Float:dmgtime
	pev(entity, pev_dmgtime, dmgtime)
	
	// Grenade not yet thrown
	if (dmgtime == 0.0)
		return FMRES_IGNORED;
	
	// Grenade's thrower
	static owner
	owner = pev(entity, pev_owner)
	
	// Get whether grenade's owner is a zombie
	if (g_zombie[owner])
	{
		if (model[9] == 'h' && model[10] == 'e' && get_pcvar_num(cvar_extrainfbomb)) // Infection Bomb
		{
			// Give it a glow
			fm_set_rendering(entity, kRenderFxGlowShell, 0, 200, 0, kRenderNormal, 16);
			
			// And a colored trail
			message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
			write_byte(TE_BEAMFOLLOW) // TE id
			write_short(entity) // entity
			write_short(g_trailSpr) // sprite
			write_byte(10) // life
			write_byte(10) // width
			write_byte(0) // r
			write_byte(200) // g
			write_byte(0) // b
			write_byte(200) // brightness
			message_end()
			
			// Set grenade type on the thrown grenade entity
			set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_INFECTION)
		}
		if (model[9] == 's' && model[10] == 'm') // Knockback Bomb
		{
			// Give it a glow
			fm_set_rendering(entity, kRenderFxGlowShell, 204, 204, 0, kRenderNormal, 16);
			
			// And a colored trail
			message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
			write_byte(TE_BEAMFOLLOW) // TE id
			write_short(entity) // entity
			write_short(g_trailSpr) // sprite
			write_byte(10) // life
			write_byte(10) // width
			write_byte(204) // r
			write_byte(204) // g
			write_byte(0) // b
			write_byte(200) // brightness
			message_end()
			
			// Set grenade type on the thrown grenade entity
			set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_KBBOMB)
		}
	}
	else if (model[9] == 'h' && model[10] == 'e' && get_pcvar_num(cvar_firegrenades)) // Napalm Grenade
	{
		switch (g_grenade_slot1[owner])
		{
			case NADE_TYPE_NAPALM:
			{
				// Give it a glow
				fm_set_rendering(entity, kRenderFxGlowShell, 200, 0, 0, kRenderNormal, 16);
				
				// And a colored trail
				message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
				write_byte(TE_BEAMFOLLOW) // TE id
				write_short(entity) // entity
				write_short(g_trailSpr) // sprite
				write_byte(10) // life
				write_byte(10) // width
				write_byte(200) // r
				write_byte(0) // g
				write_byte(0) // b
				write_byte(200) // brightness
				message_end()
				
				// Set grenade type on the thrown grenade entity
				set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_NAPALM)
			}
			case NADE_TYPE_HE:
			{
				// Give it a glow
				fm_set_rendering(entity, kRenderFxGlowShell, 200, 0, 0, kRenderNormal, 16);
				
				// And a colored trail
				message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
				write_byte(TE_BEAMFOLLOW) // TE id
				write_short(entity) // entity
				write_short(g_trailSpr) // sprite
				write_byte(10) // life
				write_byte(10) // width
				write_byte(200) // r
				write_byte(0) // g
				write_byte(0) // b
				write_byte(200) // brightness
				message_end()
				
				// Set grenade type on the thrown grenade entity
				set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_HE)
			}
			case NADE_TYPE_MOLOTOV:
			{
				// Give it a glow
				fm_set_rendering(entity, kRenderFxGlowShell, 210, 105, 30, kRenderNormal, 16);
				
				// And a colored trail
				message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
				write_byte(TE_BEAMFOLLOW) // TE id
				write_short(entity) // entity
				write_short(g_trailSpr) // sprite
				write_byte(10) // life
				write_byte(10) // width
				write_byte(210) // r
				write_byte(105) // g
				write_byte(30) // b
				write_byte(100) // brightness
				message_end()
				
				// Set grenade type on the thrown grenade entity
				set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_MOLOTOV)
				
				// Think
				set_pev(entity, pev_dmgtime, get_gametime()+5.0)
				
				// Set our custom model
				engfunc(EngFunc_SetModel, entity, "models/fzm/w_molotov.mdl")
				return HAM_SUPERCEDE;
			}
			case NADE_TYPE_CUTTER:
			{
				// Build color
				static r, g, b
				
				// Plasma Cutter upgrade?
				if (has_upgrade(owner, UPGRADE_HUMAN_PLASMA_CUTTER))
				{
					r = 200
					g = 0
					b = 0
				}
				else
				{
					r = 214
					g = 189
					b = 41
				}
				
				// Give it a glow
				fm_set_rendering(entity, kRenderFxGlowShell, r, g, b, kRenderNormal, 16);
				
				// And a colored trail
				message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
				write_byte(TE_BEAMFOLLOW) // TE id
				write_short(entity) // entity
				write_short(g_trailSpr) // sprite
				write_byte(10) // life
				write_byte(10) // width
				write_byte(r) // r
				write_byte(g) // g
				write_byte(b) // b
				write_byte(200) // brightness
				message_end()
				
				// Set grenade type on the thrown grenade entity
				set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_CUTTER)
				
				// Set our custom model
				engfunc(EngFunc_SetModel, entity, "models/fzm/w_cutter.mdl")
				return HAM_SUPERCEDE;
			}
		}
	}
	else if (model[9] == 'f' && model[10] == 'l' && get_pcvar_num(cvar_frostgrenades)) // Frost Grenade
	{
		switch (g_grenade_slot2[owner])
		{
			case NADE_TYPE_FROST:
			{
				// Give it a glow
				fm_set_rendering(entity, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 16);
				
				// And a colored trail
				message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
				write_byte(TE_BEAMFOLLOW) // TE id
				write_short(entity) // entity
				write_short(g_trailSpr) // sprite
				write_byte(10) // life
				write_byte(10) // width
				write_byte(0) // r
				write_byte(100) // g
				write_byte(200) // b
				write_byte(200) // brightness
				message_end()
				
				// Set grenade type on the thrown grenade entity
				set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_FROST)
			}
			case NADE_TYPE_FORCEFIELD:
			{
				// Give it a glow
				fm_set_rendering(entity, kRenderFxGlowShell, 148, 0, 211, kRenderNormal, 16);
				
				// And a colored trail
				message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
				write_byte(TE_BEAMFOLLOW) // TE id
				write_short(entity) // entity
				write_short(g_trailSpr) // sprite
				write_byte(10) // life
				write_byte(10) // width
				write_byte(148) // r
				write_byte(0) // g
				write_byte(211) // b
				write_byte(200) // brightness
				message_end()
				
				// Set grenade type on the thrown grenade entity
				set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_FORCEFIELD)
				
				// Set our custom model
				engfunc(EngFunc_SetModel, entity, "models/zombie_plague/w_aura.mdl")
				return HAM_SUPERCEDE;
			}
		}
	}
	else if (model[9] == 's' && model[10] == 'm' && get_pcvar_num(cvar_flaregrenades)) // Flare
	{
		switch (g_grenade_slot3[owner])
		{
			case NADE_TYPE_FLARE:
			{
				// Build flare's color
				static rgb[3]
				switch (get_pcvar_num(cvar_flarecolor))
				{
					case 0: // white
					{
						rgb[0] = 255 // r
						rgb[1] = 255 // g
						rgb[2] = 255 // b
					}
					case 1: // red
					{
						rgb[0] = random_num(50,255) // r
						rgb[1] = 0 // g
						rgb[2] = 0 // b
					}
					case 2: // green
					{
						rgb[0] = 0 // r
						rgb[1] = random_num(50,255) // g
						rgb[2] = 0 // b
					}
					case 3: // blue
					{
						rgb[0] = 0 // r
						rgb[1] = 0 // g
						rgb[2] = random_num(50,255) // b
					}
					case 4: // random (all colors)
					{
						rgb[0] = random_num(50,200) // r
						rgb[1] = random_num(50,200) // g
						rgb[2] = random_num(50,200) // b
					}
					case 5: // random (r,g,b)
					{
						switch (random_num(1, 3))
						{
							case 1: // red
							{
								rgb[0] = random_num(50,255) // r
								rgb[1] = 0 // g
								rgb[2] = 0 // b
							}
							case 2: // green
							{
								rgb[0] = 0 // r
								rgb[1] = random_num(50,255) // g
								rgb[2] = 0 // b
							}
							case 3: // blue
							{
								rgb[0] = 0 // r
								rgb[1] = 0 // g
								rgb[2] = random_num(50,255) // b
							}
						}
					}
				}
				
				// Give it a glow
				fm_set_rendering(entity, kRenderFxGlowShell, rgb[0], rgb[1], rgb[2], kRenderNormal, 16);
				
				// And a colored trail
				message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
				write_byte(TE_BEAMFOLLOW) // TE id
				write_short(entity) // entity
				write_short(g_trailSpr) // sprite
				write_byte(10) // life
				write_byte(10) // width
				write_byte(rgb[0]) // r
				write_byte(rgb[1]) // g
				write_byte(rgb[2]) // b
				write_byte(200) // brightness
				message_end()
				
				// Set grenade type on the thrown grenade entity
				set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_FLARE)
				
				// Set flare color on the thrown grenade entity
				set_pev(entity, PEV_FLARE_COLOR, rgb)
			}
		}
	}
	
	return FMRES_IGNORED;
}

// Ham Grenade Think Forward
public fw_ThinkGrenade(entity)
{
	// Invalid entity
	if (!pev_valid(entity)) return HAM_IGNORED;
	
	// Get damage time of grenade
	static Float:dmgtime, Float:current_time
	pev(entity, pev_dmgtime, dmgtime)
	current_time = get_gametime()
	
	// Check if it's time to go off
	if (dmgtime > current_time)
		return HAM_IGNORED;
	
	// Check if it's one of our custom nades
	switch (pev(entity, PEV_NADE_TYPE))
	{
		case NADE_TYPE_INFECTION: // Infection Bomb
		{
			infection_explode(entity)
			return HAM_SUPERCEDE;
		}
		case NADE_TYPE_NAPALM: // Napalm Grenade
		{
			fire_explode(entity)
			return HAM_SUPERCEDE;
		}
		case NADE_TYPE_FROST: // Frost Grenade
		{
			frost_explode(entity)
			return HAM_SUPERCEDE;
		}
		case NADE_TYPE_FORCEFIELD: // Force Field Grenade
		{
			// Get actual forcefield ent
			static parent_ent
			parent_ent = pev(entity, PEV_NADE_DURATION)
			
			// Already went off, remove entities
			if (parent_ent > 0)
			{
				// Get rid of the entities
				engfunc(EngFunc_RemoveEntity, entity)
				engfunc(EngFunc_RemoveEntity, parent_ent)
				return HAM_SUPERCEDE;
			}
			// Light up when it's stopped on ground
			else if ((pev(entity, pev_flags) & FL_ONGROUND) && fm_get_speed(entity) < 10)
			{
				// Set duration
				set_pev(entity, PEV_NADE_DURATION, create_forcefield(entity))
				set_pev(entity, pev_dmgtime, current_time + get_pcvar_float(cvar_forcefieldtime))
			}
			else
			{
				// Delay explosion until we hit ground
				set_pev(entity, pev_dmgtime, current_time + 0.5)
			}
		}
		case NADE_TYPE_KBBOMB: // Knockback Bomb
		{
			kbbomb_explode(entity)
			return HAM_SUPERCEDE;
		}
		case NADE_TYPE_FLARE: // Flare
		{
			// Get its duration
			static duration
			duration = pev(entity, PEV_NADE_DURATION)
			
			// Already went off, do lighting loop for the duration of PEV_NADE_DURATION
			if (duration > 0)
			{
				// Check whether this is the last loop
				if (duration == 1)
				{
					// Get rid of the flare entity
					engfunc(EngFunc_RemoveEntity, entity)
					return HAM_SUPERCEDE;
				}
				
				// Light it up!
				flare_lighting(entity, duration)
				
				// Set time for next loop
				set_pev(entity, PEV_NADE_DURATION, --duration)
				set_pev(entity, pev_dmgtime, current_time + 2.0)
			}
			// Light up when it's stopped on ground
			else if ((pev(entity, pev_flags) & FL_ONGROUND) && fm_get_speed(entity) < 10)
			{
				// Flare sound
				static sound[64]
				ArrayGetString(grenade_flare, random_num(0, ArraySize(grenade_flare) - 1), sound, charsmax(sound))
				emit_sound(entity, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				// Set duration and start lightning loop on next think
				set_pev(entity, PEV_NADE_DURATION, 1 + get_pcvar_num(cvar_flareduration)/2)
				set_pev(entity, pev_dmgtime, current_time + 0.1)
			}
			else
			{
				// Delay explosion until we hit ground
				set_pev(entity, pev_dmgtime, current_time + 0.5)
			}
		}
		case NADE_TYPE_HE: // Explosive grenade
		{
			he_explode(entity)
			return HAM_SUPERCEDE;
		}
		case NADE_TYPE_MOLOTOV: // Molotov cocktail
		{
			// Get its duration
			static duration
			duration = pev(entity, PEV_NADE_DURATION)
			
			// Already went off, do lighting loop for the duration of PEV_NADE_DURATION
			if (duration > 0)
			{
				// Check whether this is the last loop
				if (duration == 1)
				{
					// Get rid of the molotov entity
					engfunc(EngFunc_RemoveEntity, entity)
					return HAM_SUPERCEDE;
				}
				
				// Fire it up!
				molotov_explode(entity)
				
				// Set time for next loop
				set_pev(entity, PEV_NADE_DURATION, --duration)
				set_pev(entity, pev_dmgtime, current_time + 0.2)
			}
			else
			{
				// Get origin
				static Float:originF[3]
				pev(entity, pev_origin, originF)
				
				// Broken glass sound
				static sound[64]
				ArrayGetString(grenade_frost_break, random_num(0, ArraySize(grenade_frost_break) - 1), sound, charsmax(sound))
				emit_sound(entity, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				// Glass shatter
				engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
				write_byte(TE_BREAKMODEL) // TE id
				engfunc(EngFunc_WriteCoord, originF[0]) // x
				engfunc(EngFunc_WriteCoord, originF[1]) // y
				engfunc(EngFunc_WriteCoord, originF[2]) // z
				write_coord(16) // size x
				write_coord(16) // size y
				write_coord(16) // size z
				write_coord(random_num(-50, 50)) // velocity x
				write_coord(random_num(-50, 50)) // velocity y
				write_coord(25) // velocity z
				write_byte(10) // random velocity
				write_short(g_glassSpr) // model
				write_byte(10) // count
				write_byte(25) // life
				write_byte(BREAK_GLASS) // flags
				message_end()
				
				// Explode
				molotov_explode(entity)
				
				// Set duration and start loop on next think
				set_pev(entity, PEV_NADE_DURATION, 40)
				set_pev(entity, pev_dmgtime, current_time + 0.2)
				set_pev(entity, pev_effects, EF_NODRAW)
			}
		}
		case NADE_TYPE_CUTTER: // Laser cutter
		{
			// Get its duration
			static duration
			duration = pev(entity, PEV_NADE_DURATION)
			
			// Already went off, do lighting loop for the duration of PEV_NADE_DURATION
			if (duration > 0)
			{
				// Check whether this is the last loop
				if (duration == 1)
				{
					// Get rid of the entity
					engfunc(EngFunc_RemoveEntity, entity)
					return HAM_SUPERCEDE;
				}
				
				// Fire it up!
				cutter_explode(entity)
				
				// Set time for next loop
				set_pev(entity, pev_dmgtime, current_time + 1.0)
			}
			// Light up when it's stopped on ground
			else if ((pev(entity, pev_flags) & FL_ONGROUND) && fm_get_speed(entity) < 10)
			{
				// Reset angles
				set_pev(entity, pev_angles, FLoat:{0.0, 0.0, 0.0})
				
				// Set duration and start lightning loop on next think
				set_pev(entity, PEV_NADE_DURATION, 60)
				set_pev(entity, pev_dmgtime, current_time + 1.0)
			}
			else
			{
				// Delay explosion until we hit ground
				set_pev(entity, pev_dmgtime, current_time + 0.5)
			}
		}
	}
	
	return HAM_IGNORED;
}

public fw_GrenadeTouch(ent)
{
	// Invalid entity
	if (!pev_valid(ent) || pev(ent, pev_effects) & EF_NODRAW) return;
	
	switch (pev(ent, PEV_NADE_TYPE))
	{
		case NADE_TYPE_MOLOTOV:
		{
			set_pev(ent, pev_dmgtime, get_gametime())
			set_pev(ent, pev_velocity, Float:{0.0, 0.0, 0.0})
			fw_ThinkGrenade(ent)
		}
	}
}

public fw_ForceFieldTouch(ent, touched)
{
	// Invalid entity
	if (!pev_valid(ent)) return;
	
	if (is_user_valid_alive(touched) && g_zombie[touched])
	{
		// boring part
		static Float:pos_ptr[3], Float:pos_ptd[3]
		
		pev(ent, pev_origin, pos_ptr)
		pev(touched, pev_origin, pos_ptd)
		
		for(new i = 0; i < 3; i++)
		{
			pos_ptd[i] -= pos_ptr[i]
			if (!g_nemesis[touched]) pos_ptd[i] *= 3.0
		}
		set_pev(touched, pev_velocity, pos_ptd)
		set_pev(touched, pev_impulse, pos_ptd)
	}
}

// Forward CmdStart
public fw_CmdStart(id, handle)
{
	// Not alive
	if (!g_isalive[id])
		return;
	
	// This logic looks kinda weird, but it should work in theory...
	// p = g_zombie[id], q = g_survivor[id], r = g_cached_customflash
	// ¬(p v q v (¬p ^ r)) <==> ¬p ^ ¬q ^ (p v ¬r)
	if (!g_zombie[id] && !g_survivor[id] && (g_zombie[id] || !g_cached_customflash))
		return;
	
	// Check if it's a flashlight impulse
	if (get_uc(handle, UC_Impulse) != IMPULSE_FLASHLIGHT)
		return;
	
	// Block it I say!
	set_uc(handle, UC_Impulse, 0)
	
	// Should human's custom flashlight be turned on?
	if (!g_zombie[id] && !g_survivor[id] && g_flashbattery[id] > 2 && get_gametime() - g_lastflashtime[id] > 1.2)
	{
		// Prevent calling flashlight too quickly (bugfix)
		g_lastflashtime[id] = get_gametime()
		
		// Toggle custom flashlight
		g_flashlight[id] = !(g_flashlight[id])
		
		// Play flashlight toggle sound
		emit_sound(id, CHAN_ITEM, sound_flashlight, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Update flashlight status on the HUD
		message_begin(MSG_ONE, g_msgFlashlight, _, id)
		write_byte(g_flashlight[id]) // toggle
		write_byte(g_flashbattery[id]) // battery
		message_end()
		
		// Remove previous tasks
		remove_task(id+TASK_CHARGE)
		remove_task(id+TASK_FLASH)
		
		// Set the flashlight charge task
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b")
		
		// Call our custom flashlight task if enabled
		if (g_flashlight[id]) set_task(0.1, "set_user_flashlight", id+TASK_FLASH, _, _, "b")
	}
}

// Forward Player PreThink
public fw_PlayerPreThink(id)
{
	// Not alive
	if (!g_isalive[id])
		return;
	
	// Silent footsteps for zombies?
	if (g_cached_zombiesilent && g_zombie[id] && !g_nemesis[id])
		set_pev(id, pev_flTimeStepSound, STEPTIME_SILENT)
	
	// Player frozen?
	if (g_freezing_duration[id])
	{
		set_pev(id, pev_velocity, Float:{0.0,0.0,0.0}) // stop motion
		return; // shouldn't leap while frozen
	}
	
	// --- Check if player should leap ---
	
	// Don't allow leap during freezetime
	if (g_freezetime)
		return;
	
	// Check if proper CVARs are enabled and retrieve leap settings
	static Float:cooldown, Float:current_time
	if (g_zombie[id])
	{
		if (g_nemesis[id])
		{
			if (!g_cached_leapnemesis) return;
			cooldown = g_cached_leapnemesiscooldown
		}
		else
		{
			switch (g_cached_leapzombies)
			{
				case 0: return;
				case 2: if (!g_firstzombie[id]) return;
				case 3: if (!g_lastzombie[id]) return;
			}
			cooldown = g_cached_leapzombiescooldown
		}
	}
	else
	{
		if (g_survivor[id])
		{
			if (!g_cached_leapsurvivor) return;
			cooldown = g_cached_leapsurvivorcooldown
		}
		else return;
	}
	
	current_time = get_gametime()
	
	// Cooldown not over yet
	if (current_time - g_lastleaptime[id] < cooldown)
		return;
	
	// Not doing a longjump (don't perform check for bots, they leap automatically)
	if (!g_isbot[id] && !(pev(id, pev_button) & (IN_JUMP | IN_DUCK) == (IN_JUMP | IN_DUCK)))
		return;
	
	// Not on ground or not enough speed
	if (!(pev(id, pev_flags) & FL_ONGROUND) || fm_get_speed(id) < 80)
		return;
	
	static Float:velocity[3]
	
	// Make velocity vector
	velocity_by_aim(id, g_survivor[id] ? get_pcvar_num(cvar_leapsurvivorforce) : g_nemesis[id] ? get_pcvar_num(cvar_leapnemesisforce) : get_pcvar_num(cvar_leapzombiesforce), velocity)
	
	// Set custom height
	velocity[2] = g_survivor[id] ? get_pcvar_float(cvar_leapsurvivorheight) : g_nemesis[id] ? get_pcvar_float(cvar_leapnemesisheight) : get_pcvar_float(cvar_leapzombiesheight)
	
	// Apply the new velocity
	set_pev(id, pev_velocity, velocity)
	
	// Update last leap time
	g_lastleaptime[id] = current_time
}

/*================================================================================
 [Client Commands]
=================================================================================*/

// Say "/zpmenu"
public clcmd_saymenu(id)
{
	show_menu_game(id) // show game menu
}

// Say "/unstuck"
public clcmd_sayunstuck(id)
{
	menu_game(id, 3) // try to get unstuck
}

// Nightvision toggle
public clcmd_nightvision(id)
{
	// Nightvision available to player?
	if (g_nvision[id] || (g_isalive[id] && cs_get_user_nvg(id)))
	{
		// Enable-disable
		g_nvisionenabled[id] = !(g_nvisionenabled[id])
		set_user_gnvision(id, g_nvisionenabled[id])
	}
	
	return PLUGIN_HANDLED;
}

// Weapon Drop
public clcmd_drop(id)
{
	// Survivor should stick with its weapon
	if (g_survivor[id] || g_vip[id])
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Buy BP Ammo
public clcmd_buyammo(id)
{
	// Not alive or infinite ammo setting enabled
	if (!g_isalive[id] || get_pcvar_num(cvar_infammo))
		return PLUGIN_HANDLED;
	
	// Not human
	if (g_zombie[id])
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_HUMAN_ONLY")
		return PLUGIN_HANDLED;
	}
	
	// Not enough ammo packs
	if (g_ammopacks[id] < 1)
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "NOT_ENOUGH_AMMO")
		return PLUGIN_HANDLED;
	}
	
	// Get user weapons
	static weapons[32], num, i, currentammo, weaponid, refilled
	num = 0 // reset passed weapons count (bugfix)
	refilled = false
	get_user_weapons(id, weapons, num)
	
	// Loop through them and give the right ammo type
	for (i = 0; i < num; i++)
	{
		// Prevents re-indexing the array
		weaponid = weapons[i]
		
		// Primary and secondary only
		if (MAXBPAMMO[weaponid] > 2)
		{
			// Get current ammo of the weapon
			currentammo = cs_get_user_bpammo(id, weaponid)
			
			// Give additional ammo
			ExecuteHamB(Ham_GiveAmmo, id, BUYAMMO[weaponid], AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
			
			// Check whether we actually refilled the weapon's ammo
			if (cs_get_user_bpammo(id, weaponid) - currentammo > 0) refilled = true
		}
	}
	
	// Weapons already have full ammo
	if (!refilled) return PLUGIN_HANDLED;
	
	// Deduce ammo packs, play clip purchase sound, and notify player
	g_ammopacks[id]--
	emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
	zp_colored_print(id, "^x04[ZP]^x01 %L", id, "AMMO_BOUGHT")
	
	return PLUGIN_HANDLED;
}

// Block Team Change
public clcmd_changeteam(id)
{
	static team
	team = fm_cs_get_user_team(id)
	
	// Unless it's a spectator joining the game
	if (team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED)
		return PLUGIN_CONTINUE;
	
	// Pressing 'M' (chooseteam) ingame should show the main menu instead
	show_menu_game(id)
	return PLUGIN_HANDLED;
}

/*================================================================================
 [Menus]
=================================================================================*/

// Game Menu
show_menu_game(id)
{
	// Player disconnected?
	if (!g_isconnected[id])
		return;
	
	static menu[250], len, userflags
	len = 0
	userflags = get_user_flags(id)
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\y%s^n^n", g_modname)
	
	// 1. Equipment
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Equipment^n")
	
	// 2. Extra items
	if (get_pcvar_num(cvar_extraitems) && g_isalive[id])
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w %L^n", id, "MENU_EXTRABUY")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d2. %L^n", id, "MENU_EXTRABUY")
	
	// 3. Zombie class
	if (get_pcvar_num(cvar_zclasses))
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w %L^n", id,"MENU_ZCLASS")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d3. %L^n", id,"MENU_ZCLASS")
	
	// 4. Human class
	len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Choose Human Class^n")
	
	// 5. Upgrades
	len += formatex(menu[len], charsmax(menu) - len, "\r5.\w Upgrades^n")
	
	// 6. Achievements
	len += formatex(menu[len], charsmax(menu) - len, "\d6. Achievements^n^n")
	
	// 8. Join spec
	if (!g_isalive[id] || !get_pcvar_num(cvar_blocksuicide) || (userflags & g_access_flag[ACCESS_ADMIN_MENU]))
		len += formatex(menu[len], charsmax(menu) - len, "\r8.\w %L^n", id, "MENU_SPECTATOR")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d8. %L^n", id, "MENU_SPECTATOR")
	
	// 9. Admin menu
	if (userflags & g_access_flag[ACCESS_ADMIN_MENU])
		len += formatex(menu[len], charsmax(menu) - len, "\r9.\w %L", id, "MENU_ADMIN")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d9. %L", id, "MENU_ADMIN")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0.\w %L", id, "MENU_EXIT")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	show_menu(id, KEYSMENU, menu, -1, "Game Menu")
}

// Equipment Menu
show_menu_equipment(id)
{
	// Player disconnected?
	if (!g_isconnected[id])
		return;
	
	static menu[512], len
	len = 0
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\yEquipment^n^n")
	
	// 1. Primary
	len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Primary:\y [%s]^n", PRIMARY_NAME[g_db_primary[id]])
	
	// 2. Secondary
	len += formatex(menu[len], charsmax(menu) - len, "\r2.\w Secondary:\y [%s]^n", SECONDARY_NAME[g_db_secondary[id]])
	
	// 3. Knife
	static knifename[32]
	ArrayGetString(g_knife_name, g_db_knife[id], knifename, charsmax(knifename))
	len += formatex(menu[len], charsmax(menu) - len, "\r3.\w Knife:\y [%s]^n", knifename)
	
	// 4. Offensive Grenade
	len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Offensive Grenade:\y [%s]^n", OFFENSIVENADE_NAME[g_db_offensivegrenade[id]])
	
	// 5. Defensive Grenade
	len += formatex(menu[len], charsmax(menu) - len, "\r5.\w Defensive Grenade:\y [%s]^n", DEFENSIVENADE_NAME[g_db_defensivegrenade[id]])
	
	// 6. Tactical Grenade
	len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Utility Grenade:\y [%s]^n", UTILITYNADE_NAME[g_db_tacticalgrenade[id]])
	
	// 7. Special
	static specialname[32]
	ArrayGetString(g_special_name, g_db_special[id], specialname, charsmax(specialname))
	len += formatex(menu[len], charsmax(menu) - len, "\r7.\w Special:\y [%s]^n", specialname)
	
	// 8. Ammo
	len += formatex(menu[len], charsmax(menu) - len, "^n\r8.\w Ammunition:\y [%s]^n", AMMO_NAME[g_db_ammo[id]])
	
	// 0. Back
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w %L", id, "MENU_BACK")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	show_menu(id, KEYSMENU, menu, -1, "Equipment Menu")
}

// Primary Menu
show_menu_primary(id)
{
	static menuid, menu[128], buffer[2]
	
	// Title
	formatex(menu, charsmax(menu), "Choose Primary Weapon")
	menuid = menu_create(menu, "menu_primary")
	
	// Weapon List
	for (new weap; weap < MAX_PRIMARY_WEAPONS; weap++)
	{
		// Add Item
		if (g_db_primary[id] == weap)
			formatex(menu, charsmax(menu), "\d%s (level %d)\y (selected)", PRIMARY_NAME[weap], PRIMARY_LVL[weap])
		else if (g_level[id] < PRIMARY_LVL[weap])
			formatex(menu, charsmax(menu), "\d%s (level %d)", PRIMARY_NAME[weap], PRIMARY_LVL[weap])
		else
			formatex(menu, charsmax(menu), "%s\y (level %d)", PRIMARY_NAME[weap], PRIMARY_LVL[weap])
		
		buffer[0] = weap
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

// Secondary Menu
show_menu_secondary(id)
{
	static menuid, menu[128], buffer[2]
	
	// Title
	formatex(menu, charsmax(menu), "Choose Secondary Weapon")
	menuid = menu_create(menu, "menu_secondary")
	
	// Weapon List
	for (new weap; weap < MAX_SECONDARY_WEAPONS; weap++)
	{
		// Add Item
		if (g_db_secondary[id] == weap)
			formatex(menu, charsmax(menu), "\d%s (level %d)\y (selected)", SECONDARY_NAME[weap], SECONDARY_LVL[weap])
		else if (g_level[id] < SECONDARY_LVL[weap])
			formatex(menu, charsmax(menu), "\d%s (level %d)", SECONDARY_NAME[weap], SECONDARY_LVL[weap])
		else
			formatex(menu, charsmax(menu), "%s\y (level %d)", SECONDARY_NAME[weap], SECONDARY_LVL[weap])
		
		buffer[0] = weap
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

// Knife Menu
show_menu_knife(id)
{
	static menuid, menu[128], buffer[2], name[64], lvl
	
	// Title
	formatex(menu, charsmax(menu), "Choose Knife")
	menuid = menu_create(menu, "menu_knife")
	
	// Weapon List
	for (new weap; weap < g_knife_i; weap++)
	{
		ArrayGetString(g_knife_name, weap, name, charsmax(name))
		lvl = ArrayGetCell(g_knife_lvl, weap)
		
		if (g_db_knife[id] == weap)
			formatex(menu, charsmax(menu), "\d%s (level %d)\y (selected)", name, lvl)
		else if (g_level[id] < lvl)
			formatex(menu, charsmax(menu), "\d%s (level %d)", name, lvl)
		else
			formatex(menu, charsmax(menu), "%s\y (level %d)", name, lvl)
		
		// Add Item
		buffer[0] = weap
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

// Offensive Grenade Menu
show_menu_offensivegrenade(id)
{
	static menuid, menu[128], buffer[2]
	
	// Title
	formatex(menu, charsmax(menu), "Choose Offensive Grenade")
	menuid = menu_create(menu, "menu_offensivegrenade")
	
	// Weapon List
	for (new weap; weap < MAX_OFFENSIVE_NADES; weap++)
	{
		// Add Item
		if (g_db_offensivegrenade[id] == weap)
			formatex(menu, charsmax(menu), "\d%s (level %d)\y (selected)", OFFENSIVENADE_NAME[weap], OFFENSIVENADE_LVL[weap])
		else if (g_level[id] < OFFENSIVENADE_LVL[weap])
			formatex(menu, charsmax(menu), "\d%s (level %d)", OFFENSIVENADE_NAME[weap], OFFENSIVENADE_LVL[weap])
		else
			formatex(menu, charsmax(menu), "%s\y (level %d)", OFFENSIVENADE_NAME[weap], OFFENSIVENADE_LVL[weap])
		
		buffer[0] = weap
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

// Defensive Grenade Menu
show_menu_defensivegrenade(id)
{
	static menuid, menu[128], buffer[2]
	
	// Title
	formatex(menu, charsmax(menu), "Choose Defensive Grenade")
	menuid = menu_create(menu, "menu_defensivegrenade")
	
	// Weapon List
	for (new weap; weap < MAX_DEFENSIVE_NADES; weap++)
	{
		// Add Item
		if (g_db_defensivegrenade[id] == weap)
			formatex(menu, charsmax(menu), "\d%s (level %d)\y (selected)", DEFENSIVENADE_NAME[weap], DEFENSIVENADE_LVL[weap])
		else if (g_level[id] < DEFENSIVENADE_LVL[weap])
			formatex(menu, charsmax(menu), "\d%s (level %d)", DEFENSIVENADE_NAME[weap], DEFENSIVENADE_LVL[weap])
		else
			formatex(menu, charsmax(menu), "%s\y (level %d)", DEFENSIVENADE_NAME[weap], DEFENSIVENADE_LVL[weap])
		
		buffer[0] = weap
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

// Utility Grenade Menu
show_menu_utilitygrenade(id)
{
	static menuid, menu[128], buffer[2]
	
	// Title
	formatex(menu, charsmax(menu), "Choose Utility Grenade")
	menuid = menu_create(menu, "menu_utilitygrenade")
	
	// Weapon List
	for (new weap; weap < MAX_UTILITY_NADES; weap++)
	{
		// Add Item
		if (g_db_tacticalgrenade[id] == weap)
			formatex(menu, charsmax(menu), "\d%s (level %d)\y (selected)", UTILITYNADE_NAME[weap], UTILITYNADE_LVL[weap])
		else if (g_level[id] < UTILITYNADE_LVL[weap])
			formatex(menu, charsmax(menu), "\d%s (level %d)", UTILITYNADE_NAME[weap], UTILITYNADE_LVL[weap])
		else
			formatex(menu, charsmax(menu), "%s\y (level %d)", UTILITYNADE_NAME[weap], UTILITYNADE_LVL[weap])
		
		buffer[0] = weap
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

// Special Menu
show_menu_special(id)
{
	static menuid, menu[128], buffer[2], name[64], lvl
	
	// Title
	formatex(menu, charsmax(menu), "Choose Special Equipment")
	menuid = menu_create(menu, "menu_special")
	
	// Weapon List
	for (new weap; weap < g_special_i; weap++)
	{
		ArrayGetString(g_special_name, weap, name, charsmax(name))
		lvl = ArrayGetCell(g_special_lvl, weap)
		
		if (g_db_special[id] == weap)
			formatex(menu, charsmax(menu), "\d%s (level %d)\y (selected)", name, lvl)
		else if (g_level[id] < lvl)
			formatex(menu, charsmax(menu), "\d%s (level %d)", name, lvl)
		else
			formatex(menu, charsmax(menu), "%s\y (level %d)", name, lvl)
		
		// Add Item
		buffer[0] = weap
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

// Ammo Menu
show_menu_ammo(id)
{
	static menuid, menu[128], buffer[2]
	
	// Title
	formatex(menu, charsmax(menu), "Choose Ammo")
	menuid = menu_create(menu, "menu_ammo")
	
	// Weapon List
	for (new weap; weap < MAX_AMMO; weap++)
	{
		// Add Item
		if (g_db_ammo[id] == weap)
			formatex(menu, charsmax(menu), "\d%s (level %d)\y (selected)", AMMO_NAME[weap], AMMO_LVL[weap])
		else if (g_level[id] < AMMO_LVL[weap])
			formatex(menu, charsmax(menu), "\d%s (level %d)", AMMO_NAME[weap], AMMO_LVL[weap])
		else
			formatex(menu, charsmax(menu), "%s\y (level %d)", AMMO_NAME[weap], AMMO_LVL[weap])
		
		buffer[0] = weap
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid)
}

// Upgrades Menu
show_menu_upgrade(id)
{
	static menuid, menu[128], buffer[2], name[32], lvl, cost, team[16], upgrade_id[11]
	
	// Title
	formatex(menu, charsmax(menu), "Manage Upgrades")
	menuid = menu_create(menu, "menu_upgrade")
	
	// Weapon List
	for (new item; item < g_upgrade_i; item++)
	{
		ArrayGetString(g_upgrade_name, item, name, charsmax(name))
		ArrayGetString(g_upgrade_team, item, team, charsmax(team))
		ArrayGetString(g_upgrade_id, item, upgrade_id, charsmax(upgrade_id))
		lvl = ArrayGetCell(g_upgrade_lvl, item)
		cost = ArrayGetCell(g_upgrade_cost, item)
		
		if (has_upgrade(id, upgrade_id))
			formatex(menu, charsmax(menu), "\d%s: %s (owned) (level %d)", team, name, lvl)
		else if (g_level[id] < lvl)
			formatex(menu, charsmax(menu), "\d%s: %s (%d ammo packs) (level %d)", team, name, cost, lvl)
		else if (g_ammopacks[id] < cost)
			formatex(menu, charsmax(menu), "\d%s: %s (%d ammo packs) (level %d)", team, name, cost, lvl)
		else
			formatex(menu, charsmax(menu), "\d%s\w: %s\y (%d ammo packs) (level %d)", team, name, cost, lvl)
		
		// Add Item
		buffer[0] = item
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid, MENU_PAGE_UPGRADE)
}

show_menu_upgrade_details(id, upgrade)
{
	// Menu things
	static menu[512], len
	len = 0
	
	// Current update things
	static name[32], desc[128], avail, availability[64], lvl, cost, team[16], upgrade_id[11]
	ArrayGetString(g_upgrade_name, upgrade, name, charsmax(name))
	ArrayGetString(g_upgrade_desc, upgrade, desc, charsmax(desc))
	ArrayGetString(g_upgrade_team, upgrade, team, charsmax(team))
	ArrayGetString(g_upgrade_id, upgrade, upgrade_id, charsmax(upgrade_id))
	avail = ArrayGetCell(g_upgrade_avail, upgrade)
	lvl = ArrayGetCell(g_upgrade_lvl, upgrade)
	cost = ArrayGetCell(g_upgrade_cost, upgrade)
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\yUpgrade: %s%s^n^n", name, has_upgrade(id, upgrade_id) ? "\d (owned)" : "")
	
	// Name
	len += formatex(menu[len], charsmax(menu) - len, "\dName:\w %s^n", name)
	
	// Description
	len += formatex(menu[len], charsmax(menu) - len, "\dDescription:\w %s^n", desc)
	
	// Team
	len += formatex(menu[len], charsmax(menu) - len, "\dTeam:\w %s^n", team)
	
	// Level
	len += formatex(menu[len], charsmax(menu) - len, "\dLevel:\w %d^n", lvl)
	
	// Cost
	len += formatex(menu[len], charsmax(menu) - len, "\dCost:\w %d ammo packs^n", cost)
	
	// Availability
	if (avail == 0)
	{
		len += formatex(menu[len], charsmax(menu) - len, "\dAvailability:\w Unlimited^n^n")
	}
	else if (avail-get_systime() > 0)
	{
		get_time_length(id, avail-get_systime(), timeunit_seconds, availability, charsmax(availability))
		len += formatex(menu[len], charsmax(menu) - len, "\dAvailability:\w %s remaining^n^n", availability)
	}
	else
	{
		len += formatex(menu[len], charsmax(menu) - len, "\dAvailability:\w Expired^n^n")
	}
	
	// 1. Purchase
	if (g_level[id] >= lvl && g_ammopacks[id] >= cost && (avail == 0 || (avail > 0 && avail-get_systime() > 0)) && !has_upgrade(id, upgrade_id))
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w Purchase^n")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d1. Purchase^n")
	
	// 0. Back
	len += formatex(menu[len], charsmax(menu) - len, "\r0.\w %L", id, "MENU_BACK")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	g_viewing_upgrade[id] = upgrade
	show_menu(id, MENU_KEY_1|MENU_KEY_0, menu, -1, "Upgrade Details Menu")
}

// Extra Items Menu
show_menu_extras(id)
{
	// Player dead?
	if (!g_isalive[id])
		return;
	
	static menuid, menu[128], item, team, buffer[32]
	
	// Title
	formatex(menu, charsmax(menu), "%L [%L]\r", id, "MENU_EXTRA_TITLE", id, g_zombie[id] ? g_nemesis[id] ? "CLASS_NEMESIS" : "CLASS_ZOMBIE" : g_survivor[id] ? "CLASS_SURVIVOR" : "CLASS_HUMAN")
	menuid = menu_create(menu, "menu_extras")
	
	// Item List
	for (item = 0; item < g_extraitem_i; item++)
	{
		// Retrieve item's team
		team = ArrayGetCell(g_extraitem_team, item)
		
		// Item not available to player's team/class
		if (g_vip[id] || (g_zombie[id] && !g_nemesis[id] && !(team & ZP_TEAM_ZOMBIE)) || (!g_zombie[id] && !g_survivor[id] && !(team & ZP_TEAM_HUMAN)) || (g_nemesis[id] && !(team & ZP_TEAM_NEMESIS)) || (g_survivor[id] && !(team & ZP_TEAM_SURVIVOR)))
			continue;
		
		// Check if it's one of the hardcoded items, check availability, set translated caption
		switch (item)
		{
			case EXTRA_NVISION:
			{
				if (!get_pcvar_num(cvar_extranvision)) continue;
				formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA1")
			}
			case EXTRA_ANTIDOTE:
			{
				if (!get_pcvar_num(cvar_extraantidote) || g_antidotecounter >= get_pcvar_num(cvar_antidotelimit)) continue;
				formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA2")
			}
			case EXTRA_MADNESS:
			{
				if (!get_pcvar_num(cvar_extramadness) || g_madnesscounter >= get_pcvar_num(cvar_madnesslimit)) continue;
				formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA3")
			}
			case EXTRA_INFBOMB:
			{
				if (!get_pcvar_num(cvar_extrainfbomb) || g_infbombcounter >= get_pcvar_num(cvar_infbomblimit)) continue;
				formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA4")
			}
			case EXTRA_NAPALMGRENADE: formatex(buffer, charsmax(buffer), "Napalm Grenade")
			case EXTRA_FROSTGRENADE: formatex(buffer, charsmax(buffer), "Frost Grenade")
			case EXTRA_FLARE: formatex(buffer, charsmax(buffer), "Flare")
			case EXTRA_HEGRENADE: formatex(buffer, charsmax(buffer), "HE Grenade")
			case EXTRA_MOLOTOV: formatex(buffer, charsmax(buffer), "Molotov Cocktail")
			case EXTRA_CUTTER: formatex(buffer, charsmax(buffer), "Laser Cutter")
			case EXTRA_FORCEFIELD: formatex(buffer, charsmax(buffer), "Force Field Grenade")
			case EXTRA_KBBOMB: formatex(buffer, charsmax(buffer), "Knockback Bomb")
			default:
			{
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
			}
		}
		
		// Add Item Name and Cost
		formatex(menu, charsmax(menu), "%s \y%d %L", buffer, ArrayGetCell(g_extraitem_cost, item), id, "AMMO_PACKS2")
		buffer[0] = item
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// No items to display?
	if (menu_items(menuid) <= 0)
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id ,"CMD_NOT_EXTRAS")
		menu_destroy(menuid)
		return;
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
		
	// If remembered page is greater than number of pages, clamp down the value
	MENU_PAGE_EXTRAS = min(MENU_PAGE_EXTRAS, menu_pages(menuid)-1)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid, MENU_PAGE_EXTRAS)
}

// Zombie Class Menu
public show_menu_zclass(id)
{
	// Player disconnected
	if (!g_isconnected[id])
		return;
	
	// Bots pick their zombie class randomly
	if (g_isbot[id])
	{
		g_zombieclassnext[id] = random_num(0, g_zclass_i - 1)
		return;
	}
	
	static menuid, menu[128], class, buffer[32], buffer2[64], zclass_lvl
	
	// Title
	formatex(menu, charsmax(menu), "%L\r", id, "MENU_ZCLASS_TITLE")
	menuid = menu_create(menu, "menu_zclass")
	
	// Class List
	for (class = 0; class < g_zclass_i; class++)
	{
		// Retrieve name and info
		ArrayGetString(g_zclass_name, class, buffer, charsmax(buffer))
		ArrayGetString(g_zclass_info, class, buffer2, charsmax(buffer2))
		zclass_lvl = ArrayGetCell(g_zclass_lvl, class)
		
		// Add to menu
		// Check if available
		ExecuteForward(g_fwZombieClassAvailable, g_fwDummyResult, id, class, buffer2, charsmax(buffer2));
		
		if (g_fwDummyResult == PLUGIN_HANDLED)
			formatex(menu, charsmax(menu), "\d%s [%s] (level %d)", buffer, buffer2, zclass_lvl)
		else if (class == g_zombieclassnext[id])
			formatex(menu, charsmax(menu), "\d%s [%s] (level %d)", buffer, buffer2, zclass_lvl)
		else if (g_level[id] < zclass_lvl)
			formatex(menu, charsmax(menu), "\d%s [%s] (level %d)", buffer, buffer2, zclass_lvl)
		else
			formatex(menu, charsmax(menu), "%s \y[%s] (level %d)", buffer, buffer2, zclass_lvl)
		
		buffer[0] = class
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// If remembered page is greater than number of pages, clamp down the value
	MENU_PAGE_ZCLASS = min(MENU_PAGE_ZCLASS, menu_pages(menuid)-1)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid, MENU_PAGE_ZCLASS)
}

// Human Class Menu
public show_menu_hclass(id)
{
	// Player disconnected
	if (!g_isconnected[id])
		return;
	
	static menuid, menu[128], class, buffer[32], buffer2[64], hclass_lvl
	
	// Title
	formatex(menu, charsmax(menu), "Human Class\r")
	menuid = menu_create(menu, "menu_hclass")
	
	// Class List
	for (class = 0; class < g_hclass_i; class++)
	{
		// Retrieve name and info
		ArrayGetString(g_hclass_name, class, buffer, charsmax(buffer))
		ArrayGetString(g_hclass_info, class, buffer2, charsmax(buffer2))
		hclass_lvl = ArrayGetCell(g_hclass_lvl, class)
		
		// Add to menu
		// Check if available
		ExecuteForward(g_fwHumanClassAvailable, g_fwDummyResult, id, class, buffer2, charsmax(buffer2));
		
		if (g_fwDummyResult == PLUGIN_HANDLED)
			formatex(menu, charsmax(menu), "\d%s [%s] (level %d)", buffer, buffer2, hclass_lvl)
		if (class == g_humanclassnext[id])
			formatex(menu, charsmax(menu), "\d%s [%s] (level %d)", buffer, buffer2, hclass_lvl)
		else if (g_level[id] < hclass_lvl)
			formatex(menu, charsmax(menu), "\d%s [%s] (level %d)", buffer, buffer2, hclass_lvl)
		else
			formatex(menu, charsmax(menu), "%s \y[%s] (level %d)", buffer, buffer2, hclass_lvl)
		
		buffer[0] = class
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// If remembered page is greater than number of pages, clamp down the value
	MENU_PAGE_HCLASS = min(MENU_PAGE_HCLASS, menu_pages(menuid)-1)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid, MENU_PAGE_HCLASS)
}

// Admin Menu
show_menu_admin(id)
{
	// Player disconnected?
	if (!g_isconnected[id])
		return;
	
	static menu[250], len, userflags
	len = 0
	userflags = get_user_flags(id)
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\y%L^n^n", id, "MENU_ADMIN_TITLE")
	
	// 1. Zombiefy/Humanize command
	if (userflags & (g_access_flag[ACCESS_MODE_INFECTION] | g_access_flag[ACCESS_MAKE_ZOMBIE] | g_access_flag[ACCESS_MAKE_HUMAN]))
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w %L^n", id, "MENU_ADMIN1")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d1. %L^n", id, "MENU_ADMIN1")
	
	// 2. Nemesis command
	if (userflags & (g_access_flag[ACCESS_MODE_NEMESIS] | g_access_flag[ACCESS_MAKE_NEMESIS]))
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w %L^n", id, "MENU_ADMIN2")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d2. %L^n", id, "MENU_ADMIN2")
	
	// 3. Survivor command
	if (userflags & (g_access_flag[ACCESS_MODE_SURVIVOR] | g_access_flag[ACCESS_MAKE_SURVIVOR]))
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w %L^n", id, "MENU_ADMIN3")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d3. %L^n", id, "MENU_ADMIN3")
	
	// 4. Respawn command
	if (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS])
		len += formatex(menu[len], charsmax(menu) - len, "\r4.\w %L^n", id, "MENU_ADMIN4")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d4. %L^n", id, "MENU_ADMIN4")
	
	// 5. Swarm mode command
	if ((userflags & g_access_flag[ACCESS_MODE_SWARM]) && allowed_swarm())
		len += formatex(menu[len], charsmax(menu) - len, "\r5.\w %L^n", id, "MENU_ADMIN5")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d5. %L^n", id, "MENU_ADMIN5")
	
	// 6. Multi infection command
	if ((userflags & g_access_flag[ACCESS_MODE_MULTI]) && allowed_multi())
		len += formatex(menu[len], charsmax(menu) - len, "\r6.\w %L^n", id, "MENU_ADMIN6")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d6. %L^n", id, "MENU_ADMIN6")
	
	// 7. Plague mode command
	if ((userflags & g_access_flag[ACCESS_MODE_PLAGUE]) && allowed_plague())
		len += formatex(menu[len], charsmax(menu) - len, "\r7.\w %L^n", id, "MENU_ADMIN7")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d7. %L^n", id, "MENU_ADMIN7")
	
	// 8. Armageddon mode command
	if ((userflags & g_access_flag[ACCESS_MODE_ARMAGEDDON]) && allowed_armageddon())
		len += formatex(menu[len], charsmax(menu) - len, "\r8.\w Start Armageddon Mode^n")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d8. Start Armageddon Mode^n")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w %L", id, "MENU_EXIT")
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	show_menu(id, KEYSMENU, menu, -1, "Admin Menu")
}

// Player List Menu
show_menu_player_list(id)
{
	// Player disconnected?
	if (!g_isconnected[id])
		return;
	
	static menuid, menu[128], player, userflags, buffer[2]
	userflags = get_user_flags(id)
	
	// Title
	switch (PL_ACTION)
	{
		case ACTION_ZOMBIEFY_HUMANIZE: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN1")
		case ACTION_MAKE_NEMESIS: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN2")
		case ACTION_MAKE_SURVIVOR: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN3")
		case ACTION_RESPAWN_PLAYER: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN4")
	}
	menuid = menu_create(menu, "menu_player_list")
	
	// Player List
	for (player = 0; player <= g_maxplayers; player++)
	{
		// Skip if not connected
		if (!g_isconnected[player])
			continue;
		
		// Format text depending on the action to take
		switch (PL_ACTION)
		{
			case ACTION_ZOMBIEFY_HUMANIZE: // Zombiefy/Humanize command
			{
				if (g_zombie[player])
				{
					if (allowed_human(player) && (userflags & g_access_flag[ACCESS_MAKE_HUMAN]))
						formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, g_nemesis[player] ? "CLASS_NEMESIS" : "CLASS_ZOMBIE")
					else
						formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, g_nemesis[player] ? "CLASS_NEMESIS" : "CLASS_ZOMBIE")
				}
				else
				{
					if (allowed_zombie(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_INFECTION]) : (userflags & g_access_flag[ACCESS_MAKE_ZOMBIE])))
						formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, g_survivor[player] ? "CLASS_SURVIVOR" : "CLASS_HUMAN")
					else
						formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, g_survivor[player] ? "CLASS_SURVIVOR" : "CLASS_HUMAN")
				}
			}
			case ACTION_MAKE_NEMESIS: // Nemesis command
			{
				if (allowed_nemesis(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_NEMESIS]) : (userflags & g_access_flag[ACCESS_MAKE_NEMESIS])))
				{
					if (g_zombie[player])
						formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, g_nemesis[player] ? "CLASS_NEMESIS" : "CLASS_ZOMBIE")
					else
						formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, g_survivor[player] ? "CLASS_SURVIVOR" : "CLASS_HUMAN")
				}
				else
					formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, g_zombie[player] ? g_nemesis[player] ? "CLASS_NEMESIS" : "CLASS_ZOMBIE" : g_survivor[player] ? "CLASS_SURVIVOR" : "CLASS_HUMAN")
			}
			case ACTION_MAKE_SURVIVOR: // Survivor command
			{
				if (allowed_survivor(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_SURVIVOR]) : (userflags & g_access_flag[ACCESS_MAKE_SURVIVOR])))
				{
					if (g_zombie[player])
						formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, g_nemesis[player] ? "CLASS_NEMESIS" : "CLASS_ZOMBIE")
					else
						formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, g_survivor[player] ? "CLASS_SURVIVOR" : "CLASS_HUMAN")
				}
				else
					formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, g_zombie[player] ? g_nemesis[player] ? "CLASS_NEMESIS" : "CLASS_ZOMBIE" : g_survivor[player] ? "CLASS_SURVIVOR" : "CLASS_HUMAN")
			}
			case ACTION_RESPAWN_PLAYER: // Respawn command
			{
				if (allowed_respawn(player) && (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS]))
					formatex(menu, charsmax(menu), "%s", g_playername[player])
				else
					formatex(menu, charsmax(menu), "\d%s", g_playername[player])
			}
		}
		
		// Add player
		buffer[0] = player
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	// If remembered page is greater than number of pages, clamp down the value
	MENU_PAGE_PLAYERS = min(MENU_PAGE_PLAYERS, menu_pages(menuid)-1)
	
	// Fix for AMXX custom menus
	if (pev_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)
	
	menu_display(id, menuid, MENU_PAGE_PLAYERS)
}

/*================================================================================
 [Menu Handlers]
=================================================================================*/

// Game Menu
public menu_game(id, key)
{
	// Player disconnected?
	if (!g_isconnected[id])
		return PLUGIN_HANDLED;
	
	switch (key)
	{
		case 0: // Equipment
		{
			show_menu_equipment(id)
		}
		case 1: // Extra Items
		{
			// Extra items enabled?
			if (get_pcvar_num(cvar_extraitems))
			{
				// Check whether the player is able to buy anything
				if (g_isalive[id])
					show_menu_extras(id)
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_EXTRAS")
		}
		case 2: // Zombie Classes
		{
			// Zombie classes enabled?
			if (get_pcvar_num(cvar_zclasses))
				show_menu_zclass(id)
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ZCLASSES")
		}
		case 3: // Human Classes
		{
			show_menu_hclass(id)
		}
		case 4: // Upgrades
		{
			show_menu_upgrade(id)
		}
		case 7: // Join Spectator
		{
			// Player alive?
			if (g_isalive[id])
			{
				// Prevent abuse by non-admins if block suicide setting is enabled
				if (get_pcvar_num(cvar_blocksuicide) && !(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU]))
				{
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
					return PLUGIN_HANDLED;
				}
				
				// Check that we still have both humans and zombies to keep the round going
				check_round(id)
				
				// Kill him before he switches team
				dllfunc(DLLFunc_ClientKill, id)
			}
			
			// Remove previous tasks
			remove_task(id+TASK_TEAM)
			remove_task(id+TASK_MODEL)
			remove_task(id+TASK_FLASH)
			remove_task(id+TASK_CHARGE)
			remove_task(id+TASK_SPAWN)
			remove_task(id+TASK_BLOOD)
			remove_task(id+TASK_AURA)
			remove_task(id+TASK_BURN)
			remove_task(id+TASK_FREEZE)
			
			// Then move him to the spectator team
			fm_cs_set_user_team(id, FM_CS_TEAM_SPECTATOR)
			fm_user_team_update(id)
		}
		case 8: // Admin Menu
		{
			// Check if player has the required access
			if (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU])
				show_menu_admin(id)
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		}
	}
	
	return PLUGIN_HANDLED;
}

// Equipment Menu
public menu_equipment(id, key)
{
	switch (key)
	{
		case 0: // 1. Primary
		{
			show_menu_primary(id)
			return PLUGIN_HANDLED;
		}
		case 1: // 2. Secondary
		{
			show_menu_secondary(id)
			return PLUGIN_HANDLED;
		}
		case 2: // 3. Knife
		{
			show_menu_knife(id)
			return PLUGIN_HANDLED;
		}
		case 3: // 4. Offensive Grenade
		{
			show_menu_offensivegrenade(id)
			return PLUGIN_HANDLED;
		}
		case 4: // 5. Defensive Grenade
		{
			show_menu_defensivegrenade(id)
			return PLUGIN_HANDLED;
		}
		case 5: // 6. Utility Grenade
		{
			show_menu_utilitygrenade(id)
			return PLUGIN_HANDLED;
		}
		case 6: // 7. Special
		{
			show_menu_special(id)
			return PLUGIN_HANDLED;
		}
		case 7: // 8. Ammo
		{
			show_menu_ammo(id)
			return PLUGIN_HANDLED;
		}
		case 9: // 0. Exit
		{
			show_menu_game(id)
			return PLUGIN_HANDLED;
		}
	}
	
	show_menu_equipment(id)
	return PLUGIN_HANDLED;
}

// Primary Menu
public menu_primary(id, menuid, item)
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
		show_menu_equipment(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve weapon ID
	static buffer[2], dummy, weap
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	weap = buffer[0]
	
	// Level not high enough or already selected
	if (g_level[id] < PRIMARY_LVL[weap] || g_db_primary[id] == weap)
	{
		menu_destroy(menuid)
		show_menu_primary(id)
		return PLUGIN_HANDLED;
	}
	
	// Set as primary weapon
	g_db_primary[id] = weap
	
	// Destroy the menu
	menu_destroy(menuid)
	show_menu_equipment(id)
	return PLUGIN_HANDLED;
}

// Secondary Menu
public menu_secondary(id, menuid, item)
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
		show_menu_equipment(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve weapon ID
	static buffer[2], dummy, weap
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	weap = buffer[0]
	
	// Level not high enough or already selected
	if (g_level[id] < SECONDARY_LVL[weap] || g_db_secondary[id] == weap)
	{
		menu_destroy(menuid)
		show_menu_secondary(id)
		return PLUGIN_HANDLED;
	}
	
	// Set as secondary weapon
	g_db_secondary[id] = weap
	
	// Destroy the menu
	menu_destroy(menuid)
	show_menu_equipment(id)
	return PLUGIN_HANDLED;
}

// Knife Menu
public menu_knife(id, menuid, item)
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
		show_menu_equipment(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve weapon ID
	static buffer[2], dummy, weap
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	weap = buffer[0]
	
	// Level not high enough or already selected
	if (g_level[id] < ArrayGetCell(g_knife_lvl, weap) || g_db_knife[id] == weap)
	{
		menu_destroy(menuid)
		show_menu_knife(id)
		return PLUGIN_HANDLED;
	}
	
	// Set as knife
	g_db_knife[id] = weap
	
	// Destroy the menu
	menu_destroy(menuid)
	show_menu_equipment(id)
	return PLUGIN_HANDLED;
}

// Offensive Grenade Menu
public menu_offensivegrenade(id, menuid, item)
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
		show_menu_equipment(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve weapon ID
	static buffer[2], dummy, weap
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	weap = buffer[0]
	
	// Level not high enough or already selected
	if (g_level[id] < OFFENSIVENADE_LVL[weap] || g_db_offensivegrenade[id] == weap)
	{
		menu_destroy(menuid)
		show_menu_offensivegrenade(id)
		return PLUGIN_HANDLED;
	}
	
	// Set new
	g_db_offensivegrenade[id] = weap
	
	// Destroy the menu
	menu_destroy(menuid)
	show_menu_equipment(id)
	return PLUGIN_HANDLED;
}

// Defensive Grenade Menu
public menu_defensivegrenade(id, menuid, item)
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
		show_menu_equipment(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve weapon ID
	static buffer[2], dummy, weap
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	weap = buffer[0]
	
	// Level not high enough or already selected
	if (g_level[id] < DEFENSIVENADE_LVL[weap] || g_db_defensivegrenade[id] == weap)
	{
		menu_destroy(menuid)
		show_menu_defensivegrenade(id)
		return PLUGIN_HANDLED;
	}
	
	// Set new
	g_db_defensivegrenade[id] = weap
	
	// Destroy the menu
	menu_destroy(menuid)
	show_menu_equipment(id)
	return PLUGIN_HANDLED;
}

// Utility Grenade Menu
public menu_utilitygrenade(id, menuid, item)
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
		show_menu_equipment(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve weapon ID
	static buffer[2], dummy, weap
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	weap = buffer[0]
	
	// Level not high enough or already selected
	if (g_level[id] < UTILITYNADE_LVL[weap] || g_db_tacticalgrenade[id] == weap)
	{
		menu_destroy(menuid)
		show_menu_utilitygrenade(id)
		return PLUGIN_HANDLED;
	}
	
	// Set new
	g_db_tacticalgrenade[id] = weap
	
	// Destroy the menu
	menu_destroy(menuid)
	show_menu_equipment(id)
	return PLUGIN_HANDLED;
}

// Ammo Menu
public menu_ammo(id, menuid, item)
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
		show_menu_equipment(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve weapon ID
	static buffer[2], dummy, weap
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	weap = buffer[0]
	
	// Level not high enough or already selected
	if (g_level[id] < AMMO_LVL[weap] || g_db_ammo[id] == weap)
	{
		menu_destroy(menuid)
		show_menu_ammo(id)
		return PLUGIN_HANDLED;
	}
	
	// Set new
	g_db_ammo[id] = weap
	
	// Destroy the menu
	menu_destroy(menuid)
	show_menu_equipment(id)
	return PLUGIN_HANDLED;
}

// Special Equipment Menu
public menu_special(id, menuid, item)
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
		show_menu_equipment(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve weapon ID
	static buffer[2], dummy, weap
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	weap = buffer[0]
	
	// Level not high enough or already selected
	if (g_level[id] < ArrayGetCell(g_special_lvl, weap) || g_db_special[id] == weap)
	{
		menu_destroy(menuid)
		show_menu_special(id)
		return PLUGIN_HANDLED;
	}
	
	// Set new
	g_db_special[id] = weap
	
	// Destroy the menu
	menu_destroy(menuid)
	show_menu_equipment(id)
	return PLUGIN_HANDLED;
}

// Upgrades Menu
public menu_upgrade(id, menuid, item)
{
	// Player disconnected?
	if (!is_user_connected(id))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Remember player's menu page
	static menudummy
	player_menu_info(id, menudummy, menudummy, MENU_PAGE_UPGRADE)
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_game(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve weapon ID
	static buffer[2], dummy, weap
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	weap = buffer[0]
	
	// Destroy the menu and show upgrade details
	menu_destroy(menuid)
	show_menu_upgrade_details(id, weap)
	return PLUGIN_HANDLED;
}

// Upgrade Details Menu
public menu_upgrade_details(id, key)
{
	switch (key)
	{
		case 0: // Purchase
		{
			// Attempt to buy the item
			buy_upgrade(id, g_viewing_upgrade[id])
		}
		case 9: // Exit
		{
			show_menu_upgrade(id)
		}
	}
}

buy_upgrade(id, upgrade)
{
	static upgrade_id[11]
	ArrayGetString(g_upgrade_id, upgrade, upgrade_id, charsmax(upgrade_id))
	
	// Already owns?
	if (has_upgrade(id, upgrade_id))
	{
		zp_colored_print(id, "^4[ZP]^1 You already own that upgrade.")
		show_menu_upgrade_details(id, upgrade)
		return;
	}
	// Level
	if (g_level[id] < ArrayGetCell(g_upgrade_lvl, upgrade))
	{
		zp_colored_print(id, "^4[ZP]^1 Your level is not high enough for this upgrade.")
		show_menu_upgrade_details(id, upgrade)
		return;
	}
	// Ammo Packs
	if (g_ammopacks[id] < ArrayGetCell(g_upgrade_cost, upgrade))
	{
		zp_colored_print(id, "^4[ZP]^1 You don't have enough ammo packs for this upgrade.")
		show_menu_upgrade_details(id, upgrade)
		return;
	}
	// Limited availability?
	static avail
	avail = ArrayGetCell(g_upgrade_avail, upgrade)
	if (avail > 0 && avail-get_systime() < 0)
	{
		zp_colored_print(id, "^4[ZP]^1 This offer has already expired.")
		show_menu_upgrade_details(id, upgrade)
		return;
	}
	
	// Give upgrade
	g_ammopacks[id] -= ArrayGetCell(g_upgrade_cost, upgrade)
	give_upgrade(id, upgrade_id)
	show_menu_upgrade(id)
	
	// Notify
	static name[32]
	ArrayGetString(g_upgrade_name, upgrade, name, charsmax(name))
	zp_colored_print(id, "^4[ZP}^1 You have successfully bought following upgrade:^4 %s^1.", name)
}

// Extra Items Menu
public menu_extras(id, menuid, item)
{
	// Player disconnected?
	if (!is_user_connected(id))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Remember player's menu page
	static menudummy
	player_menu_info(id, menudummy, menudummy, MENU_PAGE_EXTRAS)
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_game(id)
		return PLUGIN_HANDLED;
	}
	
	// Dead players are not allowed to buy items
	if (!g_isalive[id] || g_vip[id])
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve extra item id
	static buffer[2], dummy, itemid
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	itemid = buffer[0]
	
	// Attempt to buy the item
	buy_extra_item(id, itemid)
	menu_destroy(menuid)
	return PLUGIN_HANDLED;
}

// Buy Extra Item
buy_extra_item(id, itemid, ignorecost = 0)
{
	// Retrieve item's team
	static team
	team = ArrayGetCell(g_extraitem_team, itemid)
	
	// Check for team/class specific items
	if ((g_zombie[id] && !g_nemesis[id] && !(team & ZP_TEAM_ZOMBIE)) || (!g_zombie[id] && !g_survivor[id] && !(team & ZP_TEAM_HUMAN)) || (g_nemesis[id] && !(team & ZP_TEAM_NEMESIS)) || (g_survivor[id] && !(team & ZP_TEAM_SURVIVOR)))
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		return;
	}
	
	// Check for unavailable items
	if ((itemid == EXTRA_NVISION && !get_pcvar_num(cvar_extranvision))
	|| (itemid == EXTRA_ANTIDOTE && (!get_pcvar_num(cvar_extraantidote) || g_antidotecounter >= get_pcvar_num(cvar_antidotelimit) || fnGetHumans() < 2) || g_vipround)
	|| (itemid == EXTRA_MADNESS && (!get_pcvar_num(cvar_extramadness) || g_madnesscounter >= get_pcvar_num(cvar_madnesslimit)))
	|| (itemid == EXTRA_INFBOMB && (!get_pcvar_num(cvar_extrainfbomb) || g_infbombcounter >= get_pcvar_num(cvar_infbomblimit))))
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		return;
	}
	
	// Check for hard coded items with special conditions
	if ((itemid == EXTRA_ANTIDOTE && (g_endround || g_swarmround || g_nemround || g_survround || g_plagueround || fnGetZombies() <= 1 || (get_pcvar_num(cvar_deathmatch) && !get_pcvar_num(cvar_respawnafterlast) && fnGetHumans() == 1)))
	|| (itemid == EXTRA_MADNESS && g_nodamage[id]) || (itemid == EXTRA_INFBOMB && (g_endround || g_swarmround || g_nemround || g_survround || g_plagueround)))
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_CANTUSE")
		return;
	}
	
	// Ignore item's cost?
	if (!ignorecost)
	{
		// Check that we have enough ammo packs
		if (g_ammopacks[id] < ArrayGetCell(g_extraitem_cost, itemid))
		{
			zp_colored_print(id, "^x04[ZP]^x01 %L", id, "NOT_ENOUGH_AMMO")
			return;
		}
		
		// Deduce item cost
		g_ammopacks[id] -= ArrayGetCell(g_extraitem_cost, itemid)
	}
	
	// Check which kind of item we're buying
	switch (itemid)
	{
		case EXTRA_NVISION: // Night Vision
		{
			g_nvision[id] = true
			
			if (!g_isbot[id])
			{
				g_nvisionenabled[id] = true
				set_user_gnvision(id, 1)
			}
			else
				cs_set_user_nvg(id, 1)
		}
		case EXTRA_ANTIDOTE: // Antidote
		{
			// Increase antidote purchase count for this round
			g_antidotecounter++
			
			humanme(id, 0, 0)
		}
		case EXTRA_MADNESS: // Zombie Madness
		{
			// Increase madness purchase count for this round
			g_madnesscounter++
			
			g_nodamage[id] = true
			set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
			set_task(get_pcvar_float(cvar_madnessduration), "madness_over", id+TASK_BLOOD)
			
			static sound[64]
			ArrayGetString(zombie_madness, random_num(0, ArraySize(zombie_madness) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		}
		case EXTRA_INFBOMB: // Infection Bomb
		{
			// Increase infection bomb purchase count for this round
			g_infbombcounter++
			
			// Already own one
			if (user_has_weapon(id, CSW_HEGRENADE))
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_HEGRENADE, cs_get_user_bpammo(id, CSW_HEGRENADE) + 1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_HEGRENADE]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Give weapon to the player
			fm_give_item(id, "weapon_hegrenade")
		}
		case EXTRA_KBBOMB: // Knockback Bomb
		{
			// Already own one
			if (user_has_weapon(id, CSW_SMOKEGRENADE))
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_SMOKEGRENADE, cs_get_user_bpammo(id, CSW_SMOKEGRENADE) + 1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_SMOKEGRENADE]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Give weapon to the player
			fm_give_item(id, "weapon_smokegrenade")
		}
		case EXTRA_NAPALMGRENADE: // Napalm Grenade
		{
			// Carrying other type of that grenade
			if (user_has_weapon(id, CSW_HEGRENADE) && g_grenade_slot1[id] != NADE_TYPE_NAPALM)
			{
				client_print(id, print_center, "You can't carry two different offensive grenades!")
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return;
			}
			
			static bpammo
			bpammo = cs_get_user_bpammo(id, CSW_HEGRENADE)
			
			// Already own one
			if (bpammo)
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_HEGRENADE, bpammo+1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_HEGRENADE]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Set grenade type to frost
			g_grenade_slot1[id] = NADE_TYPE_NAPALM
			
			// Give weapon to the player
			fm_give_item(id, "weapon_hegrenade")
		}
		case EXTRA_FROSTGRENADE: // Frost Grenade
		{
			// Carrying other type of that grenade
			if (user_has_weapon(id, CSW_FLASHBANG) && g_grenade_slot2[id] != NADE_TYPE_FROST)
			{
				client_print(id, print_center, "You can't carry two different defensive grenades!")
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return;
			}
			
			static bpammo
			bpammo = cs_get_user_bpammo(id, CSW_FLASHBANG)
			
			// Already own one
			if (bpammo)
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_FLASHBANG, bpammo+1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_FLASHBANG]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Set grenade type to frost
			g_grenade_slot2[id] = NADE_TYPE_FROST
			
			// Give weapon to the player
			fm_give_item(id, "weapon_flashbang")
		}
		case EXTRA_FORCEFIELD: // Force Field Grenade
		{
			// Carrying other type of that grenade
			if (user_has_weapon(id, CSW_FLASHBANG) && g_grenade_slot2[id] != NADE_TYPE_FORCEFIELD)
			{
				client_print(id, print_center, "You can't carry two different defensive grenades!")
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return;
			}
			
			static bpammo
			bpammo = cs_get_user_bpammo(id, CSW_FLASHBANG)
			
			// Already own one
			if (bpammo)
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_FLASHBANG, bpammo+1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_FLASHBANG]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Set grenade type to frost
			g_grenade_slot2[id] = NADE_TYPE_FORCEFIELD
			
			// Give weapon to the player
			fm_give_item(id, "weapon_flashbang")
		}
		case EXTRA_FLARE: // Flare Grenade
		{
			// Carrying other type of that grenade
			if (user_has_weapon(id, CSW_SMOKEGRENADE) && g_grenade_slot3[id] != NADE_TYPE_FLARE)
			{
				client_print(id, print_center, "You can't carry two different utility grenades!")
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return;
			}
			
			static bpammo
			bpammo = cs_get_user_bpammo(id, CSW_SMOKEGRENADE)
			
			// Already own some
			if (bpammo)
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_SMOKEGRENADE, bpammo+1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_SMOKEGRENADE]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Set grenade type to frost
			g_grenade_slot3[id] = NADE_TYPE_FLARE
			
			// Give weapon to the player
			fm_give_item(id, "weapon_smokegrenade")
		}
		case EXTRA_HEGRENADE:
		{
			// Carrying other type of that grenade
			if (user_has_weapon(id, CSW_HEGRENADE) && g_grenade_slot1[id] != NADE_TYPE_HE)
			{
				client_print(id, print_center, "You can't carry two different offensive grenades!")
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return;
			}
			
			static bpammo
			bpammo = cs_get_user_bpammo(id, CSW_HEGRENADE)
			
			// Already own one
			if (bpammo)
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_HEGRENADE, bpammo+1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_HEGRENADE]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Set grenade type to frost
			g_grenade_slot1[id] = NADE_TYPE_HE
			
			// Give weapon to the player
			fm_give_item(id, "weapon_hegrenade")
		}
		case EXTRA_MOLOTOV:
		{
			// Carrying other type of that grenade
			if (user_has_weapon(id, CSW_HEGRENADE) && g_grenade_slot1[id] != NADE_TYPE_MOLOTOV)
			{
				client_print(id, print_center, "You can't carry two different offensive grenades!")
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return;
			}
			
			static bpammo
			bpammo = cs_get_user_bpammo(id, CSW_HEGRENADE)
			
			// Already own one
			if (bpammo)
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_HEGRENADE, bpammo+1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_HEGRENADE]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Set grenade type to frost
			g_grenade_slot1[id] = NADE_TYPE_MOLOTOV
			
			// Give weapon to the player
			fm_give_item(id, "weapon_hegrenade")
		}
		case EXTRA_CUTTER: // HE-Grenade
		{
			// Carrying other type of that grenade
			if (user_has_weapon(id, CSW_HEGRENADE) && g_grenade_slot1[id] != NADE_TYPE_CUTTER)
			{
				client_print(id, print_center, "You can't carry two different offensive grenades!")
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return;
			}
			
			static bpammo
			bpammo = cs_get_user_bpammo(id, CSW_HEGRENADE)
			
			// Already own one
			if (bpammo)
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_HEGRENADE, bpammo+1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_HEGRENADE]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Set grenade type to cutter
			g_grenade_slot1[id] = NADE_TYPE_CUTTER
			
			// Give weapon to the player
			fm_give_item(id, "weapon_hegrenade")
		}
		default:
		{
			// Item selected forward
			ExecuteForward(g_fwExtraItemSelected, g_fwDummyResult, id, itemid);
			
			// Item purchase blocked, restore buyer's ammo packs
			if (g_fwDummyResult >= ZP_PLUGIN_HANDLED && !ignorecost)
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
		}
	}
}

// Zombie Class Menu
public menu_zclass(id, menuid, item)
{
	// Player disconnected?
	if (!is_user_connected(id))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Remember player's menu page
	static menudummy
	player_menu_info(id, menudummy, menudummy, MENU_PAGE_ZCLASS)
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_game(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve zombie class id
	static buffer[2], dummy, classid
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	classid = buffer[0]
	
	// Unavailable?
	if (g_level[id] < ArrayGetCell(g_zclass_lvl, classid))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Store selection for the next infection
	g_zombieclassnext[id] = classid
	
	static name[32]
	ArrayGetString(g_zclass_name, g_zombieclassnext[id], name, charsmax(name))
	
	// Show selected zombie class info and stats
	zp_colored_print(id, "^x04[ZP]^x01 %L: %s", id, "ZOMBIE_SELECT", name)
	zp_colored_print(id, "^x04[ZP]^x01 %L: %d %L: %d %L: %d %L: %d%%", id, "ZOMBIE_ATTRIB1", ArrayGetCell(g_zclass_hp, g_zombieclassnext[id]), id, "ZOMBIE_ATTRIB2", ArrayGetCell(g_zclass_spd, g_zombieclassnext[id]),
	id, "ZOMBIE_ATTRIB3", floatround(Float:ArrayGetCell(g_zclass_grav, g_zombieclassnext[id]) * 800.0), id, "ZOMBIE_ATTRIB4", floatround(Float:ArrayGetCell(g_zclass_kb, g_zombieclassnext[id]) * 100.0))
	
	menu_destroy(menuid)
	return PLUGIN_HANDLED;
}

// Human Class Menu
public menu_hclass(id, menuid, item)
{
	// Player disconnected?
	if (!is_user_connected(id))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Remember player's menu page
	static menudummy
	player_menu_info(id, menudummy, menudummy, MENU_PAGE_HCLASS)
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_game(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve human class id
	static buffer[2], dummy, classid
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	classid = buffer[0]
	
	// Unavailable?
	if (g_level[id] < ArrayGetCell(g_hclass_lvl, classid))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Store selection for the next spawn
	g_humanclassnext[id] = classid
	
	static name[32]
	ArrayGetString(g_hclass_name, g_humanclassnext[id], name, charsmax(name))
	
	zp_colored_print(id, "^x04[ZP]^x01 Your next human class will be:^x04 %s^x01.", name)
	menu_destroy(menuid)
	return PLUGIN_HANDLED;
}

// Admin Menu
public menu_admin(id, key)
{
	// Player disconnected?
	if (!g_isconnected[id])
		return PLUGIN_HANDLED;
	
	static userflags
	userflags = get_user_flags(id)
	
	switch (key)
	{
		case ACTION_ZOMBIEFY_HUMANIZE: // Zombiefy/Humanize command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_INFECTION] | g_access_flag[ACCESS_MAKE_ZOMBIE] | g_access_flag[ACCESS_MAKE_HUMAN]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_ZOMBIEFY_HUMANIZE
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case ACTION_MAKE_NEMESIS: // Nemesis command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_NEMESIS] | g_access_flag[ACCESS_MAKE_NEMESIS]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_NEMESIS
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case ACTION_MAKE_SURVIVOR: // Survivor command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_SURVIVOR] | g_access_flag[ACCESS_MAKE_SURVIVOR]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_SURVIVOR
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case ACTION_RESPAWN_PLAYER: // Respawn command
		{
			if (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS])
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_RESPAWN_PLAYER
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case ACTION_MODE_SWARM: // Swarm Mode command
		{
			if (userflags & g_access_flag[ACCESS_MODE_SWARM])
			{
				if (allowed_swarm())
					command_swarm(id)
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			
			show_menu_admin(id)
		}
		case ACTION_MODE_MULTI: // Multiple Infection command
		{
			if (userflags & g_access_flag[ACCESS_MODE_MULTI])
			{
				if (allowed_multi())
					command_multi(id)
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			
			show_menu_admin(id)
		}
		case ACTION_MODE_PLAGUE: // Plague Mode command
		{
			if (userflags & g_access_flag[ACCESS_MODE_PLAGUE])
			{
				if (allowed_plague())
					command_plague(id)
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			
			show_menu_admin(id)
		}
		case ACTION_MODE_ARMAGEDDON: // Armageddon Mode command
		{
			if (userflags & g_access_flag[ACCESS_MODE_ARMAGEDDON])
			{
				if (allowed_armageddon())
					command_armageddon(id)
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			
			show_menu_admin(id)
		}
	}
	
	return PLUGIN_HANDLED;
}

// Player List Menu
public menu_player_list(id, menuid, item)
{
	// Player disconnected?
	if (!is_user_connected(id))
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Remember player's menu page
	static menudummy
	player_menu_info(id, menudummy, menudummy, MENU_PAGE_PLAYERS)
	
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_admin(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve player id
	static buffer[2], dummy, playerid
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	playerid = buffer[0]
	
	// Perform action on player
	
	// Get admin flags
	static userflags
	userflags = get_user_flags(id)
	
	// Make sure it's still connected
	if (g_isconnected[playerid])
	{
		// Perform the right action if allowed
		switch (PL_ACTION)
		{
			case ACTION_ZOMBIEFY_HUMANIZE: // Zombiefy/Humanize command
			{
				if (g_zombie[playerid])
				{
					if (userflags & g_access_flag[ACCESS_MAKE_HUMAN])
					{
						if (allowed_human(playerid))
							command_human(id, playerid)
						else
							zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
					}
					else
						zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				}
				else
				{
					if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_INFECTION]) : (userflags & g_access_flag[ACCESS_MAKE_ZOMBIE]))
					{
						if (allowed_zombie(playerid))
							command_zombie(id, playerid)
						else
							zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
					}
					else
						zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				}
			}
			case ACTION_MAKE_NEMESIS: // Nemesis command
			{
				if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_NEMESIS]) : (userflags & g_access_flag[ACCESS_MAKE_NEMESIS]))
				{
					if (allowed_nemesis(playerid))
						command_nemesis(id, playerid)
					else
						zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_SURVIVOR: // Survivor command
			{
				if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_SURVIVOR]) : (userflags & g_access_flag[ACCESS_MAKE_SURVIVOR]))
				{
					if (allowed_survivor(playerid))
						command_survivor(id, playerid)
					else
						zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_RESPAWN_PLAYER: // Respawn command
			{
				if (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS])
				{
					if (allowed_respawn(playerid))
						command_respawn(id, playerid)
					else
						zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
		}
	}
	else
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
	
	menu_destroy(menuid)
	show_menu_player_list(id)
	return PLUGIN_HANDLED;
}

// CS Buy Menus
public menu_cs_buy(id, key)
{
	// Prevent buying if zombie/survivor (bugfix)
	if (g_zombie[id] || g_survivor[id])
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

/*================================================================================
 [Admin Commands]
=================================================================================*/

// zp_toggle [1/0]
public cmd_toggle(id, level, cid)
{
	// Check for access flag - Enable/Disable Mod
	if (!cmd_access(id, g_access_flag[ACCESS_ENABLE_MOD], cid, 2))
		return PLUGIN_HANDLED;
	
	// Retrieve arguments
	new arg[2]
	read_argv(1, arg, charsmax(arg))
	
	// Mod already enabled/disabled
	if (str_to_num(arg) == g_pluginenabled)
		return PLUGIN_HANDLED;
	
	// Set toggle cvar
	set_pcvar_num(cvar_toggle, str_to_num(arg))
	client_print(id, print_console, "Zombie Plague %L.", id, str_to_num(arg) ? "MOTD_ENABLED" : "MOTD_DISABLED")
	
	// Retrieve map name
	new mapname[32]
	get_mapname(mapname, charsmax(mapname))
	
	// Restart current map
	server_cmd("changelevel %s", mapname)
	
	return PLUGIN_HANDLED;
}

// zp_zombie [target]
public cmd_zombie(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Infection
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_INFECTION], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Zombie
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_ZOMBIE], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be zombie
	if (!allowed_zombie(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED
	}
	
	command_zombie(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_human [target]
public cmd_human(id, level, cid)
{
	// Check for access flag - Make Human
	if (!cmd_access(id, g_access_flag[ACCESS_MAKE_HUMAN], cid, 2))
		return PLUGIN_HANDLED;
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be human
	if (!allowed_human(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_human(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_survivor [target]
public cmd_survivor(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Survivor
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_SURVIVOR], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Survivor
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_SURVIVOR], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be survivor
	if (!allowed_survivor(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_survivor(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_nemesis [target]
public cmd_nemesis(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Nemesis
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_NEMESIS], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Nemesis
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_NEMESIS], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be nemesis
	if (!allowed_nemesis(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_nemesis(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_respawn [target]
public cmd_respawn(id, level, cid)
{
	// Check for access flag - Respawn
	if (!cmd_access(id, g_access_flag[ACCESS_RESPAWN_PLAYERS], cid, 2))
		return PLUGIN_HANDLED;
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, CMDTARGET_ALLOW_SELF)
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be respawned
	if (!allowed_respawn(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_respawn(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_swarm
public cmd_swarm(id, level, cid)
{
	// Check for access flag - Mode Swarm
	if (!cmd_access(id, g_access_flag[ACCESS_MODE_SWARM], cid, 1))
		return PLUGIN_HANDLED;
	
	// Swarm mode not allowed
	if (!allowed_swarm())
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_swarm(id)
	
	return PLUGIN_HANDLED;
}

// zp_multi
public cmd_multi(id, level, cid)
{
	// Check for access flag - Mode Multi
	if (!cmd_access(id, g_access_flag[ACCESS_MODE_MULTI], cid, 1))
		return PLUGIN_HANDLED;
	
	// Multi infection mode not allowed
	if (!allowed_multi())
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_multi(id)
	
	return PLUGIN_HANDLED;
}

// zp_plague
public cmd_plague(id, level, cid)
{
	// Check for access flag - Mode Plague
	if (!cmd_access(id, g_access_flag[ACCESS_MODE_PLAGUE], cid, 1))
		return PLUGIN_HANDLED;
	
	// Plague mode not allowed
	if (!allowed_plague())
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_plague(id)
	
	return PLUGIN_HANDLED;
}

// zp_armageddon
public cmd_armageddon(id, level, cid)
{
	// Check for access flag - Mode Plague
	if (!cmd_access(id, g_access_flag[ACCESS_MODE_ARMAGEDDON], cid, 1))
		return PLUGIN_HANDLED;
	
	// Plague mode not allowed
	if (!allowed_armageddon())
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_armageddon(id)
	
	return PLUGIN_HANDLED;
}

// zp_vip
public cmd_vip(id, level, cid)
{
	// Check for access flag - Mode VIP
	if (!cmd_access(id, g_access_flag[ACCESS_MODE_VIP], cid, 1))
		return PLUGIN_HANDLED;
	
	// Plague mode not allowed
	if (!allowed_vip())
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_vip(id)
	return PLUGIN_HANDLED;
}

/*================================================================================
 [Message Hooks]
=================================================================================*/

// Take off player's money
public message_money(msg_id, msg_dest, msg_entity)
{
	// Remove money setting enabled?
	if (!get_pcvar_num(cvar_removemoney))
		return PLUGIN_CONTINUE;
	
	fm_cs_set_user_money(msg_entity, 0)
	return PLUGIN_HANDLED;
}

// Fix for the HL engine bug when HP is multiples of 256
public message_health(msg_id, msg_dest, msg_entity)
{
	// Get player's health
	static health
	health = get_msg_arg_int(1)
	
	// Don't bother
	if (health < 256) return;
	
	// Check if we need to fix it
	if (health % 256 == 0)
		fm_set_user_health(msg_entity, pev(msg_entity, pev_health) + 1)
	
	// HUD can only show as much as 255 hp
	set_msg_arg_int(1, get_msg_argtype(1), 255)
}

// Show zombies' armor
public message_battery(msg_id, msg_dest, msg_entity)
{
	// Not a zombie
	if (!g_zombie[msg_entity] || g_nemesis[msg_entity])
		return;
	
	// Armor value
	static armor
	armor = floatround((1.0 - Float:ArrayGetCell(g_zclass_armor, g_zombieclass[msg_entity])) * 1000.0)
	
	// Show armor
	set_msg_arg_int(1, get_msg_argtype(1), armor)
}

// Block flashlight battery messages if custom flashlight is enabled instead
public message_flashbat()
{
	if (g_cached_customflash)
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Flashbangs should only affect zombies
public message_screenfade(msg_id, msg_dest, msg_entity)
{
	if (get_msg_arg_int(4) != 255 || get_msg_arg_int(5) != 255 || get_msg_arg_int(6) != 255 || get_msg_arg_int(7) < 200)
		return PLUGIN_CONTINUE;
	
	// Nemesis shouldn't be FBed
	if (g_zombie[msg_entity] && !g_nemesis[msg_entity])
	{
		// Set flash color to 0
		set_msg_arg_int(4, get_msg_argtype(4), 0)
		set_msg_arg_int(5, get_msg_argtype(5), 0)
		set_msg_arg_int(6, get_msg_argtype(6), 0)
		return PLUGIN_CONTINUE;
	}
	
	return PLUGIN_HANDLED;
}

// Prevent spectators' nightvision from being turned off when switching targets, etc.
public message_nvgtoggle()
{
	return PLUGIN_HANDLED;
}

// Set correct model on player corpses
public message_clcorpse()
{
	set_msg_arg_string(1, g_playermodel[get_msg_arg_int(12)])
}

// Prevent zombies from seeing any weapon pickup icon
public message_weappickup(msg_id, msg_dest, msg_entity)
{
	if (g_zombie[msg_entity])
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Prevent zombies from seeing any ammo pickup icon
public message_ammopickup(msg_id, msg_dest, msg_entity)
{
	if (g_zombie[msg_entity])
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Block hostage HUD display
public message_scenario()
{
	if (get_msg_args() > 1)
	{
		static sprite[8]
		get_msg_arg_string(2, sprite, charsmax(sprite))
		
		if (equal(sprite, "hostage"))
			return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

// Block hostages from appearing on radar
public message_hostagepos()
{
	return PLUGIN_HANDLED;
}

// Block some text messages
public message_textmsg()
{
	static textmsg[64]
	get_msg_arg_string(2, textmsg, charsmax(textmsg))
	
	// Game restarting, reset scores and call round end to balance the teams
	if (equal(textmsg, "#Game_will_restart_in"))
	{
		logevent_round_end()
		g_scorehumans = 0
		g_scorezombies = 0
	}
	// Game commencing, reset scores only (round end is automatically triggered)
	else if (equal(textmsg, "#Game_Commencing"))
	{
		g_gamecommencing = true
		g_scorehumans = 0
		g_scorezombies = 0
	}
	// Block round end related messages
	else if (equal(textmsg, "#Hostages_Not_Rescued") || equal(textmsg, "#Round_Draw") || equal(textmsg, "#Terrorists_Win") || equal(textmsg, "#CTs_Win"))
	{
		return PLUGIN_HANDLED;
	}
	// Block C4 related messages
	else if (equal(textmsg, "#C4_Plant_At_Bomb_Spot") || equal(textmsg, "#C4_Plant_Must_Be_On_Ground"))
	{
		return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

// Block CS round win audio messages, since we're playing our own instead
public message_sendaudio()
{
	static audio[17]
	get_msg_arg_string(2, audio, charsmax(audio))
	
	if(equal(audio[7], "terwin") || equal(audio[7], "ctwin") || equal(audio[7], "rounddraw"))
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Send actual team scores (T = zombies // CT = humans)
public message_teamscore()
{
	static team[2]
	get_msg_arg_string(1, team, charsmax(team))
	
	switch (team[0])
	{
		// CT
		case 'C': set_msg_arg_int(2, get_msg_argtype(2), g_scorehumans)
		// Terrorist
		case 'T': set_msg_arg_int(2, get_msg_argtype(2), g_scorezombies)
	}
}

// Team Switch (or player joining a team for first time)
public message_teaminfo(msg_id, msg_dest)
{
	// Only hook global messages
	if (msg_dest != MSG_ALL && msg_dest != MSG_BROADCAST) return;
	
	// Don't pick up our own TeamInfo messages for this player (bugfix)
	if (g_switchingteam) return;
	
	// Get player's id
	static id
	id = get_msg_arg_int(1)
	
	// Invalid player id? (bugfix)
	if (!(1 <= id <= g_maxplayers)) return;
	
	// Enable spectators' nightvision if not spawning right away
	set_task(0.2, "spec_nvision", id)
	
	// Round didn't start yet, nothing to worry about
	if (g_newround) return;
	
	// Get his new team
	static team[2]
	get_msg_arg_string(2, team, charsmax(team))
	
	// Perform some checks to see if they should join a different team instead
	switch (team[0])
	{
		case 'C': // CT
		{
			if (g_survround && fnGetHumans()) // survivor alive --> switch to T and spawn as zombie
			{
				g_respawn_as_zombie[id] = true;
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_T)
				set_msg_arg_string(2, "TERRORIST")
			}
			else if (!fnGetZombies()) // no zombies alive --> switch to T and spawn as zombie
			{
				g_respawn_as_zombie[id] = true;
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_T)
				set_msg_arg_string(2, "TERRORIST")
			}
		}
		case 'T': // Terrorist
		{
			if ((g_swarmround || g_survround) && fnGetHumans()) // survivor alive or swarm round w/ humans --> spawn as zombie
			{
				g_respawn_as_zombie[id] = true;
			}
			else if (fnGetZombies()) // zombies alive --> switch to CT
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				set_msg_arg_string(2, "CT")
			}
		}
	}
}

// Damage
public message_damage()
{
	// Don't send generic damage
	if (get_msg_arg_int(3) == DMG_GENERIC)
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Score attrib
public message_score_attrib(msg_id, msg_dest, msg_entity)
{
	static iPlayer
	iPlayer = get_msg_arg_int(SCOREATTRIB_ARG_PLAYERID)
	
	if (g_isalive[iPlayer] && g_vip[iPlayer])
		set_msg_arg_int(SCOREATTRIB_ARG_FLAGS, ARG_BYTE, SCOREATTRIB_FLAG_VIP)
}

/*================================================================================
 [Main Functions]
=================================================================================*/

// Make Zombie Task
public make_zombie_task()
{
	// Call make a zombie with no specific mode
	make_a_zombie(MODE_NONE, 0)
}

// Make a Zombie Function
make_a_zombie(mode, id)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	// Not enough players, come back later!
	if ((!id && iPlayersnum < 2) || (id && iPlayersnum < 1))
	{
		set_task(2.0, "make_zombie_task", TASK_MAKEZOMBIE)
		return;
	}
	
	// Round started!
	g_newround = false
	
	// Set up some common vars
	static forward_id, sound[64], iZombies, iMaxZombies
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_SURVIVOR) && random_num(1, get_pcvar_num(cvar_survchance)) == get_pcvar_num(cvar_surv) && iPlayersnum >= get_pcvar_num(cvar_survminplayers)) || mode == MODE_SURVIVOR)
	{
		// Survivor Mode
		g_survround = true
		g_lastmode = MODE_SURVIVOR
		
		// Choose player randomly?
		if (mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into a survivor
		humanme(id, 1, 0)
		
		// Turn the remaining players into zombies
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// Survivor or already a zombie
			if (g_survivor[id] || g_zombie[id])
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}
		
		// Play survivor sound
		ArrayGetString(sound_survivor, random_num(0, ArraySize(sound_survivor) - 1), sound, charsmax(sound))
		PlayGlobalSound(sound);
		
		// Show Survivor HUD notice
		set_dhudmessage(20, 20, 255, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 2.0, 1.0, 1.0)
		show_dhudmessage(0, "%L", LANG_PLAYER, "NOTICE_SURVIVOR", g_playername[forward_id])
		
		// Mode fully started!
		g_modestarted = true
		
		// Round start forward
		ExecuteForward(g_fwRoundStart, g_fwDummyResult, MODE_SURVIVOR, forward_id);
	}
	else if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_SWARM) && random_num(1, get_pcvar_num(cvar_swarmchance)) == get_pcvar_num(cvar_swarm) && iPlayersnum >= get_pcvar_num(cvar_swarmminplayers)) || mode == MODE_SWARM)
	{		
		// Swarm Mode
		g_swarmround = true
		g_lastmode = MODE_SWARM
		
		// Make sure there are alive players on both teams (BUGFIX)
		if (!fnGetAliveTs())
		{
			// Move random player to T team
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_T)
			fm_user_team_update(id)
		}
		else if (!fnGetAliveCTs())
		{
			// Move random player to CT team
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_CT)
			fm_user_team_update(id)
		}
		
		// Turn every T into a zombie
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// Not a Terrorist
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_T)
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}
		
		// Play swarm sound
		ArrayGetString(sound_swarm, random_num(0, ArraySize(sound_swarm) - 1), sound, charsmax(sound))
		PlayGlobalSound(sound);
		
		// Show Swarm HUD notice
		set_dhudmessage(20, 255, 20, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 2.0, 1.0, 1.0)
		show_dhudmessage(0, "%L", LANG_PLAYER, "NOTICE_SWARM")
		
		// Mode fully started!
		g_modestarted = true
		
		// Round start forward
		ExecuteForward(g_fwRoundStart, g_fwDummyResult, MODE_SWARM, 0);
	}
	else if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_MULTI) && random_num(1, get_pcvar_num(cvar_multichance)) == get_pcvar_num(cvar_multi) && floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) >= 2 && floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) < iPlayersnum && iPlayersnum >= get_pcvar_num(cvar_multiminplayers)) || mode == MODE_MULTI)
	{
		// Multi Infection Mode
		g_lastmode = MODE_MULTI
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil)
		iZombies = 0
		
		// Randomly turn iMaxZombies players into zombies
		while (iZombies < iMaxZombies)
		{
			// Keep looping through all players
			if (++id > g_maxplayers) id = 1
			
			// Dead or already a zombie
			if (!g_isalive[id] || g_zombie[id])
				continue;
			
			// Random chance
			if (random_num(0, 1))
			{
				// Turn into a zombie
				zombieme(id, 0, 0, 1, 0)
				iZombies++
			}
		}
		
		// Turn the remaining players into humans
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Only those of them who aren't zombies
			if (!g_isalive[id] || g_zombie[id])
				continue;
			
			// Switch to CT
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
		}
		
		// Play multi infection sound
		ArrayGetString(sound_multi, random_num(0, ArraySize(sound_multi) - 1), sound, charsmax(sound))
		PlayGlobalSound(sound)
		
		// Show Multi Infection HUD notice
		set_dhudmessage(200, 50, 0, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 2.0, 1.0, 1.0)
		show_dhudmessage(0, "%L", LANG_PLAYER, "NOTICE_MULTI")
		
		// Mode fully started!
		g_modestarted = true
		
		// Round start forward
		ExecuteForward(g_fwRoundStart, g_fwDummyResult, MODE_MULTI, 0);
		
		// Make a nemesis
		set_task(300.0-2.0-get_pcvar_float(cvar_warmup), "make_a_nemesis", TASK_MINUTENEMESIS)
	}
	else if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_PLAGUE) && random_num(1, get_pcvar_num(cvar_plaguechance)) == get_pcvar_num(cvar_plague) && floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil) >= 1
	&& iPlayersnum-(get_pcvar_num(cvar_plaguesurvnum)+get_pcvar_num(cvar_plaguenemnum)+floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)) >= 1 && iPlayersnum >= get_pcvar_num(cvar_plagueminplayers)) || mode == MODE_PLAGUE)
	{
		// Plague Mode
		g_plagueround = true
		g_lastmode = MODE_PLAGUE
		
		// Turn specified amount of players into Survivors
		static iSurvivors, iMaxSurvivors
		iMaxSurvivors = get_pcvar_num(cvar_plaguesurvnum)
		iSurvivors = 0
		
		while (iSurvivors < iMaxSurvivors)
		{
			// Choose random guy
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			
			// Already a survivor?
			if (g_survivor[id])
				continue;
			
			// If not, turn him into one
			humanme(id, 1, 0)
			iSurvivors++
			
			// Apply survivor health multiplier
			fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_plaguesurvhpmulti)))
		}
		
		// Turn specified amount of players into Nemesis
		static iNemesis, iMaxNemesis
		iMaxNemesis = get_pcvar_num(cvar_plaguenemnum)
		iNemesis = 0
		
		while (iNemesis < iMaxNemesis)
		{
			// Choose random guy
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			
			// Already a survivor or nemesis?
			if (g_survivor[id] || g_nemesis[id])
				continue;
			
			// If not, turn him into one
			zombieme(id, 0, 1, 0, 0)
			iNemesis++
			
			// Apply nemesis health multiplier
			fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_plaguenemhpmulti)))
		}
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)
		iZombies = 0
		
		// Randomly turn iMaxZombies players into zombies
		while (iZombies < iMaxZombies)
		{
			// Keep looping through all players
			if (++id > g_maxplayers) id = 1
			
			// Dead or already a zombie or survivor
			if (!g_isalive[id] || g_zombie[id] || g_survivor[id])
				continue;
			
			// Random chance
			if (random_num(0, 1))
			{
				// Turn into a zombie
				zombieme(id, 0, 0, 1, 0)
				iZombies++
			}
		}
		
		// Turn the remaining players into humans
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Only those of them who arent zombies or survivor
			if (!g_isalive[id] || g_zombie[id] || g_survivor[id])
				continue;
			
			// Switch to CT
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
		}
		
		// Play plague sound
		ArrayGetString(sound_plague, random_num(0, ArraySize(sound_plague) - 1), sound, charsmax(sound))
		PlayGlobalSound(sound);
		
		// Show Plague HUD notice
		set_dhudmessage(0, 50, 200, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 2.0, 1.0, 1.0)
		show_dhudmessage(0, "%L", LANG_PLAYER, "NOTICE_PLAGUE")
		
		// Mode fully started!
		g_modestarted = true
		
		// Round start forward
		ExecuteForward(g_fwRoundStart, g_fwDummyResult, MODE_PLAGUE, 0);
	}
	else if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_VIP) && random_num(1, get_pcvar_num(cvar_vipchance)) == get_pcvar_num(cvar_vip) && floatround(iPlayersnum*get_pcvar_float(cvar_vipratio), floatround_ceil) >= 2 && floatround(iPlayersnum*get_pcvar_float(cvar_vipratio), floatround_ceil) < iPlayersnum && iPlayersnum >= get_pcvar_num(cvar_vipminplayers)) || mode == MODE_VIP)
	{
		// VIP Mode
		g_vipround = true
		g_lastmode = MODE_VIP
		
		// First, turn one player into zombie
		id = fnGetRandomAlive(random_num(1, iPlayersnum))
		zombieme(id, 0, 0, 0, 0)
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround((iPlayersnum-1)*get_pcvar_float(cvar_vipratio), floatround_ceil) // should be iMaxVIPs though
		iZombies = 0
		
		// Randomly turn iMaxZombies players into VIPs
		while (iZombies < iMaxZombies)
		{
			// Keep looping through all players
			if (++id > g_maxplayers) id = 1
			
			// Dead or zombie or already a VIP
			if (!g_isalive[id] || g_zombie[id] || g_vip[id])
				continue;
			
			// Random chance
			if (random_num(0, 1))
			{
				// Turn into a VIP
				vipme(id)
				iZombies++
			}
		}
		
		// Turn the remaining players into humans
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Only those of them who aren't zombies
			if (!g_isalive[id] || g_zombie[id])
				continue;
			
			// Switch to CT
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
		}
		
		// Play multi infection sound
		ArrayGetString(sound_vip, random_num(0, ArraySize(sound_vip) - 1), sound, charsmax(sound))
		PlayGlobalSound(sound)
		
		// Show Multi Infection HUD notice
		set_dhudmessage(200, 200, 200, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 2.0, 1.0, 1.0)
		show_dhudmessage(0, "Protect the VIPs !!!")
		
		// Mode fully started!
		g_modestarted = true
		
		// Round start forward
		ExecuteForward(g_fwRoundStart, g_fwDummyResult, MODE_VIP, 0);
	}
	else if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_ARMAGEDDON) && random_num(1, get_pcvar_num(cvar_armageddonchance)) == get_pcvar_num(cvar_armageddon) && iPlayersnum >= 2) || mode == MODE_ARMAGEDDON)
	{
		// Armageddon Mode
		g_armageddonround = true
		g_lastmode = MODE_ARMAGEDDON
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround(iPlayersnum * 0.5, floatround_ceil)
		iZombies = 0
		
		// Randomly turn iMaxZombies players into Nemesis
		while (iZombies < iMaxZombies)
		{
			// Keep looping through all players
			if (++id > g_maxplayers) id = 1
			
			// Dead or already a zombie or survivor
			if (!g_isalive[id] || g_zombie[id] || g_survivor[id])
				continue;
			
			// Random chance
			if (random_num(0, 1))
			{
				// Turn into a Nemesis
				zombieme(id, 0, 1, 0, 0)
				iZombies++
			}
		}
		
		// Turn the remaining players into survivors
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Only those of them who arent zombies or survivor
			if (!g_isalive[id] || g_zombie[id] || g_survivor[id])
				continue;
			
			// Turn into a Survivor
			humanme(id, 1, 0)
		}
		
		// Play armageddon sound
		ArrayGetString(sound_armageddon, random_num(0, ArraySize(sound_armageddon) - 1), sound, charsmax(sound))
		PlayGlobalSound(sound)
		
		// Show Armageddon HUD notice
		set_dhudmessage(200, 200, 200, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 2.0, 1.0, 1.0)
		show_dhudmessage(0, "Armageddon Mode !!!")
		
		// Mode fully started!
		g_modestarted = true
		
		// Round start forward
		ExecuteForward(g_fwRoundStart, g_fwDummyResult, MODE_ARMAGEDDON, 0);
	}
	else
	{
		// Single Infection Mode or Nemesis Mode
		
		// Choose player randomly?
		if (mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_NEMESIS) && random_num(1, get_pcvar_num(cvar_nemchance)) == get_pcvar_num(cvar_nem) && iPlayersnum >= get_pcvar_num(cvar_nemminplayers)) || mode == MODE_NEMESIS)
		{
			// Nemesis Mode
			g_nemround = true
			g_lastmode = MODE_NEMESIS
			
			// Turn player into nemesis
			zombieme(id, 0, 1, 0, 0)
		}
		else
		{
			// Single Infection Mode
			g_lastmode = MODE_INFECTION
			
			// Turn player into the first zombie
			zombieme(id, 0, 0, 0, 0)
		}
		
		// Remaining players should be humans (CTs)
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// First zombie/nemesis
			if (g_zombie[id])
				continue;
			
			// Switch to CT
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
		}
		
		if (g_nemround)
		{
			// Play Nemesis sound
			ArrayGetString(sound_nemesis, random_num(0, ArraySize(sound_nemesis) - 1), sound, charsmax(sound))
			PlayGlobalSound(sound)
			
			// Show Nemesis HUD notice
			set_dhudmessage(255, 20, 20, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 2.0, 1.0, 1.0)
			show_dhudmessage(0, "%s mutated into a Nemesis !!!", g_playername[forward_id])
			
			// Mode fully started!
			g_modestarted = true
			
			// Round start forward
			ExecuteForward(g_fwRoundStart, g_fwDummyResult, MODE_NEMESIS, forward_id);
		}
		else
		{
			// Play single infection sound
			ArrayGetString(sound_none, random_num(0, ArraySize(sound_none) - 1), sound, charsmax(sound))
			PlayGlobalSound(sound)
			
			// Show First Zombie HUD notice
			set_dhudmessage(255, 0, 0, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 2.0, 1.0, 1.0)
			show_dhudmessage(0, "%L",LANG_PLAYER, "NOTICE_FIRST", g_playername[forward_id])
			
			// Mode fully started!
			g_modestarted = true
			
			// Round start forward
			ExecuteForward(g_fwRoundStart, g_fwDummyResult, MODE_INFECTION, forward_id);
			
			// Make a nemesis
			set_task(300.0-2.0-get_pcvar_float(cvar_warmup), "make_a_nemesis", TASK_MINUTENEMESIS)
		}
	}
	
	// Start ambience sounds after a mode begins
	if ((g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS] && g_nemround) || (g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR] && g_survround) || (g_ambience_sounds[AMBIENCE_SOUNDS_SWARM] && g_swarmround) || (g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE] && g_plagueround)
	|| (g_ambience_sounds[AMBIENCE_SOUNDS_ARMAGEDDON] && g_armageddonround) || (g_ambience_sounds[AMBIENCE_SOUNDS_VIP] && g_vipround) || (g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION] && !g_nemround && !g_survround && !g_swarmround && !g_plagueround && !g_armageddonround && !g_vipround))
	{
		remove_task(TASK_AMBIENCESOUNDS)
		set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
	}
}

// Make nemesis after 5 minutes
public make_a_nemesis()
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAliveTs()
	
	// Not enough players?
	if (!iPlayersnum)
		return;
	
	// Select random nemesis
	static id
	id = fnGetRandomAliveT(random_num(1, iPlayersnum))
	
	// Valid zombie?
	if (g_zombie[id])
	{
		// Make nemesis
		zombieme(id, 0, 1, 0, 0)
		
		// Show Nemesis HUD notice
		set_dhudmessage(255, 20, 20, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 2.0, 1.0, 1.0)
		show_dhudmessage(0, "%s mutated into a Nemesis !!!", g_playername[id])
	}
}

// Zombie Me Function (player id, infector, turn into a nemesis, silent mode, deathmsg and rewards)
zombieme(id, infector, nemesis, silentmode, rewards)
{
	// User infect attempt forward
	ExecuteForward(g_fwUserInfect_attempt, g_fwDummyResult, id, infector, nemesis)
	
	// One or more plugins blocked the infection. Only allow this after making sure it's
	// not going to leave us with no zombies. Take into account a last player leaving case.
	// BUGFIX: only allow after a mode has started, to prevent blocking first zombie e.g.
	if (g_fwDummyResult >= ZP_PLUGIN_HANDLED && g_modestarted && fnGetZombies() > g_lastplayerleaving)
		return;
	
	// Pre user infect forward
	ExecuteForward(g_fwUserInfected_pre, g_fwDummyResult, id, infector, nemesis)
	
	// Show zombie class menu if they haven't chosen any (e.g. just connected)
	if (g_zombieclassnext[id] == ZCLASS_NONE && get_pcvar_num(cvar_zclasses))
		set_task(0.2, "show_menu_zclass", id)
	
	// Bugfix
	set_user_rendering(id)
	
	// Set selected zombie class
	g_zombieclass[id] = g_zombieclassnext[id]
	// If no class selected yet, use the first (default) one
	if (g_zombieclass[id] == ZCLASS_NONE) g_zombieclass[id] = 0
	
	// Way to go...
	g_zombie[id] = true
	g_nemesis[id] = false
	g_survivor[id] = false
	g_firstzombie[id] = false
	
	// Remove survivor's aura (bugfix)
	set_pev(id, pev_effects, pev(id, pev_effects) &~ EF_BRIGHTLIGHT)
	
	// Remove spawn protection (bugfix)
	g_nodamage[id] = false
	set_pev(id, pev_effects, pev(id, pev_effects) &~ EF_NODRAW)
	
	// Reset burning duration counter (bugfix)
	g_burning_duration[id] = 0
	g_freezing_duration[id] = 0
	
	// Show deathmsg and reward infector?
	if (rewards && infector)
	{
		// Send death notice and fix the "dead" attrib on scoreboard
		SendDeathMsg(infector, id)
		FixDeadAttrib(id)
		
		// Reward frags, deaths, health, and ammo packs
		UpdateFrags(infector, id, get_pcvar_num(cvar_fragsinfect), 1, 1)
		fm_set_user_health(infector, pev(infector, pev_health) + get_pcvar_num(cvar_zombiebonushp))
		
		// Add to total counter
		g_db_humansinfected[infector]++
	}
	
	// Cache speed, knockback, and name for player's class
	g_zombie_spd[id] = float(ArrayGetCell(g_zclass_spd, g_zombieclass[id]))
	g_zombie_knockback[id] = Float:ArrayGetCell(g_zclass_kb, g_zombieclass[id])
	ArrayGetString(g_zclass_name, g_zombieclass[id], g_zombie_classname[id], charsmax(g_zombie_classname[]))
	
	// Set zombie attributes based on the mode
	static sound[64]
	if (!silentmode)
	{
		if (nemesis)
		{
			// Nemesis
			g_nemesis[id] = true
			
			// Set health [0 = auto]
			if (get_pcvar_num(cvar_nemhp) == 0)
			{
				if (get_pcvar_num(cvar_nembasehp) == 0)
					fm_set_user_health(id, ArrayGetCell(g_zclass_hp, 0) * fnGetAlive())
				else
					fm_set_user_health(id, get_pcvar_num(cvar_nembasehp) * fnGetAlive())
			}
			else
				fm_set_user_health(id, get_pcvar_num(cvar_nemhp))
			
			// Set gravity, if frozen set the restore gravity value instead
			if (!g_freezing_duration[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_nemgravity))
			else g_frozen_gravity[id] = get_pcvar_float(cvar_nemgravity)
			
			// Set nemesis maxspeed
			ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
		}
		else if (fnGetZombies() == 1)
		{
			// First zombie
			g_firstzombie[id] = true
			
			// Set health
			set_pev(id, pev_health, calculate_zhealth(id)*get_pcvar_float(cvar_zombiefirsthp))
			
			// Set gravity, if frozen set the restore gravity value instead
			if (!g_freezing_duration[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
			else g_frozen_gravity[id] = Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id])
			
			// Set zombie maxspeed
			ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
			
			// Infection sound
			ArrayGetString(zombie_infect, random_num(0, ArraySize(zombie_infect) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		}
		else
		{
			// Infected by someone
			
			// Set health
			set_pev(id, pev_health, calculate_zhealth(id))
			
			// Set gravity, if frozen set the restore gravity value instead
			if (!g_freezing_duration[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
			else g_frozen_gravity[id] = Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id])
			
			// Set zombie maxspeed
			ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
			
			// Infection sound
			ArrayGetString(zombie_infect, random_num(0, ArraySize(zombie_infect) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		}
	}
	else
	{
		// Silent mode, no HUD messages, no infection sounds
		
		// Set health
		set_pev(id, pev_health, calculate_zhealth(id))
		
		// Set gravity, if frozen set the restore gravity value instead
		if (!g_freezing_duration[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
		else g_frozen_gravity[id] = Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id])
		
		// Set zombie maxspeed
		ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
	}
	
	// Remove previous tasks
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	remove_task(id+TASK_FREEZE)
	
	// Switch to T
	if (fm_cs_get_user_team(id) != FM_CS_TEAM_T) // need to change team?
	{
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_T)
		fm_user_team_update(id)
	}
	
	// Custom models stuff
	static currentmodel[32], tempmodel[32], already_has_model, i, iRand, size
	already_has_model = false
	
	if (g_handle_models_on_separate_ent)
	{
		// Set the right model
		if (g_nemesis[id])
		{
			iRand = random_num(0, ArraySize(model_nemesis) - 1)
			ArrayGetString(model_nemesis, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_nemesis, iRand))
		}
		else
		{
			if (get_pcvar_num(cvar_adminmodelszombie) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]))
			{
				iRand = random_num(0, ArraySize(model_admin_zombie) - 1)
				ArrayGetString(model_admin_zombie, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_zombie, iRand))
			}
			else
			{
				iRand = random_num(ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]), ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]) - 1)
				ArrayGetString(g_zclass_playermodel, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_zclass_modelindex, iRand))
			}
		}
		
		// Set model on player model entity
		fm_set_playermodel_ent(id)
		
		// Nemesis glow / remove glow on player model entity, unless frozen
		if (!g_freezing_duration[id])
		{
			if (g_nemesis[id] && get_pcvar_num(cvar_nemglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 100, 0, 0, kRenderNormal, 1)
			else
				fm_set_rendering(g_ent_playermodel[id])
		}
	}
	else
	{
		// Get current model for comparing it with the current one
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// Set the right model, after checking that we don't already have it
		if (g_nemesis[id])
		{
			size = ArraySize(model_nemesis)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_nemesis, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_nemesis, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_nemesis, iRand))
			}
		}
		else
		{
			if (get_pcvar_num(cvar_adminmodelszombie) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]))
			{
				size = ArraySize(model_admin_zombie)
				for (i = 0; i < size; i++)
				{
					ArrayGetString(model_admin_zombie, i, tempmodel, charsmax(tempmodel))
					if (equal(currentmodel, tempmodel)) already_has_model = true
				}
				
				if (!already_has_model)
				{
					iRand = random_num(0, size - 1)
					ArrayGetString(model_admin_zombie, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_zombie, iRand))
				}
			}
			else
			{
				for (i = ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]); i < ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]); i++)
				{
					ArrayGetString(g_zclass_playermodel, i, tempmodel, charsmax(tempmodel))
					if (equal(currentmodel, tempmodel)) already_has_model = true
				}
				
				if (!already_has_model)
				{
					iRand = random_num(ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]), ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]) - 1)
					ArrayGetString(g_zclass_playermodel, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_zclass_modelindex, iRand))
				}
			}
		}
		
		// Need to change the model?
		if (!already_has_model)
		{
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if (g_newround)
				set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else
				fm_user_model_update(id+TASK_MODEL)
		}
		
		// Nemesis glow / remove glow, unless frozen
		if (!g_freezing_duration[id])
		{
			if (g_nemesis[id] && get_pcvar_num(cvar_nemglow))
				fm_set_rendering(id, kRenderFxGlowShell, 100, 0, 0, kRenderNormal, 1)
			else
				fm_set_rendering(id)
		}
	}
	
	// Remove any zoom (bugfix)
	cs_set_user_zoom(id, CS_RESET_ZOOM, 1)
	
	// Remove armor
	cs_set_user_armor(id, 0, CS_ARMOR_NONE)
	
	/*// Send armor message
	message_begin(MSG_ONE_UNRELIABLE, g_msgBattery, _, id)
	write_short(floatround((1.0 - Float:ArrayGetCell(g_zclass_armor, g_zombieclass[id]) * 100.0)))
	message_end()*/
	
	// Drop weapons when infected
	drop_weapons(id, 1)
	drop_weapons(id, 2)
	
	// Strip zombies from guns and give them a knife
	fm_strip_user_weapons(id)
	fm_give_item(id, "weapon_knife")
	
	// Fancy effects
	infection_effects(id)
	
	// Nemesis aura task
	if (g_nemesis[id] && get_pcvar_num(cvar_nemaura))
		set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
	
	// Remove CS nightvision if player owns one (bugfix)
	if (cs_get_user_nvg(id))
	{
		cs_set_user_nvg(id, 0)
		if (g_nvisionenabled[id]) set_user_gnvision(id, 0)
	}
	
	// Give Zombies Night Vision?
	g_nvision[id] = true
	
	if (!g_isbot[id])
	{
		// Turn on Night Vision automatically?
		g_nvisionenabled[id] = true
		set_user_gnvision(id, 1)
	}
	else
		cs_set_user_nvg(id, 1); // turn on NVG for bots
	
	// Set custom FOV?
	if (get_pcvar_num(cvar_zombiefov) != 90 && get_pcvar_num(cvar_zombiefov) != 0)
	{
		message_begin(MSG_ONE, g_msgSetFOV, _, id)
		write_byte(get_pcvar_num(cvar_zombiefov)) // fov angle
		message_end()
	}
	
	// Call the bloody task
	if (!g_nemesis[id] && get_pcvar_num(cvar_zombiebleeding))
		set_task(0.7, "make_blood", id+TASK_BLOOD, _, _, "b")
	
	// Idle sounds task
	if (!g_nemesis[id])
		set_task(random_float(50.0, 70.0), "zombie_play_idle", id+TASK_BLOOD, _, _, "b")
	
	// Turn off zombie's flashlight
	turn_off_flashlight(id)
	
	// Post user infect forward
	ExecuteForward(g_fwUserInfected_post, g_fwDummyResult, id, infector, nemesis)
	
	// Last Zombie Check
	fnCheckLastZombie()
}

// Function Human Me (player id, turn into a survivor, silent mode)
humanme(id, survivor, silentmode)
{
	// User humanize attempt forward
	ExecuteForward(g_fwUserHumanize_attempt, g_fwDummyResult, id, survivor)
	
	// One or more plugins blocked the "humanization". Only allow this after making sure it's
	// not going to leave us with no humans. Take into account a last player leaving case.
	// BUGFIX: only allow after a mode has started, to prevent blocking first survivor e.g.
	if (g_fwDummyResult >= ZP_PLUGIN_HANDLED && g_modestarted && fnGetHumans() > g_lastplayerleaving)
		return;
	
	// Pre user humanize forward
	ExecuteForward(g_fwUserHumanized_pre, g_fwDummyResult, id, survivor)
	
	// Remove previous tasks
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	remove_task(id+TASK_FREEZE)
	
	// Remove nightvision (bugfix)
	set_user_gnvision(id, 0)
	g_nvision[id] = 0
	g_nvisionenabled[id] = 0
	
	// Reset some vars
	g_zombie[id] = false
	g_nemesis[id] = false
	g_survivor[id] = false
	g_firstzombie[id] = false
	g_canbuy[id] = true
	
	// Set selected zombie class
	g_humanclass[id] = g_humanclassnext[id]
	// If no class selected yet, use the first (default) one
	if (g_humanclass[id] == HCLASS_NONE) g_humanclass[id] = 0
	
	// Remove survivor's aura (bugfix)
	set_pev(id, pev_effects, pev(id, pev_effects) &~ EF_BRIGHTLIGHT)
	
	// Remove spawn protection (bugfix)
	g_nodamage[id] = false
	set_pev(id, pev_effects, pev(id, pev_effects) &~ EF_NODRAW)
	
	// Reset burning duration counter (bugfix)
	g_burning_duration[id] = 0
	g_freezing_duration[id] = 0
	
	// Cache speed and name for player's class
	g_human_spd[id] = calculate_maxspeed(id)
	ArrayGetString(g_hclass_name, g_humanclass[id], g_human_classname[id], charsmax(g_human_classname[]))
	
	// Remove CS nightvision if player owns one (bugfix)
	if (cs_get_user_nvg(id))
	{
		cs_set_user_nvg(id, 0)
		if (g_nvisionenabled[id]) set_user_gnvision(id, 0)
	}
	
	// Drop previous weapons
	drop_weapons(id, 1)
	drop_weapons(id, 2)
	
	// Strip off from weapons
	fm_strip_user_weapons(id)
	
	// Set human attributes based on the mode
	if (survivor)
	{
		// Survivor
		g_survivor[id] = true
		
		// Set Health [0 = auto]
		if (get_pcvar_num(cvar_survhp) == 0)
		{
			if (get_pcvar_num(cvar_survbasehp) == 0)
				fm_set_user_health(id, ArrayGetCell(g_hclass_hp, g_humanclass[id]) * fnGetAlive())
			else
				fm_set_user_health(id, get_pcvar_num(cvar_survbasehp) * fnGetAlive())
		}
		else
			fm_set_user_health(id, get_pcvar_num(cvar_survhp))
		
		// Set armor to zero
		cs_set_user_armor(id, 0, CS_ARMOR_NONE)
		
		// Set gravity, if frozen set the restore gravity value instead
		if (!g_freezing_duration[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_survgravity))
		else g_frozen_gravity[id] = get_pcvar_float(cvar_survgravity)
		
		// Set survivor maxspeed
		ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
		
		// Give survivor his own weapon
		static survweapon[32]
		get_pcvar_string(cvar_survweapon, survweapon, charsmax(survweapon))
		fm_give_item(id, survweapon)
		ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[cs_weapon_name_to_id(survweapon)], AMMOTYPE[cs_weapon_name_to_id(survweapon)], MAXBPAMMO[cs_weapon_name_to_id(survweapon)])
		
		// Turn off his flashlight
		turn_off_flashlight(id)
		
		// Give the survivor a bright light
		if (get_pcvar_num(cvar_survaura)) set_pev(id, pev_effects, pev(id, pev_effects) | EF_BRIGHTLIGHT)
		
		// Survivor bots will also need nightvision to see in the dark
		if (g_isbot[id])
		{
			g_nvision[id] = true
			cs_set_user_nvg(id, 1)
		}
	}
	else
	{
		// Human taking an antidote
		give_equipment(id)
		
		// Set health
		set_pev(id, pev_health, calculate_hhealth(id))
		
		// Set armor
		cs_set_user_armor(id, floatround(calculate_harmor(id)), CS_ARMOR_VESTHELM)
		
		// Set gravity, if frozen set the restore gravity value instead
		if (!g_freezing_duration[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_hclass_grav, g_humanclass[id]))
		else g_frozen_gravity[id] = Float:ArrayGetCell(g_hclass_grav, g_humanclass[id])
		
		// Set human maxspeed
		ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
		
		// Silent mode = no antidote sound
		if (!silentmode)
		{
			// Antidote sound
			static sound[64]
			ArrayGetString(sound_antidote, random_num(0, ArraySize(sound_antidote) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_ITEM, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		}
	}
	
	// Switch to CT
	if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
	{
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
		fm_user_team_update(id)
	}
	
	// Custom models stuff
	static currentmodel[32], tempmodel[32], already_has_model, i, iRand, size
	already_has_model = false
	
	if (g_handle_models_on_separate_ent)
	{
		// Set the right model
		if (g_survivor[id])
		{
			iRand = random_num(0, ArraySize(model_survivor) - 1)
			ArrayGetString(model_survivor, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_survivor, iRand))
		}
		else
		{
			iRand = random_num(ArrayGetCell(g_hclass_modelsstart, g_humanclass[id]), ArrayGetCell(g_hclass_modelsend, g_humanclass[id]) - 1)
			ArrayGetString(g_hclass_playermodel, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_hclass_modelindex, iRand))
		}
		
		// Set model on player model entity
		fm_set_playermodel_ent(id)
		
		// Set survivor glow / remove glow on player model entity, unless frozen
		if (!g_freezing_duration[id])
		{
			if (g_survivor[id] && get_pcvar_num(cvar_survglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 100, kRenderNormal, 1)
			else
				fm_set_rendering(g_ent_playermodel[id])
		}
	}
	else
	{
		// Get current model for comparing it with the current one
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// Set the right model, after checking that we don't already have it
		if (g_survivor[id])
		{
			size = ArraySize(model_survivor)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_survivor, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_survivor, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_survivor, iRand))
			}
		}
		else
		{
			for (i = ArrayGetCell(g_hclass_modelsstart, g_humanclass[id]); i < ArrayGetCell(g_hclass_modelsend, g_humanclass[id]); i++)
			{
				ArrayGetString(g_hclass_playermodel, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(ArrayGetCell(g_hclass_modelsstart, g_humanclass[id]), ArrayGetCell(g_hclass_modelsend, g_humanclass[id]) - 1)
				ArrayGetString(g_hclass_playermodel, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_hclass_modelindex, iRand))
			}
		}
		
		// Need to change the model?
		if (!already_has_model)
		{
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if (g_newround)
				set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else
				fm_user_model_update(id+TASK_MODEL)
		}
		
		// Set survivor glow / remove glow, unless frozen
		if (!g_freezing_duration[id])
		{
			if (g_survivor[id] && get_pcvar_num(cvar_survglow))
				fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 100, kRenderNormal, 1)
			else
				fm_set_rendering(id)
		}
	}
	
	// Restore FOV?
	if (get_pcvar_num(cvar_zombiefov) != 90 && get_pcvar_num(cvar_zombiefov) != 0)
	{
		message_begin(MSG_ONE, g_msgSetFOV, _, id)
		write_byte(90) // angle
		message_end()
	}
	
	// Hide money
	message_begin(MSG_ONE, g_msgHideWeapon, _, id)
	write_byte(HIDE_MONEY) // what to hide bitsum
	message_end()
	
	// Hide the HL crosshair that's drawn
	message_begin(MSG_ONE, g_msgCrosshair, _, id)
	write_byte(0) // toggle
	message_end()
	
	// Post user humanize forward
	ExecuteForward(g_fwUserHumanized_post, g_fwDummyResult, id, survivor)
	
	// Last Zombie Check
	fnCheckLastZombie()
}

vipme(id)
{
	// Set VIP flag
	g_vip[id] = true
	
	// Drop weapons
	drop_weapons(id, 1)
	drop_weapons(id, 2)
	
	// Strip weapons and give VIP weapons
	fm_strip_user_weapons(id)
	fm_give_item(id, "weapon_knife")
	fm_give_item(id, "weapon_usp")
	ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_USP], AMMOTYPE[CSW_USP], MAXBPAMMO[CSW_USP])
	
	// Give armor
	set_pev(id, pev_armorvalue, 200.0)
	
	// Set VIP model
	static iRand
	if (g_handle_models_on_separate_ent)
	{
		iRand = random_num(0, ArraySize(model_vip) - 1)
		ArrayGetString(model_vip, iRand, g_playermodel[id], charsmax(g_playermodel[]))
		if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_vip, iRand))
		
		// Set model on player model entity
		fm_set_playermodel_ent(id)
	}
	else
	{
		static currentmodel[32], tempmodel[32], size, i, already_has_model
		// Get current model for comparing it with the current one
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// Set the right model, after checking that we don't already have it
		size = ArraySize(model_vip)
		for (i = 0; i < size; i++)
		{
			ArrayGetString(model_vip, i, tempmodel, charsmax(tempmodel))
			if (equal(currentmodel, tempmodel)) already_has_model = true
		}
		
		// Need to change the model?
		if (!already_has_model)
		{
			iRand = random_num(0, size - 1)
			ArrayGetString(model_vip, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_vip, iRand))
			
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if (g_newround)
				set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else
				fm_user_model_update(id+TASK_MODEL)
		}
	}
	
	// Switch to CT
	if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
	{
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
		fm_user_team_update(id)
	}
	
	// VIP flag on scoreboard
	message_begin(MSG_BROADCAST, g_msgScoreAttrib)
	write_byte(id) // id
	write_byte(SCOREATTRIB_FLAG_VIP) // attrib
	message_end()
	
	zp_colored_print(0, "%s turned into vip!", g_playername[id])
}

give_equipment(id)
{
	// Strip user weapons
	strip_user_weapons(id)
	
	// Give knife
	give_item(id, "weapon_knife")
	
	// Give primary weapon and ammo
	switch (g_db_primary[id])
	{
		case PRIMARY_AK47:
		{
			give_item(id, "weapon_ak47")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_AK47], AMMOTYPE[CSW_AK47], MAXBPAMMO[CSW_AK47])
		}
		case PRIMARY_M4A1:
		{
			give_item(id, "weapon_m4a1")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_M4A1], AMMOTYPE[CSW_M4A1], MAXBPAMMO[CSW_M4A1])
		}
		case PRIMARY_SPAS12:
		{
			give_item(id, "weapon_m3")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_M3], AMMOTYPE[CSW_M3], MAXBPAMMO[CSW_M3])
		}
		case PRIMARY_TRG42:
		{
			give_item(id, "weapon_awp")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_AWP], AMMOTYPE[CSW_AWP], MAXBPAMMO[CSW_AWP])
		}
		case PRIMARY_DEATHMACHINE:
		{
			give_item(id, "weapon_m249")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_M249], AMMOTYPE[CSW_M249], MAXBPAMMO[CSW_M249])
		}
	}
	
	// Give secondary weapon and ammo
	switch (g_db_secondary[id])
	{
		case SECONDARY_ELDIABLO:
		{
			give_item(id, "weapon_deagle")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_DEAGLE], AMMOTYPE[CSW_DEAGLE], MAXBPAMMO[CSW_DEAGLE])
		}
		case SECONDARY_G18:
		{
			give_item(id, "weapon_glock18")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_GLOCK18], AMMOTYPE[CSW_GLOCK18], MAXBPAMMO[CSW_GLOCK18])
		}
		case SECONDARY_DUALINFINITY:
		{
			give_item(id, "weapon_elite")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_ELITE], AMMOTYPE[CSW_ELITE], MAXBPAMMO[CSW_ELITE])
		}
	}
	
	// Give offensive grenade
	switch (g_db_offensivegrenade[id])
	{
		case OFFENSIVENADE_NAPALM:
		{
			give_item(id, "weapon_hegrenade")
			g_grenade_slot1[id] = NADE_TYPE_NAPALM
		}
		case OFFENSIVENADE_HE:
		{
			give_item(id, "weapon_hegrenade")
			g_grenade_slot1[id] = NADE_TYPE_HE
		}
		case OFFENSIVENADE_MOLOTOV:
		{
			give_item(id, "weapon_hegrenade")
			g_grenade_slot1[id] = NADE_TYPE_MOLOTOV
		}
		case OFFENSIVENADE_CUTTER:
		{
			give_item(id, "weapon_hegrenade")
			g_grenade_slot1[id] = NADE_TYPE_CUTTER
		}
	}
	
	// Give Defensive Grenade
	switch (g_db_defensivegrenade[id])
	{
		case DEFENSIVENADE_FROST:
		{
			give_item(id, "weapon_flashbang")
			g_grenade_slot2[id] = NADE_TYPE_FROST
		}
		case DEFENSIVENADE_FORCEFIELD:
		{
			give_item(id, "weapon_flashbang")
			g_grenade_slot2[id] = NADE_TYPE_FORCEFIELD
		}
	}
	
	// Give Utility Grenade
	switch (g_db_tacticalgrenade[id])
	{
		case UTILITYNADE_FLARE:
		{
			give_item(id, "weapon_smokegrenade")
			g_grenade_slot3[id] = NADE_TYPE_FLARE
		}
	}
	
	// Give Special Equipment
	switch (g_db_special[id])
	{
		case 0:
		{
			cs_set_user_defuse(id, true)
		}
		default:
		{
			ExecuteForward(g_fwGiveSpecial, g_fwDummyResult, id, g_db_special[id])
		}
	}
}

/*================================================================================
 [Other Functions and Tasks]
=================================================================================*/

public cache_cvars()
{
	g_cached_zombiesilent = get_pcvar_num(cvar_zombiesilent)
	g_cached_customflash = get_pcvar_num(cvar_customflash)
	g_cached_leapzombies = get_pcvar_num(cvar_leapzombies)
	g_cached_leapzombiescooldown = get_pcvar_float(cvar_leapzombiescooldown)
	g_cached_leapnemesis = get_pcvar_num(cvar_leapnemesis)
	g_cached_leapnemesiscooldown = get_pcvar_float(cvar_leapnemesiscooldown)
	g_cached_leapsurvivor = get_pcvar_num(cvar_leapsurvivor)
	g_cached_leapsurvivorcooldown = get_pcvar_float(cvar_leapsurvivorcooldown)
	
	// Cache lighting
	get_pcvar_string(cvar_lighting, g_cached_lighting, charsmax(g_cached_lighting))
	get_pcvar_string(cvar_lightingzombies, g_cached_lightingzombies, charsmax(g_cached_lightingzombies))
	strtolower(g_cached_lighting)
	strtolower(g_cached_lightingzombies)
}

load_customization_from_files()
{
	// Build customization file path
	new path[64]
	get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, ZP_CUSTOMIZATION_FILE)
	
	// File not present
	if (!file_exists(path))
	{
		new error[100]
		formatex(error, charsmax(error), "Cannot load customization file %s!", path)
		set_fail_state(error)
		return;
	}
	
	// Set up some vars to hold parsing info
	new linedata[1024], key[64], value[960], section, teams
	
	// Open customization file for reading
	new file = fopen(path, "rt")
	
	while (file && !feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		
		// Blank line or comment
		if (!linedata[0] || linedata[0] == ';') continue;
		
		// New section starting
		if (linedata[0] == '[')
		{
			section++
			continue;
		}
		
		// Get key and value(s)
		strtok(linedata, key, charsmax(key), value, charsmax(value), '=')
		
		// Trim spaces
		trim(key)
		trim(value)
		
		switch (section)
		{
			case SECTION_ACCESS_FLAGS:
			{
				if (equal(key, "ENABLE/DISABLE MOD"))
					g_access_flag[ACCESS_ENABLE_MOD] = read_flags(value)
				else if (equal(key, "ADMIN MENU"))
					g_access_flag[ACCESS_ADMIN_MENU] = read_flags(value)
				else if (equal(key, "START MODE INFECTION"))
					g_access_flag[ACCESS_MODE_INFECTION] = read_flags(value)
				else if (equal(key, "START MODE NEMESIS"))
					g_access_flag[ACCESS_MODE_NEMESIS] = read_flags(value)
				else if (equal(key, "START MODE SURVIVOR"))
					g_access_flag[ACCESS_MODE_SURVIVOR] = read_flags(value)
				else if (equal(key, "START MODE SWARM"))
					g_access_flag[ACCESS_MODE_SWARM] = read_flags(value)
				else if (equal(key, "START MODE MULTI"))
					g_access_flag[ACCESS_MODE_MULTI] = read_flags(value)
				else if (equal(key, "START MODE PLAGUE"))
					g_access_flag[ACCESS_MODE_PLAGUE] = read_flags(value)
				else if (equal(key, "START MODE ARMAGEDDON"))
					g_access_flag[ACCESS_MODE_ARMAGEDDON] = read_flags(value)
				else if (equal(key, "START MODE VIP"))
					g_access_flag[ACCESS_MODE_VIP] = read_flags(value)
				else if (equal(key, "MAKE ZOMBIE"))
					g_access_flag[ACCESS_MAKE_ZOMBIE] = read_flags(value)
				else if (equal(key, "MAKE HUMAN"))
					g_access_flag[ACCESS_MAKE_HUMAN] = read_flags(value)
				else if (equal(key, "MAKE NEMESIS"))
					g_access_flag[ACCESS_MAKE_NEMESIS] = read_flags(value)
				else if (equal(key, "MAKE SURVIVOR"))
					g_access_flag[ACCESS_MAKE_SURVIVOR] = read_flags(value)
				else if (equal(key, "RESPAWN PLAYERS"))
					g_access_flag[ACCESS_RESPAWN_PLAYERS] = read_flags(value)
				else if (equal(key, "ADMIN MODELS"))
					g_access_flag[ACCESS_ADMIN_MODELS] = read_flags(value)
			}
			case SECTION_PLAYER_MODELS:
			{
				if (equal(key, "NEMESIS"))
				{
					// Parse models
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to models array
						ArrayPushString(model_nemesis, key)
					}
				}
				else if (equal(key, "SURVIVOR"))
				{
					// Parse models
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to models array
						ArrayPushString(model_survivor, key)
					}
				}
				else if (equal(key, "VIP"))
				{
					// Parse models
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to models array
						ArrayPushString(model_vip, key)
					}
				}
				else if (equal(key, "ADMIN ZOMBIE"))
				{
					// Parse models
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to models array
						ArrayPushString(model_admin_zombie, key)
					}
				}
				else if (equal(key, "FORCE CONSISTENCY"))
					g_force_consistency = str_to_num(value)
			}
			case SECTION_WEAPON_MODELS:
			{
				if (equal(key, "V_KNIFE HUMAN"))
					copy(model_vknife_human, charsmax(model_vknife_human), value)
				else if (equal(key, "V_KNIFE NEMESIS"))
					copy(model_vknife_nemesis, charsmax(model_vknife_nemesis), value)
				else if (equal(key, "GRENADE INFECT"))
					copy(model_grenade_infect, charsmax(model_grenade_infect), value)
				else if (equal(key, "GRENADE FIRE"))
					copy(model_grenade_fire, charsmax(model_grenade_fire), value)
				else if (equal(key, "GRENADE FROST"))
					copy(model_grenade_frost, charsmax(model_grenade_frost), value)
				else if (equal(key, "GRENADE FLARE"))
					copy(model_grenade_flare, charsmax(model_grenade_flare), value)
				else if (equal(key, "V_KNIFE ADMIN HUMAN"))
					copy(model_vknife_admin_human, charsmax(model_vknife_admin_human), value)
				else if (equal(key, "V_KNIFE ADMIN ZOMBIE"))
					copy(model_vknife_admin_zombie, charsmax(model_vknife_admin_zombie), value)
			}
			case SECTION_GRENADE_SPRITES:
			{
				if (equal(key, "TRAIL"))
					copy(sprite_grenade_trail, charsmax(sprite_grenade_trail), value)
				else if (equal(key, "RING"))
					copy(sprite_grenade_ring, charsmax(sprite_grenade_ring), value)
				else if (equal(key, "FIRE"))
					copy(sprite_grenade_fire, charsmax(sprite_grenade_fire), value)
				else if (equal(key, "SMOKE"))
					copy(sprite_grenade_smoke, charsmax(sprite_grenade_smoke), value)
				else if (equal(key, "GLASS"))
					copy(sprite_grenade_glass, charsmax(sprite_grenade_glass), value)
			}
			case SECTION_SOUNDS:
			{
				if (equal(key, "WIN ZOMBIES"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_win_zombies, key)
						ArrayPushCell(sound_win_zombies_ismp3, equal(key[strlen(key)-4], ".mp3") ? 1 : 0)
					}
				}
				else if (equal(key, "WIN HUMANS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_win_humans, key)
						ArrayPushCell(sound_win_humans_ismp3, equal(key[strlen(key)-4], ".mp3") ? 1 : 0)
					}
				}
				else if (equal(key, "WIN NO ONE"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_win_no_one, key)
						ArrayPushCell(sound_win_no_one_ismp3, equal(key[strlen(key)-4], ".mp3") ? 1 : 0)
					}
				}
				else if (equal(key, "ZOMBIE INFECT"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_infect, key)
					}
				}
				else if (equal(key, "ZOMBIE PAIN"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_pain, key)
					}
				}
				else if (equal(key, "NEMESIS PAIN"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(nemesis_pain, key)
					}
				}
				else if (equal(key, "ZOMBIE DIE"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_die, key)
					}
				}
				else if (equal(key, "ZOMBIE FALL"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_fall, key)
					}
				}
				else if (equal(key, "ZOMBIE MISS SLASH"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_miss_slash, key)
					}
				}
				else if (equal(key, "ZOMBIE MISS WALL"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_miss_wall, key)
					}
				}
				else if (equal(key, "ZOMBIE HIT NORMAL"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_hit_normal, key)
					}
				}
				else if (equal(key, "ZOMBIE HIT STAB"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_hit_stab, key)
					}
				}
				else if (equal(key, "ZOMBIE IDLE"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_idle, key)
					}
				}
				else if (equal(key, "ZOMBIE IDLE LAST"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_idle_last, key)
					}
				}
				else if (equal(key, "ZOMBIE MADNESS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(zombie_madness, key)
					}
				}
				else if (equal(key, "ROUND NONE"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_none, key)
					}
				}
				else if (equal(key, "ROUND NEMESIS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_nemesis, key)
					}
				}
				else if (equal(key, "ROUND SURVIVOR"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_survivor, key)
					}
				}
				else if (equal(key, "ROUND SWARM"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_swarm, key)
					}
				}
				else if (equal(key, "ROUND MULTI"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_multi, key)
					}
				}
				else if (equal(key, "ROUND PLAGUE"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_plague, key)
					}
				}
				else if (equal(key, "ROUND VIP"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_vip, key)
					}
				}
				else if (equal(key, "ROUND ARMAGEDDON"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_armageddon, key)
					}
				}
				else if (equal(key, "GRENADE INFECT EXPLODE"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(grenade_infect, key)
					}
				}
				else if (equal(key, "GRENADE INFECT PLAYER"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(grenade_infect_player, key)
					}
				}
				else if (equal(key, "GRENADE FIRE EXPLODE"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(grenade_fire, key)
					}
				}
				else if (equal(key, "GRENADE FIRE PLAYER"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(grenade_fire_player, key)
					}
				}
				else if (equal(key, "GRENADE FROST EXPLODE"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(grenade_frost, key)
					}
				}
				else if (equal(key, "GRENADE FROST PLAYER"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(grenade_frost_player, key)
					}
				}
				else if (equal(key, "GRENADE FROST BREAK"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(grenade_frost_break, key)
					}
				}
				else if (equal(key, "GRENADE FLARE"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(grenade_flare, key)
					}
				}
				else if (equal(key, "ANTIDOTE"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_antidote, key)
					}
				}
				else if (equal(key, "LOADING"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_loading, key)
					}
				}
				else if (equal(key, "LEVEL UP"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_levelup, key)
					}
				}
			}
			case SECTION_AMBIENCE_SOUNDS:
			{
				if (equal(key, "INFECTION ENABLE"))
					g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION] = str_to_num(value)
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION] && equal(key, "INFECTION SOUNDS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_ambience1, key)
						ArrayPushCell(sound_ambience1_ismp3, equal(key[strlen(key)-4], ".mp3") ? 1 : 0)
					}
				}
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION] && equal(key, "INFECTION DURATIONS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushCell(sound_ambience1_duration, str_to_num(key))
					}
				}
				else if (equal(key, "NEMESIS ENABLE"))
					g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS] = str_to_num(value)
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS] && equal(key, "NEMESIS SOUNDS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_ambience2, key)
						ArrayPushCell(sound_ambience2_ismp3, equal(key[strlen(key)-4], ".mp3") ? 1 : 0)
					}
				}
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS] && equal(key, "NEMESIS DURATIONS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushCell(sound_ambience2_duration, str_to_num(key))
					}
				}
				else if (equal(key, "SURVIVOR ENABLE"))
					g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR] = str_to_num(value)
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR] && equal(key, "SURVIVOR SOUNDS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_ambience3, key)
						ArrayPushCell(sound_ambience3_ismp3, equal(key[strlen(key)-4], ".mp3") ? 1 : 0)
					}
				}
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR] && equal(key, "SURVIVOR DURATIONS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushCell(sound_ambience3_duration, str_to_num(key))
					}
				}
				else if (equal(key, "SWARM ENABLE"))
					g_ambience_sounds[AMBIENCE_SOUNDS_SWARM] = str_to_num(value)
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_SWARM] && equal(key, "SWARM SOUNDS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_ambience4, key)
						ArrayPushCell(sound_ambience4_ismp3, equal(key[strlen(key)-4], ".mp3") ? 1 : 0)
					}
				}
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_SWARM] && equal(key, "SWARM DURATIONS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushCell(sound_ambience4_duration, str_to_num(key))
					}
				}
				else if (equal(key, "PLAGUE ENABLE"))
					g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE] = str_to_num(value)
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE] && equal(key, "PLAGUE SOUNDS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_ambience5, key)
						ArrayPushCell(sound_ambience5_ismp3, equal(key[strlen(key)-4], ".mp3") ? 1 : 0)
					}
				}
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE] && equal(key, "PLAGUE DURATIONS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushCell(sound_ambience5_duration, str_to_num(key))
					}
				}
				else if (equal(key, "VIP ENABLE"))
					g_ambience_sounds[AMBIENCE_SOUNDS_VIP] = str_to_num(value)
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_VIP] && equal(key, "VIP SOUNDS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_ambience6, key)
						ArrayPushCell(sound_ambience6_ismp3, equal(key[strlen(key)-4], ".mp3") ? 1 : 0)
					}
				}
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_VIP] && equal(key, "VIP DURATIONS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushCell(sound_ambience6_duration, str_to_num(key))
					}
				}
				else if (equal(key, "ARMAGEDDON ENABLE"))
					g_ambience_sounds[AMBIENCE_SOUNDS_ARMAGEDDON] = str_to_num(value)
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_ARMAGEDDON] && equal(key, "ARMAGEDDON SOUNDS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushString(sound_ambience7, key)
						ArrayPushCell(sound_ambience7_ismp3, equal(key[strlen(key)-4], ".mp3") ? 1 : 0)
					}
				}
				else if (g_ambience_sounds[AMBIENCE_SOUNDS_ARMAGEDDON] && equal(key, "ARMAGEDDON DURATIONS"))
				{
					// Parse sounds
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to sounds array
						ArrayPushCell(sound_ambience7_duration, str_to_num(key))
					}
				}
			}
			case SECTION_HARD_CODED_ITEMS_COSTS:
			{
				if (equal(key, "NIGHT VISION"))
					g_extra_costs2[EXTRA_NVISION] = str_to_num(value)
				else if (equal(key, "ANTIDOTE"))
					g_extra_costs2[EXTRA_ANTIDOTE] = str_to_num(value)
				else if (equal(key, "ZOMBIE MADNESS"))
					g_extra_costs2[EXTRA_MADNESS] = str_to_num(value)
				else if (equal(key, "INFECTION BOMB"))
					g_extra_costs2[EXTRA_INFBOMB] = str_to_num(value)
				else if (equal(key, "NAPALM GRENADE"))
					g_extra_costs2[EXTRA_NAPALMGRENADE] = str_to_num(value)
				else if (equal(key, "FROST GRENADE"))
					g_extra_costs2[EXTRA_FROSTGRENADE] = str_to_num(value)
				else if (equal(key, "FLARE"))
					g_extra_costs2[EXTRA_FLARE] = str_to_num(value)
				else if (equal(key, "HE GRENADE"))
					g_extra_costs2[EXTRA_HEGRENADE] = str_to_num(value)
				else if (equal(key, "MOLOTOV"))
					g_extra_costs2[EXTRA_MOLOTOV] = str_to_num(value)
				else if (equal(key, "LASER CUTTER"))
					g_extra_costs2[EXTRA_CUTTER] = str_to_num(value)
				else if (equal(key, "FORCE FIELD GRENADE"))
					g_extra_costs2[EXTRA_FORCEFIELD] = str_to_num(value)
				else if (equal(key, "KNOCKBACK BOMB"))
					g_extra_costs2[EXTRA_KBBOMB] = str_to_num(value)
			}
			case SECTION_WEATHER_EFFECTS:
			{
				if (equal(key, "RAIN"))
					g_ambience_rain = str_to_num(value)
				else if (equal(key, "SNOW"))
					g_ambience_snow = str_to_num(value)
				else if (equal(key, "FOG"))
					g_ambience_fog = str_to_num(value)
				else if (equal(key, "FOG DENSITY"))
					copy(g_fog_density, charsmax(g_fog_density), value)
				else if (equal(key, "FOG COLOR"))
					copy(g_fog_color, charsmax(g_fog_color), value)
			}
			case SECTION_SKY:
			{
				if (equal(key, "ENABLE"))
					g_sky_enable = str_to_num(value)
				else if (equal(key, "SKY NAMES"))
				{
					// Parse sky names
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to skies array
						ArrayPushString(g_sky_names, key)
						
						// Preache custom sky files
						formatex(linedata, charsmax(linedata), "gfx/env/%sbk.tga", key)
						engfunc(EngFunc_PrecacheGeneric, linedata)
						formatex(linedata, charsmax(linedata), "gfx/env/%sdn.tga", key)
						engfunc(EngFunc_PrecacheGeneric, linedata)
						formatex(linedata, charsmax(linedata), "gfx/env/%sft.tga", key)
						engfunc(EngFunc_PrecacheGeneric, linedata)
						formatex(linedata, charsmax(linedata), "gfx/env/%slf.tga", key)
						engfunc(EngFunc_PrecacheGeneric, linedata)
						formatex(linedata, charsmax(linedata), "gfx/env/%srt.tga", key)
						engfunc(EngFunc_PrecacheGeneric, linedata)
						formatex(linedata, charsmax(linedata), "gfx/env/%sup.tga", key)
						engfunc(EngFunc_PrecacheGeneric, linedata)
					}
				}
			}
			case SECTION_ZOMBIE_DECALS:
			{
				if (equal(key, "DECALS"))
				{
					// Parse decals
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to zombie decals array
						ArrayPushCell(zombie_decals, str_to_num(key))
					}
				}
			}
			case SECTION_KNOCKBACK:
			{
				// Format weapon entity name
				strtolower(key)
				format(key, charsmax(key), "weapon_%s", key)
				
				// Add value to knockback power array
				kb_weapon_power[cs_weapon_name_to_id(key)] = str_to_float(value)
			}
			case SECTION_OBJECTIVE_ENTS:
			{
				if (equal(key, "CLASSNAMES"))
				{
					// Parse classnames
					while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
					{
						// Trim spaces
						trim(key)
						trim(value)
						
						// Add to objective ents array
						ArrayPushString(g_objective_ents, key)
					}
				}
			}
			case SECTION_SVC_BAD:
			{
				if (equal(key, "MODELCHANGE DELAY"))
					g_modelchange_delay = str_to_float(value)
				else if (equal(key, "HANDLE MODELS ON SEPARATE ENT"))
					g_handle_models_on_separate_ent = str_to_num(value)
				else if (equal(key, "SET MODELINDEX OFFSET"))
					g_set_modelindex_offset = str_to_num(value)
			}
		}
	}
	if (file) fclose(file)
	
	// Build extra items file path
	get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, ZP_EXTRAITEMS_FILE)
	
	// Parse if present
	if (file_exists(path))
	{
		// Open extra items file for reading
		file = fopen(path, "rt")
		
		while (file && !feof(file))
		{
			// Read one line at a time
			fgets(file, linedata, charsmax(linedata))
			
			// Replace newlines with a null character to prevent headaches
			replace(linedata, charsmax(linedata), "^n", "")
			
			// Blank line or comment
			if (!linedata[0] || linedata[0] == ';') continue;
			
			// New item starting
			if (linedata[0] == '[')
			{
				// Remove first and last characters (braces)
				linedata[strlen(linedata) - 1] = 0
				copy(linedata, charsmax(linedata), linedata[1])
				
				// Store its real name for future reference
				ArrayPushString(g_extraitem2_realname, linedata)
				continue;
			}
			
			// Get key and value(s)
			strtok(linedata, key, charsmax(key), value, charsmax(value), '=')
			
			// Trim spaces
			trim(key)
			trim(value)
			
			if (equal(key, "NAME"))
				ArrayPushString(g_extraitem2_name, value)
			else if (equal(key, "COST"))
				ArrayPushCell(g_extraitem2_cost, str_to_num(value))
			else if (equal(key, "TEAMS"))
			{
				// Clear teams bitsum
				teams = 0
				
				// Parse teams
				while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
				{
					// Trim spaces
					trim(key)
					trim(value)
					
					if (equal(key, ZP_TEAM_NAMES[ZP_TEAM_ZOMBIE]))
						teams |= ZP_TEAM_ZOMBIE
					else if (equal(key, ZP_TEAM_NAMES[ZP_TEAM_HUMAN]))
						teams |= ZP_TEAM_HUMAN
					else if (equal(key, ZP_TEAM_NAMES[ZP_TEAM_NEMESIS]))
						teams |= ZP_TEAM_NEMESIS
					else if (equal(key, ZP_TEAM_NAMES[ZP_TEAM_SURVIVOR]))
						teams |= ZP_TEAM_SURVIVOR
				}
				
				// Add to teams array
				ArrayPushCell(g_extraitem2_team, teams)
			}
		}
		if (file) fclose(file)
	}
}

save_customization()
{
	new i, buffer[512]
	
	// Build extra items file path
	new path[64]
	get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, ZP_EXTRAITEMS_FILE)
	
	// Open extra items file for appending data
	new file = fopen(path, "at"), size = ArraySize(g_extraitem_name)
	
	// Add any new extra items data at the end if needed
	for (i = EXTRAS_CUSTOM_STARTID; i < size; i++)
	{
		if (ArrayGetCell(g_extraitem_new, i))
		{
			// Add real name
			ArrayGetString(g_extraitem_name, i, buffer, charsmax(buffer))
			format(buffer, charsmax(buffer), "^n[%s]", buffer)
			fputs(file, buffer)
			
			// Add caption
			ArrayGetString(g_extraitem_name, i, buffer, charsmax(buffer))
			format(buffer, charsmax(buffer), "^nNAME = %s", buffer)
			fputs(file, buffer)
			
			// Add cost
			formatex(buffer, charsmax(buffer), "^nCOST = %d", ArrayGetCell(g_extraitem_cost, i))
			fputs(file, buffer)
			
			// Add team
			formatex(buffer, charsmax(buffer), "^nTEAMS = %s^n", ZP_TEAM_NAMES[ArrayGetCell(g_extraitem_team, i)])
			fputs(file, buffer)
		}
	}
	fclose(file)
	
	// Free arrays containing class/item overrides
	ArrayDestroy(g_extraitem2_realname)
	ArrayDestroy(g_extraitem2_name)
	ArrayDestroy(g_extraitem2_cost)
	ArrayDestroy(g_extraitem2_team)
	ArrayDestroy(g_extraitem_new)
}

// Register Ham Forwards for CZ bots
public register_ham_czbots(id)
{
	// Make sure it's a CZ bot and it's still connected
	if (g_hamczbots || !g_isconnected[id] || !get_pcvar_num(cvar_botquota))
		return;
	
	RegisterHamFromEntity(Ham_Spawn, id, "fw_PlayerSpawn_Post", 1)
	RegisterHamFromEntity(Ham_Killed, id, "fw_PlayerKilled")
	RegisterHamFromEntity(Ham_Killed, id, "fw_PlayerKilled_Post", 1)
	RegisterHamFromEntity(Ham_TakeDamage, id, "fw_TakeDamage")
	RegisterHamFromEntity(Ham_TakeDamage, id, "fw_TakeDamage_Post", 1)
	RegisterHamFromEntity(Ham_TraceAttack, id, "fw_TraceAttack")
	RegisterHamFromEntity(Ham_Player_ResetMaxSpeed, id, "fw_ResetMaxSpeed_Post", 1)
	
	// Ham forwards for CZ bots successfully registered
	g_hamczbots = true
	
	// If the bot has already spawned, call the forward manually for him
	if (is_user_alive(id)) fw_PlayerSpawn_Post(id)
}

// Disable minmodels task
public disable_minmodels(id)
{
	if (!g_isconnected[id]) return;
	client_cmd(id, "cl_minmodels 0")
}

// Bots automatically buy extra items
public bot_buy_extras(taskid)
{
	// Nemesis or Survivor bots have nothing to buy by default
	if (!g_isalive[ID_SPAWN] || g_survivor[ID_SPAWN] || g_nemesis[ID_SPAWN])
		return;
	
	if (!g_zombie[ID_SPAWN]) // human bots
	{
		// Attempt to buy Night Vision
		buy_extra_item(ID_SPAWN, EXTRA_NVISION)
	}
	else // zombie bots
	{
		// Attempt to buy an Antidote
		buy_extra_item(ID_SPAWN, EXTRA_ANTIDOTE)
	}
}

// Refill BP Ammo Task
public refill_bpammo(const args[], id)
{
	// Player died or turned into a zombie
	if (!g_isalive[id] || g_zombie[id])
		return;
	
	set_msg_block(g_msgAmmoPickup, BLOCK_ONCE)
	ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[REFILL_WEAPONID], AMMOTYPE[REFILL_WEAPONID], MAXBPAMMO[REFILL_WEAPONID])
}

// Balance Teams Task
balance_teams()
{
	// Get amount of users playing
	static iPlayersnum
	iPlayersnum = fnGetPlaying()
	
	// No players, don't bother
	if (iPlayersnum < 1) return;
	
	// Split players evenly
	static iTerrors, iMaxTerrors, id, team[33]
	iMaxTerrors = iPlayersnum/2
	iTerrors = 0
	
	// First, set everyone to CT
	for (id = 1; id <= g_maxplayers; id++)
	{
		// Skip if not connected
		if (!g_isconnected[id])
			continue;
		
		team[id] = fm_cs_get_user_team(id)
		
		// Skip if not playing
		if (team[id] == FM_CS_TEAM_SPECTATOR || team[id] == FM_CS_TEAM_UNASSIGNED)
			continue;
		
		// Set team
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
		team[id] = FM_CS_TEAM_CT
	}
	
	// Then randomly set half of the players to Terrorists
	while (iTerrors < iMaxTerrors)
	{
		// Keep looping through all players
		if (++id > g_maxplayers) id = 1
		
		// Skip if not connected
		if (!g_isconnected[id])
			continue;
		
		// Skip if not playing or already a Terrorist
		if (team[id] != FM_CS_TEAM_CT)
			continue;
		
		// Random chance
		if (random_num(0, 1))
		{
			fm_cs_set_user_team(id, FM_CS_TEAM_T)
			team[id] = FM_CS_TEAM_T
			iTerrors++
		}
	}
}

// Welcome Message Task
public welcome_msg()
{
	// Welcome message
	switch (random(5))
	{
		case 0: zp_colored_print(0, "^x01**** ^x04Welcome - Zombie Plague^x01 ****")
		case 1: zp_colored_print(0, "^x01**** ^x04Welcome - Zombie Carnage^x01 ****")
		case 2: zp_colored_print(0, "^x01**** ^x04Welcome - Intense Survival Experience^x01 ****")
		case 3: zp_colored_print(0, "^x01**** ^x04Welcome - Zombie Apocalypse^x01 ****")
		case 4: zp_colored_print(0, "^x01**** ^x04Welcome - Ultimate Survival Experience^x01 ****")
	}
	
	// Ammo notification
	if (!get_pcvar_num(cvar_infammo)) zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "NOTICE_INFO2")
	
	// Show T-virus HUD notice
	set_dhudmessage(0, 125, 200, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0)
	show_dhudmessage(0, "%L", LANG_PLAYER, "NOTICE_VIRUS_FREE")
}

// Respawn Player Task (deathmatch)
public respawn_player_task(taskid)
{
	// Already alive or round ended
	if (g_isalive[ID_SPAWN] || g_endround)
		return;
	
	// Get player's team
	static team
	team = fm_cs_get_user_team(ID_SPAWN)
	
	// Player moved to spectators
	if (team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED)
		return;
	
	// Respawn player automatically if allowed on current round
	if ((!g_survround || get_pcvar_num(cvar_allowrespawnsurv)) && (!g_swarmround || get_pcvar_num(cvar_allowrespawnswarm)) && (!g_nemround || get_pcvar_num(cvar_allowrespawnnem)) && (!g_plagueround || get_pcvar_num(cvar_allowrespawnplague)))
	{
		// Infection rounds = none of the above
		if (!get_pcvar_num(cvar_allowrespawninfection) && !g_survround && !g_nemround && !g_swarmround && !g_plagueround)
			return;
		
		// Respawn if only the last human is left? (ignore this setting on survivor rounds)
		if (!g_survround && !get_pcvar_num(cvar_respawnafterlast) && fnGetHumans() <= 1)
			return;
		
		// Respawn as zombie?
		if (get_pcvar_num(cvar_deathmatch) == 2 || (get_pcvar_num(cvar_deathmatch) == 3 && random_num(0, 1)) || (get_pcvar_num(cvar_deathmatch) == 4 && fnGetZombies() < fnGetAlive()/2))
			g_respawn_as_zombie[ID_SPAWN] = true
		
		// Override respawn as zombie setting on nemesis and survivor rounds
		if (g_survround) g_respawn_as_zombie[ID_SPAWN] = true
		else if (g_nemround) g_respawn_as_zombie[ID_SPAWN] = false
		
		respawn_player_manually(ID_SPAWN)
	}
}

// Respawn Player Check Task (if killed by worldspawn)
public respawn_player_check_task(taskid)
{
	// Successfully spawned or round ended
	if (g_isalive[ID_SPAWN] || g_endround)
		return;
	
	// Get player's team
	static team
	team = fm_cs_get_user_team(ID_SPAWN)
	
	// Player moved to spectators
	if (team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED)
		return;
	
	// If player was being spawned as a zombie, set the flag again
	if (g_zombie[ID_SPAWN]) g_respawn_as_zombie[ID_SPAWN] = true
	else g_respawn_as_zombie[ID_SPAWN] = false
	
	respawn_player_manually(ID_SPAWN)
}

// Respawn Player Manually (called after respawn checks are done)
respawn_player_manually(id)
{
	// Set proper team before respawning, so that the TeamInfo message that's sent doesn't confuse PODBots
	if (g_respawn_as_zombie[id])
		fm_cs_set_user_team(id, FM_CS_TEAM_T)
	else
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
	
	// Respawning a player has never been so easy
	ExecuteHamB(Ham_CS_RoundRespawn, id)
}

/*
public respawn_player_join(id)
{
	id -= TASK_JOINSPAWN
	
	if (!g_respawn_as_zombie[id])
		return;
	
	// Set proper team before respawning, so that the TeamInfo message that's sent doesn't confuse PODBots
	fm_cs_set_user_team(id, FM_CS_TEAM_T)
	
	// Respawning a player has never been so easy
	ExecuteHamB(Ham_CS_RoundRespawn, id)
}
*/
// Check Round Task -check that we still have both zombies and humans on a round-
check_round(leaving_player)
{
	// Round ended or make_a_zombie task still active
	if (g_endround || task_exists(TASK_MAKEZOMBIE))
		return;
	
	// Get alive players count
	static iPlayersnum, id
	iPlayersnum = fnGetAlive()
	
	// Last alive player, don't bother
	if (iPlayersnum < 2)
		return;
	
	// Last zombie disconnecting
	if (g_zombie[leaving_player] && fnGetZombies() == 1)
	{
		// Only one CT left, don't bother
		if (fnGetHumans() == 1 && fnGetCTs() == 1)
			return;
		
		// Pick a random one to take his place
		while ((id = fnGetRandomAlive(random_num(1, iPlayersnum))) == leaving_player ) { /* keep looping */ }
		
		// Show last zombie left notice
		zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "LAST_ZOMBIE_LEFT", g_playername[id])
		
		// Set player leaving flag
		g_lastplayerleaving = true
		
		// Turn into a Nemesis or just a zombie?
		if (g_nemesis[leaving_player])
			zombieme(id, 0, 1, 0, 0)
		else
			zombieme(id, 0, 0, 0, 0)
		
		// Remove player leaving flag
		g_lastplayerleaving = false
		
		// If Nemesis, set chosen player's health to that of the one who's leaving
		if (get_pcvar_num(cvar_keephealthondisconnect) && g_nemesis[leaving_player])
			fm_set_user_health(id, pev(leaving_player, pev_health))
	}
	
	// Last human disconnecting
	else if (!g_zombie[leaving_player] && fnGetHumans() == 1)
	{
		// Only one T left, don't bother
		if (fnGetZombies() == 1 && fnGetTs() == 1)
			return;
		
		// Pick a random one to take his place
		while ((id = fnGetRandomAlive(random_num(1, iPlayersnum))) == leaving_player ) { /* keep looping */ }
		
		// Show last human left notice
		zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "LAST_HUMAN_LEFT", g_playername[id])
		
		// Set player leaving flag
		g_lastplayerleaving = true
		
		// Turn into a Survivor or just a human?
		if (g_survivor[leaving_player])
			humanme(id, 1, 0)
		else
			humanme(id, 0, 0)
		
		// Remove player leaving flag
		g_lastplayerleaving = false
		
		// If Survivor, set chosen player's health to that of the one who's leaving
		if (get_pcvar_num(cvar_keephealthondisconnect) && g_survivor[leaving_player])
			fm_set_user_health(id, pev(leaving_player, pev_health))
	}
	
	// Last VIP disconnecting
	else if (g_vipround && g_vip[leaving_player] && fnGetAliveVIPs() == 1)
	{
		// Only one human left, don't bother
		if (fnGetCTs() == 1 || fnGetAliveCTs() == 1)
			return;
		
		// Pick a random one to take his place
		while ((id = fnGetRandomAliveCT(random_num(1, fnGetAliveCTs()))) == leaving_player ) { /* keep looping */ }
		
		// Show last human left notice
		zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "LAST_VIP_LEFT", g_playername[id])
		
		// Set player leaving flag
		g_lastplayerleaving = true
		
		// Turn into a VIP
		vipme(id)
		
		// Remove player leaving flag
		g_lastplayerleaving = false
		
		// Set chosen player's health to that of the one who's leaving
		if (get_pcvar_num(cvar_keephealthondisconnect))
		{
			fm_set_user_health(id, pev(leaving_player, pev_health))
			set_pev(id, pev_armorvalue, pev(leaving_player, pev_armorvalue))
		}
	}
}

// Lighting Effects Task
public lighting_effects()
{
	// Cache some CVAR values at every 5 secs
	cache_cvars()
}

// Ambience Sound Effects Task
public ambience_sound_effects(taskid)
{
	// Play a random sound depending on the round
	static sound[64], iRand, duration
	
	if (g_nemround) // Nemesis Mode
	{
		iRand = random_num(0, ArraySize(sound_ambience2) - 1)
		ArrayGetString(sound_ambience2, iRand, sound, charsmax(sound))
		duration = ArrayGetCell(sound_ambience2_duration, iRand)
	}
	else if (g_survround) // Survivor Mode
	{
		iRand = random_num(0, ArraySize(sound_ambience3) - 1)
		ArrayGetString(sound_ambience3, iRand, sound, charsmax(sound))
		duration = ArrayGetCell(sound_ambience3_duration, iRand)
	}
	else if (g_swarmround) // Swarm Mode
	{
		iRand = random_num(0, ArraySize(sound_ambience4) - 1)
		ArrayGetString(sound_ambience4, iRand, sound, charsmax(sound))
		duration = ArrayGetCell(sound_ambience4_duration, iRand)
	}
	else if (g_plagueround) // Plague Mode
	{
		iRand = random_num(0, ArraySize(sound_ambience5) - 1)
		ArrayGetString(sound_ambience5, iRand, sound, charsmax(sound))
		duration = ArrayGetCell(sound_ambience5_duration, iRand)
	}
	else if (g_vipround) // Protect the VIP Mode
	{
		iRand = random_num(0, ArraySize(sound_ambience6) - 1)
		ArrayGetString(sound_ambience6, iRand, sound, charsmax(sound))
		duration = ArrayGetCell(sound_ambience6_duration, iRand)
	}
	else if (g_armageddonround) // Armageddon Mode
	{
		iRand = random_num(0, ArraySize(sound_ambience7) - 1)
		ArrayGetString(sound_ambience7, iRand, sound, charsmax(sound))
		duration = ArrayGetCell(sound_ambience7_duration, iRand)
	}
	else // Infection Mode
	{
		iRand = random_num(0, ArraySize(sound_ambience1) - 1)
		ArrayGetString(sound_ambience1, iRand, sound, charsmax(sound))
		duration = ArrayGetCell(sound_ambience1_duration, iRand)
	}
	
	// Play it on clients
	PlayGlobalSound(sound)
	
	// Set the task for when the sound is done playing
	set_task(float(duration), "ambience_sound_effects", TASK_AMBIENCESOUNDS)
}

// Ambience Sounds Stop Task
ambience_sound_stop()
{
	client_cmd(0, "mp3 stop; stopsound")
}

// Flashlight Charge Task
public flashlight_charge(taskid)
{
	// Drain or charge?
	if (g_flashlight[ID_CHARGE])
		g_flashbattery[ID_CHARGE] -= get_pcvar_num(cvar_flashdrain)
	else
		g_flashbattery[ID_CHARGE] += get_pcvar_num(cvar_flashcharge)
	
	// Battery fully charged
	if (g_flashbattery[ID_CHARGE] >= 100)
	{
		// Don't exceed 100%
		g_flashbattery[ID_CHARGE] = 100
		
		// Update flashlight battery on HUD
		message_begin(MSG_ONE, g_msgFlashBat, _, ID_CHARGE)
		write_byte(100) // battery
		message_end()
		
		// Task not needed anymore
		remove_task(taskid);
		return;
	}
	
	// Battery depleted
	if (g_flashbattery[ID_CHARGE] <= 0)
	{
		// Turn it off
		g_flashlight[ID_CHARGE] = false
		g_flashbattery[ID_CHARGE] = 0
		
		// Play flashlight toggle sound
		emit_sound(ID_CHARGE, CHAN_ITEM, sound_flashlight, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Update flashlight status on HUD
		message_begin(MSG_ONE, g_msgFlashlight, _, ID_CHARGE)
		write_byte(0) // toggle
		write_byte(0) // battery
		message_end()
		
		// Remove flashlight task for this player
		remove_task(ID_CHARGE+TASK_FLASH)
	}
	else
	{
		// Update flashlight battery on HUD
		message_begin(MSG_ONE_UNRELIABLE, g_msgFlashBat, _, ID_CHARGE)
		write_byte(g_flashbattery[ID_CHARGE]) // battery
		message_end()
	}
}

// Remove Spawn Protection Task
public remove_spawn_protection(taskid)
{
	// Not alive
	if (!g_isalive[ID_SPAWN])
		return;
	
	// Remove spawn protection
	g_nodamage[ID_SPAWN] = false
	set_pev(ID_SPAWN, pev_effects, pev(ID_SPAWN, pev_effects) & ~EF_NODRAW)
}

// Hide Player's Money Task
public task_hide_money(taskid)
{
	// Not alive
	if (!g_isalive[ID_SPAWN])
		return;
	
	// Hide money
	message_begin(MSG_ONE, g_msgHideWeapon, _, ID_SPAWN)
	write_byte(HIDE_MONEY|((g_zombie[ID_SPAWN] && get_user_weapon(ID_SPAWN) == CSW_KNIFE) ? HIDE_CROSS : 0)) // what to hide bitsum
	message_end()
	
	// Hide the HL crosshair that's drawn
	message_begin(MSG_ONE, g_msgCrosshair, _, ID_SPAWN)
	write_byte(0) // toggle
	message_end()
}

// Turn Off Flashlight and Restore Batteries
turn_off_flashlight(id)
{
	// Restore batteries for the next use
	fm_cs_set_user_batteries(id, 100)
	
	// Check if flashlight is on
	if (pev(id, pev_effects) & EF_DIMLIGHT)
	{
		// Turn it off
		set_pev(id, pev_impulse, IMPULSE_FLASHLIGHT)
	}
	else
	{
		// Clear any stored flashlight impulse (bugfix)
		set_pev(id, pev_impulse, 0)
	}
	
	// Turn off custom flashlight
	if (g_cached_customflash)
	{
		// Turn it off
		g_flashlight[id] = false
		g_flashbattery[id] = 100
		
		// Update flashlight HUD
		message_begin(MSG_ONE, g_msgFlashlight, _, id)
		write_byte(0) // toggle
		write_byte(100) // battery
		message_end()
		
		// Remove previous tasks
		remove_task(id+TASK_CHARGE)
		remove_task(id+TASK_FLASH)
	}
}

// Infection Bomb Explosion
infection_explode(ent)
{
	// Round ended (bugfix)
	if (g_endround) return;
	
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Make the explosion
	create_blast(originF)
	
	// Infection nade explode sound
	static sound[64]
	ArrayGetString(grenade_infect, random_num(0, ArraySize(grenade_infect) - 1), sound, charsmax(sound))
	emit_sound(ent, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	// Get attacker
	static attacker
	attacker = pev(ent, pev_owner)
	
	// Infection bomb owner disconnected? (bugfix)
	if (!is_user_valid_connected(attacker))
	{
		// Get rid of the grenade
		engfunc(EngFunc_RemoveEntity, ent)
		return;
	}
	
	// Collisions
	static victim
	victim = -1
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, NADE_EXPLOSION_RADIUS)) != 0)
	{
		// Only effect alive non-spawnprotected humans
		if (!is_user_valid_alive(victim) || g_zombie[victim] || g_nodamage[victim] || !is_visible(victim, ent))
			continue;
		
		// Human has some armor
		if (pev(victim, pev_armorvalue) > 0.0)
		{
			// Remove it
			cs_set_user_armor(victim, 0, CS_ARMOR_NONE)
			continue;
		}
		
		// Last human is killed
		if (fnGetHumans() == 1)
		{
			ExecuteHamB(Ham_Killed, victim, attacker, 0)
			continue;
		}
		
		// Infected victim's sound
		ArrayGetString(grenade_infect_player, random_num(0, ArraySize(grenade_infect_player) - 1), sound, charsmax(sound))
		emit_sound(victim, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Turn into zombie
		zombieme(victim, attacker, 0, 1, 1)
	}
	
	// Get rid of the grenade
	engfunc(EngFunc_RemoveEntity, ent)
}

// Knockback Bomb Explosion
kbbomb_explode(ent)
{
	// Round ended (bugfix)
	if (g_endround) return;
	
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Make the explosion
	create_blast7(originF)
	
	// Infection nade explode sound
	static sound[64]
	ArrayGetString(grenade_infect, random_num(0, ArraySize(grenade_infect) - 1), sound, charsmax(sound))
	emit_sound(ent, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	// Collisions
	static victim, Float:victimOriginF[3], Float:speed, Float:velocity[3]
	victim = -1
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, NADE_EXPLOSION_RADIUS)) != 0)
	{
		// Only effect alive non-spawnprotected humans
		if (!is_user_valid_alive(victim) || g_zombie[victim] || g_nodamage[victim] || !is_visible(victim, ent))
			continue;
		
		// get victim's origin
		pev(victim, pev_origin, victimOriginF)
		
		// calculate knockback power
		speed = NADE_KNOCKBACK_POWER * (1.0 - (get_distance_f(originF, victimOriginF) / NADE_EXPLOSION_RADIUS))
		
		// calculate velocity
		get_speed_vector(originF, victimOriginF, speed, velocity)
		
		// limit z vector
		velocity[2] = 300.0
		
		// set velocity
		set_pev(victim, pev_velocity, velocity)
	}
	
	// Get rid of the grenade
	engfunc(EngFunc_RemoveEntity, ent)
}

// Fire Grenade Explosion
fire_explode(ent)
{
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Make the explosion
	create_blast2(originF)
	
	// Fire nade explode sound
	static sound[64]
	ArrayGetString(grenade_fire, random_num(0, ArraySize(grenade_fire) - 1), sound, charsmax(sound))
	emit_sound(ent, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	// Collisions
	static victim, attacker, params[1]
	victim = -1
	attacker = pev(ent, pev_owner)
	
	// Calculation specific vars
	static adjustedDuration, Float:victimOriginF[3]
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, NADE_EXPLOSION_RADIUS)) != 0)
	{
		// Only effect alive zombies
		if (!is_user_valid_alive(victim) || !g_zombie[victim] || g_nodamage[victim] || !is_visible(victim, ent))
			continue;
		
		// Get victim's origin
		pev(victim, pev_origin, victimOriginF)
		
		// Calculate fire duration
		adjustedDuration = floatround(GetRadiusDamageF(NADE_EXPLOSION_RADIUS, get_pcvar_num(cvar_fireduration) * (g_nemesis[victim] ? 1.0 : 5.0), get_distance_f(originF, victimOriginF)), floatround_ceil)
		if (!adjustedDuration) adjustedDuration = 1
		
		// Set fire duration
		g_burning_duration[victim] += adjustedDuration
		
		// Our task params
		params[0] = attacker
		
		// Set burning task on victim
		set_task(0.2, "burning_flame", victim+TASK_BURN, params, sizeof(params), "b")
	}
	
	// Get rid of the grenade
	engfunc(EngFunc_RemoveEntity, ent)
}

// Frost Grenade Explosion
frost_explode(ent)
{
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Make the explosion
	create_blast3(originF)
	
	// Frost nade explode sound
	static sound[64]
	ArrayGetString(grenade_frost, random_num(0, ArraySize(grenade_frost) - 1), sound, charsmax(sound))
	emit_sound(ent, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	// Collisions
	static victim, attacker
	victim = -1
	attacker = pev(ent, pev_owner)
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, NADE_EXPLOSION_RADIUS)) != 0)
	{
		// Only effect alive zombies
		if (!is_user_valid_alive(victim) || !g_zombie[victim] || g_nodamage[victim] || !is_visible(victim, ent))
			continue;
		
		freeze_player(victim, attacker, originF, get_pcvar_num(cvar_freezeduration) * 5.0)
	}
	
	// Get rid of the grenade
	engfunc(EngFunc_RemoveEntity, ent)
}

create_forcefield(ent)
{
	// get grenade's origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// create forcefield entity
	static ent2
	ent2 = create_entity("info_target")
	
	set_pev(ent2, pev_classname, "zp_forcefield")
	set_pev(ent2, pev_solid, SOLID_TRIGGER)
	
	engfunc(EngFunc_SetOrigin, ent2, originF)
	engfunc(EngFunc_SetModel, ent2, "models/zombie_plague/aura8.mdl")
	engfunc(EngFunc_SetSize, ent2, Float:{-100.0, -100.0, -100.0}, Float:{100.0, 100.0, 100.0})
	
	fm_set_rendering(ent2, kRenderFxGlowShell, 148, 0, 211, kRenderTransAlpha, 1)
	
	return ent2;
}

freeze_player(victim, attacker, Float:originF[3], Float:freezeduration, useOrigin = true)
{
	if (g_freezing_duration[victim] && task_exists(victim+TASK_FREEZE))
	{
		if (useOrigin)
		{
			// Get victim's origin
			static Float:victimOriginF[3]
			pev(victim, pev_origin, victimOriginF)
			
			// Calculate freezing duration
			static adjustedDuration
			adjustedDuration = floatround(GetRadiusDamageF(NADE_EXPLOSION_RADIUS, freezeduration, get_distance_f(originF, victimOriginF)), floatround_ceil)
			if (adjustedDuration < 1) adjustedDuration = 1
			
			// Freeze duration
			g_freezing_duration[victim] += adjustedDuration
		}
		else
		{
			g_freezing_duration[victim] += floatround(freezeduration)
		}
	}
	else
	{
		// Nemesis shouldn't be frozen
		if (g_nemesis[victim])
		{
			// Get player's origin
			static origin2[3]
			get_user_origin(victim, origin2)
			
			// Broken glass sound
			static sound[64]
			ArrayGetString(grenade_frost_break, random_num(0, ArraySize(grenade_frost_break) - 1), sound, charsmax(sound))
			emit_sound(victim, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			// Glass shatter
			message_begin(MSG_PVS, SVC_TEMPENTITY, origin2)
			write_byte(TE_BREAKMODEL) // TE id
			write_coord(origin2[0]) // x
			write_coord(origin2[1]) // y
			write_coord(origin2[2]+24) // z
			write_coord(16) // size x
			write_coord(16) // size y
			write_coord(16) // size z
			write_coord(random_num(-50, 50)) // velocity x
			write_coord(random_num(-50, 50)) // velocity y
			write_coord(25) // velocity z
			write_byte(10) // random velocity
			write_short(g_glassSpr) // model
			write_byte(10) // count
			write_byte(25) // life
			write_byte(BREAK_GLASS) // flags
			message_end()
			
			// Should take minimal damage
			TakeDamage(victim, attacker, "frostbite", get_pcvar_float(cvar_freezedamage), DMG_DROWN) // DMG_FREEZE
			return;
		}
		
		// Get victim's origin
		static Float:victimOriginF[3]
		pev(victim, pev_origin, victimOriginF)
		
		if (useOrigin)
		{
			// Calculate freezing duration
			static adjustedDuration
			adjustedDuration = floatround(GetRadiusDamageF(NADE_EXPLOSION_RADIUS, freezeduration, get_distance_f(originF, victimOriginF)), floatround_ceil)
			if (adjustedDuration < 1) adjustedDuration = 1
			
			// Freeze duration
			g_freezing_duration[victim] += adjustedDuration
		}
		else
		{
			g_freezing_duration[victim] += floatround(freezeduration)
		}
		
		// Light blue glow while frozen
		if (g_handle_models_on_separate_ent)
			fm_set_rendering(g_ent_playermodel[victim], kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 1)
		else
			fm_set_rendering(victim, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 1)
		
		// Freeze sound
		static sound[64]
		ArrayGetString(grenade_frost_player, random_num(0, ArraySize(grenade_frost_player) - 1), sound, charsmax(sound))
		emit_sound(victim, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Add a blue tint to their screen
		message_begin(MSG_ONE, g_msgScreenFade, _, victim)
		write_short(0) // duration
		write_short(0) // hold time
		write_short(FFADE_STAYOUT) // fade type
		write_byte(0) // red
		write_byte(50) // green
		write_byte(200) // blue
		write_byte(100) // alpha
		message_end()
		
		// Save player's old gravity (bugfix)
		pev(victim, pev_gravity, g_frozen_gravity[victim])
		
		// Prevent from jumping
		if (pev(victim, pev_flags) & FL_ONGROUND)
			set_pev(victim, pev_gravity, 999999.9) // set really high
		else
			set_pev(victim, pev_gravity, 0.000001) // no gravity
		
		// Prevent from moving
		ExecuteHamB(Ham_Player_ResetMaxSpeed, victim)
		
		// Our task params
		static params[1]
		params[0] = attacker
		
		// Set freeze task on victim
		set_task(0.2, "freezing_blast", victim+TASK_FREEZE, params, sizeof(params), "b")
	}
}

// Freezing Blast
public freezing_blast(params[1], taskid)
{
	static id
	id = ID_FREEZE
	
	// Should not be frozen anymore
	if (g_nodamage[id] || g_freezing_duration[id] < 1)
	{
		// Reset duration to 0
		g_freezing_duration[id] = 0
		
		// Restore gravity and maxspeed (bugfix)
		set_pev(id, pev_gravity, g_frozen_gravity[id])
		ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
		
		// Restore rendering
		if (g_handle_models_on_separate_ent)
		{
			// Nemesis or Survivor glow / remove glow on player model entity
			if (g_nemesis[id] && get_pcvar_num(cvar_nemglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 255, 0, 0, kRenderNormal, 1)
			else if (g_survivor[id] && get_pcvar_num(cvar_survglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 255, kRenderNormal, 1)
			else
				fm_set_rendering(g_ent_playermodel[id])
		}
		else
		{
			// Nemesis or Survivor glow / remove glow
			if (g_nemesis[id] && get_pcvar_num(cvar_nemglow))
				fm_set_rendering(id, kRenderFxGlowShell, 255, 0, 0, kRenderNormal, 1)
			else if (g_survivor[id] && get_pcvar_num(cvar_survglow))
				fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 255, kRenderNormal, 1)
			else
				fm_set_rendering(id)
		}
		
		// Gradually remove screen's blue tint
		message_begin(MSG_ONE, g_msgScreenFade, _, id)
		write_short(UNIT_SECOND) // duration
		write_short(0) // hold time
		write_short(FFADE_IN) // fade type
		write_byte(0) // red
		write_byte(50) // green
		write_byte(200) // blue
		write_byte(100) // alpha
		message_end()
		
		// Broken glass sound
		static sound[64]
		ArrayGetString(grenade_frost_break, random_num(0, ArraySize(grenade_frost_break) - 1), sound, charsmax(sound))
		emit_sound(id, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Get player's origin
		static origin2[3]
		get_user_origin(id, origin2)
		
		// Glass shatter
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin2)
		write_byte(TE_BREAKMODEL) // TE id
		write_coord(origin2[0]) // x
		write_coord(origin2[1]) // y
		write_coord(origin2[2]+24) // z
		write_coord(16) // size x
		write_coord(16) // size y
		write_coord(16) // size z
		write_coord(random_num(-50, 50)) // velocity x
		write_coord(random_num(-50, 50)) // velocity y
		write_coord(25) // velocity z
		write_byte(10) // random velocity
		write_short(g_glassSpr) // model
		write_byte(10) // count
		write_byte(25) // life
		write_byte(BREAK_GLASS) // flags
		message_end()
		
		ExecuteForward(g_fwUserUnfrozen, g_fwDummyResult, id)
		remove_task(taskid)
		return;
	}
	
	// Take damage from the freeze
	TakeDamage(id, params[0], "frostbite", get_pcvar_float(cvar_freezedamage), DMG_DROWN) // DMG_FREEZE
	
	// Decrease freezing duration counter
	g_freezing_duration[id]--
}

// Laser cutter: Beam ring
create_blast6(const Float:originF[3])
{
	engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMDISK)
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]+16.0) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]+350.0) // z
	write_short(g_trailSpr) // sprite index
	write_byte(0) // starting frame
	write_byte(0) // frame rate in 0.1's
	write_byte(4) // life in 0.1's
	write_byte(0) // line width in 0.1's
	write_byte(0) // noise amplitude in 0.01's
	write_byte(214) // colour
	write_byte(189)
	write_byte(41)
	write_byte(100) // brightness
	write_byte(0) // scroll speed in 0.1's
	message_end()
}

// Laser cutter: Beam ring (blue)
create_blast6_blue(const Float:originF[3])
{
	engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMDISK)
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]+16.0) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]+350.0) // z
	write_short(g_trailSpr) // sprite index
	write_byte(0) // starting frame
	write_byte(0) // frame rate in 0.1's
	write_byte(4) // life in 0.1's
	write_byte(0) // line width in 0.1's
	write_byte(0) // noise amplitude in 0.01's
	write_byte(0) // colour
	write_byte(100)
	write_byte(200)
	write_byte(100) // brightness
	write_byte(0) // scroll speed in 0.1's
	message_end()
}

// Laser cutter: Beam ring (red)
create_blast6_red(const Float:originF[3])
{
	engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMDISK)
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]+16.0) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]+350.0) // z
	write_short(g_trailSpr) // sprite index
	write_byte(0) // starting frame
	write_byte(0) // frame rate in 0.1's
	write_byte(4) // life in 0.1's
	write_byte(0) // line width in 0.1's
	write_byte(0) // noise amplitude in 0.01's
	write_byte(200) // colour
	write_byte(10)
	write_byte(0)
	write_byte(100) // brightness
	write_byte(0) // scroll speed in 0.1's
	message_end()
}

/*
// Frost Grenade: Freeze Blast
create_blast3(const Float:originF[3])
{
    // Smallest ring
    engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
    write_byte(TE_BEAMCYLINDER) // TE id
    engfunc(EngFunc_WriteCoord, originF[0]) // x
    engfunc(EngFunc_WriteCoord, originF[1]) // y
    engfunc(EngFunc_WriteCoord, originF[2]) // z
    engfunc(EngFunc_WriteCoord, originF[0]) // x axis
    engfunc(EngFunc_WriteCoord, originF[1]) // y axis
    engfunc(EngFunc_WriteCoord, originF[2]+385.0) // z axis
    write_short(g_exploSpr) // sprite
    write_byte(0) // startframe
    write_byte(0) // framerate
    write_byte(4) // life
    write_byte(60) // width
    write_byte(0) // noise
    write_byte(0) // red
    write_byte(100) // green
    write_byte(200) // blue
    write_byte(200) // brightness
    write_byte(0) // speed
    message_end()
    
    // Medium ring
    engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
    write_byte(TE_BEAMCYLINDER) // TE id
    engfunc(EngFunc_WriteCoord, originF[0]) // x
    engfunc(EngFunc_WriteCoord, originF[1]) // y
    engfunc(EngFunc_WriteCoord, originF[2]) // z
    engfunc(EngFunc_WriteCoord, originF[0]) // x axis
    engfunc(EngFunc_WriteCoord, originF[1]) // y axis
    engfunc(EngFunc_WriteCoord, originF[2]+470.0) // z axis
    write_short(g_exploSpr) // sprite
    write_byte(0) // startframe
    write_byte(0) // framerate
    write_byte(4) // life
    write_byte(60) // width
    write_byte(0) // noise
    write_byte(51) // red
    write_byte(135) // green
    write_byte(198) // blue
    write_byte(200) // brightness
    write_byte(0) // speed
    message_end()
    
    // Largest ring
    engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
    write_byte(TE_BEAMCYLINDER) // TE id
    engfunc(EngFunc_WriteCoord, originF[0]) // x
    engfunc(EngFunc_WriteCoord, originF[1]) // y
    engfunc(EngFunc_WriteCoord, originF[2]) // z
    engfunc(EngFunc_WriteCoord, originF[0]) // x axis
    engfunc(EngFunc_WriteCoord, originF[1]) // y axis
    engfunc(EngFunc_WriteCoord, originF[2]+555.0) // z axis
    write_short(g_exploSpr) // sprite
    write_byte(0) // startframe
    write_byte(0) // framerate
    write_byte(4) // life
    write_byte(60) // width
    write_byte(0) // noise
    write_byte(0) // red
    write_byte(100) // green
    write_byte(200) // blue
    write_byte(200) // brightness
    write_byte(0) // speed
    message_end()

    engfunc(EngFunc_MessageBegin, MSG_BROADCAST,SVC_TEMPENTITY, originF, 0)
    write_byte(TE_DLIGHT);
    engfunc(EngFunc_WriteCoord, originF[0]) // x axis
    engfunc(EngFunc_WriteCoord, originF[1]) // y axis
    engfunc(EngFunc_WriteCoord, originF[2]) // z axis
    write_byte(floatround(GRANATE_LGHT_RADIUS/5.0)); // radius
    write_byte(14); // r
    write_byte(116); // g
    write_byte(177); // b
    write_byte(5); // life
    write_byte(25); // decay rate
    message_end();

    engfunc(EngFunc_MessageBegin, MSG_BROADCAST,SVC_TEMPENTITY, originF, 0)
    write_byte(TE_SPRITETRAIL) // TE ID
    engfunc(EngFunc_WriteCoord, originF[0]) // x axis
    engfunc(EngFunc_WriteCoord, originF[1]) // y axis
    engfunc(EngFunc_WriteCoord, originF[2] + 40) // z axis
    engfunc(EngFunc_WriteCoord, originF[0]) // x axis
    engfunc(EngFunc_WriteCoord, originF[1]) // y axis
    engfunc(EngFunc_WriteCoord, originF[2]) // z axis
    write_short(g_frostgibs) // Sprite Index
    write_byte(30) // Count
    write_byte(10) // Life
    write_byte(2) // Scale
    write_byte(50) // Velocity Along Vector
    write_byte(10) // Rendomness of Velocity
    message_end();

    engfunc(EngFunc_MessageBegin, MSG_BROADCAST,SVC_TEMPENTITY, originF, 0)
    write_byte(TE_DLIGHT);
    engfunc(EngFunc_WriteCoord, originF[0]) // x axis
    engfunc(EngFunc_WriteCoord, originF[1]) // y axis
    engfunc(EngFunc_WriteCoord, originF[2]) // z axis
    write_byte(floatround(GRANATE_LGHT_RADIUS/5.0)); // radius
    write_byte(14); // r
    write_byte(116); // g
    write_byte(177); // b
    write_byte(5); // life
    write_byte(25); // decay rate
    message_end();
    
    engfunc(EngFunc_MessageBegin, MSG_BROADCAST,SVC_TEMPENTITY, originF, 0)
    write_byte(TE_EXPLOSION)
    engfunc(EngFunc_WriteCoord, originF[0]) // x axis
    engfunc(EngFunc_WriteCoord, originF[1]) // y axis
    engfunc(EngFunc_WriteCoord, originF[2]+75) // z axis
    write_short(g_fireexpSpr3)
    write_byte(22)
    write_byte(35)
    write_byte(TE_EXPLFLAG_NOSOUND)
    message_end();
    
    engfunc(EngFunc_MessageBegin, MSG_BROADCAST,SVC_TEMPENTITY, originF, 0)
    write_byte(TE_WORLDDECAL)
    engfunc(EngFunc_WriteCoord, originF[0]) // x axis
    engfunc(EngFunc_WriteCoord, originF[1]) // y axis
    engfunc(EngFunc_WriteCoord, originF[2]) // z axis
    write_byte(random_num(46,48))
    message_end();
}
*/

he_explode(ent)
{
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Effects
	create_blast4(originF)
	
	// Collisions
	static victim, attacker
	victim = -1
	attacker = pev(ent, pev_owner)
	
	// Calculation specific vars
	static Float:adjustedDamage, Float:victimOriginF[3], Float:distance, duration
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, NADE_EXPLOSION_RADIUS)) != 0)
	{
		// Only affect alive zombies
		if (!is_user_valid_alive(victim))
			continue;
		
		// Get victim's origin
		pev(victim, pev_origin, victimOriginF)
		
		// Calculate distance between grenade and victim
		distance = get_distance_f(originF, victimOriginF)
		
		// Calculate screenshake / screenfade duration
		duration = floatround(GetRadiusDamageF(NADE_EXPLOSION_RADIUS, UNIT_SECOND * 1.0, distance), floatround_ceil)
		
		// Screenshake
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, victim)
		write_short(floatround(GetRadiusDamageF(NADE_EXPLOSION_RADIUS, UNIT_SECOND * 6.0, distance), floatround_ceil)) // amplitude
		write_short(duration) // duration
		write_short(UNIT_SECOND * 10) // frequency
		message_end()
		
		// Explosion can't see victim / victim is frozen
		if (!is_visible(victim, ent) || g_freezing_duration[victim])
			continue;
		
		// Gradually remove screen's red tint
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenFade, _, victim)
		write_short(duration) // duration
		write_short(0) // hold time
		write_short(FFADE_IN) // fade type
		write_byte(random_num(200, 250)) // red
		write_byte(random_num(0, 25)) // green
		write_byte(random_num(0, 25)) // blue
		write_byte(floatround(GetRadiusDamageF(NADE_EXPLOSION_RADIUS, 200.0, distance), floatround_ceil)) // alpha
		message_end()
		
		// Victim should not take damage
		if (!g_zombie[victim] || g_nodamage[victim])
			continue;
		
		// Calculate damage
		adjustedDamage = GetRadiusDamageF(NADE_EXPLOSION_RADIUS, NADE_EXPLOSION_DAMAGE, distance)
		
		// Actually take damage
		if (adjustedDamage) TakeDamage(victim, attacker, "grenade", adjustedDamage, DMG_HEGRENADE, true)
	}
	
	// Get rid of the grenade
	engfunc(EngFunc_RemoveEntity, ent)
}

molotov_explode(ent)
{
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Flame sprites
	for (new i; i < 8; i++)
	{
		engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
		write_byte(TE_SPRITE) // TE id
		engfunc(EngFunc_WriteCoord, originF[0]+random_float(-MOLOTOV_EXPLOSION_RADIUS, MOLOTOV_EXPLOSION_RADIUS)) // x
		engfunc(EngFunc_WriteCoord, originF[1]+random_float(-MOLOTOV_EXPLOSION_RADIUS, MOLOTOV_EXPLOSION_RADIUS)) // y
		engfunc(EngFunc_WriteCoord, originF[2]) // z
		write_short(g_flameSpr) // sprite
		write_byte(random_num(3, 10)) // scale
		write_byte(random_num(180, 220)) // brightness
		message_end()
		
		// Smoke every 4th flame
		if (!(i % 4))
		{
			engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
			write_byte(TE_SMOKE)
			engfunc(EngFunc_WriteCoord, originF[0]+random_float(-MOLOTOV_EXPLOSION_RADIUS, MOLOTOV_EXPLOSION_RADIUS)) // x
			engfunc(EngFunc_WriteCoord, originF[1]+random_float(-MOLOTOV_EXPLOSION_RADIUS, MOLOTOV_EXPLOSION_RADIUS)) // y
			engfunc(EngFunc_WriteCoord, originF[2]) // z
			write_short(g_smokeSpr)
			write_byte(random_num(10, 30))
			write_byte(random_num(10, 20))
			message_end()
		}
	}
	
	// Damage
	static attacker, victim, params[1]
	attacker = pev(ent, pev_owner)
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, MOLOTOV_EXPLOSION_RADIUS)) != 0)
	{
		// Only effect alive zombies
		if (!is_user_valid_alive(victim) || !g_zombie[victim] || g_nodamage[victim])
			continue;
		
		// Set fire duration
		g_burning_duration[victim] += 5
		
		// Our task params
		params[0] = attacker
		
		// Set burning task on victim
		set_task(0.2, "burning_flame", victim+TASK_BURN, params, sizeof(params), "b")
	}
}

cutter_explode(ent)
{
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Attacker
	static attacker, victim
	attacker = pev(ent, pev_owner)
	
	// Calculate damage
	static Float:damage, freeze
	damage = 100.0
	
	// Plasma Cutter upgrade?
	if (has_upgrade(attacker, UPGRADE_HUMAN_PLASMA_CUTTER))
	{
		damage *= 1.5 // increase by 50%
		freeze = chance(15)
		
		// Effects
		if (freeze)
			create_blast6_blue(originF)
		else
			create_blast6_red(originF)
	}
	else
	{
		freeze = chance(10)
		
		// Effects
		if (freeze)
			create_blast6_blue(originF)
		else
			create_blast6(originF)
	}
	
	// Sound
	emit_sound(ent, CHAN_VOICE, "ambience/alien_minddrill.wav", 0.4, ATTN_IDLE, 0, PITCH_NORM)
	
	// Durability
	static health
	health = pev(ent, PEV_NADE_DURATION)
	
	// Reduce health by 1
	health--
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, 150.0)) != 0)
	{
		// Only effect alive zombies
		if (!is_user_valid_alive(victim) || !g_zombie[victim] || g_nodamage[victim])
			continue;
		
		// Laser can't see victim / victim is frozen
		if (!is_visible(victim, ent) || g_freezing_duration[victim])
			continue;
		
		// Take damage
		TakeDamage(victim, attacker, "laser cutter", damage, DMG_ENERGYBEAM, true)
		
		// % chance freezing the target
		if (freeze)
			freeze_player(victim, attacker, originF, 5.0)
		
		// Reduce cutter's health
		health--
	}
	
	if (health < 1) health = 1
	set_pev(ent, PEV_NADE_DURATION, health)
}

// Remove Stuff Task
public remove_stuff()
{
	static ent
	
	// Remove rotating doors
	if (get_pcvar_num(cvar_removedoors) > 0)
	{
		ent = -1;
		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "func_door_rotating")) != 0)
			engfunc(EngFunc_SetOrigin, ent, Float:{8192.0 ,8192.0 ,8192.0})
	}
	
	// Remove all doors
	if (get_pcvar_num(cvar_removedoors) > 1)
	{
		ent = -1;
		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "func_door")) != 0)
			engfunc(EngFunc_SetOrigin, ent, Float:{8192.0 ,8192.0 ,8192.0})
	}
	
	// Triggered lights
	if (!get_pcvar_num(cvar_triggered))
	{
		ent = -1
		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "light")) != 0)
		{
			dllfunc(DLLFunc_Use, ent, 0); // turn off the light
			set_pev(ent, pev_targetname, 0) // prevent it from being triggered
		}
	}
}

// Set Custom Weapon Models
replace_weapon_models(id, weaponid)
{
	switch (weaponid)
	{
		case CSW_KNIFE: // Custom knife models
		{
			if (g_zombie[id])
			{
				if (g_nemesis[id]) // Nemesis
				{
					set_pev(id, pev_viewmodel2, model_vknife_nemesis)
					set_pev(id, pev_weaponmodel2, "")
				}
				else // Zombies
				{
					// Admin knife models?
					if (get_pcvar_num(cvar_adminknifemodelszombie) && get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])
					{
						set_pev(id, pev_viewmodel2, model_vknife_admin_zombie)
						set_pev(id, pev_weaponmodel2, "")
					}
					else
					{
						static clawmodel[100]
						ArrayGetString(g_zclass_clawmodel, g_zombieclass[id], clawmodel, charsmax(clawmodel))
						set_pev(id, pev_viewmodel2, clawmodel)
						set_pev(id, pev_weaponmodel2, "")
					}
				}
				
				// Hide crosshair
				message_begin(MSG_ONE_UNRELIABLE, g_msgHideWeapon, _, id)
				write_byte(HIDE_CROSS|HIDE_MONEY) // what to hide bitsum
				message_end()
				
				// Hide the HL crosshair that's drawn
				message_begin(MSG_ONE_UNRELIABLE, g_msgCrosshair, _, id)
				write_byte(0) // toggle
				message_end()
			}
			else // Humans
			{
				static knifevmodel[64], knifepmodel[64]
				ArrayGetString(g_knife_vmodel, g_knife[id], knifevmodel, charsmax(knifevmodel))
				ArrayGetString(g_knife_pmodel, g_knife[id], knifepmodel, charsmax(knifepmodel))
				
				set_pev(id, pev_viewmodel2, knifevmodel)
				set_pev(id, pev_weaponmodel2, knifepmodel)
			}
		}
		case CSW_HEGRENADE: // Infection bomb or fire grenade
		{
			if (g_zombie[id])
			{
				set_pev(id, pev_viewmodel2, model_grenade_infect)
				
				// Show crosshair
				message_begin(MSG_ONE_UNRELIABLE, g_msgHideWeapon, _, id)
				write_byte(HIDE_MONEY) // what to hide bitsum
				message_end()
				
				// Hide the HL crosshair that's drawn
				message_begin(MSG_ONE_UNRELIABLE, g_msgCrosshair, _, id)
				write_byte(0) // toggle
				message_end()
			}
			else
			{
				switch (g_grenade_slot1[id])
				{
					case NADE_TYPE_NAPALM: set_pev(id, pev_viewmodel2, model_grenade_fire);
					case NADE_TYPE_MOLOTOV:
					{
						set_pev(id, pev_viewmodel2, "models/fzm/v_molotov.mdl")
						set_pev(id, pev_weaponmodel2, "models/fzm/p_molotov.mdl")
					}
				}
			}
		}
		case CSW_FLASHBANG: // Frost grenade
		{
			if (g_zombie[id])
			{
				
			}
			else
			{
				switch (g_grenade_slot2[id])
				{
					case NADE_TYPE_FROST: set_pev(id, pev_viewmodel2, model_grenade_frost);
					case NADE_TYPE_FORCEFIELD: set_pev(id, pev_viewmodel2, "models/zombie_plague/v_auragren.mdl");
				}
			}
		}
		case CSW_SMOKEGRENADE: // Slot 3 grenade (utility)
		{
			if (g_zombie[id])
			{
				// Show crosshair
				message_begin(MSG_ONE_UNRELIABLE, g_msgHideWeapon, _, id)
				write_byte(HIDE_MONEY) // what to hide bitsum
				message_end()
				
				// Hide the HL crosshair that's drawn
				message_begin(MSG_ONE_UNRELIABLE, g_msgCrosshair, _, id)
				write_byte(0) // toggle
				message_end()
			}
			else
			{
				switch (g_grenade_slot3[id]) // Flare
				{
					case NADE_TYPE_FLARE: set_pev(id, pev_viewmodel2, model_grenade_flare);
				}
			}
		}
	}
	
	// Update model on weaponmodel ent
	if (g_handle_models_on_separate_ent) fm_set_weaponmodel_ent(id)
	
	// Custom overrides
	ExecuteForward(g_fwReplaceWeaponModels, g_fwDummyResult, id, weaponid)
}

// Reset Player Vars
reset_vars(id, resetall)
{
	g_zombie[id] = false
	g_nemesis[id] = false
	g_survivor[id] = false
	g_vip[id] = false
	g_firstzombie[id] = false
	g_lastzombie[id] = false
	g_lasthuman[id] = false
	g_nodamage[id] = false
	g_respawn_as_zombie[id] = false
	g_nvision[id] = false
	g_nvisionenabled[id] = false
	g_flashlight[id] = false
	g_flashbattery[id] = 100
	g_canbuy[id] = true
	g_burning_duration[id] = 0
	g_freezing_duration[id] = 0
	g_ammostacks_frostbite[id] = 0
	g_ammostacks_incendiary[id] = 0
	g_ammostacks_poison[id] = 0
	g_grenade_slot1[id] = NADE_TYPE_NAPALM
	g_grenade_slot2[id] = NADE_TYPE_FROST
	g_grenade_slot3[id] = NADE_TYPE_FLARE
	
	if (resetall)
	{
		g_ammopacks[id] = get_pcvar_num(cvar_startammopacks)
		g_zombieclass[id] = 0
		g_zombieclassnext[id] = ZCLASS_NONE
		g_humanclass[id] = 0
		g_humanclassnext[id] = HCLASS_NONE
		g_knife[id] = 0
		g_ammo[id] = 0
		g_level[id] = 1
		g_viewing_upgrade[id] = 0
		TrieClear(g_upgrades[id])
		PL_ACTION = 0
		MENU_PAGE_ZCLASS = 0
		MENU_PAGE_EXTRAS = 0
		MENU_PAGE_PLAYERS = 0
		
		g_db_id[id] = -1
		g_db_primary[id] = PRIMARY_AK47
		g_db_secondary[id] = SECONDARY_ELDIABLO
		g_db_knife[id] = 0
		g_db_offensivegrenade[id] = 0
		g_db_defensivegrenade[id] = 0
		g_db_tacticalgrenade[id] = 0
		g_db_special[id] = 0
		g_db_ammo[id] = 0
		g_db_xp[id] = 0
		g_db_zombieskilled[id] = 0
		g_db_humansinfected[id] = 0
		g_db_roundswon[id] = 0
	}
}

// Set spectators nightvision
public spec_nvision(id)
{
	// Not connected, alive, or bot
	if (!g_isconnected[id] || g_isalive[id] || g_isbot[id])
		return;
	
	// Give Night Vision?
	g_nvision[id] = true
	
	// Turn on Night Vision automatically?
	g_nvisionenabled[id] = true
	set_user_gnvision(id, 1)
}

// Show HUD Task
public ShowHUD(taskid)
{
	static id
	id = ID_SHOWHUD;
	
	// Force fog first
	client_cmd(id, "gl_fog 1; developer 0; fps_override 0;")
	
	// Player died?
	if (!g_isalive[id])
	{
		// Get spectating target
		id = pev(id, PEV_SPEC_TARGET)
		
		// Target not alive
		if (!g_isalive[id]) return;
	}
	
	// Format classname
	static class[32], red, green, blue
	
	if (g_zombie[id]) // zombies
	{
		red = HUD_ZOMBIES_RED
		green = HUD_ZOMBIES_GREEN
		blue = HUD_ZOMBIES_BLUE
		
		if (g_nemesis[id])
			formatex(class, charsmax(class), "%L", ID_SHOWHUD, "CLASS_NEMESIS")
		else
			copy(class, charsmax(class), g_zombie_classname[id])
	}
	else // humans
	{
		red = HUD_HUMANS_RED
		green = HUD_HUMANS_GREEN
		blue = HUD_HUMANS_BLUE
		
		if (g_survivor[id])
			formatex(class, charsmax(class), "%L", ID_SHOWHUD, "CLASS_SURVIVOR")
		else
			formatex(class, charsmax(class), "%s", g_human_classname[id])
	}
	
	// Spectating someone else?
	if (id != ID_SHOWHUD)
	{
		// Show name, health, class, and ammo packs
		set_hudmessage(255, 255, 255, HUD_SPECT_X, HUD_SPECT_Y, 0, 6.0, 1.1, 0.0, 0.0, -1)
		ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync2, "Primary: %s^nSecondary: %s^n^nSpectating: %s^n^nHealth: %d^nArmor: %d^nAmmo Packs: %d^nClass: %s^nLevel: %d", PRIMARY_NAME[g_db_primary[id]], SECONDARY_NAME[g_db_secondary[id]], g_playername[id], pev(id, pev_health), (g_zombie[id] ? floatround((1.0 - Float:ArrayGetCell(g_zclass_armor, g_zombieclass[id])) * 1000.0) : pev(id, pev_armorvalue)), g_ammopacks[id], class, g_level[id])
	}
	else
	{
		// Show health, class and ammo packs
		set_hudmessage(red, green, blue, HUD_STATS_X, HUD_STATS_Y, 0, 6.0, 1.1, 0.0, 0.0, -1)
		ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync2, "Level: %d - XP: %d / %d - HP: %d - Class: %s - AP: %d", g_level[ID_SHOWHUD], g_db_xp[ID_SHOWHUD], g_xpneeded[ID_SHOWHUD], pev(ID_SHOWHUD, pev_health), class, g_ammopacks[ID_SHOWHUD])
		
		// Dirty way...
		health_tick(ID_SHOWHUD)
		armor_tick(ID_SHOWHUD)
	}
}

// Play idle zombie sounds
public zombie_play_idle(taskid)
{
	// Round ended/new one starting
	if (g_endround || g_newround)
		return;
	
	static sound[64]
	
	// Last zombie?
	if (g_lastzombie[ID_BLOOD])
	{
		ArrayGetString(zombie_idle_last, random_num(0, ArraySize(zombie_idle_last) - 1), sound, charsmax(sound))
		emit_sound(ID_BLOOD, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	else
	{
		ArrayGetString(zombie_idle, random_num(0, ArraySize(zombie_idle) - 1), sound, charsmax(sound))
		emit_sound(ID_BLOOD, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
}

// Madness Over Task
public madness_over(taskid)
{
	g_nodamage[ID_BLOOD] = false
}

// Place user at a random spawn
do_random_spawn(id, regularspawns = 0)
{
	static hull, sp_index, i
	
	// Get whether the player is crouching
	hull = (pev(id, pev_flags) & FL_DUCKING) ? HULL_HEAD : HULL_HUMAN
	
	// Use regular spawns?
	if (!regularspawns)
	{
		// No spawns?
		if (!g_spawnCount)
			return;
		
		// Choose random spawn to start looping at
		sp_index = random_num(0, g_spawnCount - 1)
		
		// Try to find a clear spawn
		for (i = sp_index + 1; /*no condition*/; i++)
		{
			// Start over when we reach the end
			if (i >= g_spawnCount) i = 0
			
			// Free spawn space?
			if (is_hull_vacant(g_spawns[i], hull))
			{
				// Engfunc_SetOrigin is used so ent's mins and maxs get updated instantly
				engfunc(EngFunc_SetOrigin, id, g_spawns[i])
				break;
			}
			
			// Loop completed, no free space found
			if (i == sp_index) break;
		}
	}
	else
	{
		// No spawns?
		if (!g_spawnCount2)
			return;
		
		// Choose random spawn to start looping at
		sp_index = random_num(0, g_spawnCount2 - 1)
		
		// Try to find a clear spawn
		for (i = sp_index + 1; /*no condition*/; i++)
		{
			// Start over when we reach the end
			if (i >= g_spawnCount2) i = 0
			
			// Free spawn space?
			if (is_hull_vacant(g_spawns2[i], hull))
			{
				// Engfunc_SetOrigin is used so ent's mins and maxs get updated instantly
				engfunc(EngFunc_SetOrigin, id, g_spawns2[i])
				break;
			}
			
			// Loop completed, no free space found
			if (i == sp_index) break;
		}
	}
}

// Update lighting on client
set_lighting(id, lighting[2])
{
	message_begin(MSG_ONE, SVC_LIGHTSTYLE, _, id)
	write_byte(0)
	write_string(lighting)
	message_end()
}

// Get Zombies -returns alive zombies number-
fnGetZombies()
{
	static iZombies, id
	iZombies = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_zombie[id])
			iZombies++
	}
	
	return iZombies;
}

// Get Humans -returns alive humans number-
fnGetHumans()
{
	static iHumans, id
	iHumans = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && !g_zombie[id])
			iHumans++
	}
	
	return iHumans;
}

// Get Nemesis -returns alive nemesis number-
fnGetNemesis()
{
	static iNemesis, id
	iNemesis = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_nemesis[id])
			iNemesis++
	}
	
	return iNemesis;
}

// Get Survivors -returns alive survivors number-
fnGetSurvivors()
{
	static iSurvivors, id
	iSurvivors = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_survivor[id])
			iSurvivors++
	}
	
	return iSurvivors;
}

// Get Alive -returns alive players number-
fnGetAlive()
{
	static iAlive, id
	iAlive = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id])
			iAlive++
	}
	
	return iAlive;
}

// Get Random Alive -returns index of alive player number n -
fnGetRandomAlive(n)
{
	static iAlive, id
	iAlive = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id])
			iAlive++
		
		if (iAlive == n)
			return id;
	}
	
	return -1;
}

// Get Random Alive -returns index of alive CT number n -
fnGetRandomAliveCT(n)
{
	static iAlive, id
	iAlive = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && fm_cs_get_user_team(id) == FM_CS_TEAM_CT)
			iAlive++
		
		if (iAlive == n)
			return id;
	}
	
	return -1;
}

// Get Random Alive -returns index of alive CT number n -
fnGetRandomAliveT(n)
{
	static iAlive, id
	iAlive = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && fm_cs_get_user_team(id) == FM_CS_TEAM_T)
			iAlive++
		
		if (iAlive == n)
			return id;
	}
	
	return -1;
}

// Get Playing -returns number of users playing-
fnGetPlaying()
{
	static iPlaying, id, team
	iPlaying = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isconnected[id])
		{
			team = fm_cs_get_user_team(id)
			
			if (team != FM_CS_TEAM_SPECTATOR && team != FM_CS_TEAM_UNASSIGNED)
				iPlaying++
		}
	}
	
	return iPlaying;
}

// Get CTs -returns number of CTs connected-
fnGetCTs()
{
	static iCTs, id
	iCTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isconnected[id])
		{			
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_CT)
				iCTs++
		}
	}
	
	return iCTs;
}

// Get Ts -returns number of Ts connected-
fnGetTs()
{
	static iTs, id
	iTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isconnected[id])
		{			
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_T)
				iTs++
		}
	}
	
	return iTs;
}

// Get Alive CTs -returns number of CTs alive-
fnGetAliveCTs()
{
	static iCTs, id
	iCTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id])
		{			
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_CT)
				iCTs++
		}
	}
	
	return iCTs;
}

// Get Alive Ts -returns number of Ts alive-
fnGetAliveTs()
{
	static iTs, id
	iTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id])
		{			
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_T)
				iTs++
		}
	}
	
	return iTs;
}

// Get VIPs -returns number of VIPs alive-
fnGetAliveVIPs()
{
	static iVIPs, id
	iVIPs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_vip[id] && g_isalive[id] && !g_zombie[id])
			iVIPs++
	}
	
	return iVIPs;
}

// Last Zombie Check -check for last zombie and set its flag-
fnCheckLastZombie()
{
	static id
	for (id = 1; id <= g_maxplayers; id++)
	{
		// Last zombie
		if (g_isalive[id] && g_zombie[id] && !g_nemesis[id] && fnGetZombies() == 1)
		{
			if (!g_lastzombie[id])
			{
				// Last zombie forward
				ExecuteForward(g_fwUserLastZombie, g_fwDummyResult, id);
			}
			g_lastzombie[id] = true
		}
		else
			g_lastzombie[id] = false
		
		// Last human
		if (g_isalive[id] && !g_zombie[id] && !g_survivor[id] && fnGetHumans() == 1)
		{
			if (!g_lasthuman[id])
			{
				// Last human forward
				ExecuteForward(g_fwUserLastHuman, g_fwDummyResult, id);
				
				// Reward extra hp
				fm_set_user_health(id, pev(id, pev_health) + get_pcvar_num(cvar_humanlasthp))
			}
			g_lasthuman[id] = true
		}
		else
			g_lasthuman[id] = false
	}
}

// Checks if a player is allowed to be zombie
allowed_zombie(id)
{
	if ((g_zombie[id] && !g_nemesis[id]) || g_endround || g_vip[id] || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to be human
allowed_human(id)
{
	if ((!g_zombie[id] && !g_survivor[id]) || g_endround || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to be survivor
allowed_survivor(id)
{
	if (g_endround || g_survivor[id] || !g_isalive[id] || g_vip[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to be nemesis
allowed_nemesis(id)
{
	if (g_endround || g_nemesis[id] || !g_isalive[id] || g_vip[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to respawn
allowed_respawn(id)
{
	static team
	team = fm_cs_get_user_team(id)
	
	if (g_endround || team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED || g_isalive[id])
		return false;
	
	return true;
}

// Checks if swarm mode is allowed
allowed_swarm()
{
	if (g_endround || !g_newround || task_exists(TASK_WELCOMEMSG))
		return false;
	
	return true;
}

// Checks if multi infection mode is allowed
allowed_multi()
{
	if (g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || floatround(fnGetAlive()*get_pcvar_float(cvar_multiratio), floatround_ceil) < 2 || floatround(fnGetAlive()*get_pcvar_float(cvar_multiratio), floatround_ceil) >= fnGetAlive())
		return false;
	
	return true;
}

// Checks if plague mode is allowed
allowed_plague()
{
	if (g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || floatround((fnGetAlive()-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil) < 1
	|| fnGetAlive()-(get_pcvar_num(cvar_plaguesurvnum)+get_pcvar_num(cvar_plaguenemnum)+floatround((fnGetAlive()-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)) < 1)
		return false;
	
	return true;
}

// Checks if armageddon mode is allowed
allowed_armageddon()
{
	if (g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || fnGetAlive() < 2)
		return false;
	
	return true;
}

// Checks if VIP mode is allowed
allowed_vip()
{
	if (g_endround || !g_newround || task_exists(TASK_WELCOMEMSG)/* || floatround(fnGetAlive()*get_pcvar_float(cvar_vipratio), floatround_ceil) < 2 || floatround(fnGetAlive()*get_pcvar_float(cvar_vipratio), floatround_ceil) >= fnGetAlive() */)
		return false;
	
	return true;
}

// Admin Command. zp_zombie
command_zombie(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_INFECT")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_INFECT")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER, "CMD_INFECT", fnGetPlaying(), g_maxplayers)
		log_to_file("zombieplague.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first zombie
		remove_task(TASK_MAKEZOMBIE)
		make_a_zombie(MODE_INFECTION, player)
	}
	else
	{
		// Just infect
		zombieme(player, 0, 0, 0, 0)
	}
}

// Admin Command. zp_human
command_human(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_DISINFECT")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_DISINFECT")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER,"CMD_DISINFECT", fnGetPlaying(), g_maxplayers)
		log_to_file("zombieplague.log", logdata)
	}
	
	// Turn to human
	humanme(player, 0, 0)
}

// Admin Command. zp_survivor
command_survivor(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_SURVIVAL")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_SURVIVAL")
	}
	
	 // Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER,"CMD_SURVIVAL", fnGetPlaying(), g_maxplayers)
		log_to_file("zombieplague.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first survivor
		remove_task(TASK_MAKEZOMBIE)
		make_a_zombie(MODE_SURVIVOR, player)
	}
	else
	{
		// Turn player into a Survivor
		humanme(player, 1, 0)
	}
}

// Admin Command. zp_nemesis
command_nemesis(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_NEMESIS")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_NEMESIS")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER,"CMD_NEMESIS", fnGetPlaying(), g_maxplayers)
		log_to_file("zombieplague.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first nemesis
		remove_task(TASK_MAKEZOMBIE)
		make_a_zombie(MODE_NEMESIS, player)
	}
	else
	{
		// Turn player into a Nemesis
		zombieme(player, 0, 1, 0, 0)
	}
}

// Admin Command. zp_respawn
command_respawn(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_RESPAWN")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_RESPAWN")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER, "CMD_RESPAWN", fnGetPlaying(), g_maxplayers)
		log_to_file("zombieplague.log", logdata)
	}
	
	// Respawn as zombie?
	if (get_pcvar_num(cvar_deathmatch) == 2 || (get_pcvar_num(cvar_deathmatch) == 3 && random_num(0, 1)) || (get_pcvar_num(cvar_deathmatch) == 4 && fnGetZombies() < fnGetAlive()/2))
		g_respawn_as_zombie[player] = true
	
	// Override respawn as zombie setting on nemesis and survivor rounds
	if (g_survround) g_respawn_as_zombie[player] = true
	else if (g_nemround) g_respawn_as_zombie[player] = false
	
	respawn_player_manually(player);
}

// Admin Command. zp_swarm
command_swarm(id)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %L", LANG_PLAYER, "CMD_SWARM")
		case 2: client_print(0, print_chat, "ADMIN %s - %L", g_playername[id], LANG_PLAYER, "CMD_SWARM")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %L (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER, "CMD_SWARM", fnGetPlaying(), g_maxplayers)
		log_to_file("zombieplague.log", logdata)
	}
	
	// Call Swarm Mode
	remove_task(TASK_MAKEZOMBIE)
	make_a_zombie(MODE_SWARM, 0)
}

// Admin Command. zp_multi
command_multi(id)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %L", LANG_PLAYER, "CMD_MULTI")
		case 2: client_print(0, print_chat, "ADMIN %s - %L", g_playername[id], LANG_PLAYER, "CMD_MULTI")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %L (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER,"CMD_MULTI", fnGetPlaying(), g_maxplayers)
		log_to_file("zombieplague.log", logdata)
	}
	
	// Call Multi Infection
	remove_task(TASK_MAKEZOMBIE)
	make_a_zombie(MODE_MULTI, 0)
}

// Admin Command. zp_plague
command_plague(id)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %L", LANG_PLAYER, "CMD_PLAGUE")
		case 2: client_print(0, print_chat, "ADMIN %s - %L", g_playername[id], LANG_PLAYER, "CMD_PLAGUE")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %L (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER,"CMD_PLAGUE", fnGetPlaying(), g_maxplayers)
		log_to_file("zombieplague.log", logdata)
	}
	
	// Call Plague Mode
	remove_task(TASK_MAKEZOMBIE)
	make_a_zombie(MODE_PLAGUE, 0)
}

// Admin Command. zp_armageddon
command_armageddon(id)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - start Armageddon Mode")
		case 2: client_print(0, print_chat, "ADMIN %s - start Armageddon Mode", g_playername[id])
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - start Armageddon Mode (Players: %d/%d)", g_playername[id], authid, ip, fnGetPlaying(), g_maxplayers)
		log_to_file("zombieplague.log", logdata)
	}
	
	// Call Plague Mode
	remove_task(TASK_MAKEZOMBIE)
	make_a_zombie(MODE_ARMAGEDDON, 0)
}

// Admin Command. zp_vip
command_vip(id)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %L", LANG_PLAYER, "CMD_VIP")
		case 2: client_print(0, print_chat, "ADMIN %s - %L", g_playername[id], LANG_PLAYER, "CMD_VIP")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %L (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER, "CMD_VIP", fnGetPlaying(), g_maxplayers)
		log_to_file("zombieplague.log", logdata)
	}
	
	// Call VIP mode
	remove_task(TASK_MAKEZOMBIE)
	make_a_zombie(MODE_VIP, 0)
}

// Set proper maxspeed for player
set_player_maxspeed(id)
{
	// If frozen, prevent from moving
	if (g_freezing_duration[id])
	{
		set_pev(id, pev_maxspeed, 1.0)
	}
	// Otherwise, set maxspeed directly
	else
	{
		if (g_zombie[id])
		{
			if (g_nemesis[id])
				set_pev(id, pev_maxspeed, get_pcvar_float(cvar_nemspd))
			else
				set_pev(id, pev_maxspeed, g_zombie_spd[id])
		}
		else
		{
			if (g_survivor[id])
				set_pev(id, pev_maxspeed, get_pcvar_float(cvar_survspd))
			else
				set_pev(id, pev_maxspeed, g_human_spd[id])
		}
	}
}

health_tick(id)
{
	if (!is_user_alive(id) || g_nemesis[id] || g_survivor[id] || g_freezing_duration[id] > 0 || g_burning_duration[id] > 0) return;
	
	static Float:health, Float:maxHealth, Float:regenPerSec
	pev(id, pev_health, health)
	
	if (health <= 0.0) return;
	
	if (g_zombie[id])
	{
		maxHealth = calculate_zhealth(id)
		regenPerSec = 20.0
		
		if (health < maxHealth)
			set_pev(id, pev_health, floatmin(health+regenPerSec, maxHealth))
	}
	else
	{
		maxHealth = float(ArrayGetCell(g_hclass_hp, g_humanclass[id]))
		regenPerSec = 0.2
		
		if (health < maxHealth)
			set_pev(id, pev_health, floatmin(health+regenPerSec, maxHealth))
	}
}

armor_tick(id)
{
	if (!is_user_alive(id)) return;
	
	static Float:armor, Float:maxArmor, Float:regenPerSec
	pev(id, pev_armorvalue, armor)
	
	if (armor <= 0.0) return;
	
	if (!g_zombie[id] && !g_survivor[id])
	{
		maxArmor = calculate_harmor(id)
		regenPerSec = ArrayGetCell(g_hclass_aprgn, g_humanclass[id])
		
		if (armor < maxArmor)
			set_pev(id, pev_armorvalue, floatmin(armor+regenPerSec, maxArmor))
	}
}

Float:calculate_harmor(id)
{
	// Base armor
	static Float:armorF
	armorF = float(ArrayGetCell(g_hclass_ap, g_humanclass[id]))
	
	// Class with no armor
	if (armorF <= 0.0)
		return 0.0;
	
	// Full armor only available to VIPs
	if (!access(id, ADMIN_LEVEL_H))
		armorF /= 2.0
	
	// Flat armor
	if (has_upgrade(id, UPGRADE_HUMAN_FLAT_ARMOR)) armorF += 10.0
	
	// Scaling armor
	if (has_upgrade(id, UPGRADE_HUMAN_SCALING_ARMOR)) armorF += g_level[id]*0.5
	
	return armorF;
}

Float:calculate_hhealth(id)
{
	// Base health
	static Float:healthF
	healthF = float(ArrayGetCell(g_hclass_hp, g_humanclass[id]))
	
	// Flat health
	if (has_upgrade(id, UPGRADE_HUMAN_FLAT_HP)) healthF += 10.0
	
	// Scaling health
	if (has_upgrade(id, UPGRADE_HUMAN_SCALING_HP)) healthF += g_level[id]*0.5
	
	return healthF;
}

Float:calculate_zhealth(id, modifiers = true)
{
	// Base health
	static Float:healthF
	healthF = float(ArrayGetCell(g_zclass_hp, g_zombieclass[id]))
	
	if (modifiers)
	{
		// Percent health
		if (has_upgrade(id, UPGRADE_ZOMBIE_PERCENT_HP)) healthF *= 1.2
	}
	
	return healthF;
}

Float:calculate_maxspeed(id)
{
	// Variables
	static Float:percentModifier
	percentModifier = 1.0
	
	// Extreme Conditioning upgrade?
	if (has_upgrade(id, UPGRADE_HUMAN_XTR_COND))
		percentModifier += 0.03 // increase by 3%
	
	return float(ArrayGetCell(g_hclass_spd, g_humanclass[id]))*percentModifier;
}

has_upgrade(id, const upgrade_id[])
{
	return TrieKeyExists(g_upgrades[id], upgrade_id);
}

give_upgrade(id, const upgrade_id[])
{
	TrieSetCell(g_upgrades[id], upgrade_id, true)
}

/*================================================================================
 [XP Functions]
=================================================================================*/

GetLevelFromXP(xp)
{
	return min(MAX_LEVEL, floatround(XP_MODIFIER + floatsqroot(XP_MODIFIER*XP_MODIFIER + 4.0*XP_MODIFIER*xp), floatround_floor) / (XP_MODIFIER*2));
}

GetXPFromLevel(level)
{
	return XP_MODIFIER*level*level - XP_MODIFIER*level;
}

// Add XP
AddXP(id, amount, reason[], ap = 0)
{
	if (amount == 0)
		return;
	
	// vip boonus
	if (access(id, ADMIN_LEVEL_H))
	{
		amount = floatround(amount*1.5, floatround_ceil)
		ap = floatround(ap*1.5, floatround_ceil)
	}
	
	g_db_xp[id] += amount
	g_ammopacks[id] += ap
	
	// Show message
	set_hudmessage((g_zombie[id] ? HUD_ZOMBIES_RED : HUD_HUMANS_RED), (g_zombie[id] ? HUD_ZOMBIES_GREEN : HUD_HUMANS_GREEN), (g_zombie[id] ? HUD_ZOMBIES_BLUE : HUD_HUMANS_BLUE), HUD_STATS_X, HUD_STATS_Y - 0.02, 0, 6.0, 0.75, 0.0, 0.5, -1)
	ShowSyncHudMsg(id, g_MsgSync, "                   +%d - %s", amount, reason)
	
	// Show chat message
	if (ap)
		zp_colored_print(id, "^1*^3 %s^1:^4 +%dXP^1 &^4 +%dAP", reason, amount, ap)
	else
		zp_colored_print(id, "^1*^3 %s^1:^4 +%dXP", reason, amount)
	
	// Level up?
	static level
	level = GetLevelFromXP(g_db_xp[id])
	
	if (g_level[id] < level)
	{
		// Update level status
		g_level[id] = level
		g_xpneeded[id] = GetXPFromLevel(level+1)
		
		// Play level up sound
		static sound[64]
		ArrayGetString(sound_levelup, random_num(0, ArraySize(sound_levelup) - 1), sound, charsmax(sound))
		PlaySound(id, sound)
		
		// Notify everyone
		zp_colored_print(0, "^x04[ZP]^x01 Congratulations!^4 %s^1 has just achieved level^4 %d^1.", g_playername[id], level)
	}
}

// Initialize
public sql_init()
{
	if (g_sql_tuple != Empty_Handle)
		return;
	
	SQL_SetAffinity("mysql")
	g_sql_tuple = SQL_MakeStdTuple()
}

// Load data
load_data(id)
{
	// Format query
	new query[1024], len
	len += formatex(query[len], charsmax(query)-len, "SELECT `id`, `primary`, `secondary`, `knife`, `offensivegrenade`, `defensivegrenade`, ")
	len += formatex(query[len], charsmax(query)-len, "`tacticalgrenade`, `special`, `ammo`, `zclass`, `hclass`, `xp`, `ammopacks`, `upgrades`, `zombies_killed`, `humans_infected`, `rounds_won` FROM `zm_data` WHERE `auth` = ^"%s^"", g_auth[id])
	
	// Format data
	static data[1]
	data[0] = id
	
	// Query
	SQL_ThreadQuery(g_sql_tuple, "_load_data", query, data, sizeof(data))
}

// Load data query handler
public _load_data(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
	
	static id
	id = data[0]
	
	if (!SQL_NumResults(query))
	{
		g_db_id[id] = 0
		return;
	}
	
	g_db_id[id] = SQL_ReadResult(query, 0)
	
	static i
	for (i = 1; i <= g_maxplayers; i++)
	{
		if (id != i && g_db_id[id] == g_db_id[i] && g_isconnected[id])
		{
			g_db_id[id] = -1
			return;
		}
	}
	
	g_db_primary[id] = SQL_ReadResult(query, 1)
	g_db_secondary[id] = SQL_ReadResult(query, 2)
	g_db_knife[id] = SQL_ReadResult(query, 3)
	g_db_offensivegrenade[id] = SQL_ReadResult(query, 4)
	g_db_defensivegrenade[id] = SQL_ReadResult(query, 5)
	g_db_tacticalgrenade[id] = SQL_ReadResult(query, 6)
	g_db_special[id] = SQL_ReadResult(query, 7)
	g_db_ammo[id] = SQL_ReadResult(query, 8)
	g_zombieclass[id] = min(SQL_ReadResult(query, 9), g_zclass_i-1)
	g_zombieclassnext[id] = min(SQL_ReadResult(query, 9), g_zclass_i-1)
	g_humanclass[id] = min(SQL_ReadResult(query, 10), g_hclass_i-1)
	g_humanclassnext[id] = min(SQL_ReadResult(query, 10), g_hclass_i-1)
	g_db_xp[id] = SQL_ReadResult(query, 11)
	g_ammopacks[id] = SQL_ReadResult(query, 12)
	g_level[id] = GetLevelFromXP(g_db_xp[id])
	g_xpneeded[id] = GetXPFromLevel(min(MAX_LEVEL, g_level[id]+1))
	
	// Parse upgrades
	new upgrades[512], upgradeSZ[8]
	SQL_ReadResult(query, 13, upgrades, charsmax(upgrades))
	
	while ((strtok(upgrades, upgradeSZ, charsmax(upgradeSZ), upgrades, charsmax(upgrades), ',')) > 0)
	{
		if (!upgradeSZ[0]) break;
		TrieSetCell(g_upgrades[id], upgradeSZ, true)
	}
	
	g_db_zombieskilled[id] = SQL_ReadResult(query, 14)
	g_db_humansinfected[id] = SQL_ReadResult(query, 15)
	g_db_roundswon[id] = SQL_ReadResult(query, 16)
}

public task_save_data()
{
	for (new i = 1; i <= g_maxplayers; i++)
	{
		if (is_user_connected(i) && g_db_id[i] != -1)
			save_data(i)
	}
}

// Save data
save_data(id)
{
	// Get data
	new nick[32], ip[16], playtime
	get_user_name(id, nick, charsmax(nick))
	get_user_ip(id, ip, charsmax(ip), 1)
	playtime = 60
	
	// Ammo packs limit
	static aplimit, ap
	aplimit = access(id, ADMIN_LEVEL_H) ? 100 : 50
	ap = g_ammopacks[id]
	
	if (ap > aplimit) ap = aplimit
	
	// Build upgrades
	new upgrades[512], len, upgrade_id[11]
	for (new i; i < g_upgrade_i; i++)
	{
		ArrayGetString(g_upgrade_id, i, upgrade_id, charsmax(upgrade_id))
		if (has_upgrade(id, upgrade_id)) len += formatex(upgrades[len], charsmax(upgrades)-len, "%s,", upgrade_id)
	}
	
	// Format query
	static query[1900]
	len = formatex(query, charsmax(query), "INSERT INTO `zm_data` (`nick`, `auth`, `ip`, `playtime`, `primary`, `secondary`, `knife`, `offensivegrenade`, `defensivegrenade`, ")
	len += formatex(query[len], charsmax(query) - len, "`tacticalgrenade`, `special`, `ammo`, `zclass`, `hclass`, `xp`, `ammopacks`, `upgrades`, `zombies_killed`, `humans_infected`, `rounds_won`) VALUES ")
	len += formatex(query[len], charsmax(query) - len, "(^"%s^", '%s', '%s', %d, %d, %d, %d, %d, ", nick, g_auth[id], ip, playtime, g_db_primary[id], g_db_secondary[id], g_db_knife[id], g_db_offensivegrenade[id])
	len += formatex(query[len], charsmax(query) - len, "%d, %d, %d, %d, %d, %d, %d, %d, '%s', %d, %d, %d) ", g_db_defensivegrenade[id], g_db_tacticalgrenade[id], g_db_special[id], g_db_ammo[id], g_zombieclassnext[id], g_humanclassnext[id], g_db_xp[id], ap, upgrades, g_db_zombieskilled[id], g_db_humansinfected[id], g_db_roundswon[id])
	len += formatex(query[len], charsmax(query) - len, "ON DUPLICATE KEY UPDATE `nick` = ^"%s^", `ip` = '%s', `playtime` = `playtime` + %d, `primary` = %d, `secondary` = %d, ", nick, ip, playtime, g_db_primary[id], g_db_secondary[id])
	len += formatex(query[len], charsmax(query) - len, "`knife` = %d, `offensivegrenade` = %d, `defensivegrenade` = %d, `tacticalgrenade` = %d, ", g_db_knife[id], g_db_offensivegrenade[id], g_db_defensivegrenade[id], g_db_tacticalgrenade[id])
	len += formatex(query[len], charsmax(query) - len, "`special` = %d, `ammo` = %d, `zclass` = %d, `hclass` = %d, `xp` = %d, `ammopacks` = %d, `upgrades` = '%s', ", g_db_special[id], g_db_ammo[id], g_zombieclassnext[id], g_humanclassnext[id], g_db_xp[id], ap, upgrades)
	len += formatex(query[len], charsmax(query) - len, "`zombies_killed` = %d, `humans_infected` = %d, `rounds_won` = %d", g_db_zombieskilled[id], g_db_humansinfected[id], g_db_roundswon[id])
	
	// Query
	SQL_ThreadQuery(g_sql_tuple, "_save_data", query)
}

// Save data query handler
public _save_data(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		log_amx(error)
		return;
	}
}

/*================================================================================
 [Custom Natives]
=================================================================================*/

// Native: zp_get_user_zombie
public native_get_user_zombie(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_zombie[id];
}

// Native: zp_get_user_nemesis
public native_get_user_nemesis(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_nemesis[id];
}

// Native: zp_get_user_survivor
public native_get_user_survivor(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_survivor[id];
}

public native_get_user_first_zombie(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_firstzombie[id];
}

// Native: zp_get_user_last_zombie
public native_get_user_last_zombie(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_lastzombie[id];
}

// Native: zp_get_user_last_human
public native_get_user_last_human(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_lasthuman[id];
}

// Native: zp_get_user_zombie_class
public native_get_user_zombie_class(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_zombieclass[id];
}

// Native: zp_get_user_next_class
public native_get_user_next_class(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_zombieclassnext[id];
}

// Native: zp_set_user_zombie_class
public native_set_user_zombie_class(id, classid)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	if (classid < 0 || classid >= g_zclass_i)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid zombie class id (%d)", classid)
		return false;
	}
	
	g_zombieclassnext[id] = classid
	return true;
}

// Native: zp_get_user_ammo_packs
public native_get_user_ammo_packs(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_ammopacks[id];
}

// Native: zp_set_user_ammo_packs
public native_set_user_ammo_packs(id, amount)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	g_ammopacks[id] = amount;
	return true;
}

// Native: zp_get_zombie_maxhealth
public native_get_zombie_maxhealth(id)
{
	// ZP disabled
	if (!g_pluginenabled)
		return -1;
	
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	if (!g_zombie[id] || g_nemesis[id])
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Player not a normal zombie (%d)", id)
		return -1;
	}
	
	if (g_firstzombie[id])
		return floatround(float(ArrayGetCell(g_zclass_hp, g_zombieclass[id])) * get_pcvar_float(cvar_zombiefirsthp));
	
	return ArrayGetCell(g_zclass_hp, g_zombieclass[id]);
}

// Native: zp_get_user_batteries
public native_get_user_batteries(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_flashbattery[id];
}

// Native: zp_set_user_batteries
public native_set_user_batteries(id, value)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	if (!is_user_valid_connected(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	g_flashbattery[id] = clamp(value, 0, 100);
	
	if (g_cached_customflash)
	{
		// Set the flashlight charge task to update battery status
		remove_task(id+TASK_CHARGE)
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b")
	}
	return true;
}

// Native: zp_get_user_nightvision
public native_get_user_nightvision(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_nvision[id];
}

// Native: zp_set_user_nightvision
public native_set_user_nightvision(id, set)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	if (!is_user_valid_connected(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	if (set)
	{
		g_nvision[id] = true
		
		if (!g_isbot[id])
		{
			g_nvisionenabled[id] = true
			set_user_gnvision(id, 1)
		}
		else
			cs_set_user_nvg(id, 1)
	}
	else
	{
		// Remove CS nightvision if player owns one (bugfix)
		cs_set_user_nvg(id, 0)
		
		if (g_nvisionenabled[id]) set_user_gnvision(id, 0)
		g_nvision[id] = false
		g_nvisionenabled[id] = false
	}
	return true;
}

// Native: zp_infect_user
public native_infect_user(id, infector, silent, rewards)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	if (!is_user_valid_alive(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	// Not allowed to be zombie
	if (!allowed_zombie(id))
		return false;
	
	// New round?
	if (g_newround)
	{
		// Set as first zombie
		remove_task(TASK_MAKEZOMBIE)
		make_a_zombie(MODE_INFECTION, id)
	}
	else
	{
		// Just infect (plus some checks)
		zombieme(id, is_user_valid_alive(infector) ? infector : 0, 0, (silent == 1) ? 1 : 0, (rewards == 1) ? 1 : 0)
	}
	return true;
}

// Native: zp_disinfect_user
public native_disinfect_user(id, silent)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	if (!is_user_valid_alive(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	// Not allowed to be human
	if (!allowed_human(id))
		return false;
	
	// Turn to human
	humanme(id, 0, (silent == 1) ? 1 : 0)
	return true;
}

// Native: zp_make_user_nemesis
public native_make_user_nemesis(id)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	if (!is_user_valid_alive(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	// Not allowed to be nemesis
	if (!allowed_nemesis(id))
		return false;
	
	// New round?
	if (g_newround)
	{
		// Set as first nemesis
		remove_task(TASK_MAKEZOMBIE)
		make_a_zombie(MODE_NEMESIS, id)
	}
	else
	{
		// Turn player into a Nemesis
		zombieme(id, 0, 1, 0, 0)
	}
	return true;
}

// Native: zp_make_user_survivor
public native_make_user_survivor(id)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	if (!is_user_valid_alive(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	// Not allowed to be survivor
	if (!allowed_survivor(id))
		return false;
	
	// New round?
	if (g_newround)
	{
		// Set as first survivor
		remove_task(TASK_MAKEZOMBIE)
		make_a_zombie(MODE_SURVIVOR, id)
	}
	else
	{
		// Turn player into a Survivor
		humanme(id, 1, 0)
	}
	
	return true;
}

// Native: zp_respawn_user
public native_respawn_user(id, team)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	if (!is_user_valid_connected(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	// Respawn not allowed
	if (!allowed_respawn(id))
		return false;
	
	// Respawn as zombie?
	g_respawn_as_zombie[id] = (team == ZP_TEAM_ZOMBIE) ? true : false
	
	// Respawnish!
	respawn_player_manually(id)
	return true;
}

// Native: zp_force_buy_extra_item
public native_force_buy_extra_item(id, itemid, ignorecost)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	if (!is_user_valid_alive(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	if (itemid < 0 || itemid >= g_extraitem_i)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid extra item id (%d)", itemid)
		return false;
	}
	
	buy_extra_item(id, itemid, ignorecost)
	return true;
}

// Native: zp_override_user_model
public native_override_user_model(id, const newmodel[], modelindex)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	if (!is_user_valid_connected(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	// Strings passed byref
	param_convert(2)
	
	// Remove previous tasks
	remove_task(id+TASK_MODEL)
	
	// Custom models stuff
	static currentmodel[32]
	
	if (g_handle_models_on_separate_ent)
	{
		// Set the right model
		copy(g_playermodel[id], charsmax(g_playermodel[]), newmodel)
		if (g_set_modelindex_offset && modelindex) fm_cs_set_user_model_index(id, modelindex)
		
		// Set model on player model entity
		fm_set_playermodel_ent(id)
	}
	else
	{
		// Get current model for comparing it with the current one
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// Set the right model, after checking that we don't already have it
		if (!equal(currentmodel, newmodel))
		{
			copy(g_playermodel[id], charsmax(g_playermodel[]), newmodel)
			if (g_set_modelindex_offset && modelindex) fm_cs_set_user_model_index(id, modelindex)
			
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if (g_newround)
				set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else
				fm_user_model_update(id+TASK_MODEL)
		}
	}
	return true;
}

// Native: zp_has_round_started
public native_has_round_started()
{
	if (g_newround) return 0; // not started
	if (g_modestarted) return 1; // started
	return 2; // starting
}

// Native: zp_is_nemesis_round
public native_is_nemesis_round()
{
	return g_nemround;
}

// Native: zp_is_survivor_round
public native_is_survivor_round()
{
	return g_survround;
}

// Native: zp_is_swarm_round
public native_is_swarm_round()
{
	return g_swarmround;
}

// Native: zp_is_plague_round
public native_is_plague_round()
{
	return g_plagueround;
}

// Native: zp_get_zombie_count
public native_get_zombie_count()
{
	return fnGetZombies();
}

// Native: zp_get_human_count
public native_get_human_count()
{
	return fnGetHumans();
}

// Native: zp_get_nemesis_count
public native_get_nemesis_count()
{
	return fnGetNemesis();
}

// Native: zp_get_survivor_count
public native_get_survivor_count()
{
	return fnGetSurvivors();
}

// Native: zp_register_extra_item
public native_register_extra_item(const name[], cost, team)
{
	// ZP disabled
	if (!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	
	// Arrays not yet initialized
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register extra item yet (%s)", name)
		return -1;
	}
	
	if (strlen(name) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register extra item with an empty name")
		return -1;
	}
	
	new index, extraitem_name[32]
	for (index = 0; index < g_extraitem_i; index++)
	{
		ArrayGetString(g_extraitem_name, index, extraitem_name, charsmax(extraitem_name))
		if (equali(name, extraitem_name))
		{
			log_error(AMX_ERR_NATIVE, "[ZP] Extra item already registered (%s)", name)
			return -1;
		}
	}
	
	// For backwards compatibility
	if (team == ZP_TEAM_ANY)
		team = (ZP_TEAM_ZOMBIE|ZP_TEAM_HUMAN)
	
	// Add the item
	ArrayPushString(g_extraitem_name, name)
	ArrayPushCell(g_extraitem_cost, cost)
	ArrayPushCell(g_extraitem_team, team)
	
	// Set temporary new item flag
	ArrayPushCell(g_extraitem_new, 1)
	
	// Override extra items data with our customizations
	new i, buffer[32], size = ArraySize(g_extraitem2_realname)
	for (i = 0; i < size; i++)
	{
		ArrayGetString(g_extraitem2_realname, i, buffer, charsmax(buffer))
		
		// Check if this is the intended item to override
		if (!equal(name, buffer))
			continue;
		
		// Remove new item flag
		ArraySetCell(g_extraitem_new, g_extraitem_i, 0)
		
		// Replace caption
		ArrayGetString(g_extraitem2_name, i, buffer, charsmax(buffer))
		ArraySetString(g_extraitem_name, g_extraitem_i, buffer)
		
		// Replace cost
		buffer[0] = ArrayGetCell(g_extraitem2_cost, i)
		ArraySetCell(g_extraitem_cost, g_extraitem_i, buffer[0])
		
		// Replace team
		buffer[0] = ArrayGetCell(g_extraitem2_team, i)
		ArraySetCell(g_extraitem_team, g_extraitem_i, buffer[0])
	}
	
	// Increase registered items counter
	g_extraitem_i++
	
	// Return id under which we registered the item
	return g_extraitem_i-1;
}

// Function: zp_register_extra_item (to be used within this plugin only)
native_register_extra_item2(const name[], cost, team)
{
	// Add the item
	ArrayPushString(g_extraitem_name, name)
	ArrayPushCell(g_extraitem_cost, cost)
	ArrayPushCell(g_extraitem_team, team)
	
	// Set temporary new item flag
	ArrayPushCell(g_extraitem_new, 1)
	
	// Increase registered items counter
	g_extraitem_i++
}

// Native: zp_register_zombie_class
public native_register_zombie_class(const name[], const info[], const model[], const clawmodel[], hp, speed, Float:gravity, Float:knockback, level, Float:armor, Float:slash_dmg, Float:stab_dmg)
{
	// ZP disabled
	if (!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	param_convert(2)
	param_convert(3)
	param_convert(4)
	
	// Arrays not yet initialized
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register zombie class yet (%s)", name)
		return -1;
	}
	
	if (strlen(name) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register zombie class with an empty name")
		return -1;
	}
	
	new index, zombieclass_name[32]
	for (index = 0; index < g_zclass_i; index++)
	{
		ArrayGetString(g_zclass_name, index, zombieclass_name, charsmax(zombieclass_name))
		if (equali(name, zombieclass_name))
		{
			log_error(AMX_ERR_NATIVE, "[ZP] Zombie class already registered (%s)", name)
			return -1;
		}
	}
	
	// Add the class
	ArrayPushString(g_zclass_name, name)
	ArrayPushString(g_zclass_info, info)
	
	ArrayPushCell(g_zclass_modelsstart, ArraySize(g_zclass_playermodel))
	ArrayPushString(g_zclass_playermodel, model)
	ArrayPushCell(g_zclass_modelsend, ArraySize(g_zclass_playermodel))
	ArrayPushCell(g_zclass_modelindex, -1)
	
	ArrayPushString(g_zclass_clawmodel, clawmodel)
	ArrayPushCell(g_zclass_hp, hp)
	ArrayPushCell(g_zclass_spd, speed)
	ArrayPushCell(g_zclass_grav, gravity)
	ArrayPushCell(g_zclass_kb, knockback)
	ArrayPushCell(g_zclass_lvl, level)
	ArrayPushCell(g_zclass_armor, armor)
	ArrayPushCell(g_zclass_slashdmg, slash_dmg)
	ArrayPushCell(g_zclass_stabdmg, stab_dmg)
	
	new prec_mdl[100]
	// Precache default class model and replace modelindex with the real one
	formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%s.mdl", model, model)
	ArraySetCell(g_zclass_modelindex, ArrayGetCell(g_zclass_modelsstart, g_zclass_i), engfunc(EngFunc_PrecacheModel, prec_mdl))
	if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, prec_mdl)
	if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, prec_mdl)
	// Precache modelT.mdl files too
	copy(prec_mdl[strlen(prec_mdl)-4], charsmax(prec_mdl) - (strlen(prec_mdl)-4), "T.mdl")
	if (file_exists(prec_mdl)) engfunc(EngFunc_PrecacheModel, prec_mdl)

	// Precache default clawmodel
	engfunc(EngFunc_PrecacheModel, clawmodel)
	
	// Increase registered classes counter
	g_zclass_i++
	
	// Return id under which we registered the class
	return g_zclass_i-1;
}

// Native: zp_register_human_class
public native_register_human_class(const name[], const info[], const model[], hp, speed, Float:gravity, lvl, ap, Float:ap_regen)
{
	// ZP disabled
	if (!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	param_convert(2)
	param_convert(3)
	
	// Arrays not yet initialized
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register human class yet (%s)", name)
		return -1;
	}
	
	if (strlen(name) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register human class with an empty name")
		return -1;
	}
	
	new index, humanclass_name[32]
	for (index = 0; index < g_hclass_i; index++)
	{
		ArrayGetString(g_hclass_name, index, humanclass_name, charsmax(humanclass_name))
		if (equali(name, humanclass_name))
		{
			log_error(AMX_ERR_NATIVE, "[ZP] Human class already registered (%s)", name)
			return -1;
		}
	}
	
	// Add the class
	ArrayPushString(g_hclass_name, name)
	ArrayPushString(g_hclass_info, info)
	
	ArrayPushCell(g_hclass_modelsstart, ArraySize(g_hclass_playermodel))
	ArrayPushString(g_hclass_playermodel, model)
	ArrayPushCell(g_hclass_modelsend, ArraySize(g_hclass_playermodel))
	ArrayPushCell(g_hclass_modelindex, -1)
	
	ArrayPushCell(g_hclass_hp, hp)
	ArrayPushCell(g_hclass_spd, speed)
	ArrayPushCell(g_hclass_grav, gravity)
	ArrayPushCell(g_hclass_lvl, lvl)
	ArrayPushCell(g_hclass_ap, ap)
	ArrayPushCell(g_hclass_aprgn, ap_regen)
	
	// Precache default class model and replace modelindex with the real one
	new prec_mdl[100]
	formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%s.mdl", model, model)
	ArraySetCell(g_hclass_modelindex, ArrayGetCell(g_hclass_modelsstart, g_hclass_i), engfunc(EngFunc_PrecacheModel, prec_mdl))
	if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, prec_mdl)
	if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, prec_mdl)
	// Precache modelT.mdl files too
	copy(prec_mdl[strlen(prec_mdl)-4], charsmax(prec_mdl) - (strlen(prec_mdl)-4), "T.mdl")
	if (file_exists(prec_mdl)) engfunc(EngFunc_PrecacheModel, prec_mdl)
	
	// Increase registered classes counter
	g_hclass_i++
	
	// Return id under which we registered the class
	return g_hclass_i-1;
}

// Native: zp_get_user_human_class
public native_get_user_human_class(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_humanclass[id];
}

// Native: zp_register_knife
public native_register_knife(const name[], const vmodel[], const pmodel[], lvl, Float:distance_slash, Float:distance_stab)
{
	// ZP disabled
	if (!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	param_convert(2)
	param_convert(3)
	
	// Arrays not yet initialized
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register knife item yet (%s)", name)
		return -1;
	}
	
	if (strlen(name) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register knife with an empty name")
		return -1;
	}
	
	new index, knife_name[32]
	for (index = 0; index < g_knife_i; index++)
	{
		ArrayGetString(g_knife_name, index, knife_name, charsmax(knife_name))
		if (equali(name, knife_name))
		{
			log_error(AMX_ERR_NATIVE, "[ZP] Knife already registered (%s)", name)
			return -1;
		}
	}
	
	// Precache models
	engfunc(EngFunc_PrecacheModel, vmodel)
	engfunc(EngFunc_PrecacheModel, pmodel)
	
	// Add the item
	ArrayPushString(g_knife_name, name)
	ArrayPushString(g_knife_vmodel, vmodel)
	ArrayPushString(g_knife_pmodel, pmodel)
	ArrayPushCell(g_knife_lvl, lvl)
	ArrayPushCell(g_knife_slash, distance_slash)
	ArrayPushCell(g_knife_stab, distance_stab)
	
	// Increase counter
	g_knife_i++
	
	// Return id under which we registered the item
	return g_knife_i-1;
}

// Native: zp_register_knife
public native_register_special(const name[], lvl)
{
	// ZP disabled
	if (!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	
	// Arrays not yet initialized
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register special item yet (%s)", name)
		return -1;
	}
	
	if (strlen(name) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register special with an empty name")
		return -1;
	}
	
	new index, special_name[32]
	for (index = 0; index < g_special_i; index++)
	{
		ArrayGetString(g_special_name, index, special_name, charsmax(special_name))
		if (equali(name, special_name))
		{
			log_error(AMX_ERR_NATIVE, "[ZP] Special already registered (%s)", name)
			return -1;
		}
	}
	
	// Add the item
	ArrayPushString(g_special_name, name)
	ArrayPushCell(g_special_lvl, lvl)
	
	// Increase counter
	g_special_i++
	
	// Return id under which we registered the item
	return g_special_i-1;
}

public native_get_user_knife(id)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1;
	}
	
	return g_knife[id];
}

// Native: zp_register_upgrade
public native_register_upgrade(const name[], const desc[], cost, lvl, const team[], const id[], avail)
{
	// ZP disabled
	if (!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	param_convert(2)
	param_convert(5)
	param_convert(6)
	
	// Arrays not yet initialized
	if (!g_arrays_created)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register upgrade yet (%s)", name)
		return -1;
	}
	
	if (strlen(name) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register upgrade with an empty name")
		return -1;
	}
	
	new index, upgrade_id[11]
	for (index = 0; index < g_upgrade_i; index++)
	{
		ArrayGetString(g_upgrade_id, index, upgrade_id, charsmax(upgrade_id))
		if (equali(id, upgrade_id))
		{
			log_error(AMX_ERR_NATIVE, "[ZP] Upgrade already registered (%s)", id)
			return -1;
		}
	}
	
	// Add the upgrade
	ArrayPushString(g_upgrade_name, name)
	ArrayPushString(g_upgrade_desc, desc)
	ArrayPushCell(g_upgrade_cost, cost)
	ArrayPushCell(g_upgrade_lvl, lvl)
	ArrayPushString(g_upgrade_team, team)
	ArrayPushString(g_upgrade_id, id)
	ArrayPushCell(g_upgrade_avail, avail)
	
	// Increase counter
	g_upgrade_i++
	
	return 1;
}

public native_user_has_upgrade(id, const upgradeid[])
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return 0;
	}
	
	// Strings passed byref
	param_convert(2)
	
	return TrieKeyExists(g_upgrades[id], upgradeid);
}

// Native: zp_get_extra_item_id
public native_get_extra_item_id(const name[])
{
	// ZP disabled
	if (!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	
	// Loop through every item (not using Tries since ZP should work on AMXX 1.8.0)
	static i, item_name[32]
	for (i = 0; i < g_extraitem_i; i++)
	{
		ArrayGetString(g_extraitem_name, i, item_name, charsmax(item_name))
		
		// Check if this is the item to retrieve
		if (equali(name, item_name))
			return i;
	}
	
	return -1;
}

// Native: zp_get_zombie_class_id
public native_get_zombie_class_id(const name[])
{
	// ZP disabled
	if (!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	
	// Loop through every class (not using Tries since ZP should work on AMXX 1.8.0)
	static i, class_name[32]
	for (i = 0; i < g_zclass_i; i++)
	{
		ArrayGetString(g_zclass_name, i, class_name, charsmax(class_name))
		
		// Check if this is the class to retrieve
		if (equali(name, class_name))
			return i;
	}
	
	return -1;
}

// Native: zp_get_zombie_class_info
public native_get_zombie_class_info(classid, info[], len)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	// Invalid class
	if (classid < 0 || classid >= g_zclass_i)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid zombie class id (%d)", classid)
		return false;
	}
	
	// Strings passed byref
	param_convert(2)
	
	// Fetch zombie class info
	ArrayGetString(g_zclass_info, classid, info, len)
	return true;
}

// Native: zp_takedamage
public native_takedamage(id, attacker, weaponname[], Float:damage, damagetype, gib)
{
	// Strings passed byref
	param_convert(3)
	
	TakeDamage(id, attacker, weaponname, damage, damagetype, gib)
	return true;
}

// Native: zp_get_user_frozen
public native_get_user_frozen(id)
{
	if (!is_user_valid_connected(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	return (g_freezing_duration[id] > 0);
}

// Native: zp_calculate_zhealth
public Float:native_calculate_zhealth(id, modifiers)
{
	if (!is_user_valid_connected(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return -1.0;
	}
	
	return calculate_zhealth(id, modifiers);
}

// Native: zp_add_xp
public native_add_xp(id, amount, info[], ap)
{
	if (!is_user_valid(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	// Strings passed byref
	param_convert(3)
	
	AddXP(id, amount, info, ap)
	return true;
}

/*================================================================================
 [Custom Messages]
=================================================================================*/

// Game Nightvision
set_user_gnvision(id, toggle)
{
	set_lighting(id, (toggle ? g_cached_lightingzombies : g_cached_lighting))
}

// Custom Flashlight
public set_user_flashlight(taskid)
{
	// Get player and aiming origins
	static Float:originF[3], Float:destoriginF[3]
	pev(ID_FLASH, pev_origin, originF)
	fm_get_aim_origin(ID_FLASH, destoriginF)
	
	// Max distance check
	if (get_distance_f(originF, destoriginF) > get_pcvar_float(cvar_flashdist))
		return;
	
	// Send to all players?
	if (get_pcvar_num(cvar_flashshowall))
		engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, destoriginF, 0)
	else
		message_begin(MSG_ONE_UNRELIABLE, SVC_TEMPENTITY, _, ID_FLASH)
	
	// Flashlight
	write_byte(TE_DLIGHT) // TE id
	engfunc(EngFunc_WriteCoord, destoriginF[0]) // x
	engfunc(EngFunc_WriteCoord, destoriginF[1]) // y
	engfunc(EngFunc_WriteCoord, destoriginF[2]) // z
	write_byte(get_pcvar_num(cvar_flashsize)) // radius
	write_byte(get_pcvar_num(cvar_flashcolor[0])) // r
	write_byte(get_pcvar_num(cvar_flashcolor[1])) // g
	write_byte(get_pcvar_num(cvar_flashcolor[2])) // b
	write_byte(3) // life
	write_byte(0) // decay rate
	message_end()
}

// Infection special effects
infection_effects(id)
{
	// Screen fade? (unless frozen)
	if (!g_freezing_duration[id] && get_pcvar_num(cvar_infectionscreenfade))
	{
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenFade, _, id)
		write_short(UNIT_SECOND) // duration
		write_short(0) // hold time
		write_short(FFADE_IN) // fade type
		if (g_nemesis[id])
		{
			write_byte(150) // r
			write_byte(0) // g
			write_byte(0) // b
		}
		else
		{
			write_byte(0) // r
			write_byte(150) // g
			write_byte(0) // b
		}
		write_byte (255) // alpha
		message_end()
	}
	
	// Screen shake?
	if (get_pcvar_num(cvar_infectionscreenshake))
	{
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, id)
		write_short(UNIT_SECOND*4) // amplitude
		write_short(UNIT_SECOND*2) // duration
		write_short(UNIT_SECOND*10) // frequency
		message_end()
	}
	
	// Infection icon?
	if (get_pcvar_num(cvar_hudicons))
	{
		message_begin(MSG_ONE_UNRELIABLE, g_msgDamage, _, id)
		write_byte(0) // damage save
		write_byte(0) // damage take
		write_long(DMG_NERVEGAS) // damage type - DMG_RADIATION
		write_coord(0) // x
		write_coord(0) // y
		write_coord(0) // z
		message_end()
	}
	
	// Get player's origin
	static origin[3]
	get_user_origin(id, origin)
	
	// Tracers?
	if (get_pcvar_num(cvar_infectiontracers))
	{
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_IMPLOSION) // TE id
		write_coord(origin[0]) // x
		write_coord(origin[1]) // y
		write_coord(origin[2]) // z
		write_byte(128) // radius
		write_byte(20) // count
		write_byte(3) // duration
		message_end()
	}
	
	// Particle burst?
	if (get_pcvar_num(cvar_infectionparticles))
	{
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_PARTICLEBURST) // TE id
		write_coord(origin[0]) // x
		write_coord(origin[1]) // y
		write_coord(origin[2]) // z
		write_short(50) // radius
		write_byte(70) // color
		write_byte(3) // duration (will be randomized a bit)
		message_end()
	}
	
	// Light sparkle?
	if (get_pcvar_num(cvar_infectionsparkle))
	{
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_DLIGHT) // TE id
		write_coord(origin[0]) // x
		write_coord(origin[1]) // y
		write_coord(origin[2]) // z
		write_byte(20) // radius
		write_byte(0) // r
		write_byte(150) // g
		write_byte(0) // b
		write_byte(2) // life
		write_byte(0) // decay rate
		message_end()
	}
}

// Nemesis/madness aura task
public zombie_aura(taskid)
{
	// Not nemesis, not in zombie madness
	if (!g_nemesis[ID_AURA] && !g_nodamage[ID_AURA])
	{
		// Task not needed anymore
		remove_task(taskid);
		return;
	}
	
	// Get player's origin
	static origin[3]
	get_user_origin(ID_AURA, origin)
	
	// Colored Aura
	message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
	write_byte(TE_DLIGHT) // TE id
	write_coord(origin[0]) // x
	write_coord(origin[1]) // y
	write_coord(origin[2]) // z
	write_byte(20) // radius
	write_byte(150) // r
	write_byte(0) // g
	write_byte(0) // b
	write_byte(2) // life
	write_byte(0) // decay rate
	message_end()
}

// Make zombies leave footsteps and bloodstains on the floor
public make_blood(taskid)
{
	// Only bleed when moving on ground
	if (!(pev(ID_BLOOD, pev_flags) & FL_ONGROUND) || fm_get_speed(ID_BLOOD) < 80)
		return;
	
	// Get user origin
	static Float:originF[3]
	pev(ID_BLOOD, pev_origin, originF)
	
	// If ducking set a little lower
	if (pev(ID_BLOOD, pev_bInDuck))
		originF[2] -= 18.0
	else
		originF[2] -= 36.0
	
	// Send the decal message
	engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_WORLDDECAL) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	write_byte(ArrayGetCell(zombie_decals, random_num(0, ArraySize(zombie_decals) - 1)) + (g_czero * 12)) // random decal number (offsets +12 for CZ)
	message_end()
}

// Flare Lighting Effects
flare_lighting(entity, duration)
{
	// Get origin and color
	static Float:originF[3], color[3]
	pev(entity, pev_origin, originF)
	pev(entity, PEV_FLARE_COLOR, color)
	
	// Lighting
	engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_DLIGHT) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	write_byte(get_pcvar_num(cvar_flaresize)) // radius
	write_byte(color[0]) // r
	write_byte(color[1]) // g
	write_byte(color[2]) // b
	write_byte(21) //life
	write_byte((duration < 2) ? 3 : 0) //decay rate
	message_end()
	
	// Sparks
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_SPARKS) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	message_end()
}

// Burning Flames
public burning_flame(params[1], taskid)
{
	// Get player origin and flags
	static origin[3], flags
	get_user_origin(ID_BURN, origin)
	flags = pev(ID_BURN, pev_flags)
	
	// Madness mode - in water - frozen - burning stopped
	if (g_nodamage[ID_BURN] || (flags & FL_INWATER) || g_freezing_duration[ID_BURN] || g_burning_duration[ID_BURN] < 1)
	{
		// Smoke sprite
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_SMOKE) // TE id
		write_coord(origin[0]) // x
		write_coord(origin[1]) // y
		write_coord(origin[2]-50) // z
		write_short(g_smokeSpr) // sprite
		write_byte(random_num(15, 20)) // scale
		write_byte(random_num(10, 20)) // framerate
		message_end()
		
		// Task not needed anymore
		remove_task(taskid);
		return;
	}
	
	// Randomly play burning zombie scream sounds (not for nemesis)
	if (!g_nemesis[ID_BURN] && !random_num(0, 20))
	{
		static sound[64]
		ArrayGetString(grenade_fire_player, random_num(0, ArraySize(grenade_fire_player) - 1), sound, charsmax(sound))
		emit_sound(ID_BURN, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	
	// Fire slow down, unless nemesis
	if (!g_nemesis[ID_BURN] && (flags & FL_ONGROUND) && get_pcvar_float(cvar_fireslowdown) > 0.0)
	{
		static Float:velocity[3]
		pev(ID_BURN, pev_velocity, velocity)
		xs_vec_mul_scalar(velocity, get_pcvar_float(cvar_fireslowdown), velocity)
		set_pev(ID_BURN, pev_velocity, velocity)
	}
	
	// Take damage from the fire
	TakeDamage(ID_BURN, params[0], "fire", get_pcvar_float(cvar_firedamage), DMG_BURN)
	
	// Flame sprite
	message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
	write_byte(TE_SPRITE) // TE id
	write_coord(origin[0]+random_num(-5, 5)) // x
	write_coord(origin[1]+random_num(-5, 5)) // y
	write_coord(origin[2]+random_num(-10, 10)) // z
	write_short(g_flameSpr) // sprite
	write_byte(random_num(5, 10)) // scale
	write_byte(200) // brightness
	message_end()
	
	// Decrease burning duration counter
	g_burning_duration[ID_BURN]--
}

// Infection Bomb: Green Blast
create_blast(const Float:originF[3])
{
	// Smallest ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+385.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(0) // red
	write_byte(200) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Medium ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+470.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(0) // red
	write_byte(200) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Largest ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+555.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(0) // red
	write_byte(200) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
}

// Fire Grenade: Fire Blast
create_blast2(const Float:originF[3])
{
	// Smallest ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+385.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(200) // red
	write_byte(100) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Medium ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+470.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(200) // red
	write_byte(50) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Largest ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+555.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(200) // red
	write_byte(0) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
}

// Frost Grenade: Freeze Blast
create_blast3(const Float:originF[3])
{
	// Smallest ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+385.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(0) // red
	write_byte(100) // green
	write_byte(200) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Medium ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+470.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(0) // red
	write_byte(100) // green
	write_byte(200) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Largest ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+555.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(0) // red
	write_byte(100) // green
	write_byte(200) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
}

// HE Grenade: Explosive Blast
create_blast4(Float:originF[3])
{
	// create effect exp
	engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_EXPLOSION)
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	write_short(cache_nade) // sprites
	write_byte(15) // scale in 0.1's
	write_byte(30) // framerate
	write_byte(TE_EXPLFLAG_NONE) // flags
	message_end() // message end
	
	// Smoke
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_SMOKE)
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	write_short(cache_smoke)
	write_byte(15)
	write_byte(5)
	message_end()
}

// Knockback Bomb: Orange Blast
create_blast7(const Float:originF[3])
{
	// Smallest ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+385.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(204) // red
	write_byte(204) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Medium ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+470.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(204) // red
	write_byte(204) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Largest ring
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+555.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(204) // red
	write_byte(204) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
}

// Fix Dead Attrib on scoreboard
FixDeadAttrib(id)
{
	message_begin(MSG_BROADCAST, g_msgScoreAttrib)
	write_byte(id) // id
	write_byte(0) // attrib
	message_end()
}

// Send Death Message for infections
SendDeathMsg(attacker, victim)
{
	message_begin(MSG_BROADCAST, g_msgDeathMsg)
	write_byte(attacker) // killer
	write_byte(victim) // victim
	write_byte(1) // headshot flag
	write_string("infection") // killer's weapon
	message_end()
}

// Update Player Frags and Deaths
UpdateFrags(attacker, victim, frags, deaths, scoreboard)
{
	// Set attacker frags
	set_pev(attacker, pev_frags, float(pev(attacker, pev_frags) + frags))
	
	// Set victim deaths
	fm_cs_set_user_deaths(victim, cs_get_user_deaths(victim) + deaths)
	
	// Update scoreboard with attacker and victim info
	if (scoreboard)
	{
		message_begin(MSG_BROADCAST, g_msgScoreInfo)
		write_byte(attacker) // id
		write_short(pev(attacker, pev_frags)) // frags
		write_short(cs_get_user_deaths(attacker)) // deaths
		write_short(0) // class?
		write_short(fm_cs_get_user_team(attacker)) // team
		message_end()
		
		message_begin(MSG_BROADCAST, g_msgScoreInfo)
		write_byte(victim) // id
		write_short(pev(victim, pev_frags)) // frags
		write_short(cs_get_user_deaths(victim)) // deaths
		write_short(0) // class?
		write_short(fm_cs_get_user_team(victim)) // team
		message_end()
	}
}

// Remove Player Frags (when Nemesis/Survivor ignore_frags cvar is enabled)
RemoveFrags(attacker, victim)
{
	// Remove attacker frags
	set_pev(attacker, pev_frags, float(pev(attacker, pev_frags) - 1))
	
	// Remove victim deaths
	fm_cs_set_user_deaths(victim, cs_get_user_deaths(victim) - 1)
}

// Plays a sound on all clients
PlayGlobalSound(const sound[])
{
	if (equal(sound[strlen(sound)-4], ".mp3"))
		client_cmd(0, "mp3 play ^"sound/%s^"", sound)
	else
		client_cmd(0, "spk ^"%s^"", sound)
}

// Plays a sound on a client
PlaySound(id, const sound[])
{
	if (equal(sound[strlen(sound)-4], ".mp3"))
		client_cmd(id, "mp3 play ^"sound/%s^"", sound)
	else
		client_cmd(id, "spk ^"%s^"", sound)
}

// Stops played sound on a client
StopSound(id)
{
	client_cmd(id, "mp3 stop; stopsound;")
}

// Prints a colored message to target (use 0 for everyone), supports ML formatting.
// Note: I still need to make something like gungame's LANG_PLAYER_C to avoid unintended
// argument replacement when a function passes -1 (it will be considered a LANG_PLAYER)
zp_colored_print(target, const message[], any:...)
{
	static buffer[512], i, argscount
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
			static changed[5], changedcount // [5] = max LANG_PLAYER occurencies
			changedcount = 0
			
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
	// Send to specific target
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

/*================================================================================
 [Stocks]
=================================================================================*/

// Set an entity's key value (from fakemeta_util)
stock fm_set_kvd(entity, const key[], const value[], const classname[])
{
	set_kvd(0, KV_ClassName, classname)
	set_kvd(0, KV_KeyName, key)
	set_kvd(0, KV_Value, value)
	set_kvd(0, KV_fHandled, 0)

	dllfunc(DLLFunc_KeyValue, entity, 0)
}

// Set entity's rendering type (from fakemeta_util)
stock fm_set_rendering(entity, fx = kRenderFxNone, r = 255, g = 255, b = 255, render = kRenderNormal, amount = 16)
{
	static Float:color[3]
	color[0] = float(r)
	color[1] = float(g)
	color[2] = float(b)
	
	set_pev(entity, pev_renderfx, fx)
	set_pev(entity, pev_rendercolor, color)
	set_pev(entity, pev_rendermode, render)
	set_pev(entity, pev_renderamt, float(amount))
}

// Get entity's speed (from fakemeta_util)
stock fm_get_speed(entity)
{
	static Float:velocity[3]
	pev(entity, pev_velocity, velocity)
	
	return floatround(vector_length(velocity));
}

// Get entity's aim origins (from fakemeta_util)
stock fm_get_aim_origin(id, Float:origin[3])
{
	static Float:origin1F[3], Float:origin2F[3]
	pev(id, pev_origin, origin1F)
	pev(id, pev_view_ofs, origin2F)
	xs_vec_add(origin1F, origin2F, origin1F)

	pev(id, pev_v_angle, origin2F);
	engfunc(EngFunc_MakeVectors, origin2F)
	global_get(glb_v_forward, origin2F)
	xs_vec_mul_scalar(origin2F, 9999.0, origin2F)
	xs_vec_add(origin1F, origin2F, origin2F)

	engfunc(EngFunc_TraceLine, origin1F, origin2F, 0, id, 0)
	get_tr2(0, TR_vecEndPos, origin)
}

// Find entity by its owner (from fakemeta_util)
stock fm_find_ent_by_owner(entity, const classname[], owner)
{
	while ((entity = engfunc(EngFunc_FindEntityByString, entity, "classname", classname)) && pev(entity, pev_owner) != owner) { /* keep looping */ }
	return entity;
}

// Set player's health (from fakemeta_util)
stock fm_set_user_health(id, health)
{
	(health > 0) ? set_pev(id, pev_health, float(health)) : dllfunc(DLLFunc_ClientKill, id);
}

// Give an item to a player (from fakemeta_util)
stock fm_give_item(id, const item[])
{
	static ent
	ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, item))
	if (!pev_valid(ent)) return;
	
	static Float:originF[3]
	pev(id, pev_origin, originF)
	set_pev(ent, pev_origin, originF)
	set_pev(ent, pev_spawnflags, pev(ent, pev_spawnflags) | SF_NORESPAWN)
	dllfunc(DLLFunc_Spawn, ent)
	
	static save
	save = pev(ent, pev_solid)
	dllfunc(DLLFunc_Touch, ent, id)
	if (pev(ent, pev_solid) != save)
		return;
	
	engfunc(EngFunc_RemoveEntity, ent)
}

// Strip user weapons (from fakemeta_util)
stock fm_strip_user_weapons(id)
{
	static ent
	ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "player_weaponstrip"))
	if (!pev_valid(ent)) return;
	
	dllfunc(DLLFunc_Spawn, ent)
	dllfunc(DLLFunc_Use, ent, id)
	engfunc(EngFunc_RemoveEntity, ent)
}

// Collect random spawn points
stock load_spawns()
{
	// Check for CSDM spawns of the current map
	new cfgdir[32], mapname[32], filepath[100], linedata[64]
	get_configsdir(cfgdir, charsmax(cfgdir))
	get_mapname(mapname, charsmax(mapname))
	formatex(filepath, charsmax(filepath), "%s/csdm/%s.spawns.cfg", cfgdir, mapname)
	
	// Load CSDM spawns if present
	if (file_exists(filepath))
	{
		new csdmdata[10][6], file = fopen(filepath,"rt")
		
		while (file && !feof(file))
		{
			fgets(file, linedata, charsmax(linedata))
			
			// invalid spawn
			if(!linedata[0] || str_count(linedata,' ') < 2) continue;
			
			// get spawn point data
			parse(linedata,csdmdata[0],5,csdmdata[1],5,csdmdata[2],5,csdmdata[3],5,csdmdata[4],5,csdmdata[5],5,csdmdata[6],5,csdmdata[7],5,csdmdata[8],5,csdmdata[9],5)
			
			// origin
			g_spawns[g_spawnCount][0] = floatstr(csdmdata[0])
			g_spawns[g_spawnCount][1] = floatstr(csdmdata[1])
			g_spawns[g_spawnCount][2] = floatstr(csdmdata[2])
			
			// increase spawn count
			g_spawnCount++
			if (g_spawnCount >= sizeof g_spawns) break;
		}
		if (file) fclose(file)
	}
	else
	{
		// Collect regular spawns
		collect_spawns_ent("info_player_start")
		collect_spawns_ent("info_player_deathmatch")
	}
	
	// Collect regular spawns for non-random spawning unstuck
	collect_spawns_ent2("info_player_start")
	collect_spawns_ent2("info_player_deathmatch")
}

// Collect spawn points from entity origins
stock collect_spawns_ent(const classname[])
{
	new ent = -1
	while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", classname)) != 0)
	{
		// get origin
		new Float:originF[3]
		pev(ent, pev_origin, originF)
		g_spawns[g_spawnCount][0] = originF[0]
		g_spawns[g_spawnCount][1] = originF[1]
		g_spawns[g_spawnCount][2] = originF[2]
		
		// increase spawn count
		g_spawnCount++
		if (g_spawnCount >= sizeof g_spawns) break;
	}
}

// Collect spawn points from entity origins
stock collect_spawns_ent2(const classname[])
{
	new ent = -1
	while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", classname)) != 0)
	{
		// get origin
		new Float:originF[3]
		pev(ent, pev_origin, originF)
		g_spawns2[g_spawnCount2][0] = originF[0]
		g_spawns2[g_spawnCount2][1] = originF[1]
		g_spawns2[g_spawnCount2][2] = originF[2]
		
		// increase spawn count
		g_spawnCount2++
		if (g_spawnCount2 >= sizeof g_spawns2) break;
	}
}

// Drop primary/secondary weapons
stock drop_weapons(id, dropwhat)
{
	// Get user weapons
	static weapons[32], num, i, weaponid
	num = 0 // reset passed weapons count (bugfix)
	get_user_weapons(id, weapons, num)
	
	// Loop through them and drop primaries or secondaries
	for (i = 0; i < num; i++)
	{
		// Prevent re-indexing the array
		weaponid = weapons[i]
		
		if ((dropwhat == 1 && ((1<<weaponid) & PRIMARY_WEAPONS_BIT_SUM)) || (dropwhat == 2 && ((1<<weaponid) & SECONDARY_WEAPONS_BIT_SUM)))
		{
			// Get weapon entity
			static wname[32], weapon_ent
			get_weaponname(weaponid, wname, charsmax(wname))
			weapon_ent = fm_find_ent_by_owner(-1, wname, id)
			
			// Hack: store weapon bpammo on PEV_ADDITIONAL_AMMO
			set_pev(weapon_ent, PEV_ADDITIONAL_AMMO, cs_get_user_bpammo(id, weaponid))
			
			// Player drops the weapon and looses his bpammo
			engclient_cmd(id, "drop", wname)
			cs_set_user_bpammo(id, weaponid, 0)
		}
	}
}

// Stock by (probably) Twilight Suzuka -counts number of chars in a string
stock str_count(const str[], searchchar)
{
	new count, i, len = strlen(str)
	
	for (i = 0; i <= len; i++)
	{
		if(str[i] == searchchar)
			count++
	}
	
	return count;
}

// Checks if a space is vacant (credits to VEN)
stock is_hull_vacant(Float:origin[3], hull)
{
	engfunc(EngFunc_TraceHull, origin, origin, 0, hull, 0, 0)
	
	if (!get_tr2(0, TR_StartSolid) && !get_tr2(0, TR_AllSolid) && get_tr2(0, TR_InOpen))
		return true;
	
	return false;
}

// Check if a player is stuck (credits to VEN)
stock is_player_stuck(id)
{
	static Float:originF[3]
	pev(id, pev_origin, originF)
	
	engfunc(EngFunc_TraceHull, originF, originF, 0, (pev(id, pev_flags) & FL_DUCKING) ? HULL_HEAD : HULL_HUMAN, id, 0)
	
	if (get_tr2(0, TR_StartSolid) || get_tr2(0, TR_AllSolid) || !get_tr2(0, TR_InOpen))
		return true;
	
	return false;
}

// Simplified get_weaponid (CS only)
stock cs_weapon_name_to_id(const weapon[])
{
	static i
	for (i = 0; i < sizeof WEAPONENTNAMES; i++)
	{
		if (equal(weapon, WEAPONENTNAMES[i]))
			return i;
	}
	
	return 0;
}

// Get User Current Weapon Entity
stock fm_cs_get_current_weapon_ent(id)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return -1;
	
	return get_pdata_cbase(id, OFFSET_ACTIVE_ITEM, OFFSET_LINUX);
}

// Get Weapon Entity's Owner
stock fm_cs_get_weapon_ent_owner(ent)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(ent) != PDATA_SAFE)
		return -1;
	
	return get_pdata_cbase(ent, OFFSET_WEAPONOWNER, OFFSET_LINUX_WEAPONS);
}

// Set User Deaths
stock fm_cs_set_user_deaths(id, value)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return;
	
	set_pdata_int(id, OFFSET_CSDEATHS, value, OFFSET_LINUX)
}

// Get User Team
stock fm_cs_get_user_team(id)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return FM_CS_TEAM_UNASSIGNED;
	
	return get_pdata_int(id, OFFSET_CSTEAMS, OFFSET_LINUX);
}

// Set a Player's Team
stock fm_cs_set_user_team(id, team)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return;
	
	set_pdata_int(id, OFFSET_CSTEAMS, team, OFFSET_LINUX)
}

// Set User Money
stock fm_cs_set_user_money(id, value)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return;
	
	set_pdata_int(id, OFFSET_CSMONEY, value, OFFSET_LINUX)
}

// Set User Flashlight Batteries
stock fm_cs_set_user_batteries(id, value)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return;
	
	set_pdata_int(id, OFFSET_FLASHLIGHT_BATTERY, value, OFFSET_LINUX)
}

// Update Player's Team on all clients (adding needed delays)
stock fm_user_team_update(id)
{
	static Float:current_time
	current_time = get_gametime()
	
	if (current_time - g_teams_targettime >= 0.1)
	{
		set_task(0.1, "fm_cs_set_user_team_msg", id+TASK_TEAM)
		g_teams_targettime = current_time + 0.1
	}
	else
	{
		set_task((g_teams_targettime + 0.1) - current_time, "fm_cs_set_user_team_msg", id+TASK_TEAM)
		g_teams_targettime = g_teams_targettime + 0.1
	}
}

// Send User Team Message
public fm_cs_set_user_team_msg(taskid)
{
	// Note to self: this next message can now be received by other plugins
	
	// Set the switching team flag
	g_switchingteam = true
	
	// Tell everyone my new team
	emessage_begin(MSG_ALL, g_msgTeamInfo)
	ewrite_byte(ID_TEAM) // player
	ewrite_string(CS_TEAM_NAMES[fm_cs_get_user_team(ID_TEAM)]) // team
	emessage_end()
	
	// Done switching team
	g_switchingteam = false
}

// Set the precached model index (updates hitboxes server side)
stock fm_cs_set_user_model_index(id, value)
{
	// Prevent server crash if entity's private data not initalized
	if (pev_valid(id) != PDATA_SAFE)
		return;
	
	set_pdata_int(id, OFFSET_MODELINDEX, value, OFFSET_LINUX)
}

// Set Player Model on Entity
stock fm_set_playermodel_ent(id)
{
	// Make original player entity invisible without hiding shadows or firing effects
	fm_set_rendering(id, kRenderFxNone, 255, 255, 255, kRenderTransTexture, 1)
	
	// Format model string
	static model[100]
	formatex(model, charsmax(model), "models/player/%s/%s.mdl", g_playermodel[id], g_playermodel[id])
	
	// Set model on entity or make a new one if unexistant
	if (!pev_valid(g_ent_playermodel[id]))
	{
		g_ent_playermodel[id] = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "info_target"))
		if (!pev_valid(g_ent_playermodel[id])) return;
		
		set_pev(g_ent_playermodel[id], pev_classname, MODEL_ENT_CLASSNAME)
		set_pev(g_ent_playermodel[id], pev_movetype, MOVETYPE_FOLLOW)
		set_pev(g_ent_playermodel[id], pev_aiment, id)
		set_pev(g_ent_playermodel[id], pev_owner, id)
	}
	
	engfunc(EngFunc_SetModel, g_ent_playermodel[id], model)
}

// Set Weapon Model on Entity
stock fm_set_weaponmodel_ent(id)
{
	// Get player's p_ weapon model
	static model[100]
	pev(id, pev_weaponmodel2, model, charsmax(model))
	
	// Set model on entity or make a new one if unexistant
	if (!pev_valid(g_ent_weaponmodel[id]))
	{
		g_ent_weaponmodel[id] = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "info_target"))
		if (!pev_valid(g_ent_weaponmodel[id])) return;
		
		set_pev(g_ent_weaponmodel[id], pev_classname, WEAPON_ENT_CLASSNAME)
		set_pev(g_ent_weaponmodel[id], pev_movetype, MOVETYPE_FOLLOW)
		set_pev(g_ent_weaponmodel[id], pev_aiment, id)
		set_pev(g_ent_weaponmodel[id], pev_owner, id)
	}
	
	engfunc(EngFunc_SetModel, g_ent_weaponmodel[id], model)
}

// Remove Custom Model Entities
stock fm_remove_model_ents(id)
{
	// Remove "playermodel" ent if present
	if (pev_valid(g_ent_playermodel[id]))
	{
		engfunc(EngFunc_RemoveEntity, g_ent_playermodel[id])
		g_ent_playermodel[id] = 0
	}
	// Remove "weaponmodel" ent if present
	if (pev_valid(g_ent_weaponmodel[id]))
	{
		engfunc(EngFunc_RemoveEntity, g_ent_weaponmodel[id])
		g_ent_weaponmodel[id] = 0
	}
}

// Set User Model
public fm_cs_set_user_model(taskid)
{
	set_user_info(ID_MODEL, "model", g_playermodel[ID_MODEL])
}

// Get User Model -model passed byref-
stock fm_cs_get_user_model(player, model[], len)
{
	get_user_info(player, "model", model, len)
}

// Update Player's Model on all clients (adding needed delays)
public fm_user_model_update(taskid)
{
	static Float:current_time
	current_time = get_gametime()
	
	if (current_time - g_models_targettime >= g_modelchange_delay)
	{
		fm_cs_set_user_model(taskid)
		g_models_targettime = current_time
	}
	else
	{
		set_task((g_models_targettime + g_modelchange_delay) - current_time, "fm_cs_set_user_model", taskid)
		g_models_targettime = g_models_targettime + g_modelchange_delay
	}
}

stock TakeDamage(id, attacker, const weaponname[], Float:damage, damagetype, gib = false)
{
	if (pev_valid(id) != PDATA_SAFE || pev_valid(attacker) != PDATA_SAFE || !is_user_connected(id) || !is_user_connected(attacker))
		return;
	
	// Get victim's health
	static Float:health
	pev(id, pev_health, health)
	
	if (g_zombie[id])
	{
		// Variables
		static Float:percentModifier
		percentModifier = Float:ArrayGetCell(g_zclass_armor, g_zombieclass[id])
		
		// Executioner upgrade?
		if (health < float(ArrayGetCell(g_zclass_hp, g_zombieclass[id]))*0.4 && has_upgrade(attacker, UPGRADE_HUMAN_EXECUTIONER))
			percentModifier += 0.1 // increase by 10%
		
		// Melee combat
		if (equal(weaponname, "knife"))
		{
			if (g_humanclass[attacker] == 3) // survivalist class
				percentModifier += 0.1
			
			if (has_upgrade(attacker, UPGRADE_HUMAN_BLOODY_BLADE))
				percentModifier += 0.2
		}
		
		switch (g_zombieclass[id])
		{
			case 1: // Boomer
			{
				if (damage > 300.0) percentModifier /= 2.0 // half
			}
			case 3: // Venom Guard
			{
				if (damage > 250.0) percentModifier /= 2.0 // half
			}
		}
		
		// Protector upgrade?
		if (health < float(ArrayGetCell(g_zclass_hp, g_zombieclass[id]))*0.5 && has_upgrade(id, UPGRADE_ZOMBIE_PROTECTOR))
			percentModifier -= 0.1 // decrease by 10%
		
		damage *= percentModifier
	}
	
	// Show damage?
	if (is_user_alive(attacker) && access(attacker, ADMIN_LEVEL_H))
	{
		client_print(attacker, print_center, "%s - DMG: %d - HP: %d", g_playername[id], floatround(damage), max(0, floatround(health-damage)))
	}
	
	// Damage victim
	if (health - damage > 0)
	{
		// Set user health
		set_pev(id, pev_health, health - damage)
		
		// Icon
		message_begin(MSG_ONE_UNRELIABLE, g_msgDamage, _, id)
		write_byte(0) // damage save
		write_byte(floatround(damage)) // damage take
		write_long(damagetype) // damage type
		write_coord(0) // x
		write_coord(0) // y
		write_coord(0) // z
		message_end()
	}
	else
	{
		// Kill victim
		set_msg_block(g_msgDeathMsg, BLOCK_SET)
		ExecuteHamB(Ham_Killed, id, attacker, gib)
		set_msg_block(g_msgDeathMsg, BLOCK_NOT)
		
		message_begin(MSG_BROADCAST, g_msgDeathMsg)
		write_byte(attacker) // killer
		write_byte(id) // victim
		write_byte(0) // headshot flag
		write_string(weaponname) // killer's weapon
		message_end()
	}
	
	// Origin for blood
	static Float:originF[3]
	pev(id, pev_origin, originF)
	
	// Actual blood
	message_begin(MSG_BROADCAST,SVC_TEMPENTITY)
	write_byte(TE_BLOODSPRITE)
	engfunc(EngFunc_WriteCoord, originF[0])
	engfunc(EngFunc_WriteCoord, originF[1])
	engfunc(EngFunc_WriteCoord, originF[2])
	write_short(g_bloodSpr)
	write_short(g_bloodSpr)
	write_byte((damagetype == DMG_POISON) ? 83 : 229)
	write_byte(10)
	message_end()
	
	// Sounds for zombies
	static sound[64]
	
	// Zombie being hit
	if (g_nemesis[id])
	{
		ArrayGetString(nemesis_pain, random_num(0, ArraySize(nemesis_pain) - 1), sound, charsmax(sound))
		emit_sound(id, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	else
	{
		ArrayGetString(zombie_pain, random_num(0, ArraySize(zombie_pain) - 1), sound, charsmax(sound))
		emit_sound(id, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
}

stock Float:GetRadiusDamageF(Float:radius, Float:damage, Float:distance)
{
	static Float:adjustedDamage
	adjustedDamage = distance * (radius ? floatdiv(damage, radius) : 1.0)
	adjustedDamage = damage - adjustedDamage
	
	return (adjustedDamage > 0.0) ? adjustedDamage : 0.0;
}

stock get_speed_vector(const Float:origin1[3], const Float:origin2[3], Float:speed, Float:new_velocity[3])
{
	new_velocity[0] = origin2[0] - origin1[0]
	new_velocity[1] = origin2[1] - origin1[1]
	new_velocity[2] = origin2[2] - origin1[2]
	static Float:num; num = floatsqroot(speed*speed / (new_velocity[0]*new_velocity[0] + new_velocity[1]*new_velocity[1] + new_velocity[2]*new_velocity[2]))
	new_velocity[0] *= num
	new_velocity[1] *= num
	new_velocity[2] *= num
	
	return 1;
}

stock is_entity_outside(ent)
{
	// We get the origin of the entity
	static Float:originF[3], Float:targetF[3]
	pev(ent, pev_origin, originF)
	
	// We calculate targetF
	targetF[0] = originF[0]
	targetF[1] = originF[1]
	targetF[2] = 8191.0
	
	// Trace to the target
	static texture[64]
	engfunc(EngFunc_TraceTexture, 0, originF, targetF, texture, charsmax(texture))
	
	// Did we hit sky
	if (equali(texture, "sky"))
		return true;
	
	return false;
}
