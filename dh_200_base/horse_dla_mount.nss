// script: horse_mount
// by Barry_1066
// 02/10/2008
// Included so DMs can mount DLA/Bioware horses

#include "x3_inc_horse"
void main()
{
object oPC = GetPCSpeaker();
object oHorse = OBJECT_SELF;

if(GetIsDM(oPC) || GetIsDMPossessed(oPC))
{
    if (GetIsObjectValid(oHorse))
    AssignCommand(oPC, HorseMount(oHorse));
    if (GetItemPossessedBy(oPC, "horse_dismt2")== OBJECT_INVALID)
   {
   CreateItemOnObject("zep_horse_dismt", oPC);
    }


 }
}
