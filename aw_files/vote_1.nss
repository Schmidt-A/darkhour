void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map1",GetLocalInt(GetModule(), "map1")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_1"))+" has received "+IntToString(GetLocalInt(GetModule(), "map1"))+" votes</c>", TALKVOLUME_SHOUT));

}
