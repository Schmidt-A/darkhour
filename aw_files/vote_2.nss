void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map2",GetLocalInt(GetModule(), "map2")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_2"))+" has received "+IntToString(GetLocalInt(GetModule(), "map2"))+" votes</c>", TALKVOLUME_SHOUT));

}
