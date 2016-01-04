// script: horse_mount
// by Barry_1066
// 02/10/2008
// Variable PONY_ID string resref (resref of the horse to be spawned)
// This variable is placed on the horse/pony blueprint.
#include "zep_inc_phenos"
#include "x3_inc_horse"
#include "nw_i0_generic"
void main()
{
object oPC=OBJECT_SELF;
string sResRef = GetLocalString(oPC,"PONY_ID");
        zep_Dismount (oPC, "horse_dismt");
        SetLocalInt(oPC,"bX3_IS_MOUNTED",FALSE);
        DeleteLocalString(oPC,"X3_HORSE_SCRIPT_DISMOUNT");
        SetLocalInt(oPC, "VAR_HORSEMOUNT", 0);//horselord class variable

    object oTarget;
    location lPc = GetLocation(oPC);
    location lWyrmling = GetItemActivatedTargetLocation();
string sString = GetName(OBJECT_SELF);

    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
      // SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
         SetName (oWyrmling, sString + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPC, oWyrmling);
    }/* end then (valid owyrmling) */
    else
    {
        AssignCommand(oPC, ActionSpeakString("Invalid Horse/Pony"));
    }/* end else (valid owyrmling) */

//remove horse support DLA Style
object oRider=OBJECT_SELF;

DelayCommand(1.0, HORSE_SupportOriginalSpeed(oRider));
DelayCommand(1.0, HORSE_SupportRemoveMountedSkillDecreases(oRider));
DelayCommand(1.0, HORSE_SupportRemoveACBonus(oRider));
DelayCommand(1.0, HORSE_SupportRemoveHPBonus(oRider));
}

