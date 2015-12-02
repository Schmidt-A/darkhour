#include "criminalrecorder"
#include "inc_bs_module"
#include "aw_include"
void main()
{
//GetIsGMNormalChar
object oGm = GetPCSpeaker();
object oMyTarget = GetLocalObject(oGm,"MyTarget");
if(GetIsObjectValid(oMyTarget))
   {
   if (GetIsDM(oMyTarget) || GetIsDMPossessed(oMyTarget) || oGm == oMyTarget)
      {
       FloatingTextStringOnCreature("You can't!.",oGm, FALSE);
       }
   else
      {
      if (GetLocalInt(oMyTarget,"pause") == 1)     FreezeUnfreeze(oMyTarget,oGm);


      AssignCommand(oMyTarget,ClearAllActions(TRUE));
      int nTeam = GetPlayerTeam(oMyTarget);
      if(nTeam != TEAM_NONE) RemovePlayerFromTeam(nTeam, oMyTarget);
      BootPC(oMyTarget);
      FloatingTextStringOnCreature(GetPCPlayerName(oMyTarget)+" ["+GetName(oMyTarget)+"] it's Booted.",oGm, FALSE);
      WriteTimestampedLogEntry("["+GetPCPlayerName(oGm)+"] "+GetName(oGm)+" Booted "+GetPCPlayerName(oMyTarget)+" ["+GetName(oMyTarget)+"]");
      BroadcastMessage(GetName(oGm)+" Booted "+GetPCPlayerName(oMyTarget)+" ["+GetName(oMyTarget)+"]");
         if (!GetIsGM(oMyTarget))  CriminalRecordEntry(oMyTarget, oGm, "", 2);
      }
   }
   else FloatingTextStringOnCreature("Player not found",oGm,FALSE);

DelayCommand(20.0, DeleteLocalObject(oGm,"MyTarget"));
}
