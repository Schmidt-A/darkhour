#include "zzz_huntinclude"
void main()
{
//This script turns players into hunters when they touch the  swor d in "The Hunt" special round.
object oPC = GetLastUsedBy();
if ((GetLocalInt(oPC, "Used") != TRUE)) //don't allow them to spam it
{
SetLocalInt(oPC, "Used", TRUE);
DelayCommand(4.0, DeleteLocalInt(oPC, "Used"));
DoRemoveBuffs(oPC);
int nGender;
if (GetGender(oPC) == GENDER_MALE) // separate appearances for male and female
{
    nGender = 110;
}

else
{
    nGender = 109;
}
effect ePoly = EffectPolymorph(nGender, TRUE);

SetLocalInt(oPC, "Hunter", TRUE);
DelayCommand(1.2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 720;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 65));
DelayCommand(1.3, DoAB(oPC, 0));
DelayCommand(1.3, DoDR(oPC, 2, 0));
DelayCommand(1.3, DoSkills(oPC, 2));
DelayCommand(1.3, DoAttacks(oPC));
}
}
