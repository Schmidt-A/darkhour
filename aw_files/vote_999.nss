void main()
{
object oPC = GetPCSpeaker();
if(!GetIsDM(oPC))
SetLocalInt(oPC, "HuntVote", 1);
SetLocalInt(GetModule(), "map999",GetLocalInt(GetModule(), "map999")+1 );
AssignCommand(OBJECT_SELF,ActionSpeakString("<cоло>Map "+GetName(GetObjectByTag("arena_999"))+" has received "+IntToString(GetLocalInt(GetModule(), "map999"))+" votes</c>", TALKVOLUME_SHOUT));

}
