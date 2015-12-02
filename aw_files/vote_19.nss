void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map19",GetLocalInt(GetModule(), "map19")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_19"))+" has received "+IntToString(GetLocalInt(GetModule(), "map19"))+" votes</c>", TALKVOLUME_SHOUT));

}
