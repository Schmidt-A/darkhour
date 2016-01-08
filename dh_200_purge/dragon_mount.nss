// script: dragon_mount
// by Barry_1066
// 05/09/2009
// Variable PONY_ID string resref (resref of the dragon to be spawned)
// This variable is placed on the dragon blueprint.
#include "x2_inc_switches"
#include "x3_inc_horse"
void main()
{
object oPC=OBJECT_SELF;
object oMount=GetSpellTargetObject();


   int MALE_DRAGONRIDER_APP = 3271;
   int FEMALE_DRAGONRIDER_APP = 3272;
//////////////////////////////////////////////////////
//   Used for testing before models we in cep 2.3   //
/////////////////////////////////////////////////////
   //int MALE_DRAGONRIDER_APP = 1556;
   //int FEMALE_DRAGONRIDER_APP = 1557;
   int iAppearance;
   int iTail;

 if (GetLocalInt(oPC, "dragon_riding") == FALSE)
      { // change to riding dragon type
          if (GetMaster(oMount) != oPC)
    {
FloatingTextStringOnCreature("This Dragon Belongs to someone else", oPC);
    }
//////////////////////////////////////////////////////
//   Do NOT Mount if the monut belongs to another  //
/////////////////////////////////////////////////////
     if (GetMaster(oMount) == oPC)
/////////////////////////////////////////////////////
{
string sResRef = GetLocalString(oMount,"PONY_ID");
SetLocalString(oPC, "PONY_ID", sResRef);

        iAppearance = GetAppearanceType(oPC);
        SetLocalInt(oPC, "CgApp", iAppearance);
        iTail = GetCreatureTailType(oPC);
        SetLocalInt(oPC, "CgTail", iTail);
        SetLocalInt(oPC, "dragon_riding", TRUE);
        if (GetGender(oPC) == GENDER_MALE)
        { SetCreatureAppearanceType(oPC, MALE_DRAGONRIDER_APP); }
        else
        { SetCreatureAppearanceType(oPC, FEMALE_DRAGONRIDER_APP); }
SetLocalInt(oPC,"bX3_IS_MOUNTED",TRUE);
SetLocalString(oPC, "X3_HORSE_SCRIPT_DISMOUNT", "dragon_dmount");
SetLocalInt(oPC, "VAR_HORSEMOUNT", 1);//horselord class variable

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
        return;

      }



      if (GetLocalInt(oPC, "dragon_riding")== TRUE)
      { SetLocalInt(oPC, "dragon_riding", FALSE);
        int iAppearance = GetLocalInt(oPC, "CgApp");
        object oPC=OBJECT_SELF;
        string sResRef = GetLocalString(oPC,"PONY_ID");
        SetCreatureAppearanceType(oPC, iAppearance);
        int iTail = GetLocalInt(oPC, "CgTail");
        SetCreatureTailType(iTail, oPC);
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
        return;
      }
    }
}






