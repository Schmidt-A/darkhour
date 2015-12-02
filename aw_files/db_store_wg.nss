////This script Store the LOGIN name of the Targeted Player ( targeted by the Admin rod)
//// on a table in teh BATADASE  AS Winged GOD   /////////////
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
    SetModuleVar("WingedGod_"+sLogin,"1",0,"AdminsGmsGods");
    FloatingTextStringOnCreature("<c.ÍŽ>"+GetPCPlayerName(oTarget)+" Login is stored as WingedGod [DB Table:AdminsGmsGods].</c>",oPC,FALSE);

    DelayCommand(03.0,DeleteLocalObject(oPC, "oMyTarget"));

    if ( GetModuleVar("WingedGod_"+sLogin,"AdminsGmsGods") == "1" )
    {
        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Information stored Successfully.</c>",oPC,FALSE);
    }
    if (GetIsWingedGod(oTarget))
    {
        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Verified Successfully.</c>",oPC,FALSE);
    }
}
