////This script Store the LOGIN name of the Targeted Player ( targeted by the Admin rod)
//// on a table in teh BATADASE  AS GAME MASTER   /////////////
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
    SetModuleVar("GameMaster_"+sLogin, "1",0,"AdminsGmsGods");
    FloatingTextStringOnCreature("<c.ÍŽ>"+GetPCPlayerName(oTarget)+" Login is stored as GM [DB Table:AdminsGmsGods].</c>",oPC,FALSE);

    DelayCommand(03.0,DeleteLocalObject(oPC, "oMyTarget"));

    if ( GetModuleVar("GameMaster_"+sLogin,"AdminsGmsGods") == "1" )
    {
        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Information stored Successfully.</c>",oPC,FALSE);
    }
    if (GetIsGMNormalChar(oTarget))
    {
        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Verified Successfully.</c>",oPC,FALSE);
    }
}
