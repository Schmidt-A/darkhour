void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map6",GetLocalInt(GetModule(), "map6")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_6"))+" has received "+IntToString(GetLocalInt(GetModule(), "map6"))+" votes</c>", TALKVOLUME_SHOUT));

}
