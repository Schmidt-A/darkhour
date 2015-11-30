void main()
{
    object oPC = GetLastUsedBy();
    object oToken = GetItemPossessedBy(oPC,"BARABAN");
    if (oToken != OBJECT_INVALID)
    {
        location lLoc = GetLocation(GetWaypointByTag("BARABAN"));
        AssignCommand(oPC,JumpToLocation(lLoc));
    }
    else
    {
        FloatingTextStringOnCreature("You have not visited Baraban yet.",oPC,FALSE);
    }
}
