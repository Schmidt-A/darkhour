void main()
{
object oPC = GetPCSpeaker();
if(!GetIsDM(oPC))
SetLocalInt(oPC, "SudVote", 1);
SetLocalInt(GetModule(), "map100",GetLocalInt(GetModule(), "map100")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_100"))+" has received "+IntToString(GetLocalInt(GetModule(), "map999"))+" votes</c>", TALKVOLUME_SHOUT));

}
