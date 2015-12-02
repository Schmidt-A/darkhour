void main()
{
object oPC = GetPCSpeaker();
if(!GetIsDM(oPC))
SetLocalInt(oPC, "HillVote", 1);
SetLocalInt(GetModule(), "map50",GetLocalInt(GetModule(), "map50")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_50"))+" has received "+IntToString(GetLocalInt(GetModule(), "map50"))+" votes</c>", TALKVOLUME_SHOUT));


}
