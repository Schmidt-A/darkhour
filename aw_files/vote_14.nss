void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map14",GetLocalInt(GetModule(), "map14")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_14"))+" has received "+IntToString(GetLocalInt(GetModule(), "map14"))+" votes</c>", TALKVOLUME_SHOUT));
}
