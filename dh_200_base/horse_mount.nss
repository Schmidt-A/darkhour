// script: horse_mount
// by Barry_1066
// 02/10/2008
// Variable PONY_ID string resref (resref of the horse to be spawned)
// This variable is placed on the horse/pony blueprint.
#include "zep_inc_phenos"
#include "x3_inc_horse"
void main()
{
object oPC=OBJECT_SELF;
object oMount=GetSpellTargetObject();

    if (GetMaster(oMount) != oPC)
    {
FloatingTextStringOnCreature("This Horse Belongs to someone else", oPC);
    }

//////////////////////////////////////////////////////
//   Do NOT Mount if the monut belongs to another  //
/////////////////////////////////////////////////////
     if (GetMaster(oMount) == oPC)
/////////////////////////////////////////////////////
{
string sResRef = GetLocalString(oMount,"PONY_ID");
SetLocalString(oPC, "PONY_ID", sResRef);
//zep_Mount(oPC, oMount, 0, fDEFAULT_SPEED, "horse_dismt");
zep_Mount(oPC, oMount, 0, 0.0, "horse_dismt"); // removes horse speed
SetLocalInt(oPC,"bX3_IS_MOUNTED",TRUE);
SetLocalString(oPC, "X3_HORSE_SCRIPT_DISMOUNT", "horse_dmount");
SetLocalInt(oPC, "VAR_HORSEMOUNT", 1);//horselord class variable

//apply horse support DLA Style
object oRider=OBJECT_SELF;
object oHorse;
oHorse=GetHenchman(oPC);

//HORSE_SupportIncreaseSpeed(oRider,oHorse);
//HORSE_SupportAdjustMountedArcheryPenalty(oRider);
//HORSE_SupportApplyACBonus(oRider,oHorse);
//HORSE_SupportApplyHPBonus(oRider,oHorse);
//HORSE_SupportApplyMountedSkillDecreases(object oRider)
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

