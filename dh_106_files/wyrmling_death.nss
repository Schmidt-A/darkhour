//:://////////////////////////////////////////////////
//:: X0_CH_HEN_DEATH
//:: Copyright (c) 2002 Floodgate Entertainment
//:://////////////////////////////////////////////////
/*
  OnDeath handler for henchmen ONLY. Causes them to respawn at
  (in order of preference) the respawn point of their master
  or their own starting location.
 */
//:://////////////////////////////////////////////////
//:: Created By: Naomi Novik
//:: Created On: 10/09/2002
//:://////////////////////////////////////////////////

#include "x0_i0_henchman"

void main()
{
    // Handle a bunch of stuff to keep us from running around,
    // dying again, etc.
    PreRespawnSetup();

    // Call for healing
    DelayCommand(0.5, VoiceHealMe(TRUE));

    // Get our last master
    object oPC = GetLastMaster();
    object oSelf = OBJECT_SELF;


    // Clear dialogue events
    ClearAllDialogue(oPC, OBJECT_SELF);
    ClearAllActions();

    if (GetIsObjectValid(oPC) == FALSE)
    {
        // SpawnScriptDebugger();
        // * if you kill a henchmen who has never had a master
        // * then permanently kill them to prevent
        // * faction issues.
        SetPlotFlag(OBJECT_SELF,FALSE);
        SetImmortal(OBJECT_SELF, FALSE);
        SetIsDestroyable(TRUE, FALSE, FALSE);
        DestroyObject(OBJECT_SELF, 0.2);
        return;
    }
}

