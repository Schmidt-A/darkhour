void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map8",GetLocalInt(GetModule(), "map8")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_8"))+" has received "+IntToString(GetLocalInt(GetModule(), "map8"))+" votes</c>", TALKVOLUME_SHOUT));

}
