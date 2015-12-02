void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map4",GetLocalInt(GetModule(), "map4")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_4"))+" has received "+IntToString(GetLocalInt(GetModule(), "map4"))+" votes</c>", TALKVOLUME_SHOUT));

}
