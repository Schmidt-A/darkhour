void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map20",GetLocalInt(GetModule(), "map20")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_20"))+" has received "+IntToString(GetLocalInt(GetModule(), "map20"))+" votes</c>", TALKVOLUME_SHOUT));

}
