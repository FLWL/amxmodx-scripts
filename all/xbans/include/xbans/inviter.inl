#if defined _inviter_included
	#endinput
#endif
#define _inviter_included

send_invite(authid[])
{
	static domain[128], path[128], packet[512], error
	get_pcvar_string(cvar_inviterdomain, domain, charsmax(domain))
	get_pcvar_string(cvar_inviterpath, path, charsmax(path))
	formatex(packet, charsmax(packet), "GET %s?authid=%s HTTP/1.1^nHost: %s^n^n", domain, authid, path)
	
	socket_send(socket_open(domain, 80, SOCKET_TCP, error), packet, charsmax(packet))
}
