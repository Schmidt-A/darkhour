void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map17",GetLocalInt(GetModule(), "map17")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_17"))+" has received "+IntToString(GetLocalInt(GetModule(), "map17"))+" votes</c>", TALKVOLUME_SHOUT));
}
