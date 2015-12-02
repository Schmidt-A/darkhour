void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map11",GetLocalInt(GetModule(), "map11")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_11"))+" has received "+IntToString(GetLocalInt(GetModule(), "map11"))+" votes</c>", TALKVOLUME_SHOUT));
}
