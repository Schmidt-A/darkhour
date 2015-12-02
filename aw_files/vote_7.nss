void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map7",GetLocalInt(GetModule(), "map7")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_7"))+" has received "+IntToString(GetLocalInt(GetModule(), "map7"))+" votes</c>", TALKVOLUME_SHOUT));

}
