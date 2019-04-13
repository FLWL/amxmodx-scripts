#if defined _global_vars_included
	#endinput
#endif
#define _global_vars_included

#define XBANS_VERSION "1.0.5"

#define MAX_PLAYERS 32

#define ADMIN_LOOKUP (1<<0)
#define ADMIN_NORMAL (1<<1)
#define ADMIN_STEAM (1<<2)
#define ADMIN_IPADDR (1<<3)
#define ADMIN_NAME (1<<4)

#define FFADE_STAYOUT 0x0004

/*
new const SCREENFADE_COLORS[][] =
{
	255, 0, 0,
	0, 255, 0,
	0, 0, 255
}
*/

new const QUERY_LOAD_SID[] = "SELECT `id` FROM `%s_servers` WHERE `ip` = '%s' AND `port` = %d"
new const QUERY_INSERT_SID[] = "INSERT INTO `%s_servers` (`ip`, `port`) VALUES ('%s', %d)"
new const QUERY_LOAD_ADMINS[] = "SELECT aa.`id`, aa.`auth`, aa.`password`, aas.`access`, aas.`removed_flags` FROM `%s_admins` AS aa, `%s_admins_servers` AS aas, `%s_servers` AS asi WHERE ((aas.admin_id = aa.id) AND (aas.server_id = asi.id) AND (asi.id = %d))"
new const QUERY_LOAD_BANREASONS[] = "SELECT abr.`reason_name`, abr.`bantime` FROM `%s_ban_reasons` AS abr, `%s_ban_reasons_servers` AS abrs WHERE ((abr.`reason_id` = abrs.`reason_id`) AND (abrs.`server_id` = %d)) ORDER BY abr.`reason_id`"
new const QUERY_LOAD_STREAMS[] = "SELECT `id`, `name` FROM `xbans_streams`"
new const QUERY_INSERT_BAN[] = "INSERT INTO `%s_bans` (`player_ip`, `player_id`, `player_nick`, `admin_ip`, `admin_id`, `admin_nick`, `admin_aid`, `ban_reason`, `ban_created`, `ban_length`, `server_sid`, `server_map`, `expired`, `no_unban`, `cross_server`) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', %d, '%s', %d, %d, %d, '%s', 0, 0, %d)"
new const QUERY_VALIDATE_PLAYER[] = "SELECT `ab`.`bid`, `ab`.`player_nick`, `ab`.`admin_nick`, `ab`.`ban_reason`, `ab`.`ban_created`, `ab`.`ban_length`, `ab`.`server_sid`, `ab`.`server_map`, `ab`.`expired`, `ab`.`cross_server`, `as`.`hostname` FROM `%s_bans` AS `ab`, `%s_servers` AS `as` WHERE (`ab`.`player_ip` = '%s' OR `ab`.`player_id` = '%s' OR `ab`.`bid` = %d) AND (`ab`.`server_sid` = `as`.`id`) ORDER BY `ban_created` ASC"
new const QUERY_UNBAN_SEARCH[] = "SELECT `bid`, `player_nick`, `admin_nick`, `ban_reason`, `ban_length` FROM `%s_bans` WHERE (`expired` = 0) AND (`ban_length` = 0 OR (`ban_created` + `ban_length` > UNIX_TIMESTAMP(NOW()))) AND (`admin_aid` = %d OR %s) AND (`bid` = '%s' OR `player_ip` = '%s' OR `player_id` = '%s' OR `player_nick` = '%s') ORDER BY `ban_created` DESC LIMIT 1"
new const QUERY_UNBAN_UNBAN[] = "UPDATE `xbans_archive_bans` SET `expired` = 1 WHERE `bid` = %d"
new const QUERY_DISPLAY_MESSAGE[] = "SELECT `message` FROM `xbans_messages` WHERE (`servers` = 0 OR (`servers` & (1 << (%d & 31)))) ORDER BY RAND() LIMIT 0, 1"

new const DEFAULT_CFG_FILE[][] =
{
	"// Table prefix used in SQL queries. Default: ^"amx^"^nxbans_sql_prefix ^"amx^"^n",
	"// Server's IP address used for loading admins. If left blank, XBans will fetch server's IP automatically. Default: ^"^"^nxbans_server_address ^"^"^n",
	"// Whether to load admins or not. Default: ^"1^"^nxbans_load_admins ^"1^"^n",
	"// Key used to prevent non-steam clients from evading bans by changing their IP address. Default: ^"heapsize^"^nxbans_setinfo_key ^"heapsize^"^n",
	"// Web address where players can complain about their bans. Default: ^"www.example.com^"^nxbans_complain_url ^"www.example.com^"^n",
	"// Whether to load admins, reasons etc. by threaded queries. Enabling this may shorten map loading times. Default: ^"0^"^nxbans_threaded_loading ^"0^"^n",
	"// Whether to notify admins when player banned before connects to the server. Default: ^"0^"^nxbans_notify_on_connect ^"0^"^n",
	"// Displays server message every X (defined by this cvar) seconds. Default: ^"60^"^nxbans_message_interval ^"60^"^n"
}

new cvar_mode, cvar_passwordfield, cvar_defaultaccess, cvar_sqlprefix, cvar_serveraddr,
cvar_loadadmins, cvar_setinfokey, cvar_complainurl, cvar_threadedloading, 
cvar_notifyonconnect, cvar_messageinterval

new g_msgSayText//, g_msgScreenFade

// Player vars
new g_casesensitivename[MAX_PLAYERS+1]
new g_beingbanned[MAX_PLAYERS+1]
new g_beinggagged[MAX_PLAYERS+1]
new g_adminid[MAX_PLAYERS+1]
new g_custombanplayer[MAX_PLAYERS+1]
new g_playerbanuserid[MAX_PLAYERS+1]
new g_custombanreason[MAX_PLAYERS+1][64]
new g_lastbantime[MAX_PLAYERS+1]
new g_blackmarks[MAX_PLAYERS+1]

new Handle:g_sqltuple

new Array:g_adminids
new Array:g_banreasons
new Array:g_banlengths
//new Array:g_gagreasons
//new Array:g_gaglengths
new Array:g_streamids
new Array:g_streamnames

new g_cmdloopback[16]
new g_cmdloopback_ban[16]
new g_configsdir[64]
new g_sqlprefix[16]
new g_serveraddr[22]
new g_serverip[16]
new g_mapname[32]
new g_serverport
new g_serverid
new g_admincount
new g_banreasoncount
new g_streamcount
new g_maxplayers
