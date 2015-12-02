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

    if ((GetTag(OBJECT_SELF) == GetTag(GetArea(OBJECT_SELF))+"GoodTransition" || GetTag(OBJECT_SELF) == GetTag(GetArea(OBJECT_SELF))+"GoodTransition1") && nTeam == TEAM_GOOD)
    {
        bEntryAllowed = TRUE;
    }
    else if ((GetTag(OBJECT_SELF) == GetTag(GetArea(OBJECT_SELF))+"EvilTransition" || GetTag(OBJECT_SELF) == GetTag(GetArea(OBJECT_SELF))+"EvilTransition1") && nTeam == TEAM_EVIL)
    {
        bEntryAllowed = TRUE;
    }


   if (bEntryAllowed == TRUE)
    {
         if (oClicker == GetLocalObject(GetModule(), szEnemyHasFlag))
        {
        FloatingTextStringOnCreature("You can't go in with Flag!",oClicker,FALSE);
            //RemoveAllEffects(oClicker);
        }

      else  AssignCommand(oClicker, MoveMeToLocation(lLoc));
    }
    else
   {
        FloatingTextStringOnCreature("Ha! You can't go in there!",oClicker,FALSE);
    }

}
