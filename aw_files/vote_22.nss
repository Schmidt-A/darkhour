void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map22",GetLocalInt(GetModule(), "map22")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_22"))+" has received "+IntToString(GetLocalInt(GetModule(), "map22"))+" votes</c>", TALKVOLUME_SHOUT));
}
