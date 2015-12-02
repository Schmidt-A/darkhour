void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map16",GetLocalInt(GetModule(), "map16")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_16"))+" has received "+IntToString(GetLocalInt(GetModule(), "map16"))+" votes</c>", TALKVOLUME_SHOUT));
}
