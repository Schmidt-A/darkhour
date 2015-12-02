#include "inc_bs_module"
#include "aw_include"
#include "criminalrecorder"
void main()
{
   object oDM = GetItemActivator();
   object oTarget = GetItemActivatedTarget();

   if ( GetIsDMAW(oDM) || GetIsGMNormalChar(oDM))
   {
   int nTeam = GetPlayerTeam(oTarget);
   if(nTeam != TEAM_NONE) RemovePlayerFromTeam(nTeam, oTarget);
   FloatingTextStringOnCreature(GetPCPlayerName(oTarget)+" ["+GetName(oTarget)+"] it's Booted.",oDM, FALSE);
   WriteTimestampedLogEntry("["+GetPCPlayerName(oDM)+"] "+GetName(oDM)+" Booted "+GetPCPlayerName(oTarget)+" ["+GetName(oTarget)+"]");
   SendMessageToAllDMs("["+GetPCPlayerName(oDM)+"] "+GetName(oDM)+" Booted "+GetPCPlayerName(oTarget)+" ["+GetName(oTarget)+"]");
      if (!GetIsGM(oTarget))  CriminalRecordEntry(oTarget,oDM, "", 2);
   BootPC(oTarget);
   }
   else  FloatingTextStringOnCreature("Only Dm can use this Item",oDM, FALSE);
}
