void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map13",GetLocalInt(GetModule(), "map13")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_13"))+" has received "+IntToString(GetLocalInt(GetModule(), "map13"))+" votes</c>", TALKVOLUME_SHOUT));
}
