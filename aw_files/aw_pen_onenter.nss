#include "inc_bs_module"
#include "aw_include"
void main()
{
 object oPlayer = GetEnteringObject();


 int nTeam = GetPlayerTeam(oPlayer);
 WriteTimestampedLogEntry("["+GetPCPlayerName(oPlayer)+"] "+GetName(oPlayer)+" ["+IntToString(GetHitDice(oPlayer))+"] "+GetTeamName(nTeam)+"- Entered The Antiworld Pen");

 //int nPlayerTeam = GetPlayerTeam(oPlayer);
    int nEnemyTeam = 3 - nTeam;
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);

    if (GetLocalObject(GetModule(), szEnemyHasFlag) == oPlayer
        && (nEnemyTeam == TEAM_GOOD || nEnemyTeam == TEAM_EVIL))
    {
           //DropFlag(oPlayer);
           RemoveFlagEffect(oPlayer);
           FlagDestroyed(nEnemyTeam);
    }

 if (!GetIsDMAW(oPlayer) && !GetIsGMNormalChar(oPlayer))
  {
   ///All Moderators can enter the pen Without being removed from their team, so they can go back to castle when they finished
   if (nTeam == 1 ||  nTeam == 2)
   {
   RemovePlayerFromTeam(nTeam, oPlayer);
   }
  AssignCommand(oPlayer,ActionExamine(GetObjectByTag("antiworld_pen")));
  DelayCommand(10.0,AssignCommand( oPlayer, ActionStartConversation(oPlayer,"antiworld_npc",TRUE,FALSE)));
  }

}
