#include "inc_bs_module"
#include "aw_inc_doors"
void main()
{
  object oClicker = GetLastUsedBy();
  string oTarget =  GetLocalString(OBJECT_SELF,"Transition Target");
    location lLoc = GetLocation(GetObjectByTag(oTarget));
    int bEntryAllowed = FALSE;
    int nTeam = GetPlayerTeam(oClicker);
    int nEnemyTeam = 3 - nTeam;
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);
    string szAllyHasFlag = "oHasFlag_" + IntToString(nTeam);



    if (GetLockKeyTag(OBJECT_SELF) == "GoodKey" && nTeam == TEAM_GOOD)
    {
        bEntryAllowed = TRUE;
    }
    else if (GetLockKeyTag(OBJECT_SELF) == "EvilKey" && nTeam == TEAM_EVIL)
    {
        bEntryAllowed = TRUE;
    }


    if (bEntryAllowed == TRUE)
    {
        EnterDoor(OBJECT_SELF,lLoc,oClicker,1);
    }
    else
    {
        EnterDoor(OBJECT_SELF,lLoc,oClicker);
    }

}
