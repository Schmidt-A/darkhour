void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "MapVote", 1);
SetLocalInt(GetModule(), "map21",GetLocalInt(GetModule(), "map21")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_21"))+" has received "+IntToString(GetLocalInt(GetModule(), "map21"))+" votes</c>", TALKVOLUME_SHOUT));

}
