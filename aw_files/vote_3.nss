void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map3",GetLocalInt(GetModule(), "map3")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_3"))+" has received "+IntToString(GetLocalInt(GetModule(), "map3"))+" votes</c>", TALKVOLUME_SHOUT));

}
