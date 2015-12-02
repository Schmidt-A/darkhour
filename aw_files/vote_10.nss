void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map10",GetLocalInt(GetModule(), "map10")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_10"))+" has received "+IntToString(GetLocalInt(GetModule(), "map10"))+" votes</c>", TALKVOLUME_SHOUT));
}
