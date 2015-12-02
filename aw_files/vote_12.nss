void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map12",GetLocalInt(GetModule(), "map12")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_12"))+" has received "+IntToString(GetLocalInt(GetModule(), "map12"))+" votes</c>", TALKVOLUME_SHOUT));
}
