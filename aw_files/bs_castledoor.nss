#include "inc_bs_module"
#include "team_balance"
void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    location lLoc = GetLocation(oTarget);
    int bEntryAllowed = FALSE;
    int nTeam = GetPlayerTeam(oClicker);
    int nEnemyTeam = 3 - nTeam;
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);

    if (GetTag(OBJECT_SELF) == "GoodCastleDoor" && nTeam == TEAM_GOOD)
    {
        bEntryAllowed = TRUE;
    }
    else if (GetTag(OBJECT_SELF) == "EvilCastleDoor" && nTeam == TEAM_EVIL)
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
     ActionWait(2.0);
     ActionCloseDoor(OBJECT_SELF);
}
