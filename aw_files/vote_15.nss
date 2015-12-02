void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map15",GetLocalInt(GetModule(), "map15")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_15"))+" has received "+IntToString(GetLocalInt(GetModule(), "map15"))+" votes</c>", TALKVOLUME_SHOUT));
}
