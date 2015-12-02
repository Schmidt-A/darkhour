#include "inc_bs_module"
void main()
{
object oPC = GetPCSpeaker();
if(!GetIsDM(oPC))
SetLocalInt(oPC, "HillVote", 1);
SetLocalInt(GetModule(), "map98",GetLocalInt(GetModule(), "map98")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_98"))+" has received "+IntToString(GetLocalInt(GetModule(), "map98"))+" votes</c>", TALKVOLUME_SHOUT));

}
