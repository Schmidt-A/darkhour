#include "criminalrecorder"
#include "inc_bs_module"
#include "aw_include"
void main()
{
object oGm = GetPCSpeaker();
object oMyTarget = GetLocalObject(oGm,"MyTarget");
if(GetIsObjectValid(oMyTarget))
   {
    int nTeam = GetPlayerTeam(oMyTarget);
    WriteTimestampedLogEntry("["+ GetPCPlayerName(oGm) + "] " + GetName(oGm) + " [" + IntToString(GetHitDice(oGm)) + "] " + GetTeamName(GetPlayerTeam(oGm)) + " Has Moved to Pen: ["+  GetPCPlayerName(oMyTarget) + "] " + GetName(oMyTarget) + " [" + IntToString(GetHitDice(oMyTarget)) + "] " + GetTeamName(nTeam) );
    if (GetLocalInt(oMyTarget, "pause")) FreezeUnfreeze(oMyTarget,oGm);

   object oJail = GetObjectByTag("antiworld_jail");
   location lJail = GetLocation(oJail);
   AssignCommand(oMyTarget,ClearAllActions(TRUE));
   if(nTeam != TEAM_NONE)RemovePlayerFromTeam(nTeam,oMyTarget);
   AssignCommand(oMyTarget,MoveMeToLocation(lJail));
   FloatingTextStringOnCreature(GetName(oMyTarget)+" Moved to Antiworld Pen!",oGm,FALSE);
   DelayCommand(5.0,FreezeUnfreeze(oMyTarget,oGm));
      if (!GetIsGM(oMyTarget))  CriminalRecordEntry(oMyTarget, oGm, "", 0);
   }
   else FloatingTextStringOnCreature("Player not found",oGm,FALSE);

DelayCommand(20.0, DeleteLocalObject(oGm,"MyTarget"));
}

