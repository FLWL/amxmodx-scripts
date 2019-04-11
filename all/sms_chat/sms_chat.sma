#include <amxmodx>
#include <amxmisc>
#include <sqlx>

#define PLUGIN "SMS Chat"
#define VERSION "1.1"
#define AUTHOR "FLWL"

#define DB_NONE 0
#define DB_CONNECTING 1
#define DB_READY 2

new Handle:g_sql_tuple
new Handle:g_sql_connection
new g_db_status
new SayText

new cvar_sql_table, cvar_enabled

new sms_lastmessage[128]

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	SayText = get_user_msgid("SayText")
	
	cvar_enabled = register_cvar("sms_chat_enabled", "1")
	cvar_sql_table = register_cvar("sms_chat_table", "sms_chat")
	
	g_db_status = DB_NONE
	set_task(0.1, "prepare_database")
	
	set_task(300.0, "show_message", _, _, _, "b")
}

public show_message()
{
	if (!strlen(sms_lastmessage))
		return;
	
	client_printcolor(0, "^x04[SMS Chat]^x01 Last message:^x04 %s", sms_lastmessage)
	client_printcolor(0, "^x04[SMS Chat]^x01 Messages are displayed every^x04 5 minutes^x01. More info - ^x04/smschat")
}

public prepare_database()
{
	g_db_status = DB_NONE
	if (get_pcvar_num(cvar_enabled) == 0)
		return
	
	sql_init()
}

public sql_init()
{
	if (g_db_status == DB_CONNECTING)
		return
	g_db_status = DB_CONNECTING
	
	new err[512], err_code
	
	g_sql_tuple = SQL_MakeStdTuple()
	
	if (g_sql_connection != Empty_Handle)
		SQL_FreeHandle(g_sql_connection)
	
	g_sql_connection = SQL_Connect(g_sql_tuple, err_code, err, 511)
	if (g_sql_connection == Empty_Handle)
	{
		log_amx("SQL Error: %s (%d)", err, err_code)
		g_db_status = DB_NONE
		return
	}
	
	check_tables()
}

public check_tables()
{
	static cache[256], table[32]
	get_pcvar_string(cvar_sql_table, table, 31)
	formatex(cache, 255, "CREATE TABLE IF NOT EXISTS `%s` (`id` INT NOT NULL AUTO_INCREMENT ,`message` VARCHAR( 128 ) NOT NULL ,`timestamp` INT NOT NULL ,PRIMARY KEY ( `id` ))", table)
	SQL_ThreadQuery(g_sql_tuple, "handle_create_table_query", cache)
}

public handle_create_table_query(FailState, Handle:Query, Error[], Errcode, Data[], DataSize)
{
	if (g_db_status != DB_CONNECTING)
		return PLUGIN_HANDLED
	
	if (FailState)
	{
		log_amx("SQL Error: %s (%d)", Error, Errcode)
		g_db_status = DB_NONE
		return PLUGIN_HANDLED
	}
	
	g_db_status = DB_READY
	data_load()
	
	return PLUGIN_CONTINUE
}

public data_load()
{
	static data[2], cache[256], table[32]
	get_pcvar_string(cvar_sql_table, table, 31)
	format(cache, 255, "SELECT message FROM `%s` ORDER BY timestamp DESC LIMIT 1", table)
	SQL_ThreadQuery(g_sql_tuple, "handle_sql_load", cache, data, 2)
}

public handle_sql_load(FailState, Handle:Query, Error[], Errcode, Data[], DataSize)
{
	static cache[256]
	if (g_db_status != DB_READY)
		return PLUGIN_HANDLED
	
	if (FailState)
	{
		log_amx("SQL Error: %s (%d)", Error, Errcode)
		return PLUGIN_HANDLED
	}
	
	if (SQL_MoreResults(Query))
		SQL_ReadResult(Query, 0, cache, 255)
	
	copy(sms_lastmessage, charsmax(sms_lastmessage), cache)
	replace_all(sms_lastmessage, charsmax(sms_lastmessage), "\'", "'")
	server_print("[SMS Chat] Latest message: %s", sms_lastmessage)
	return PLUGIN_CONTINUE
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
		for (new i = 0; i < count; i++)
		{
			if (is_user_connected(players[i]))
			{
				message_begin(MSG_ONE_UNRELIABLE, SayText, _, players[i])
				write_byte(players[i]);
				write_string(msg);
				message_end();
			}
		}
	}
}
