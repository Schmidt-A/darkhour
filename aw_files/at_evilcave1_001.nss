#include "inc_bs_module"
void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  location lLoc = GetLocation(oTarget);
    int bEntryAllowed = FALSE;
    int nTeam = GetPlayerTeam(oClicker);
    int nEnemyTeam = 3 - nTeam;
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);

    if (GetTag(OBJECT_SELF) == "GoodTransition" && nTeam == TEAM_GOOD)
    {
        bEntryAllowed = TRUE;
    }
    else if (GetTag(OBJECT_SELF) == "EvilTransitionr" && nTeam == TEAM_EVIL)
    {
        bEntryAllowed = TRUE;
    }


    if (bEntryAllowed == TRUE)
    {
        if (oClicker == GetLocalObject(GetModule(), szEnemyHasFlag))
        {
            //RemoveAllEffects(oClicker);

        }
        AssignCommand(oClicker, MoveMeToLocation(lLoc));
    }
    else
    {
        AssignCommand(GetObjectByTag("FlagHolder_" + IntToString(nEnemyTeam)), ActionSpeakString("Ha! You can't go in there!"));
    }
  //SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);

  //AssignCommand(oClicker,JumpToObject(oTarget));
}
