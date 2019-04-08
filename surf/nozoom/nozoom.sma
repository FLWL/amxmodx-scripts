#include <amxmodx>
#include <fakemeta>
#include <hamsandwich>

public plugin_init()
{
	register_plugin("No Zoom", "1.0", "FLWL")
	
	RegisterHam(Ham_Weapon_SecondaryAttack, "weapon_sg550", "OnSecondaryAttack")
	RegisterHam(Ham_Weapon_SecondaryAttack, "weapon_g3sg1", "OnSecondaryAttack")
	RegisterHam(Ham_Weapon_SecondaryAttack, "weapon_awp", "OnSecondaryAttack")
	RegisterHam(Ham_Weapon_SecondaryAttack, "weapon_scout", "OnSecondaryAttack")
}

public OnSecondaryAttack(const entity)
{
	client_print(pev(entity, pev_owner), print_center, "You can't use the zoom!")
	
	return HAM_SUPERCEDE;
}
