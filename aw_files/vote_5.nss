void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map5",GetLocalInt(GetModule(), "map5")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_5"))+" has received "+IntToString(GetLocalInt(GetModule(), "map5"))+" votes</c>", TALKVOLUME_SHOUT));

}
