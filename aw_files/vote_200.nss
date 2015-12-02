void main()
{
object oPC = GetPCSpeaker();
if(!GetIsDM(oPC))
SetLocalInt(oPC, "PowVote", 1);
SetLocalInt(GetModule(), "map200",GetLocalInt(GetModule(), "map200")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_200"))+" has received "+IntToString(GetLocalInt(GetModule(), "map200"))+" votes</c>", TALKVOLUME_SHOUT));


}
