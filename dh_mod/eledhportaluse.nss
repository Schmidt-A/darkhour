void main()
{
    object oPC = GetLastUsedBy();
    object oToken = GetItemPossessedBy(oPC,"ELEDHRETH");
    if (oToken != OBJECT_INVALID)
    {
        location lLoc = GetLocation(GetWaypointByTag("ELEDHRETH"));
        AssignCommand(oPC,JumpToLocation(lLoc));
    }
    else
    {
        FloatingTextStringOnCreature("You have not visited Eledhreth yet.",oPC,FALSE);
    }
}
