void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map18",GetLocalInt(GetModule(), "map18")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_18"))+" has received "+IntToString(GetLocalInt(GetModule(), "map18"))+" votes</c>", TALKVOLUME_SHOUT));
}
