void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map9",GetLocalInt(GetModule(), "map9")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_9"))+" has received "+IntToString(GetLocalInt(GetModule(), "map9"))+" votes</c>", TALKVOLUME_SHOUT));
}
