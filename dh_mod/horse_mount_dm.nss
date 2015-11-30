// script: horse_mount
// by Barry_1066
// 02/10/2008
// Included so DMs can mount CEP horses/ponies
#include "zep_inc_phenos"
#include "x3_inc_horse"
void main()
{
object oPC = GetPCSpeaker();
object oMount = OBJECT_SELF;
//if(GetIsDM(oPC))
if(GetIsDM(oPC) || GetIsDMPossessed(oPC))
{
string sResRef = GetLocalString(oMount,"PONY_ID");
SetLocalString(oPC, "PONY_ID", sResRef);
zep_Mount(oPC, oMount, 0, fDEFAULT_SPEED, "horse_dismt");
//apply horse support DLA Style
object oRider=OBJECT_SELF;
object oHorse;
oHorse=GetHenchman(oPC);

DelayCommand(1.0, HORSE_SupportIncreaseSpeed(oRider,oHorse));
DelayCommand(1.0, HORSE_SupportApplyMountedSkillDecreases(oRider));
DelayCommand(1.0, HORSE_SupportAdjustMountedArcheryPenalty(oRider));
DelayCommand(1.0, HORSE_SupportApplyACBonus(oRider,oHorse));
DelayCommand(1.0, HORSE_SupportApplyHPBonus(oRider,oHorse));

//Removes horse as henchman while mounted
object oTarget;
oTarget=GetHenchman(oPC);

RemoveHenchman(oPC, oTarget);

DestroyObject(oTarget);
}
}
