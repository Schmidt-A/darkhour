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
    int result = DemoteGMRank(oTarget);


    DelayCommand(03.0,DeleteLocalObject(oPC, "oMyTarget"));

    if ( result == 1)
    {
        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Successfully Demoted.</c>",oPC,FALSE);
        FloatingTextStringOnCreature("You have been a bad kitty.</c>",oTarget,FALSE);
    }
    else if (result == 0)
    {
        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+"'s Demotion was  Unsuccessfull.</c>",oPC,FALSE);
    }
    else if (result == -1)
    {

        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Isn't a GM.</c>",oPC,FALSE);
    }
    else if (result == -2)
    {

        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Is aJunior GM. They can go no lower as a GM. Maybe you want to remove their GM status</c>",oPC,FALSE);
    }
}
