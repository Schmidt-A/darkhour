////This script Store the LOGIN name of the Targeted Player (targeted by the Admin rod)
//// on a table in teh BATADASE  ASADMIN   /////////////
#include "aps_include"
#include "inc_bs_module"
#include "aw_include"
void main()
{
    object oPC = GetPCSpeaker();
    object oTarget=GetLocalObject(oPC, "oMyTarget");

    if (!GetIsAdmin(oPC))
    {
        FloatingTextStringOnCreature("You can't use this Power!",oPC,FALSE);
        return;
    }
    string sLogin = GetPCPublicCDKey(oTarget)+GetPCPlayerName(oTarget);
    SetModuleVar("Admin_"+sLogin,"0",0,"AdminsGmsGods");
    FloatingTextStringOnCreature("<c.ÍŽ>"+GetPCPlayerName(oTarget)+" Login was removed (set to 0) from Admin [DB Table:AdminsGmsGods].</c>",oPC,FALSE);

    DelayCommand(03.0,DeleteLocalObject(oPC, "oMyTarget"));

    if (!GetIsAdmin(oTarget))
    {
        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Removed Successfully.</c>",oPC,FALSE);
    }
}
