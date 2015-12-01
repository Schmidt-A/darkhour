void main()
{
if(GetLocked(OBJECT_SELF) == FALSE)
    {
    object oPC = GetLastUsedBy();
    object oDestination = GetWaypointByTag("SmithyHomeWP2");
    location lLocation = GetLocation(oDestination);
    AssignCommand(oPC, JumpToLocation(lLocation));
    SendMessageToPC(oPC, "The door locks shut behind you.");
    SetLocked(OBJECT_SELF, TRUE);
    }
}
