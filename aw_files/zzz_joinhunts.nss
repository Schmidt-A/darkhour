#include "zzz_huntinclude"
void main()
{
//This script turns players into hunters when they touch the  swor d in "The Hunt" special round.
object oPC = GetLastUsedBy();
if ((GetLocalInt(oPC, "Used") != TRUE)) //don't allow them to spam it
{
DoRemoveBuffs(oPC);
SetLocalInt(oPC, "Used", TRUE);
DelayCommand(4.0, DeleteLocalInt(oPC, "Used"));

int nGender;
if (GetGender(oPC) == GENDER_MALE) // separate appearances for male and female
{
    nGender = 116;
}

else
{
    nGender = 115;
}
effect ePoly = EffectPolymorph(nGender, TRUE);

SetLocalInt(oPC, "Hunter", TRUE);
DelayCommand(1.2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 1000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 60));
DelayCommand(1.3, DoAB(oPC, 2));
DelayCommand(1.3, DoDR(oPC, 2, 0));
DelayCommand(1.3, DoSkills(oPC, 0));
DelayCommand(1.3, DoAttacks(oPC));

}
}
