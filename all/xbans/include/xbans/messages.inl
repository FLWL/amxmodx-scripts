#if defined _messages_included
	#endinput
#endif
#define _messages_included

public display_server_message()
{
	// Format query
	static query[256]
	formatex(query, charsmax(query), QUERY_DISPLAY_MESSAGE, g_serverid)
	
	SQL_ThreadQuery(g_sqltuple, "_display_server_message", query)
}

public _display_server_message(failstate, Handle:query, error[], errno, data[], datasize)
{
	if (failstate)
	{
		sql_error(error)
		return;
	}
	
	if (!SQL_NumResults(query))
		return;
	
	static col_message
	col_message = SQL_FieldNameToNum(query, "message")
	
	static message[192]
	SQL_ReadResult(query, col_message, message, charsmax(message))
	
	// Color codes
	replace_all(message, charsmax(message), "!g", "^4")
	replace_all(message, charsmax(message), "!y", "^1")
	
	// Display
	colored_print(0, "^3*^1 %s", message)
}
