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



    DelayCommand(03.0,DeleteLocalObject(oPC, "oMyTarget"));

    int rank = GetGMRank(oTarget);

    if (rank == JUNIOR_GM)
    {
        FloatingTextStringOnCreature("This GM is a n00b",oPC,FALSE);
    }
    else if (rank == GM)
    {
        FloatingTextStringOnCreature("This GM is a ...... GM",oPC,FALSE);
    }
    else if (rank == SENIOR_GM)
    {
         FloatingTextStringOnCreature("This GM is a Senior GMs",oPC,FALSE);
    }

}

