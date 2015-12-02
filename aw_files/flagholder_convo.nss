#include "inc_bs_module"
void main()
{
object oPC = GetLastSpeaker();
int nRound = GetLocalInt(GetModule(), "nRound");
if (nRound >= 999)
{
AssignCommand(OBJECT_SELF, ActionSpeakString("It's our day off. Go away."));
}
else
{
int nFlagTeam = StringToInt(GetStringRight(GetTag(OBJECT_SELF), 1));
int nPCTeam = GetPlayerTeam(oPC);

if   (nPCTeam == nFlagTeam )
   {
   // object oGoodFlagHolder = GetLocalObject(GetModule(), "oHasFlag_1"); //GOOD
   // object oEvilFlagHolder = GetLocalObject(GetModule(), "oHasFlag_2"); //EVIL
   object oFlagHolder = GetLocalObject(GetModule(), "oHasFlag_"+IntToString(nFlagTeam));
   if  (oFlagHolder != OBJECT_SELF)   SpeakString(GetName(oFlagHolder)+" has stolen our flag!");
   }
else return;
}

}
