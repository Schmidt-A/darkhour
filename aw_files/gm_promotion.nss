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
    int result = PromoteGMRank(oTarget);


    DelayCommand(03.0,DeleteLocalObject(oPC, "oMyTarget"));

    if ( result == 1)
    {
        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Successfully Promoted.</c>",oPC,FALSE);
        FloatingTextStringOnCreature("Congratulations, your kissing ass has successfully gained you a higher Rank.</c>",oTarget,FALSE);
    }
    else if (result == 0)
    {
        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+"'s Promotion was Unsuccessfull.</c>",oPC,FALSE);
    }
    else if (result == -1)
    {

        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Isn't a GM. Try making them a GM first.</c>",oPC,FALSE);
    }
    else if (result == -2)
    {
        FloatingTextStringOnCreature("<cß7Ž>"+sLogin+" Is a Senior GM. They can attain no higher rank as a GM.</c>",oPC,FALSE);
    }
}
